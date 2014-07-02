$.event.special.inputchange = {
    setup: function() {
        var self = this, val;
        $.data(this, 'timer', window.setInterval(function() {
            val = self.value;
            if ( $.data( self, 'cache') != val ) {
                $.data( self, 'cache', val );
                $( self ).trigger( 'inputchange' );
            }
        }, 20));
    },
    teardown: function() {
        window.clearInterval( $.data(this, 'timer') );
    },
    add: function() {
        $.data(this, 'cache', this.value);
    }
};

$("#changesize").on('inputchange', function() {

     $("#imgProgress").show();
    var str = document.getElementById("currentPage").value;

    // Return all pattern matches with captured groups
    RegExp.prototype.execAll = function(string) {
    var match = null;
    var matches = new Array();
    while (match = this.exec(string)) {
        var matchArray = [];
        for (i in match) {
            if (parseInt(i) == i) {
                matchArray.push(match[i]);
            }
        }
        matches.push(matchArray);
        }
        return matches;
    }

    var results = /size=\d*/g.execAll(str);
    for (i in results) {
        str =  str.replace (results[i], "size=".concat(this.value));
    }


    var request = ((window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP"));
    request.open("GET", str, true);
    request.send(null);
    
    request.onreadystatechange = function(){
      if (request.readyState == 4) {
         if (request.status==200) { 
                window.location=str;
                $("#imgProgress").hide();
            }
     }
   }
});