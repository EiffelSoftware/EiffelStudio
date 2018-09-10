 <div>
    <form action="{$site_url/}account/reactivate" method="post">
        <fieldset>
            <legend>Reactivate Form</legend>
            <div>
                <input type="email" id="email" name="email"  value="{htmlentities}{$email/}{/htmlentities}"  required/>
                <label for="email">Email</label>
                {if isset="$error_email"}
                    <span><i>{$error_email/}</i></span> <br>
                {/if}
                <br>
                {if isset="$is_active"}
                    <span><i>{$is_active/}</i></span> <br>
                {/if}
            </div>
            <button type="submit">Reactivate</button>
        </fieldset>    
    </form>
</div>
