$files = @(
    "index.html",
    "Photo Gallery.html",
    "about-board-of-advisors.html",
    "about-board-of-directors.html",
    "about-mission-vision-purpose.html",
    "about2.html",
    "achievements.html",
    "functions.html",
    "news.html",
    "partnership.html"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "Cleaning CSS in $file..."
        $content = Get-Content $file -Raw
        
        # Remove old CSS selectors related to navbar/sidebar/header
        $selectors = @(
            '\.sidebar\s*\{.*?\}',
            '\.sidebar\.active\s*\{.*?\}',
            '\.sidebar\s+nav\s+ul\s*\{.*?\}',
            '\.sidebar\s+nav\s+ul\s+li\s*\{.*?\}',
            '\.sidebar\s+nav\s+ul\s+li\s+a\s*\{.*?\}',
            '\.sidebar\s+nav\s+ul\s+li\s+a\s+i\s*\{.*?\}',
            '\.sidebar\s+nav\s+ul\s+li\.has-sub\s*>\s*a\s*\{.*?\}',
            '\.sidebar\s+nav\s+ul\s+li\.has-sub\s*>\s*a\s+\.chev\s*\{.*?\}',
            '\.sidebar\s+nav\s+ul\s+li\.has-sub\.open\s*>\s*a\s+\.chev\s*\{.*?\}',
            '\.submenu\s*\{.*?\}',
            '\.submenu\.open\s*\{.*?\}',
            '\.submenu\s+li\s+a\s*\{.*?\}',
            '\.sidebar\s+nav\s+ul\s+li\.has-sub:hover\s*>\s*a\s+\.chev\s*\{.*?\}',
            '\.sidebar\s+nav\s+ul\s+li\.has-sub:hover\s+\.submenu\s*\{.*?\}',
            '\.sidebar\s+nav\s+ul\s+li\.has-sub\s+\.submenu:hover\s*\{.*?\}',
            '\.office-box\s*\{.*?\}',
            '\.office-box\s+h4\s*\{.*?\}',
            '\.office-box\s+a\s*\{.*?\}',
            '\.overlay\s*\{.*?\}',
            '\.overlay\.active\s*\{.*?\}',
            'header\s*\{.*?\}',
            'header\s+\.left-logo\s*\{.*?\}',
            'header\s+img\s*\{.*?\}',
            'header\s+h2\s*\{.*?\}',
            '\.menu-toggle\s*\{.*?\}',
            '\.menu-toggle:hover\s*\{.*?\}',
            '\.menu-toggle\s+\.bar\s*\{.*?\}',
            '\.menu-toggle\.open\s+\.bar:nth-child\(1\)\s*\{.*?\}',
            '\.menu-toggle\.open\s+\.bar:nth-child\(2\)\s*\{.*?\}',
            '\.menu-toggle\.open\s+\.bar:nth-child\(3\)\s*\{.*?\}'
        )

        foreach ($selector in $selectors) {
            $content = [regex]::Replace($content, '(?s)' + $selector, "")
        }

        # Also remove old JS functions related to sidebar
        $content = [regex]::Replace($content, '(?s)function toggleSidebar\(\)\{.*?\}', "")
        $content = [regex]::Replace($content, '(?s)document\.querySelectorAll\(''\.sidebar a''\)\.forEach\(.*?\);', "")
        $content = [regex]::Replace($content, '(?s)// About submenu toggle.*?\(function\(\)\{.*?\}\)\(\);', "")

        [System.IO.File]::WriteAllText((Get-Item $file).FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Cleaned $file"
    }
}
