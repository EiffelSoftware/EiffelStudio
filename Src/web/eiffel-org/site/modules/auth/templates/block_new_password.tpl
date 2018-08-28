 <div>
    <form action="{$site_url/}account/new-password" method="post">
        <fieldset>
            <legend>Request new password by email</legend>
            <div>
                <input type="email" id="email" name="email"  value="{htmlentities}{$email/}{/htmlentities}"  required/>
                <label for="email">Email</label>
                {if isset="$error_email"}
                    <span><i>{$error_email/}</i></span> <br>
                {/if}
                <br>
            </div>
            <button type="submit">Send</button>
        </fieldset>    
    </form>
    <hr>
    <form action="{$site_url/}account/new-password" method="post">
        <fieldset>
            <legend>Request new password by username</legend>
            <div>
                <input type="text" id="username" name="username"  value="{htmlentities}{$username/}{/htmlentities}"  required/>
                <label for="username">Username</label>
                {if isset="$error_username"}
                    <span><i>{$error_username/}</i></span> <br>
                {/if}
                <br>
            </div>
            <button type="submit">Send</button>
        </fieldset>    
    </form>

</div>
