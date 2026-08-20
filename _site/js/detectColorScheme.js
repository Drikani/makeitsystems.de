function activateDarkMode() {
    document.querySelector('meta[name="twitter:widgets:theme"]').setAttribute("content", "light");
}
function activateLightMode() {
    document.querySelector('meta[name="twitter:widgets:theme"]').setAttribute("content", "dark");
}
function setColorScheme() {
    const isDarkMode = window.matchMedia("(prefers-color-scheme: dark)").matches
    const isLightMode = window.matchMedia("(prefers-color-scheme: light)").matches
  
    window.matchMedia("(prefers-color-scheme: dark)").addListener(e => e.matches && activateDarkMode())
    window.matchMedia("(prefers-color-scheme: light)").addListener(e => e.matches && activateLightMode())
  
    if(isDarkMode) activateDarkMode()
    if(isLightMode) activateLightMode()
}

setColorScheme();