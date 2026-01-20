import os
import re

NAVBAR_HTML = """    <!-- New Modern Header -->
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

    <div class="main-content">"""

def update_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Skip already updated files
    if 'main-header' in content:
        print(f"Skipping {filepath} - already updated")
        return

    # Add stylesheet link after </style>
    content = re.sub(r'</style>', r'</style>\n    <link rel="stylesheet" href="assets/css/navbar-modern.css" />', content)

    # Replace Sidebar and Header
    # This regex is broad enough to catch different variations of the sidebar/header
    sidebar_pattern = r'<!-- (?:Enhanced )?Sidebar -->\s*<aside class="sidebar".*?</aside>'
    overlay_pattern = r'<div class="overlay".*?</div>'
    header_pattern = r'<div class="main-content">\s*(?:<!-- (?:Enhanced )?Header -->\s*)?<header.*?</header>'

    # Alternative pattern if comments are missing or different
    full_nav_pattern = r'(<aside class="sidebar".*?</aside>.*?<div class="overlay".*?</div>.*?<div class="main-content">.*?<header.*?</header>)'

    content = re.sub(sidebar_pattern, '', content, flags=re.DOTALL)
    content = re.sub(overlay_pattern, '', content, flags=re.DOTALL)
    
    # Replace header and wrap it in the new structure
    # We replace from <header> to </header> inside <div class="main-content">
    content = re.sub(r'<div class="main-content">.*?<header.*?</header>', NAVBAR_HTML, content, flags=re.DOTALL)

    # Add JS script before </body>
    if 'assets/js/navbar.js' not in content:
        content = re.sub(r'</body>', r'    <script src="assets/js/navbar.js"></script>\n  </body>', content)

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f"Updated {filepath}")

# List of files to update
files = [
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
]

for f in files:
    if os.path.exists(f):
        update_file(f)
    else:
        print(f"File not found: {f}")
