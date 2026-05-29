@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ========================================
echo VimWiki .wiki 批量转换 HTML
echo ========================================

:: 配置区 - 根据你的实际路径修改
set WIKI_DIR=%USERPROFILE%\dev\qsl-cards
set VIM_EXE=vim

:: 检查 wiki 目录是否存在
if not exist "%WIKI_DIR%" (
    echo [错误] Wiki 目录不存在: %WIKI_DIR%
    pause
    exit /b 1
)

:: 计数器
set /a count=0
set /a success=0
set /a failed=0

echo [信息] Wiki 目录: %WIKI_DIR%
echo [信息] 开始转换...
echo.

:: 遍历所有 .wiki 文件
for /r "%WIKI_DIR%" %%f in (*.wiki) do (
    set /a count+=1
    echo [转换] %%~nxf

    %VIM_EXE% -E -s -u %USERPROFILE%\_vimrc "%%f" ^
        -c "Vimwiki2HTML" ^
        -c "qa!" >nul 2>&1

    if !errorlevel! == 0 (
        set /a success+=1
        echo        成功
    ) else (
        set /a failed+=1
        echo        失败
    )
)

echo.
echo ========================================
echo 转换完成
echo   总计: !count! 个文件
echo   成功: !success! 个
echo   失败: !failed! 个
echo ========================================
pause