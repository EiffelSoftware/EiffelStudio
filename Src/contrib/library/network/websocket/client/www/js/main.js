$(function() {
  var wsEchoURI = "ws://localhost:9999/";
  var websocket;

  function printConsole(text) {
    $("#console").append($(document.createElement("p")).html(text));
  }

  function onWSOpen(evt) {
    printConsole("WebSocket open");
    if(websocket.readyState == websocket.OPEN) {
      printConsole("WebSocket ready");
    }
  }

  function onWSClose(evt) {
    printConsole("WebSocket closed");
    printConsole(websocket.readyState);
  }

  function onWSMessage(evt) {
    printConsole(evt.data);
  }

  function onWSError(evt) {
    printConsole("An error occured in the WebSocket : " + evt.data);
  }

  $("#run").click(function buttonRun() {
    printConsole("Connection");
    websocket = new WebSocket(wsEchoURI);
    websocket.onopen = function(evt) { onWSOpen(evt) };
    websocket.onclose = function(evt) { onWSClose(evt) };
    websocket.onmessage = function(evt) { onWSMessage(evt) };
    websocket.onerror = function(evt) { onWSError(evt) };
  });
});
