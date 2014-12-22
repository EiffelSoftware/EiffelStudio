<div id="breadcumb">
	<span class="ico"><img src="/theme/images/ico-documnet.png" width="21" height="21" alt="Image Description"></span>
			  		<a href="{$site_url/}/about">About</a>
			  		:: Contact
</div>

<p>Have a question? Something you see doesn't work? Anything else? You can leave a message using the contact
form below.</p>



<div id="contact-form" class="clearfix">
    <h1>Contact us!</h1>
    <ul id="errors" class="">
        <li id="info">There were some problems with your form submission:</li>
    </ul>
    <p id="success">Thanks for your message! We will get back to you ASAP!</p>
    <form method="post" action="{$site_url/}/post_contact">
        <label for="name">Name: <span class="required">*</span></label>
        <input type="text" id="name" name="name" value="{$name/}" placeholder="John Doe" required="required" autofocus="autofocus" />
         
        <label for="email">Email Address: <span class="required">*</span></label>
        <input type="email" id="email" name="email" value="{$email/}" placeholder="johndoe@example.com" required="required" />
         
        <label for="message">Message: <span class="required">*</span></label>
        <textarea id="message" name="message" placeholder="Your message" required="required" data-minlength="20" minlength="20" >{$message/}</textarea>
        <div class="g-recaptcha" data-sitekey="6LdJef8SAAAAAHzWyhy6Y838EVCTS8XrKC7mLIjT"></div>
        <br/>
        <input type="submit" value="Send" id="submit-button" />
        <p id="req-field-desc"><span class="required">*</span> indicates a required field</p>
    </form>
    {if isset="$error_response"}
        <div class="errors">
            <ul>
                {foreach item="item" from="$error_response"}
                <li class="info">
                    {$item/}
                </li>    
                {/foreach}
            </ul>
        </div>
        <div class="Info"> Try again later </div>
    {/if}        
</div>