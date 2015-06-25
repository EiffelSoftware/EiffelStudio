 <div>
    <form action="/account/new-password" method="post">
        <fieldset>
            <legend>Require new password</legend>
            <div>
                <input type="email" id="email" name="email"  value="{$email/}"  required/>
                <label for="email">Email</label>
                {if isset="$error_email"}
                    <span><i>{$error_email/}</i></span> <br>
                {/if}
                <br>
            </div>
            <button type="submit">Send</button>
        </fieldset>    
    </form>
</div>
