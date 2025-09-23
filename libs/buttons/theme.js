function toggleTheme() {
  const html = document.documentElement;
  const icon = document.getElementById("theme-icon");
  const currentTheme = html.getAttribute("data-theme");

  if (currentTheme === "dark") {
    html.setAttribute("data-theme", "light");
    icon.className = "fas fa-moon";
    localStorage.setItem("theme", "light");
  } else {
    html.setAttribute("data-theme", "dark");
    icon.className = "fas fa-sun";
    localStorage.setItem("theme", "dark");
  }
}

// Check for saved theme preference
document.addEventListener("DOMContentLoaded", () => {
  const savedTheme = localStorage.getItem("theme");
  const html = document.documentElement;
  const icon = document.getElementById("theme-icon");

  if (savedTheme === "dark") {
    html.setAttribute("data-theme", "dark");
    icon.className = "fas fa-sun";
  }
});
