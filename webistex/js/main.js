<script>
  function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    const overlay = document.getElementById('overlay');
    sidebar.classList.toggle('active');
    overlay.classList.toggle('active');
  }

  document.querySelectorAll('.sidebar a').forEach(link => {
    link.addEventListener('click', () => {
      document.getElementById('sidebar').classList.remove('active');
      document.getElementById('overlay').classList.remove('active');
    });
  });
</script>
