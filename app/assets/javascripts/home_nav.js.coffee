$(document).ready ->
  if location.pathname.indexOf("albums") > -1
    active = "#gallery"
  else
    active = location.pathname.replace("/", "#")

  if $(active.concat("-nav-btn"))[0] != undefined
    $(active.concat("-nav-btn"))[0].style.color = "#FF69B4"

  if $(active.concat("-nav-btn-small"))[0] != undefined
    $(active.concat("-nav-btn-small"))[0].style.color = "#FF69B4"



$(document).on "click", '.nav-btn', (event) ->
  active = event.toElement
  nav_group = $(".nav-btn")
  $(".navbar-collapse").collapse('hide')
  i = 0
  while i < nav_group.length
    if active == nav_group[i]
      active.style.color = "#FF69B4"
    else
      nav_group[i].style.color = "black"
    i++

