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
                <p> <a href="#" target="_blank" class="info">View »</a> and <a href="#" target="_blank" class="info">submit »</a> problem and bug reports to the Eiffel Software Team through this web site. 
                    Customers with a higher priority Support Plan receive faster response times and problem resolution. 
                    Additional support options include email, phone, fax and training courses from an Eiffel Software professional.
                </p>
               
            </div>
            <div class="col-sm-6 col-md-6 col-lg-6">
                <h2>Self Support</h2>
                <p>Self-support
                  Learn more about Eiffel Technologies from various online resources. Browse our full online documentation and technical archives, purchase educational and reference material, or join the Eiffel User Group to discuss issues and get help.</p>
               
            </div>
        </div>  
        <hr>
        <div class="row">
            <div class="col-sm-12 ">
                <footer >
                    <p class="text-left"><a href="{$host/}/doc/esa_doc.html" target="_blank" class="info">API Documentation</a></p>
                    <p class="text-right">© Copyright 2014 Eiffel Software</p>
                </footer>

            </div>
        </div>
    </div>


    <!-- Placed at the end of the document so the pages load faster -->
    {include file="optional_enhancement_js.tpl"/}     
  </body>
</html>
