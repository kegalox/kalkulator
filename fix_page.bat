@echo off
setlocal enabledelayedexpansion

REM Укажите путь к вашему файлу page.tsx
set "FILE_PATH=app\page.tsx"

REM Проверка существования файла
if not exist "%FILE_PATH%" (
    echo Файл не найден: %FILE_PATH%
    goto :eof
)

REM Создаем временный файл
set "TEMP_FILE=%TEMP%\page_temp.tsx"

REM Добавляем 'use client'; в начало файла
echo 'use client'; > "%TEMP_FILE%"

REM Удаляем строку, начинающуюся с 'use client'; из оригинального файла, если она есть
for /f "usebackq delims=" %%A in ("%FILE_PATH%") do (
    set "line=%%A"
    if /i not "%%A"=="'use client';" (
        echo %%A>> "%TEMP_FILE%"
    )
)

REM Заменяем оригинальный файл на исправленный
move /Y "%TEMP_FILE%" "%FILE_PATH%"

REM Теперь удалим дублирующие импорты, если есть
REM Для этого используем PowerShell команду
powershell -Command ^
    "$content = Get-Content '%FILE_PATH%';" ^
    "$newContent = $content | Select-Object -Unique;" ^
    "$newContent | Set-Content '%FILE_PATH%'"

echo Исправление завершено.

pause