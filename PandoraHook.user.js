// ==UserScript==
// @name        PandoraHook
// @namespace   http://jaburns.net/
// @match       http://www.pandora.com/
// @description Notifies a local http server of the current song, and interprets
//              the server's response to control playback.
// ==/UserScript==

var PORT  = 1338;
var DELAY = 1000;

setInterval (update, DELAY);

function update ()
{
    click (elem ("still_listening"));

    var songInfo =
        [ "playerBarSong",
          "playerBarArtist",
          "playerBarAlbum" ]
        .map (function (s) { return elem (s) .innerText })
        .join ("|");

    var liked = elem ("thumbUpButton") .classList.contains ("indicator");

    hitServer ("pandora|"+songInfo+"|"+liked+"|"+isPlaying());
}

function hitServer (request)
{
    GM_xmlhttpRequest({
        method: "GET",
        url: "http://localhost:"+PORT+"/" + encodeURIComponent (request),
        onload: handleResponse
    });
}

function handleResponse (result)
{
    switch (result.responseText) {
        case "up":   click (elem ("thumbUpButton"));   break;
        case "down": click (elem ("thumbDownButton")); break;
        case "skip": click (elem ("skipButton"));      break;
        case "pause":
        case "play":
            click (elem (isPlaying () ? "pauseButton" : "playButton"));
            setTimeout (update, 50);
            break;
    }
}

function elem (className) {
    return document.getElementsByClassName (className) [0];
}

function isPlaying () {
    return elem ("playButton").style.display === "none";
}

function click (elem)
{
    if (!elem) return;
    
    var evObj = document.createEvent ("MouseEvents");
    evObj.initMouseEvent ("click", true, true, window, 1, 12, 345, 7, 220,
                          false, false, true, false, 0, null);
    elem.dispatchEvent (evObj);
}

