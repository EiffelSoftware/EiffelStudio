<!DOCTYPE html>
<html lang="en">
	{include file="master/head.tpl"/}
	<body>
		{include file="master/navbar.tpl"/}
		<div class="container-fluid" itemscope itemtype="{$host/}/static/profile/esa_api.xml">
			<div class="col-xs-12">
				<form class="form-inline well" data-rel="register" id="registerHere" method='POST' action='{$host/}/register' itemprop="create">
					<fieldset>
						<legend><h1>Registration</h1></legend>
						<div class="span3">
							<p>Register yourself with Eiffel's web site, it's quick and free.
							Once registered you will be able to access download and report problems via our support web page.
							An activation code will be sent to the email address below for verification.</p>
						</div>

						<div class="row">
							<div class="col-xs-2">
								<label class="control-label-api" itemprop="first_name" >First Name</label>
							</div>
							<div class="col-xs-6">
								<input type="text" class="form-control" id="first_name" name="first_name" rel="popover" data-content="Enter your first" data-original-title="First Name" placeholder="Enter First Name" value="{$form.first_name/}" required />
							</div>
						</div>
						<div class="row">
							<div class="col-xs-2">
								<label class="control-label-api" itemprop="last_name">Last Name</label>
							</div>
							<div class="col-xs-6">
								<input type="text" class="form-control" id="last_name" name="last_name" rel="popover" data-content="Enter your last name" data-original-title="Last Name" placeholder="Enter Last Name"value="{$form.last_name/}" required />
							</div>
						</div>
						<div class="row">
							<div class="col-xs-2">
								<label class="control-label-api" itemprop="email">Email</label>
							</div>
							<div class="col-xs-6">
								<input type="email" class="form-control" id="user_email" name="user_email" rel="popover" data-content="What’s your email address?" data-original-title="Email" placeholder="email@example.com" value="{$form.email/}" required />
							</div>
						</div>
						<div class="row">
							<div class="col-xs-2">
								<label class="control-label-api" itemprop="user_name">User Name</label>
							</div>
							<div class="col-xs-6">
								<input type="text" class="form-control" id="user_name" name="user_name" rel="popover" data-content="Enter your user_name" data-original-title="User Name" placeholder="Enter User Name"value="{$form.user_name/}" required />
							</div>
						</div>
						<div class="row">
							<div class="col-xs-2">
								<label class="control-label-api" itemprop="password">Password</label>
							</div>
							<div class="col-xs-6">
								<input type="password" class="form-control" id="password" name="password" rel="popover" data-content="Enter your password" placeholder="Enter Password" data-original-title="Password" required />
							</div>
						</div>
						<div class="row">
							<div class="col-xs-2">
								<label class="control-label-api" itemprop="check_password">Re-type Password</label>
							</div>
							<div class="col-xs-6">
								<input type="password" class="form-control" id="check_password" name="check_password" rel="popover" data-content="Re-type your password" placeholder="Confirm Password" data-original-title="Re-type Password" required />
							</div>
						</div>
						<div class="row">
							<div class="col-xs-2">
								<label class="control-label-api" for="input01">Security question</label>
							</div>
							<div class="col-xs-6">
								<select class="form-control" data-style="btn-primary" itemprop="security_question" name="question" rel="popover" data-original-title="Choose a security question">
									{foreach from="$questions" item="item"}
										{if condition="$item.id = $view.selected_question"}
											<option value="{$item.id/}" selected>{$item.question/}</option>
										{/if}
										{unless condition="$item.id = $view.selected_question"}
											<option value="{$item.id/}">{$item.question/}</option>
										{/unless}
									{/foreach}
								</select>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-2">
								<label class="control-label-api" itemprop="answer">Answer</label>
							</div>
							<div class="col-xs-6">
								<input type="text" class="form-control" id="answer_question" name="answer_question" rel="popover" data-content="Answer security question" placeholder="Answer security question" data-original-title="Answer security question" value="{$form.answer/}" required />
							</div>
						</div>
						<p></p>
						<div class="row">
							<div class="col-xs-12">
								<button type="submit" class="btn btn-primary" >Create</button>
								<input type="reset" class="btn btn-default" value="Reset" />
							</div>
						</div>

						{if isset="$has_error"}
							<div class="control-group">
								<label class="control-label">Errors</label>
								{foreach from="$form.errors" item="item"}
										{$item/} <br>
								{/foreach}
							</div>
						{/if}
					</fieldset>
				</form>
			</div>
		</div>
		{include file="master/footer.tpl"/}
	</body>
</html>
