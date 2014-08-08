var firstExecution = true;

$(document).ready(function() {

  $("#changesize").pressEnter( function() {
       $("#pageLoad").show();
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


                        /** http://msdn.microsoft.com/en-us/library/ie/bg182625(v=vs.85).aspx  Compatibility changes in IE11*/ 
                        if ((navigator.userAgent.indexOf('MSIE') !== -1) ||  (navigator.userAgent.indexOf('Trident') !== -1)) {
                            $(location).attr('href',str);    
                        } else {

                        var request = ((window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP"));
                        request.open("GET", str, true);
                        request.send(null);
                        
                        request.onreadystatechange = function(){
                          if (request.readyState == 4) {
                             if (request.status==200) { 
                                    //window.location=str;
                                    $("#pageLoad").hide();
                                      //document.open();
                                      document.write(request.responseText);
                                      window.history.pushState(request.responseText, "Support Site for Eiffel users", str);
                                      document.close();
                                      document.contentWindow.stop();
                                } else {
                                  $("#pageLoad").hide();
                                    //document.open();
                                    document.write(request.responseText);
                                    window.history.pushState(request.responseText, "Support Site for Eiffel users", str);
                                    document.close();
                                    document.contentWindow.stop();
                                }

                           } 
                     }
                  }
      });

});