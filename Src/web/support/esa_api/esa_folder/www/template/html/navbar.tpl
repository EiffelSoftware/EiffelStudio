<!-- Modal  Login-->
<div class="modal fade" id="myModalLogin" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" itemscope itemtype="{$host/}/profile/esa_api.xml">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
         <h4 class="modal-title" id="myModalLabel">Login Form</h4>
      </div>
      <div class="modal-body" id="myModalForm">
         <a href="{$host/}/reminder" itemprop="reminder" rel="reminder">Forgot username or password?</a>
          <form itemprop="login">
            <p itemprop="user-name"><input type="text" class="span3" name="username" id="username" placeholder="Enter Username" value="" required></p>
            <p itemprop="password"><input type="password" class="span3" id="password" name="password" placeholder="Enter Password" required></p>
	    <input type="hidden" name="host" value="{$host/}">
            <p><button type="button" class="btn btn-success" onclick="login();">Sign in</button></p>
          </form>
      </div>
    </div>
  </div>
</div>
<!-- Modal  Logoff-->
<div class="modal fade" id="myModalLogoff" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" itemscope itemtype="{$host/}/profile/esa_api.xml">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
         <h4 class="modal-title" id="myModalLabel">Are you sure to Logoff?</h4>
      </div>
      <div class="modal-body">
          <form itemprop="logoff">
	         <input type="hidden" name="host" value="{$host/}">
            <p><button type="button" class="btn btn-success" onclick="logoff();">Logoff</button></p>
          </form>
      </div>
    </div>
  </div>
</div>
   
<div class="navbar navbar-inverse navbar-fixed-top" role="navigation" itemscope itemtype="{$host/}/profile/esa_api.xml">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
         <a class="navbar-brand" href="{$host/}" itemprop="home" rel="home">Eiffel Support API</a>
     </div>
    <div class="navbar-collapse collapse">
      <ul class="nav navbar-nav navbar-right">
          {if isset="$user"}
           <li><a href="#">{$user/}</a></li>
         {/if}
         {unless isset="$user"}
              <li><a href="#">Guest</a></li>
              <li><a href="{$host/}/register" itemprop="register" rel="register">Register</a></li> 
         {/unless} 
         
         {if isset="$user"}
            <li><a class="btn pull-right" data-toggle="modal"  data-target="#myModalLogoff" rel="logoff" itemprop="logoff">Logoff</a></li>
         {/if}
         {unless isset="$user"}
            <li><a class="btn pull-right" data-toggle="modal"  data-target="#myModalLogin">Login</a></li>  <!--  Custome Modal -->
            <!-- <li><a href="{$host/}/login">Login</a></li> -->   <!--Browser pop up -->
         {/unless} 
         <li><a href="#">Help</a></li>
        </ul>
      <!--form class="navbar-form navbar-right">
        <input type="text" class="form-control" placeholder="Search...">
      </form -->
    </div>
  </div>
</div>