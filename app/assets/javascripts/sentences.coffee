$(document).ready ->

  $("#new_sentence").on("ajax:success", (e, data, status, xhr) ->
    $("#story p").append " #{data.text}"
    $("#new_sentence")[0].reset()
    $("#new_sentence").attr('action', "/sentences/#{data.id}/sentences")
    history.pushState({id: 'sentence_state'}, '', data.id);
    $("#errors").html ""
    $("#nextLines").html ""
  ).on "ajax:error", (e, xhr, status, error) ->
    console.log(xhr.responseText);
    $("#errors").html "<ul><li>#{xhr.responseText}</li></ul>"