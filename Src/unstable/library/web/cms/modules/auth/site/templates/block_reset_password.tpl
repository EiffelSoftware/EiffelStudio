 <div>
    <form action="{$site_url/}account/reset-password" method="post">
        <fieldset>
            <legend>Generate New Password Form</legend>
            <div>
                <input type="text" id="token" name="token"  value="{htmlentities}{$token/}{/htmlentities}" required />
                <label for="token">Token</label>
                {if isset="$error_token"}
                    <span><i>{$error_token/}</i></span> <br>
                {/if}
            </div>
            <div>
                <input type="password" id="password" name="password" value="" required/>
                <label for="password">Password</label>
            </div>
            <div>
                <input type="password" id="confirm_password" name="confirm_password" value="" required/>
                <label for="password">Confirm Password</label>
            </div>
            
            <button type="submit">Confirm</button>
            {if isset="$error_password"}
              <span><i>{$error_password/}</i></span> <br>
            {/if}
 
        </fieldset>    
    </form>
</div>
