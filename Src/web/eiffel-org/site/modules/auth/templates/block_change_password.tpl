 <div>
    <form action="{$site_url/}account/change-password" method="post">
        <fieldset>
            <legend>Change Password</legend>
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
