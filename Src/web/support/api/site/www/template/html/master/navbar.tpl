<!-- Modal	SignIn-->
<div class="modal fade" id="myModalSignIn" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" itemscope itemtype="{$host/}/profile/esa_api.xml">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Sign In Form</h4>
			</div>
			<div class="modal-body" id="myModalForm">
				<a href="{$host/}/reminder" itemprop="reminder" rel="reminder">Forgot username or password?</a>
				<form data-rel="login" itemprop="login">
					<p itemprop="user_name"><input type="text" class="form-control" name="username" id="username" placeholder="Enter Username or Email" value="" required/></p>
					<p itemprop="password"><input type="password" class="form-control" id="password" name="password" placeholder="Enter Password" required/></p>
					<p itemprop="remember_me"><input type="checkbox" name="remember_me" value="remember me" checked> Remember me<br>
					<input type="hidden" name="host" value="{$host/}"/>
					<div class="controls">
						<button type="button" class="btn btn-primary" onclick="login();">Sign In</button>
						<input type="reset" class="btn btn-default" value="Reset"/><img src="{$host/}/static/images/ajax-loader.gif" alt="Loading..." style="display: none;" id="imgProgress" />
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- Modal	SignOut-->
<div class="modal fade" id="myModalSignOut" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" itemscope itemtype="{$host/}/profile/esa_api.xml">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Are you sure you want to sign out?</h4>
			</div>
			<div class="modal-body">
				<form data-rel="logoff" itemprop="logoff">
					<input type="hidden" name="host" value="{$host/}"/>
					<p><button type="button" class="login btn-primary" onclick="logoff();">Sign Out</button></p>
				</form>
			</div>
		</div>
	</div>
</div>

<div class="navbar navbar-default navbar-fixed-top" role="navigation" itemscope="itemscope" itemtype="{$host/}/static/profile/esa_api.xml">
	<input id="host_pe" type="hidden" name="host" value="{$host/}"/>
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span>
			</button>
			<a class="navbar-brand" href="{$host/}" itemprop="home" rel="home">Eiffel Support Site</a>
		</div>
		<div class="navbar-collapse collapse" itemscope="itemscope" itemtype="{$host/}/static/profile/esa_api.xml#report" >
			<ul class="nav navbar-nav navbar-left">
				<li><a href="{$host/}/reports" class="active" itemprop="all" rel="all">Reports</a></li>
					{if isset="$user"}
						<li><a href="{$host/}/user_reports/{$user/}" itemprop="all_user" rel="all_user">My Reports</a></li>
						<li><a href="{$host/}/report_form" itemprop="create_report_problem" rel="create_report_problem">Report a Problem</a></li>
					{/if}
			</ul>
			<ul class="nav navbar-nav navbar-right">
				{if isset="$user"}
					<li id="dropdown_pe_1">
						<input id="user_pe" type="hidden" name="user" value="{$user/}"/>
						<a>{$user/} </a></li>
					<li id="dropdown_pe_2"><a href="{$host/}/account" itemprop="account_information" rel="account_information">Account Information</a></li>
					<li id="dropdown_pe_3"><a href="{$host/}/password" itemprop="change_password" rel="change_password">Change Password</a></li>
					<li id="dropdown_pe_4"><a href="{$host/}/email" itemprop="change_email" rel="change_email">Change Email</a></li>
				{/if}
				{unless isset="$user"}
					<li><a href="{$host/}/register" itemprop="register" rel="register">Register</a></li>
				{/unless}

				{if isset="$user"}
					<li id="logoff_pe" ><a href="{$host/}/logoff" itemprop="logoff" rel="logoff">Sign Out</a></li>
				{/if}
				{unless isset="$user"}
					<!--<li><a class="login pull-right" data-toggle="modal" data-target="#myModalSignIn">Sign In</a></li>	<! Custome Modal -->
					<li id="login_pe" ><a href="{$host/}/login" itemprop="login" rel="login">Sign In</a></li>	<!--	Custome Modal -->
				{/unless}
			</ul>
			<!--form class="navbar-form navbar-right">
				<input type="text" class="form-control" placeholder="Search..."/>
			</form -->
		</div>
	</div>
</div>
