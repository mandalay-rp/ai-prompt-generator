# AI Prompt Generator

[English](#english) | [Русский](#russian)

<a id="english"></a>
## English

### Overview

**AI Prompt Generator** is an interactive Bash script for creating structured prompts for AI chats.

The script asks a series of questions and builds a final prompt using one of two prompt-engineering frameworks:

- **RCT** — Role, Context, Task;
- **COSTAR** — Context, Objective, Style, Tone, Audience, Response.

After the questionnaire is completed, the script displays the final prompt and allows you to:

- copy it to the clipboard;
- save it as a `Markdown` file;
- save it as a structured `JSON` file.

---

### Features

- Interactive prompt construction.
- Choice between `RCT` and `COSTAR` frameworks.
- Example hints for every input field.
- Default values for empty inputs.
- Final prompt generated in readable Markdown format.
- Copy final prompt to clipboard.
- Save result as `JSON`.
- Save result as `Markdown`.
- Works in terminal environments:
  - Linux;
  - macOS;
  - WSL;
  - Termux.
- Optional clipboard support through common system utilities.

---

### Requirements

Required:

- `bash`, preferably version 4 or newer;
- standard shell utilities:
  - `cat`;
  - `printf`;
  - `read`.

Optional clipboard utilities:

| Environment | Utility |
|---|---|
| macOS | `pbcopy` |
| Wayland | `wl-copy` |
| X11 | `xclip` or `xsel` |
| Termux | `termux-clipboard-set` |
| WSL / Windows | `clip.exe` |

If no clipboard utility is found, the script will still work, but clipboard copying will be unavailable.

---

### Installation

Create a script file:

```bash
nano ai_prompt.sh
```

Paste the script content, save the file, and make it executable:

```bash
chmod +x ai_prompt.sh
```

Run it:

```bash
./ai_prompt.sh
```

Or run it through Bash explicitly:

```bash
bash ai_prompt.sh
```

---

### Usage

After starting, the script asks which framework to use:

```text
=== Генератор структурированных промптов для ИИ ===
Выберите методологию:
1) RCT (Role, Context, Task)
2) COSTAR (Context, Objective, Style, Tone, Audience, Response)
Введите номер (1 или 2):
```

Then it asks for the fields required by the selected framework.

---

### RCT Template

`RCT` is suitable for simple and direct AI requests.

| Field | Purpose | Example |
|---|---|---|
| `ROLE` | The role the AI should assume | `Senior Python Developer, Django 5 expert` |
| `CONTEXT` | Project context, stack, constraints | `Developing a REST API for a blog using Django REST Framework` |
| `TASK` | The exact task for the AI | `Write a custom manager that filters only published posts` |

Example final prompt:

```markdown
# ROLE
Senior Python Developer, Django 5 expert

# CONTEXT
Developing a REST API for a blog using Django REST Framework

# TASK
Write a custom manager that filters only published posts
```

---

### COSTAR Template

`COSTAR` is suitable for more detailed and controlled AI requests.

| Field | Purpose | Example |
|---|---|---|
| `CONTEXT` | Background information | `Django project with slow SQL queries in product listing` |
| `OBJECTIVE` | Desired goal | `Optimize queries using select_related and prefetch_related` |
| `STYLE` | Required style | `PEP8-compatible code with type hints` |
| `TONE` | Response tone | `Professional and technical` |
| `AUDIENCE` | Target audience | `Middle Python developer` |
| `RESPONSE` | Required response format | `Return only code without explanations` |

Example final prompt:

```markdown
# CONTEXT
Django project with slow SQL queries in product listing

# OBJECTIVE
Optimize queries using select_related and prefetch_related

# STYLE
PEP8-compatible code with type hints

# TONE
Professional and technical

# AUDIENCE
Middle Python developer

# RESPONSE FORMAT
Return only code without explanations
```

---

### Actions After Questionnaire

After displaying the final prompt, the script shows a menu:

```text
Действие:
1) Скопировать в буфер обмена
2) Сохранить в JSON
3) Сохранить в Markdown
4) Выйти
Выберите действие [1-4]:
```

You can perform multiple actions before exiting.

---

### Clipboard Support

The script tries to copy the final prompt using one of the following utilities:

```text
pbcopy
wl-copy
xclip
xsel
termux-clipboard-set
clip.exe
```

If copying succeeds, you will see:

```text
Промпт скопирован в буфер обмена.
```

If no clipboard utility is available:

```text
Не найдена утилита буфера обмена.
Поддерживаются: pbcopy, wl-copy, xclip, xsel, termux-clipboard-set, clip.exe.
```

On Linux X11, you can install:

```bash
sudo apt install xclip
```

or:

```bash
sudo apt install xsel
```

On Wayland:

```bash
sudo apt install wl-clipboard
```

---

### Saving as Markdown

Select menu item `3`.

Default file name:

```text
prompt.md
```

Example prompt:

```text
Имя файла [prompt.md]:
```

Press `Enter` to accept the default file name.

The Markdown file will contain the final generated prompt.

Example:

```markdown
# ROLE
Senior Python Developer, Django 5 expert

# CONTEXT
Developing a REST API for a blog using Django REST Framework

# TASK
Write a custom manager that filters only published posts
```

---

### Saving as JSON

Select menu item `2`.

Default file name:

```text
prompt.json
```

Example prompt:

```text
Имя файла [prompt.json]:
```

Press `Enter` to accept the default file name.

The JSON file contains structured prompt data.

---

### JSON Example for RCT

```json
{
  "framework": "RCT",
  "role": "Senior Python Developer, Django 5 expert",
  "context": "Developing a REST API for a blog using Django REST Framework",
  "task": "Write a custom manager that filters only published posts",
  "prompt": "# ROLE\nSenior Python Developer, Django 5 expert\n\n# CONTEXT\nDeveloping a REST API for a blog using Django REST Framework\n\n# TASK\nWrite a custom manager that filters only published posts"
}
```

---

### JSON Example for COSTAR

```json
{
  "framework": "COSTAR",
  "context": "Django project with slow SQL queries in product listing",
  "objective": "Optimize queries using select_related and prefetch_related",
  "style": "PEP8-compatible code with type hints",
  "tone": "Professional and technical",
  "audience": "Middle Python developer",
  "response": "Return only code without explanations",
  "prompt": "# CONTEXT\nDjango project with slow SQL queries in product listing\n\n# OBJECTIVE\nOptimize queries using select_related and prefetch_related\n\n# STYLE\nPEP8-compatible code with type hints\n\n# TONE\nProfessional and technical\n\n# AUDIENCE\nMiddle Python developer\n\n# RESPONSE FORMAT\nReturn only code without explanations"
}
```

---

### Default Values

If a field is left empty, the script uses a default value.

Default values for `RCT`:

```text
ROLE:
Senior Python Developer, Django 5 expert

CONTEXT:
Django 5 project, REST API

TASK:
Write code to solve the task
```

Default values for `COSTAR`:

```text
CONTEXT:
Django 5 project, REST API

OBJECTIVE:
Solve the task and produce working code

STYLE:
PEP8, type hints, code comments

TONE:
Professional and technical

AUDIENCE:
Middle Python developer

RESPONSE:
Only code without explanations
```

---

### Existing File Behavior

If the target file already exists, the script asks:

```text
Файл 'prompt.md' уже существует. Перезаписать? (y/N):
```

Possible answers:

- `y` or `Y` — overwrite the file;
- any other input — cancel saving.

---

### Project Structure

Minimal project structure:

```text
.
├── README.md
└── ai_prompt.sh
```

After saving generated files, the directory may look like this:

```text
.
├── README.md
├── ai_prompt.sh
├── prompt.json
└── prompt.md
```

---

### Customization

You can edit default values inside the script.

For `RCT`, find this block:

```bash
rct_role="${rct_role:-Senior Python Developer, эксперт в Django 5}"
rct_context="${rct_context:-Проект на Django 5, REST API}"
rct_task="${rct_task:-Напиши код для решения задачи}"
```

For `COSTAR`, find this block:

```bash
costar_c="${costar_c:-Проект на Django 5, REST API}"
costar_o="${costar_o:-Решить задачу и получить рабочий код}"
costar_s="${costar_s:-PEP8, type hints, комментарии в коде}"
costar_t="${costar_t:-Профессиональный, технический}"
costar_a="${costar_a:-Разработчик уровня Middle Python}"
costar_r="${costar_r:-Только код без пояснений}"
```

You can also change default output file names here:

```bash
save_file "$JSON_CONTENT" "prompt.json"
save_file "$FINAL_PROMPT" "prompt.md"
```

---

### Troubleshooting

#### Permission denied

If you get:

```text
Permission denied
```

make the script executable:

```bash
chmod +x ai_prompt.sh
```

---

#### Clipboard does not work

If you see:

```text
Не найдена утилита буфера обмена.
```

install one of the supported clipboard utilities.

For X11:

```bash
sudo apt install xclip
```

For Wayland:

```bash
sudo apt install wl-clipboard
```

On macOS, `pbcopy` is usually already installed.

---

#### File cannot be saved

Check:

- directory exists;
- you have write permission;
- file path is correct.

Use:

```bash
ls -l
```

to inspect permissions.

---

### Limitations

- Each field is entered as a single line.
- Multiline input is not supported by default.
- Clipboard copying requires an external utility.
- JSON escaping covers common cases such as quotes, newlines, tabs, and some control characters.

---

### Recommendations

For better AI results:

- describe the task clearly;
- specify language, framework, and library versions;
- define the expected output format;
- ask for code only if explanations are not needed;
- mention the target audience if explanation depth matters.

Example of a good task:

```text
Write a Django model, serializer, and viewset for an Article entity.
Use Django 5 and Django REST Framework.
Return only code without explanations.
```

---

### License

This script is provided as-is. Use and modify it as needed. Add your own license file if required.

---

<a id="russian"></a>
## Русский

### Описание

**AI Prompt Generator** — это интерактивный Bash-скрипт для создания структурированных запросов к ИИ.

Скрипт задаёт пользователю последовательные вопросы и формирует итоговый промпт по одной из двух методологий:

- **RCT** — Role, Context, Task;
- **COSTAR** — Context, Objective, Style, Tone, Audience, Response.

После завершения опроса скрипт показывает готовый промпт и позволяет:

- скопировать его в буфер обмена;
- сохранить в файл `Markdown`;
- сохранить в структурированный файл `JSON`.

---

### Возможности

- Интерактивное заполнение промпта.
- Выбор между `RCT` и `COSTAR`.
- Подсказки с примерами для каждого поля.
- Значения по умолчанию для пустых полей.
- Итоговый промпт в читаемом Markdown-формате.
- Копирование результата в буфер обмена.
- Сохранение результата в `JSON`.
- Сохранение результата в `Markdown`.
- Работа в терминальных окружениях:
  - Linux;
  - macOS;
  - WSL;
  - Termux.
- Опциональная поддержка буфера обмена через системные утилиты.

---

### Требования

Обязательные зависимости:

- `bash`, желательно версии 4 или новее;
- стандартные утилиты командной строки:
  - `cat`;
  - `printf`;
  - `read`.

Дополнительные утилиты для буфера обмена:

| Платформа / окружение | Утилита |
|---|---|
| macOS | `pbcopy` |
| Wayland | `wl-copy` |
| X11 | `xclip` или `xsel` |
| Termux | `termux-clipboard-set` |
| WSL / Windows | `clip.exe` |

Если ни одна утилита не найдена, скрипт продолжит работу, но копирование в буфер обмена будет недоступно.

---

### Установка

Создайте файл скрипта:

```bash
nano ai_prompt.sh
```

Вставьте содержимое скрипта, сохраните файл и сделайте его исполняемым:

```bash
chmod +x ai_prompt.sh
```

Запуск:

```bash
./ai_prompt.sh
```

Или через явный вызов `bash`:

```bash
bash ai_prompt.sh
```

---

### Использование

После запуска скрипт предложит выбрать методологию:

```text
=== Генератор структурированных промптов для ИИ ===
Выберите методологию:
1) RCT (Role, Context, Task)
2) COSTAR (Context, Objective, Style, Tone, Audience, Response)
Введите номер (1 или 2):
```

Далее скрипт по очереди запросит поля выбранного шаблона.

---

### Шаблон RCT

`RCT` подходит для простых и прямых запросов.

| Поле | Назначение | Пример |
|---|---|---|
| `ROLE` | Роль, которую должен принять ИИ | `Senior Python Developer, эксперт в Django 5` |
| `CONTEXT` | Контекст проекта, стек, ограничения | `Разрабатываемое приложение: REST API для блога на DRF` |
| `TASK` | Конкретная задача для ИИ | `Напиши кастомный менеджер для фильтрации только опубликованных постов` |

Пример итогового промпта:

```markdown
# ROLE
Senior Python Developer, эксперт в Django 5

# CONTEXT
Разрабатываемое приложение: REST API для блога на DRF

# TASK
Напиши кастомный менеджер для фильтрации только опубликованных постов
```

---

### Шаблон COSTAR

`COSTAR` подходит для более детализированных запросов, где важны стиль, тон, аудитория и формат ответа.

| Поле | Назначение | Пример |
|---|---|---|
| `CONTEXT` | Контекст задачи | `Проект на Django, медленные SQL запросы в списке товаров` |
| `OBJECTIVE` | Цель запроса | `Оптимизировать запросы через select_related и prefetch_related` |
| `STYLE` | Стиль ответа или кода | `Код в стиле PEP8, с type hints` |
| `TONE` | Тон ответа | `Профессиональный, строго технический` |
| `AUDIENCE` | Для кого предназначен результат | `Код будет читать Middle Python разработчик` |
| `RESPONSE` | Требуемый формат ответа | `Верни только готовый код без пояснений` |

Пример итогового промпта:

```markdown
# CONTEXT
Проект на Django, медленные SQL запросы в списке товаров

# OBJECTIVE
Оптимизировать запросы через select_related и prefetch_related

# STYLE
Код в стиле PEP8, с type hints

# TONE
Профессиональный, строго технический

# AUDIENCE
Код будет читать Middle Python разработчик

# RESPONSE FORMAT
Верни только готовый код без пояснений
```

---

### Действия после заполнения

После вывода готового промпта скрипт покажет меню:

```text
Действие:
1) Скопировать в буфер обмена
2) Сохранить в JSON
3) Сохранить в Markdown
4) Выйти
Выберите действие [1-4]:
```

Можно выполнять несколько действий подряд, пока вы не выберете выход.

---

### Поддержка буфера обмена

Скрипт пытается скопировать промпт с помощью одной из следующих утилит:

```text
pbcopy
wl-copy
xclip
xsel
termux-clipboard-set
clip.exe
```

Если копирование прошло успешно, появится сообщение:

```text
Промпт скопирован в буфер обмена.
```

Если утилита не найдена:

```text
Не найдена утилита буфера обмена.
Поддерживаются: pbcopy, wl-copy, xclip, xsel, termux-clipboard-set, clip.exe.
```

Для X11 можно установить:

```bash
sudo apt install xclip
```

или:

```bash
sudo apt install xsel
```

Для Wayland:

```bash
sudo apt install wl-clipboard
```

---

### Сохранение в Markdown

Выберите пункт меню `3`.

Имя файла по умолчанию:

```text
prompt.md
```

Пример запроса имени файла:

```text
Имя файла [prompt.md]:
```

Если просто нажать `Enter`, будет использовано имя по умолчанию.

Файл будет содержать итоговый промпт в Markdown-формате.

Пример:

```markdown
# ROLE
Senior Python Developer, эксперт в Django 5

# CONTEXT
Разрабатываемое приложение: REST API для блога на DRF

# TASK
Напиши кастомный менеджер для фильтрации только опубликованных постов
```

---

### Сохранение в JSON

Выберите пункт меню `2`.

Имя файла по умолчанию:

```text
prompt.json
```

Пример запроса имени файла:

```text
Имя файла [prompt.json]:
```

Если просто нажать `Enter`, будет использовано имя по умолчанию.

Файл будет содержать структурированные данные промпта.

---

### Пример JSON для RCT

```json
{
  "framework": "RCT",
  "role": "Senior Python Developer, эксперт в Django 5",
  "context": "Разрабатываемое приложение: REST API для блога на DRF",
  "task": "Напиши кастомный менеджер для фильтрации только опубликованных постов",
  "prompt": "# ROLE\nSenior Python Developer, эксперт в Django 5\n\n# CONTEXT\nРазрабатываемое приложение: REST API для блога на DRF\n\n# TASK\nНапиши кастомный менеджер для фильтрации только опубликованных постов"
}
```

---

### Пример JSON для COSTAR

```json
{
  "framework": "COSTAR",
  "context": "Проект на Django, медленные SQL запросы в списке товаров",
  "objective": "Оптимизировать запросы через select_related и prefetch_related",
  "style": "Код в стиле PEP8, с type hints",
  "tone": "Профессиональный, строго технический",
  "audience": "Код будет читать Middle Python разработчик",
  "response": "Верни только готовый код без пояснений",
  "prompt": "# CONTEXT\nПроект на Django, медленные SQL запросы в списке товаров\n\n# OBJECTIVE\nОптимизировать запросы через select_related и prefetch_related\n\n# STYLE\nКод в стиле PEP8, с type hints\n\n# TONE\nПрофессиональный, строго технический\n\n# AUDIENCE\nКод будет читать Middle Python разработчик\n\n# RESPONSE FORMAT\nВерни только готовый код без пояснений"
}
```

---

### Значения по умолчанию

Если оставить поле пустым, скрипт подставит значение по умолчанию.

Для `RCT`:

```text
ROLE:
Senior Python Developer, эксперт в Django 5

CONTEXT:
Проект на Django 5, REST API

TASK:
Напиши код для решения задачи
```

Для `COSTAR`:

```text
CONTEXT:
Проект на Django 5, REST API

OBJECTIVE:
Решить задачу и получить рабочий код

STYLE:
PEP8, type hints, комментарии в коде

TONE:
Профессиональный, технический

AUDIENCE:
Разработчик уровня Middle Python

RESPONSE:
Только код без пояснений
```

---

### Поведение при существующем файле

Если указанный файл уже существует, скрипт спросит:

```text
Файл 'prompt.md' уже существует. Перезаписать? (y/N):
```

Варианты ответа:

- `y` или `Y` — перезаписать файл;
- любой другой ввод или пустой ввод — отменить запись.

---

### Структура проекта

Минимальная структура проекта:

```text
.
├── README.md
└── ai_prompt.sh
```

После сохранения сгенерированных файлов каталог может выглядеть так:

```text
.
├── README.md
├── ai_prompt.sh
├── prompt.json
└── prompt.md
```

---

### Настройка

Вы можете изменить значения по умолчанию прямо в скрипте.

Для `RCT` найдите блок:

```bash
rct_role="${rct_role:-Senior Python Developer, эксперт в Django 5}"
rct_context="${rct_context:-Проект на Django 5, REST API}"
rct_task="${rct_task:-Напиши код для решения задачи}"
```

Замените значения на свои.

Для `COSTAR` найдите блок:

```bash
costar_c="${costar_c:-Проект на Django 5, REST API}"
costar_o="${costar_o:-Решить задачу и получить рабочий код}"
costar_s="${costar_s:-PEP8, type hints, комментарии в коде}"
costar_t="${costar_t:-Профессиональный, технический}"
costar_a="${costar_a:-Разработчик уровня Middle Python}"
costar_r="${costar_r:-Только код без пояснений}"
```

Также можно изменить имена файлов по умолчанию здесь:

```bash
save_file "$JSON_CONTENT" "prompt.json"
save_file "$FINAL_PROMPT" "prompt.md"
```

---

### Типичные проблемы

#### `Permission denied` при запуске

Если появляется ошибка:

```text
Permission denied
```

выдайте права на выполнение:

```bash
chmod +x ai_prompt.sh
```

---

#### Не работает копирование в буфер обмена

Если появляется сообщение:

```text
Не найдена утилита буфера обмена.
```

установите одну из поддерживаемых утилит.

Для X11:

```bash
sudo apt install xclip
```

Для Wayland:

```bash
sudo apt install wl-clipboard
```

В macOS `pbcopy` обычно уже установлен.

---

#### Файл не сохраняется

Проверьте:

- существует ли каталог;
- есть ли права на запись;
- корректность пути к файлу.

Для проверки прав используйте:

```bash
ls -l
```

---

### Ограничения

- Каждое поле вводится одной строкой.
- Многострочный ввод в текущей версии не поддерживается.
- Для копирования в буфер обмена требуется внешняя утилита.
- Экранирование `JSON` покрывает типовые случаи: кавычки, переводы строк, табы и некоторые управляющие символы.

---

### Рекомендации

Для получения лучших результатов от ИИ:

- формулируйте задачу максимально конкретно;
- указывайте версию языка, фреймворка или библиотеки;
- явно задавайте формат ответа;
- просите только код, если пояснения не нужны;
- указывайте целевую аудиторию, если важна глубина объяснений.

Пример хорошей задачи:

```text
Напиши Django-модель, сериализатор и viewset для сущности "Статья".
Используй Django 5 и Django REST Framework.
Верни только готовый код без пояснений.
```

---

### Лицензия

Скрипт предоставляется как есть. Используйте и изменяйте его по своему усмотрению. При необходимости добавьте собственную лицензию в проект.