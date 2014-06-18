<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
     {include file="optional_styling_css.tpl"/}     
  </head>

  <body>
     {include file="navbar.tpl"/}  

  <div class="container">
        <div class="jumbotron">
            <h1>Eiffel Software Support</h1>
            <p><small>The Eiffel Software Support web site, your one stop destination for information and support on Eiffel products and technologies.</small> 
        </div>
        <div class="row">
            <div class="col-sm-6 col-md-6 col-lg-6">
                <h2 class="info">Assited Support</h2>
                <p> <a href="#" target="_blank" class="info">View</a> and <a href="#" target="_blank" class="info">submit</a> problem and bug reports to the Eiffel Software Team through this web site. 
                    Customers with a higher priority <a href="http://www.eiffel.com/services/support/" target="_blank" class="info">Support Plan</a> receive faster response times and problem resolution. 
                    Additional support options include email, phone, fax and <a href="http://www.eiffel.com/services/training/index.html" target="_blank" class="info">training courses</a> from an Eiffel Software professional.
                </p>
               
            </div>
            <div class="col-sm-6 col-md-6 col-lg-6">
                <h2>Self Support</h2>
                <p>Self-support
                  Learn more about Eiffel Technologies from various online resources. Browse our full <a href="http://docs.eiffel.com/" target="_blank" class="info">online documentation</a> and <a href="http://www.eiffel.com/search/search.html"target="_blank" class="info">technical archives</a>, purchase educational and reference material, or join the <a href="http://groups.yahoo.com/group/eiffel_software/" target="_blank" class="info">Eiffel User Group</a> to discuss issues and get help.</p>
               
            </div>
        </div>  
        <hr>
        <!--div class="row">
            <div class="container">
                <footer>
                    <p class="text-muted"><a href="{$host/}/doc/esa_doc.html" target="_blank" class="info">API Documentation </a></p>
                    <p class="text-muted"><a href="http://www.eiffel.com/company/contact/" target="_blank" class="info">Questions? Comments? Let us know! </a></p>
                    <p class="text-muted">© Copyright 2014 Eiffel Software -- <a href="http://www.eiffel.com/privacy-policy" target="_blank" class="info">Privacy Policy</a> </p>
                </footer>

            </div>
        </div> -->
        <div id="footer">
            <div class="container">
                   <p class="text-muted"><a href="{$host/}/doc/esa_doc.html" target="_blank" class="info">API Documentation </a></p>
                    <p class="text-muted"><a href="http://www.eiffel.com/company/contact/" target="_blank" class="info">Questions? Comments? Let us know! </a></p>
                    <p class="text-muted">© Copyright 2014 Eiffel Software -- <a href="http://www.eiffel.com/privacy-policy" target="_blank" class="info">Privacy Policy</a> </p>
              </div>
        </div>
    </div>


    <!-- Placed at the end of the document so the pages load faster -->
    {include file="optional_enhancement_js.tpl"/}     
  </body>
</html>
