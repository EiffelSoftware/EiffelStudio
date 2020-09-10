<div class="contact-box clearfix">
    <h1>Contact us!</h1>
    <form method="post" action="{$site_url/}contact" id="{$form_id/}">
        <label for="name">Name: <span class="required">*</span></label>
        <input type="text" id="name" name="name" value="{htmlentities}{$name/}{/htmlentities}" required="required" autofocus="autofocus" />
         
        <label for="email">Email Address: <span class="required">*</span></label>
        <input type="email" id="email" name="email" value="{htmlentities}{$email/}{/htmlentities}" required="required" />
         
        <label for="message">Message: <span class="required">*</span></label>
        <textarea id="message" name="message" required="required" data-minlength="20" minlength="20" >{htmlentities}{$message/}{/htmlentities}</textarea>
		{unless isempty="$recaptcha_site_html"}{$recaptcha_site_html/}<br/>{/unless}
        <input type="submit" value="Send" class="submit-button" />
        <p class="req-field-desc"><span class="required">*</span> indicates a required field</p>
    </form>
    {unless isempty="$error_response"}
        <ul class="message error">
			{foreach item="item" from="$error_response"}<li class="info">{$item/}</li>{/foreach}
        </ul>
        <div class="notice"> Try again later </div>
    {/unless}        
</div>
