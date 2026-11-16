@echo off
title Upload Project to GitHub
echo ==========================================
echo       Upload Project to GitHub
echo ==========================================
echo.
echo Make sure this file is inside your project folder.
echo.

where git >nul 2>nul
if errorlevel 1 (
    echo ERROR: Git is not installed or is not added to PATH.
    echo Install Git from https://git-scm.com/downloads and try again.
    pause
    exit /b 1
)

set /p REPO_URL=Paste your GitHub repository URL: 
if "%REPO_URL%"=="" (
    echo ERROR: Repository URL cannot be empty.
    pause
    exit /b 1
)

echo.
echo [1/5] Initializing Git...
git init
if errorlevel 1 goto :error

echo.
echo [2/5] Adding project files...
git add .
if errorlevel 1 goto :error

echo.
echo [3/5] Creating the initial commit...
git commit -m "Initial commit"
if errorlevel 1 (
    echo.
    echo Commit failed. If Git asks you to configure your identity, run:
    echo git config --global user.name "Your Name"
    echo git config --global user.email "you@example.com"
    echo Then run this file again.
    pause
    exit /b 1
)

echo.
echo [4/5] Setting the main branch...
git branch -M main
if errorlevel 1 goto :error

echo.
echo [5/5] Connecting to GitHub and pushing...
git remote get-url origin >nul 2>nul
if errorlevel 1 (
    git remote add origin "%REPO_URL%"
) else (
    git remote set-url origin "%REPO_URL%"
)
if errorlevel 1 goto :error

git push -u origin main
if errorlevel 1 goto :error

echo.
echo SUCCESS: Your project has been pushed to GitHub.
pause
exit /b 0

:error
echo.
echo An error occurred. Read the message above, fix the issue, and try again.
pause
exit /b 1
