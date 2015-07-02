 <div>
    <form action="/account/roc-register" method="post">
        <fieldset>
            <legend>Register Form</legend>
            <div>
                <input type="text" id="name" name="name"  value="{$name/}" required  autofocus />
                <label for="name">Name</label>
                {if isset="$error_name"}
                    <span><i>{$error_name/}</i></span> <br>
                {/if}
            </div>
            <div>
                <input type="password" id="password" name="password" value="" required/>
                <label for="password">Password</label>
            </div>
            <div>
                <input type="email" id="email" name="email"  value="{$email/}"  required/>
                <label for="email">Email</label>
                {if isset="$error_email"}
                    <span><i>{$error_email/}</i></span> <br>
                {/if}
            </div>
            
            
            <button type="submit">Register</button>
        </fieldset>    
    </form>
</div>
