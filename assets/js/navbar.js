document.addEventListener("DOMContentLoaded", () => {
  const header = document.querySelector(".main-header");
  const menuToggle = document.getElementById("menuToggle");
  const closeSidebar = document.getElementById("closeSidebar");
  const mobileSidebar = document.getElementById("mobileSidebar");
  const sidebarOverlay = document.getElementById("sidebarOverlay");
  const mobileDropdownToggles = document.querySelectorAll(
    ".mobile-dropdown-toggle",
  );

  // Scroll Effect
  window.addEventListener("scroll", () => {
    if (window.scrollY > 50) {
      header.classList.add("scrolled");
    } else {
      header.classList.remove("scrolled");
    }
  });

  // Mobile Menu Toggle
  const toggleSidebar = () => {
    mobileSidebar.classList.toggle("active");
    sidebarOverlay.classList.toggle("active");
    document.body.style.overflow = mobileSidebar.classList.contains("active")
      ? "hidden"
      : "";
  };

  if (menuToggle) menuToggle.addEventListener("click", toggleSidebar);
  if (closeSidebar) closeSidebar.addEventListener("click", toggleSidebar);
  if (sidebarOverlay) sidebarOverlay.addEventListener("click", toggleSidebar);

  // Mobile Dropdowns
  mobileDropdownToggles.forEach((toggle) => {
    toggle.addEventListener("click", (e) => {
      e.preventDefault();
      const submenu = toggle.nextElementSibling;
      const icon = toggle.querySelector("i");

      submenu.classList.toggle("active");
      if (icon) {
        icon.style.transform = submenu.classList.contains("active")
          ? "rotate(180deg)"
          : "rotate(0deg)";
      }
    });
  });

  // Close sidebar on link click
  const mobileLinks = document.querySelectorAll(
    ".mobile-nav-link:not(.mobile-dropdown-toggle), .mobile-submenu-item a",
  );
  mobileLinks.forEach((link) => {
    link.addEventListener("click", () => {
      mobileSidebar.classList.remove("active");
      sidebarOverlay.classList.remove("active");
      document.body.style.overflow = "";
    });
  });
});
