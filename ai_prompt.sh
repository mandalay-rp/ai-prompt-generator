#!/usr/bin/env bash

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

copy_to_clipboard() {
    local text="$1"

    if command -v pbcopy >/dev/null 2>&1; then
        printf '%s' "$text" | pbcopy
    elif command -v wl-copy >/dev/null 2>&1; then
        printf '%s' "$text" | wl-copy
    elif command -v xclip >/dev/null 2>&1; then
        printf '%s' "$text" | xclip -selection clipboard
    elif command -v xsel >/dev/null 2>&1; then
        printf '%s' "$text" | xsel --clipboard --input
    elif command -v termux-clipboard-set >/dev/null 2>&1; then
        printf '%s' "$text" | termux-clipboard-set
    elif command -v clip.exe >/dev/null 2>&1; then
        printf '%s' "$text" | clip.exe
    else
        return 1
    fi
}

json_escape() {
    local s="$1"

    local esc_nl="\\n"
    local esc_cr="\\r"
    local esc_tab="\\t"
    local esc_bsp="\\b"
    local esc_ff="\\f"

    s=${s//\\/\\\\}
    s=${s//\"/\\\"}

    s=${s//$'\n'/$esc_nl}
    s=${s//$'\r'/$esc_cr}
    s=${s//$'\t'/$esc_tab}
    s=${s//$'\b'/$esc_bsp}
    s=${s//$'\f'/$esc_ff}

    printf '%s' "$s"
}

save_file() {
    local content="$1"
    local default_name="$2"
    local filename
    local overwrite

    read -r -e -p "Имя файла [$default_name]: " filename
    filename="${filename:-$default_name}"
    filename="${filename/#\~/$HOME}"

    if [[ -e "$filename" ]]; then
        read -r -p "Файл '$filename' уже существует. Перезаписать? (y/N): " overwrite

        if [[ ! "$overwrite" =~ ^[Yy]$ ]]; then
            echo "Запись отменена."
            return 0
        fi
    fi

    if printf '%s\n' "$content" > "$filename"; then
        echo "Файл сохранен: $filename"
    else
        echo "Ошибка: не удалось сохранить файл '$filename'."
    fi
}

echo -e "${CYAN}=== Генератор структурированных промптов для ИИ ===${NC}"
echo "Выберите методологию:"
echo "1) RCT (Role, Context, Task)"
echo "2) COSTAR (Context, Objective, Style, Tone, Audience, Response)"

read -r -p "Введите номер (1 или 2): " choice

case "$choice" in
    1)
        echo -e "\n${YELLOW}--- Заполнение данных для RCT ---${NC}"

        read -r -e -p "ROLE (Роль). Пример: 'Senior Python Developer, эксперт в Django 5': " rct_role
        read -r -e -p "CONTEXT (Контекст). Пример: 'Разрабатываемое приложение: REST API для блога на DRF': " rct_context
        read -r -e -p "TASK (Задача). Пример: 'Напиши кастомный менеджер для фильтрации только опубликованных постов': " rct_task

        rct_role="${rct_role:-Senior Python Developer, эксперт в Django 5}"
        rct_context="${rct_context:-Проект на Django 5, REST API}"
        rct_task="${rct_task:-Напиши код для решения задачи}"

        FRAMEWORK="RCT"

        FINAL_PROMPT=$(cat <<EOF
# ROLE
$rct_role

# CONTEXT
$rct_context

# TASK
$rct_task
EOF
)

        JSON_CONTENT=$(cat <<EOF
{
  "framework": "RCT",
  "role": "$(json_escape "$rct_role")",
  "context": "$(json_escape "$rct_context")",
  "task": "$(json_escape "$rct_task")",
  "prompt": "$(json_escape "$FINAL_PROMPT")"
}
EOF
)
        ;;

    2)
        echo -e "\n${YELLOW}--- Заполнение данных для COSTAR ---${NC}"

        read -r -e -p "CONTEXT (Контекст). Пример: 'Проект на Django, медленные SQL запросы в списке товаров': " costar_c
        read -r -e -p "OBJECTIVE (Цель). Пример: 'Оптимизировать запросы через select_related и prefetch_related': " costar_o
        read -r -e -p "STYLE (Стиль). Пример: 'Код в стиле PEP8, с type hints': " costar_s
        read -r -e -p "TONE (Тон). Пример: 'Профессиональный, строго технический': " costar_t
        read -r -e -p "AUDIENCE (Аудитория). Пример: 'Код будет читать Middle Python разработчик': " costar_a
        read -r -e -p "RESPONSE (Формат ответа). Пример: 'Верни только готовый код без пояснений': " costar_r

        costar_c="${costar_c:-Проект на Django 5, REST API}"
        costar_o="${costar_o:-Решить задачу и получить рабочий код}"
        costar_s="${costar_s:-PEP8, type hints, комментарии в коде}"
        costar_t="${costar_t:-Профессиональный, технический}"
        costar_a="${costar_a:-Разработчик уровня Middle Python}"
        costar_r="${costar_r:-Только код без пояснений}"

        FRAMEWORK="COSTAR"

        FINAL_PROMPT=$(cat <<EOF
# CONTEXT
$costar_c

# OBJECTIVE
$costar_o

# STYLE
$costar_s

# TONE
$costar_t

# AUDIENCE
$costar_a

# RESPONSE FORMAT
$costar_r
EOF
)

        JSON_CONTENT=$(cat <<EOF
{
  "framework": "COSTAR",
  "context": "$(json_escape "$costar_c")",
  "objective": "$(json_escape "$costar_o")",
  "style": "$(json_escape "$costar_s")",
  "tone": "$(json_escape "$costar_t")",
  "audience": "$(json_escape "$costar_a")",
  "response": "$(json_escape "$costar_r")",
  "prompt": "$(json_escape "$FINAL_PROMPT")"
}
EOF
)
        ;;

    *)
        echo "Неверный выбор."
        exit 1
        ;;
esac

echo -e "\n${GREEN}=== ГОТОВЫЙ ПРОМПТ ===${NC}"
printf '%s\n' "$FINAL_PROMPT"

while true; do
    echo
    echo "Действие:"
    echo "1) Скопировать в буфер обмена"
    echo "2) Сохранить в JSON"
    echo "3) Сохранить в Markdown"
    echo "4) Выйти"

    read -r -p "Выберите действие [1-4]: " action

    case "$action" in
        1)
            if copy_to_clipboard "$FINAL_PROMPT"; then
                echo "Промпт скопирован в буфер обмена."
            else
                echo "Не найдена утилита буфера обмена."
                echo "Поддерживаются: pbcopy, wl-copy, xclip, xsel, termux-clipboard-set, clip.exe."
            fi
            ;;

        2)
            save_file "$JSON_CONTENT" "prompt.json"
            ;;

        3)
            save_file "$FINAL_PROMPT" "prompt.md"
            ;;

        4)
            break
            ;;

        *)
            echo "Некорректный ввод. Введите 1, 2, 3 или 4."
            ;;
    esac
done