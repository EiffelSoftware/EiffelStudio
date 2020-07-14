<h1 class="sub-header">{$module_item/}# {$wish.id/} {htmlentities}{$wish.synopsis/}{/htmlentities} </h1>  
	{if isset="$can_edit"}
		<div id="primary-tabs" class="menu tabs"><ul class="horizontal">
			<li class="active"><a href="{$site_url/}{$resource_path/}/{$module_item/}/{$wish.id/}/form">Edit</a></li></ul>
		</div>	
	{/if}
	{if isset="$can_delete"}
		<div id="primary-tabs" class="menu tabs"><ul class="horizontal">
			<li class="active"><a href="{$site_url/}{$resource_path/}/{$module_item/}/{$wish.id/}/delete">Delete</a></li></ul>
		</div>	
	{/if}
	<div class="row">
			{if condition="$can_vote"}
				<div class="vote-container">
  			   		 <div class="vote-float">
							<form  action="{$site_url/}{$resource_path/}/{$module_item/}/{$wish.id/}/like" id="wish" method="POST" itemprop="vote">
								<input type="hidden" name="wishid" value="{$wish.id/}">
								<button class='vote-button vote-btn-blue' type="submit" ><img src="{$theme_path/}images/like.png" width="52" height="52" alt="Like"></button>
							</form>
				    </div>
				</div>
				<div class="vote-container">
 				    <div class="vote-float">
 				    		<form  action="{$site_url/}{$resource_path/}/{$module_item/}/{$wish.id/}/not_like" id="wish" method="POST" itemprop="vote">
							<input type="hidden" name="wishid" value="{$wish.id/}">
							<button class='vote-button vote-btn-blue' type="submit" ><img src="{$theme_path/}images/notlike.png" width="52" height="52" alt="Not Like"></button>
						</form>
		
				    </div>
				</div>	    	
		 	{/if}

			<div class="vote-container">
  			    <div class="vote-float">
				    	{if condition="$do_like"}
							<form  action="{$site_url/}{$resource_path/}/{$module_item/}/{$wish.id/}/like" id="wish" method="POST" itemprop="vote">
								<input type="hidden" name="wishid" value="{$wish.id/}">
								<button class='vote-button vote-btn-blue' type="submit" ><img src="{$theme_path/}images/like.png" width="52" height="52" alt="Like"></button>
							</form>
						{/if}
				    </div>
			</div>
	    	
			<div class="vote-container">
  				  <div class="vote-float">
					{if condition="$do_not_like"}
						<form  action="{$site_url/}{$resource_path/}/{$module_item/}/{$wish.id/}/not_like" id="wish" method="POST" itemprop="vote">
							<input type="hidden" name="wishid" value="{$wish.id/}">
							<button class='vote-button vote-btn-blue' type="submit" ><img src="{$theme_path/}images/notlike.png" width="52" height="52" alt="Not Like"></button>
						</form>
					{/if}
				 </div>
			</div>
				
			<section>
				<span  class="class-form-6" itemprop="submitter">Submitter:</span>	<span class="class-form-6"><strong>{htmlentities}{$wish.contact.name/}{/htmlentities}</strong></span> <br>
				<span  class="class-form-6" itemprop="category">Category:</span>	<span class="class-form-6">{$wish.category.synopsis/}</span> <br>
				<span  class="class-form-6" itemprop="date">Date:</span>	<span class="class-form-6">{$wish.submission_date_output/}</span> <br>
				<span  class="class-form-6" itemprop="report_number">Number:</span>	<span class="class-form-6">{$wish.id/}</span><br>
				<span  class="class-form-6" itemprop="status">Status:</span> <span class="class-form-6">{$wish.status.synopsis/}</span> <br>
				<span  class="class-form-6" itemprop="synopsis">Synopsis:</span> <span class="class-form-6">{htmlentities}{$wish.synopsis/}{/htmlentities}</span> <br>
			
				<strong>Description</strong>
				<textarea class="class-form-textarea" style="border: none ;background-color:white;" rows="17" readonly>{htmlentities}{$wish.description/}{/htmlentities}</textarea>
				{foreach from="$wish.attachments" item="elem"}
								<div class="row">
									<div class="col-xs-1">
										<div class="panel panel-default">
											<div class="panel-heading">
												<span class="label label-primary-api-interactions" itemprop="attachment">Attachment:</span>
													<a href="{$site_url/}{$resource_path/}/{$module_item/}/{$wish.id/}/download/{$elem.name/}" download="{$elem.name/}">{$elem.name/}</a>&nbsp;&nbsp;&nbsp;&nbsp;
												<span class="label label-primary-api-interactions">Size:</span>{$elem.size/}
											</div>
										</div>
									</div>
								</div>
							{/foreach}
				</section>
	</div>

	<div  class="row">
	 	 <ul class="cms-links">
			<li><a href="{$site_url/}{$resource_path/}/{$module_name/}" class="btn btn-primary" itemprop="create-interaction-form" rel="create-interaction-form">Go to {$module_item/} list</a></li>
		  </ul>	
	 </div>


<div class="row">
		<section>
		<strong>Interactions</strong><br>
			{foreach from="$wish.interactions" item="item"}
				<div class="row-interaction">
				<span class="label label-primary-api-interactions" itemprop="submitter">From:</span>{htmlentities}{$item.contact.name/}{/htmlentities}&nbsp;&nbsp;&nbsp;
				<span class="label label-primary-api-interactions" itemprop="date">Date:</span>{$item.date_output/}&nbsp;&nbsp;&nbsp;
					{if isset="$item.status"}
						<span class="label label-primary-api-interactions" itemprop="status">Status:</span> {$item.status/}&nbsp;&nbsp;&nbsp;
					{/if}
					<pre>{$item.content/}</pre>
					<br/>
					{foreach from="$item.attachments" item="elem"}
								<span class="label label-primary-api-interactions" itemprop="attachment">Attachment:</span>
								<a href="{$site_url/}{$resource_path/}/{$module_item/}/{$wish.id/}/interaction/{$item.id/}/download/{$elem.name/}" download="{$elem.name/}">{$elem.name/}</a>&nbsp;&nbsp;&nbsp;&nbsp;
								<span class="label label-primary-api-interactions">Size:</span>{$elem.size/}
					{/foreach}
				</div>
			{/foreach}
		</section>
</div>

{if isset="$user"}
	 <div  class="row">
	 	 <ul class="cms-links">
			<li><a href="{$site_url/}{$resource_path/}/{$module_item/}/detail/{$wish.id/}/interaction_form" class="btn btn-primary" itemprop="create-interaction-form" rel="create-interaction-form">Add Interaction</a></li>
		  </ul>	
	 </div> 		
{/if}


