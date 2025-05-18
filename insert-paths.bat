@echo off
setlocal enabledelayedexpansion

set "file=C:\SafeZone\unit_converter_full_project\unit-converter\tsconfig.json"
set "temp=%file%.tmp"

if not exist "%file%" (
    echo [Ошибка] tsconfig.json не найден по пути: %file%
    pause
    exit /b
)

echo [Инфо] Обновление tsconfig.json...

set "inCompilerOptions=0"
set "baseUrlExists=0"
set "pathsExists=0"

> "%temp%" (
  for /f "usebackq delims=" %%A in ("%file%") do (
    set "line=%%A"

    echo !line! | find "\"compilerOptions\"" >nul && set "inCompilerOptions=1"
    echo !line! | find "\"baseUrl\"" >nul && set "baseUrlExists=1"
    echo !line! | find "\"paths\"" >nul && set "pathsExists=1"

    if !inCompilerOptions! equ 1 (
      if "!line!"=="  }," (
        if !baseUrlExists! equ 0 (
          echo     "baseUrl": ".",
        )
        if !pathsExists! equ 0 (
          echo     "paths": {
          echo       "@/*": ["./*"]
          echo     },
        )
        set "inCompilerOptions=0"
      )
    )

    echo !line!
  )
)

move /Y "%temp%" "%file%" >nul
echo [Успех] tsconfig.json обновлён.
pause
