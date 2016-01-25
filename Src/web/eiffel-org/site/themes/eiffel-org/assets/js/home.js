var EHOME = EHOME || { };

$(document).ready(function() {
    $("main input, main textarea").on("input change", function() {
        window.onbeforeunload = window.onbeforeunload || function (e) {
            return "You have unsaved changes.  Do you want to leave this page and lose your changes?";
        };
    });
    $("form").on("submit", function() {
        window.onbeforeunload = null;
    });
});

