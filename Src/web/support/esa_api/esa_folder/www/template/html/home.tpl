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
            <h1>Eiffel Support Site</h1>
            <p>It's an Hypermedia API using HTML5 and Collection+JSON (CJ).  
            <p><a href="{$host/}/register" target="_blank" class="btn btn-success btn-large">Get started today</a></p>
        </div>
        <div class="row">
            <div class="col-sm-4 col-md-4 col-lg-3">
                <h2>HTML5 API</h2>
                <p>HTML5 is a well known media type. The HTML5 tutorial section will help you understand the basics of API, using your browser.</p>
                <p><a href="#" target="_blank" class="btn btn-success btn-medium">Learn More »</a></p>
            </div>
            <div class="col-sm-4 col-md-4 col-lg-3">
                <h2>CJ API</h2>
                <p>Collection JSON is an hypermedia type to describe APIs, here you will find examples about how to use the API using cURL or a CJ browser</p>
                <p><a href="{$host/}/doc/cj_doc.html" target="_blank" class="btn btn-success btn-medium">Learn More »</a></p>
            </div>
            <div class="clearfix visible-sm"></div>
            <div class="col-sm-4 col-md-4 col-lg-3">
                <h2>API Examples</h2>
                <p>The examples section encloses an extensive collection of examples on various topic that you can try and test the API using a Collection JSON generic client or and HTML browser.</p>
                <p><a href="#" target="_blank" class="btn btn-success btn-medium">Learn More »</a></p>
            </div>
            <div class="col-sm-4 col-md-4 col-lg-3">
                <h2>FAQ</h2>
                <p>The collection of Frequently Asked Questions (FAQ) provides brief answers to many common questions related to Eiffel Support API.</p>
                <p><a href="#" target="_blank" class="btn btn-success btn-medium">Learn More »</a></p>
            </div>
        </div>  
        <hr>
        <div class="row">
            <div class="col-sm-12">
                <footer>
                    <p>© Copyright 2014 Eiffel Software</p>
                </footer>
            </div>
        </div>
    </div>

    <!-- Placed at the end of the document so the pages load faster -->
    {include file="optional_enhancement_js.tpl"/}     
  </body>
</html>
