@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

:: Request admin privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

set "DEST=%USERPROFILE%\.llm-cli\assets"

cls
echo.
echo   ================================================================
echo.
echo       _      _      __  __        ____  _      ___     ____   ____ 
echo      ^| ^|    ^| ^|    ^|  \/  ^|_____ / ___^|^| ^|    ^|_ _^|   ^|  _ \ / ___^|
echo      ^| ^|    ^| ^|    ^| ^|\/^| ^|_____^| ^|    ^| ^|     ^| ^|    ^| ^|_) ^| ^|    
echo      ^| ^|___ ^| ^|___ ^| ^|  ^| ^|     ^| ^|___ ^| ^|___  ^| ^|    ^|  _ ^<^| ^|___ 
echo      ^|_____^|^|_____^|^|_^|  ^|_^|      \____^|^|_____^|^|___^|   ^|_^| \_\\____^|
echo.
echo            Context Menu Installer for Windows
echo.
echo   ================================================================
echo.

:: Initialize CLI selections
set "INSTALL_CLAUDE=0"
set "INSTALL_GEMINI=0"
set "INSTALL_QWEN=0"
set "INSTALL_DROID=0"
set "INSTALL_OPENCODE=0"

echo   SELECT CLI TOOLS
echo   ----------------------------------------------------------------
echo.

:: Claude Code
echo   [1/5] Claude Code
choice /C YN /N /M "         Install? [Y/N]: "
if errorlevel 2 (
    echo         [-] Skipped
) else (
    set "INSTALL_CLAUDE=1"
    echo         [+] Selected
)
echo.

:: Gemini CLI
echo   [2/5] Gemini CLI
choice /C YN /N /M "         Install? [Y/N]: "
if errorlevel 2 (
    echo         [-] Skipped
) else (
    set "INSTALL_GEMINI=1"
    echo         [+] Selected
)
echo.

:: Qwen
echo   [3/5] Qwen
choice /C YN /N /M "         Install? [Y/N]: "
if errorlevel 2 (
    echo         [-] Skipped
) else (
    set "INSTALL_QWEN=1"
    echo         [+] Selected
)
echo.

:: Droid
echo   [4/5] Droid
choice /C YN /N /M "         Install? [Y/N]: "
if errorlevel 2 (
    echo         [-] Skipped
) else (
    set "INSTALL_DROID=1"
    echo         [+] Selected
)
echo.

:: Opencode
echo   [5/5] Opencode
choice /C YN /N /M "         Install? [Y/N]: "
if errorlevel 2 (
    echo         [-] Skipped
) else (
    set "INSTALL_OPENCODE=1"
    echo         [+] Selected
)
echo.

:: Check if at least one CLI is selected
set /a "TOTAL=INSTALL_CLAUDE+INSTALL_GEMINI+INSTALL_QWEN+INSTALL_DROID+INSTALL_OPENCODE"
if %TOTAL%==0 (
    echo   ----------------------------------------------------------------
    echo.
    echo   ^! No CLI tools selected. Installation cancelled.
    echo.
    pause
    exit /b 0
)

echo   ----------------------------------------------------------------
echo.
echo   INSTALLING
echo   Selected: %TOTAL% tool(s)
echo.

:: Create directory
echo   [Step 1/3] Creating directories...
if not exist "%USERPROFILE%\.llm-cli" mkdir "%USERPROFILE%\.llm-cli"
if not exist "%DEST%" mkdir "%DEST%"
echo              ^> %DEST%
echo.

:: Copy icons
echo   [Step 2/3] Copying icons...
copy /Y "%~dp0assets\cli.ico" "%DEST%\" >nul
if %INSTALL_CLAUDE%==1 copy /Y "%~dp0assets\claude.ico" "%DEST%\" >nul
if %INSTALL_GEMINI%==1 copy /Y "%~dp0assets\gemini.ico" "%DEST%\" >nul
if %INSTALL_QWEN%==1 copy /Y "%~dp0assets\qwen.ico" "%DEST%\" >nul
if %INSTALL_DROID%==1 copy /Y "%~dp0assets\droid.ico" "%DEST%\" >nul
if %INSTALL_OPENCODE%==1 copy /Y "%~dp0assets\opencode.ico" "%DEST%\" >nul
echo              ^> Icons copied successfully
echo.

:: Apply registry entries
echo   [Step 3/3] Applying registry entries...

:: Create main menu structure
reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\LLMCLI" /v "MUIVerb" /t REG_SZ /d "LLM-CLI RC" /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\LLMCLI" /v "Icon" /t REG_SZ /d "%DEST%\cli.ico" /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\LLMCLI" /v "SubCommands" /t REG_SZ /d "" /f >nul

reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\LLMCLI" /v "MUIVerb" /t REG_SZ /d "LLM-CLI RC" /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\LLMCLI" /v "Icon" /t REG_SZ /d "%DEST%\cli.ico" /f >nul
reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\LLMCLI" /v "SubCommands" /t REG_SZ /d "" /f >nul

:: Add Claude if selected (both safe and yolo modes)
if %INSTALL_CLAUDE%==1 (
    :: Claude Code (Safe mode)
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\LLMCLI\shell\Claude" /v "MUIVerb" /t REG_SZ /d "Claude Code" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\LLMCLI\shell\Claude" /v "Icon" /t REG_SZ /d "%DEST%\claude.ico" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\LLMCLI\shell\Claude\command" /ve /t REG_SZ /d "wt.exe -d \"%%V\" cmd /k claude" /f >nul

    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\LLMCLI\shell\Claude" /v "MUIVerb" /t REG_SZ /d "Claude Code" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\LLMCLI\shell\Claude" /v "Icon" /t REG_SZ /d "%DEST%\claude.ico" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\LLMCLI\shell\Claude\command" /ve /t REG_SZ /d "wt.exe -d \"%%V\" cmd /k claude" /f >nul

    :: Claude Code (Yolo mode - skip permissions)
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\LLMCLI\shell\ClaudeYolo" /v "MUIVerb" /t REG_SZ /d "Claude Code (Yolo)" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\LLMCLI\shell\ClaudeYolo" /v "Icon" /t REG_SZ /d "%DEST%\claude.ico" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\LLMCLI\shell\ClaudeYolo\command" /ve /t REG_SZ /d "wt.exe -d \"%%V\" cmd /k claude --dangerously-skip-permissions" /f >nul

    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\LLMCLI\shell\ClaudeYolo" /v "MUIVerb" /t REG_SZ /d "Claude Code (Yolo)" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\LLMCLI\shell\ClaudeYolo" /v "Icon" /t REG_SZ /d "%DEST%\claude.ico" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\LLMCLI\shell\ClaudeYolo\command" /ve /t REG_SZ /d "wt.exe -d \"%%V\" cmd /k claude --dangerously-skip-permissions" /f >nul
)

:: Add Gemini if selected
if %INSTALL_GEMINI%==1 (
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\LLMCLI\shell\Gemini" /v "MUIVerb" /t REG_SZ /d "Gemini" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\LLMCLI\shell\Gemini" /v "Icon" /t REG_SZ /d "%DEST%\gemini.ico" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\LLMCLI\shell\Gemini\command" /ve /t REG_SZ /d "wt.exe -d \"%%V\" cmd /k gemini" /f >nul
    
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\LLMCLI\shell\Gemini" /v "MUIVerb" /t REG_SZ /d "Gemini" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\LLMCLI\shell\Gemini" /v "Icon" /t REG_SZ /d "%DEST%\gemini.ico" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\LLMCLI\shell\Gemini\command" /ve /t REG_SZ /d "wt.exe -d \"%%V\" cmd /k gemini" /f >nul
)

:: Add Qwen if selected
if %INSTALL_QWEN%==1 (
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\LLMCLI\shell\Qwen" /v "MUIVerb" /t REG_SZ /d "Qwen" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\LLMCLI\shell\Qwen" /v "Icon" /t REG_SZ /d "%DEST%\qwen.ico" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\LLMCLI\shell\Qwen\command" /ve /t REG_SZ /d "wt.exe -d \"%%V\" cmd /k qwen" /f >nul
    
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\LLMCLI\shell\Qwen" /v "MUIVerb" /t REG_SZ /d "Qwen" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\LLMCLI\shell\Qwen" /v "Icon" /t REG_SZ /d "%DEST%\qwen.ico" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\LLMCLI\shell\Qwen\command" /ve /t REG_SZ /d "wt.exe -d \"%%V\" cmd /k qwen" /f >nul
)

:: Add Droid if selected
if %INSTALL_DROID%==1 (
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\LLMCLI\shell\Droid" /v "MUIVerb" /t REG_SZ /d "Droid" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\LLMCLI\shell\Droid" /v "Icon" /t REG_SZ /d "%DEST%\droid.ico" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\LLMCLI\shell\Droid\command" /ve /t REG_SZ /d "wt.exe -d \"%%V\" cmd /k droid" /f >nul
    
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\LLMCLI\shell\Droid" /v "MUIVerb" /t REG_SZ /d "Droid" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\LLMCLI\shell\Droid" /v "Icon" /t REG_SZ /d "%DEST%\droid.ico" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\LLMCLI\shell\Droid\command" /ve /t REG_SZ /d "wt.exe -d \"%%V\" cmd /k droid" /f >nul
)

:: Add Opencode if selected
if %INSTALL_OPENCODE%==1 (
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\LLMCLI\shell\Opencode" /v "MUIVerb" /t REG_SZ /d "Opencode" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\LLMCLI\shell\Opencode" /v "Icon" /t REG_SZ /d "%DEST%\opencode.ico" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\shell\LLMCLI\shell\Opencode\command" /ve /t REG_SZ /d "wt.exe -d \"%%V\" cmd /k opencode" /f >nul
    
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\LLMCLI\shell\Opencode" /v "MUIVerb" /t REG_SZ /d "Opencode" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\LLMCLI\shell\Opencode" /v "Icon" /t REG_SZ /d "%DEST%\opencode.ico" /f >nul
    reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\LLMCLI\shell\Opencode\command" /ve /t REG_SZ /d "wt.exe -d \"%%V\" cmd /k opencode" /f >nul
)

echo              ^> Registry updated successfully
echo.

echo   ================================================================
echo.
echo                    INSTALLATION COMPLETE!
echo.
echo   ================================================================
echo.
echo   Installed tools:
echo.
if %INSTALL_CLAUDE%==1 echo       [+] Claude Code / Claude Code (Yolo)
if %INSTALL_GEMINI%==1 echo       [+] Gemini CLI
if %INSTALL_QWEN%==1 echo       [+] Qwen
if %INSTALL_DROID%==1 echo       [+] Droid
if %INSTALL_OPENCODE%==1 echo       [+] Opencode
echo.
echo   ----------------------------------------------------------------
echo.
echo   Right-click on any folder to see the "LLM CLI" menu.
echo   To uninstall, run: uninstall.bat
echo.
pause
