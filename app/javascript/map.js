document.addEventListener("turbo:load", async () => {
    const map = "/map/map-full.svg";
    const container = document.querySelector("#map");
  
    if (!container) return;
  
    const res = await fetch(map);
  
    if (res.ok) {
      const svg = await res.text();
      container.innerHTML = svg;
  
      const prefs = document.querySelectorAll(".geolonia-svg-map .prefecture");
  
      prefs.forEach((pref) => {
        pref.addEventListener("mouseover", (event) => {
          event.currentTarget.style.fill = "#eb714c";
        });
  
        pref.addEventListener("mouseleave", (event) => {
          event.currentTarget.style.fill = "";
        });
  
        pref.addEventListener("click", (event) => {
          const dataCode = event.currentTarget.dataset.code;
          if (dataCode) {
            window.location.href = `/cities/${dataCode}`;
          }
        });
      });
    }
  });