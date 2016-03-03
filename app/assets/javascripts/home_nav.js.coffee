$(document).ready ->
  if location.pathname.indexOf("albums") > -1
    active = "#gallery"
  else
    active = location.pathname.replace("/", "#")

  if $(active.concat("-nav-btn"))[0] != undefined
    $(active.concat("-nav-btn"))[0].style.color = "#FF69B4"

  $("#new_question").on("ajax:success", (e, data, status, xhr) ->
    $('#btn-modal').click()
    $('#new_question')[0].reset()
    $.bootstrapGrowl 'Inquiry Sent. We\'ll reply to you shortly',
      type: 'success'
      delay: 3000
      allow_dismiss: true
      align: 'right'
      width: 'auto'
  ).on "ajax:error", (e, xhr, status, error) ->
    console.log("ajax error")

  $("#new_booking").on("ajax:success", (e, data, status, xhr) ->
    $('#btn-modal').click()
    $('#new_booking')[0].reset()
    $.bootstrapGrowl 'Thank you for booking our service. We\'ll get in touch with you shortly',
      type: 'success'
      delay: 3000
      allow_dismiss: true
      align: 'right'
      width: 'auto'
  ).on "ajax:error", (e, xhr, status, error) ->
    console.log("ajax error")

$(document).on "click", '.nav-btn', (event) ->
  active = event.toElement
  nav_group = $(".nav-btn")
  i = 0
  while i < nav_group.length
    if active == nav_group[i]
      active.style.color = "#FF69B4"
    else
      nav_group[i].style.color = "black"
    i++

