$navbar_html = @"
    <!-- New Modern Header -->
    <header class="main-header">
      <div class="header-container">
        <div class="logo-area">
          <button class="menu-toggle" id="menuToggle">
            <i class="fas fa-bars"></i>
          </button>
          <a href="index.html" class="logo-link">
            <img src="assets/img/NEPS Nav Logo.png" alt="NEPS Logo" class="logo-img" />
            <span class="logo-text">NEPS</span>
          </a>
        </div>

        <nav class="desktop-nav">
          <ul class="nav-list">
            <li class="nav-item">
              <a href="index.html" class="nav-link">Home</a>
            </li>
            <li class="nav-item has-dropdown">
              <a href="#" class="nav-link">About Us <i class="fas fa-chevron-down"></i></a>
              <ul class="dropdown-menu">
                <li class="dropdown-item"><a href="about-mission-vision-purpose.html">Mission & Vision</a></li>
                <li class="dropdown-item"><a href="about-board-of-directors.html">Board of Directors</a></li>
                <li class="dropdown-item"><a href="about-board-of-advisors.html">Board of Advisors</a></li>
              </ul>
            </li>
            <li class="nav-item">
              <a href="functions.html" class="nav-link">Functions</a>
            </li>
            <li class="nav-item">
              <a href="partnership.html" class="nav-link">Partnerships</a>
            </li>
            <li class="nav-item">
              <a href="achievements.html" class="nav-link">Achievements</a>
            </li>
            <li class="nav-item">
              <a href="news.html" class="nav-link">News</a>
            </li>
            <li class="nav-item">
              <a href="Photo Gallery.html" class="nav-link">Gallery</a>
            </li>
          </ul>
        </nav>

        <div class="header-actions">
          <a href="#" class="donate-btn">Donate</a>
        </div>
      </div>
    </header>

    <!-- Mobile Sidebar -->
    <div class="sidebar-overlay" id="sidebarOverlay"></div>
    <aside class="mobile-sidebar" id="mobileSidebar">
      <div class="sidebar-header">
        <img src="assets/img/NEPS Nav Logo.png" alt="NEPS Logo" class="logo-img" style="height: 40px;" />
        <button class="close-sidebar" id="closeSidebar">
          <i class="fas fa-times"></i>
        </button>
      </div>
      <nav class="mobile-nav">
        <ul class="mobile-nav-list">
          <li class="mobile-nav-item">
            <a href="index.html" class="mobile-nav-link">Home</a>
          </li>
          <li class="mobile-nav-item">
            <a href="#" class="mobile-nav-link mobile-dropdown-toggle">About Us <i class="fas fa-chevron-down"></i></a>
            <ul class="mobile-submenu">
              <li class="mobile-submenu-item"><a href="about-mission-vision-purpose.html">Mission & Vision</a></li>
              <li class="mobile-submenu-item"><a href="about-board-of-directors.html">Board of Directors</a></li>
              <li class="mobile-submenu-item"><a href="about-board-of-advisors.html">Board of Advisors</a></li>
            </ul>
          </li>
          <li class="mobile-nav-item">
            <a href="functions.html" class="mobile-nav-link">Functions</a>
          </li>
          <li class="mobile-nav-item">
            <a href="partnership.html" class="mobile-nav-link">Partnerships</a>
          </li>
          <li class="mobile-nav-item">
            <a href="achievements.html" class="mobile-nav-link">Achievements</a>
          </li>
          <li class="mobile-nav-item">
            <a href="news.html" class="mobile-nav-link">News</a>
          </li>
          <li class="mobile-nav-item">
            <a href="Photo Gallery.html" class="mobile-nav-link">Gallery</a>
          </li>
          <li class="mobile-nav-item" style="margin-top: 20px;">
            <a href="#" class="donate-btn" style="display: block; text-align: center;">Donate</a>
          </li>
        </ul>
      </nav>
    </aside>

    <div class="main-content">
"@

$files = @(
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
        Write-Host "Processing $file..."
        $content = Get-Content $file -Raw
        
        if ($content -like "*main-header*") {
            Write-Host "Skipping $file - already updated"
            continue
        }

        # Add stylesheet link
        $content = $content -replace '</style>', "</style>`n    <link rel=`"stylesheet`" href=`"assets/css/navbar-modern.css`" />"

        # Replace Sidebar, Overlay, and Header
        $content = [regex]::Replace($content, '(?s)<aside class="sidebar".*?</aside>', "")
        $content = [regex]::Replace($content, '(?s)<div class="overlay".*?</div>', "")
        
        # Replace Header inside main-content or just the header tag
        $content = [regex]::Replace($content, '(?s)<div class="main-content">.*?<header.*?</header>', $navbar_html)

        # Add JS script
        if ($content -notlike "*assets/js/navbar.js*") {
            $content = $content -replace '</body>', "`n    <script src=`"assets/js/navbar.js`"></script>`n  </body>"
        }

        [System.IO.File]::WriteAllText((Get-Item $file).FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Updated $file"
    }
    else {
        Write-Host "File not found: $file"
    }
}
