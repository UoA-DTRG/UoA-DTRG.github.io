Write-Host "==> Checking Ruby installation..." -ForegroundColor Yellow
if (-not (Get-Command ruby -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Ruby via Chocolatey..." -ForegroundColor Yellow
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }
    choco install -y ruby git
    refreshenv
}

Write-Host "==> Installing bundler..." -ForegroundColor Yellow
gem install bundler --no-document

if (-not (Test-Path "Gemfile")) {
@"
source "https://rubygems.org"
gem "github-pages", group: :jekyll_plugins
"@ | Out-File -Encoding UTF8 Gemfile
}

Write-Host "==> Installing gems..." -ForegroundColor Yellow
bundle install

Write-Host "✅ Setup complete! Run ./Tools/serve.ps1 to start your site." -ForegroundColor Green
