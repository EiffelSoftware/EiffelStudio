       <ul class="nav navbar-nav navbar-right">
              {foreach item="item" from="$menu.items"}
                <!-- TODO check if a menu item is active or not -->
                <li class="active"><a href="{$item.location/}">{$item.title/}</a></li>
             {/foreach}
        </ul>
 