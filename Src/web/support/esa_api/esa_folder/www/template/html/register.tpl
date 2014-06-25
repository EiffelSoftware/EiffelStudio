<!DOCTYPE html>
<html lang="en">

  {include file="head.tpl"/}     

  <body>
     {include file="navbar.tpl"/}  

    <div class="container" itemscope itemtype="{$host/}/profile/esa_api.xml">
          <div class="main">
          <form class="form-horizontal well" data-rel="register" id="registerHere" method='POST' action='{$host/}/register' itemprop="create">
            <fieldset>

              <legend><h1>Registration</h1></legend>
              <p>Register yourself with Eiffel's web site, it's quick and free. 
              Once registered you will be able to access download and report problems via our support web page.
              An activation code will be sent to the email address below for verification.</p> 
              <div class="form-group">
                <label class="control-label col-xs-3" itemprop="first_name" >First Name</label>
                 <div class="col-xs-9">
                  <input type="text" class="input-xlarge" id="first_name" name="first_name" rel="popover" data-content="Enter your first" data-original-title="First Name"  placeholder="Enter First Name" value="{$form.first_name/}" required>
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-xs-3" itemprop="last_name">Last Name</label>
                 <div class="col-xs-9">
                  <input type="text" class="input-xlarge" id="last_name" name="last_name" rel="popover" data-content="Enter your last name" data-original-title="Last Name"  placeholder="Enter Last Name"value="{$form.last_name/}" required>
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-xs-3" itemprop="email">Email</label>
                 <div class="col-xs-9">
                  <input type="email" class="input-xlarge" id="user_email" name="user_email" rel="popover" data-content="What’s your email address?" data-original-title="Email" placeholder="email@example.com" value="{$form.email/}" required>
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-xs-3" itemprop="user_name">User Name</label>
                 <div class="col-xs-9">
                  <input type="text" class="input-xlarge" id="user_name" name="user_name" rel="popover" data-content="Enter your user_name" data-original-title="User Name" placeholder="Enter User Name"value="{$form.user_name/}" required>
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-xs-3" itemprop="password">Password</label>
                 <div class="col-xs-9">
                  <input type="password" class="input-xlarge" id="password" name="password" rel="popover" data-content="Enter your password" placeholder="Enter Password" data-original-title="Password" required>
                </div>
              </div>


              <div class="form-group">
                <label class="control-label col-xs-3" itemprop="check_password">Re-type Password</label>
                 <div class="col-xs-9">
                  <input type="password" class="input-xlarge" id="check_password" name="check_password" rel="popover" data-content="Re-type your password" placeholder="Confirm Password" data-original-title="Re-type Password" required>
                </div>
              </div>

               <div class="form-group">
                 <label class="control-label col-xs-3" for="input01">Choose a security question</label>
                 <div class="col-xs-9">
                   <select  data-style="btn-primary" itemprop="security_question" name="question" >
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

              <div class="form-group">
                <label class="control-label col-xs-3" itemprop="answer">Answer security question</label>
                <div class="col-xs-9">
                  <input type="text" class="input-xlarge" id="answer_question" name="answer_question" rel="popover" data-content="Answer security question" placeholder="Answer security question" data-original-title="Answer question" value="{$form.answer/}" required>
                </div>
              </div>
              <div class="form-group">
                <div class="col-xs-offset-3 col-xs-9">
                  <button type="submit" class="btn btn-primary" >Create My Account</button>
                  <input type="reset" class="btn btn-default" value="Reset">
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
    </div>
    <!-- Placed at the end of the document so the pages load faster -->
    {include file="optional_enhancement_js.tpl"/}     
  </body>
</html>