$(function(){
  $('#new_question').submit(function(e){
    e.preventDefault();
    $.ajax({
      url: $(this).attr('action'),
      type: 'POST',
      data: $(this).serialize(),
      success: function(){
        $('#btn-modal').click();
        $('#new_question')[0].reset();
        $.bootstrapGrowl("Inquiry Sent. We'll reply to you shortly", { type: 'success', delay: 3000, allow_dismiss: true, align: 'right', width: 'auto' });
      }
    });
  });

  $('#new_booking').submit(function(e){
    e.preventDefault();
    $.ajax({
      url: $(this).attr('action'),
      type: 'POST',
      data: $(this).serialize(),
      success: function(){
        $('#btn-modal').click();
        $('#new_booking')[0].reset();
        $.bootstrapGrowl("Thank you for booking our service. We'll get in touch with you shortly", { type: 'success', delay: 3000, allow_dismiss: true, align: 'right', width: 'auto' });
      }
    });
  });
});