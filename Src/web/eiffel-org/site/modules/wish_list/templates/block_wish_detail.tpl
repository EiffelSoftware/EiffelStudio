<h1 class="sub-header">WISH# {$wish.id/} {$wish.synopsis/} </h1>  
	{if isset="$edit"}
		<h2><a href="{$site_url/}resources/wish_form/{$wish.id/}">Edit</a></h2>
	{/if}

<div class="row">
	<div class="col-xs-12">
		<div class="panel panel-default">
			<div class="panel-heading"><strong>Wish Item Summary</strong></div>
			<div class="panel-body">
				<div class="form-horizontal">
					<!--form -->
					<div class="row">
						<div class="span8">
							<div class="row">
								<div class="col-xs-4">
									<span class="label label-primary-api-default" itemprop="submitter">Submitter:</span>	<span>{$wish.contact.name/}</span> <br/>
								</div>
								<div class="col-xs-4">
									<span class="label label-primary-api-default" itemprop="category">Category:</span>	<span>{$wish.category.synopsis/}</span> <br/>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-4">
									<span class="label label-primary-api-default" itemprop="date">Date:</span>	<span>{$wish.submission_date_output/}</span> <br/>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-4">
									<span class="label label-primary-api-default" itemprop="report_number">Number:</span>	<span>{$wish.id/}</span> <br/>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-4">
									<span class="label label-primary-api-default" itemprop="status">Status:</span> <span>{$wish.status.synopsis/}</span> <br/>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<span class="label label-primary-api-default" itemprop="synopsis">Synopsis:</span> <span>{$wish.synopsis/}</span> <br/>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<br/>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="panel panel-default">
										<div class="panel-heading" itemprop="description"><strong>Description</strong></div>
										<div class="panel-body">
											<textarea class="form-control input-xlarge" style="border: none ;background-color:white;" rows="17">{$wish.description/}</textarea>
										</div>
									</div>
								</div>
							</div>
							{foreach from="$wish.attachments" item="elem"}
								<div class="row">
									<div class="col-xs-1">
										<div class="panel panel-default">
											<div class="panel-heading">
												<span class="label label-primary-api-interactions" itemprop="attachment">Attachment:</span>
													<a href="{$site_url/}download/wish/{$wish.id/}/{$elem.name/}" download="{$elem.name/}">{$elem.name/}</a>&nbsp;&nbsp;&nbsp;&nbsp;
												<span class="label label-primary-api-interactions">Size:</span>{$elem.size/}
											</div>
										</div>
									</div>
								</div>
							{/foreach}
						</div><!-- span -->
					</div><!--form -->
				</div>
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-xs-12">
		<div class="panel panel-default">
			<div class="panel-heading"><strong>Wish Interactions</strong></div>
			<div class="panel-body">
				<div class="form-horizontal">
					<!--form -->
					<div class="row">
						<div class="span8">
							{foreach from="$wish.interactions" item="item"}
							<div class="row">
								<div class="col-xs-12">
										<div class="panel panel-default">
											<div class="panel-heading">
											<span class="label label-primary-api-interactions" itemprop="submitter">From:</span>{$item.contact.name/}&nbsp;&nbsp;&nbsp;
											<span class="label label-primary-api-interactions" itemprop="date">Date:</span>{$item.date_output/}&nbsp;&nbsp;&nbsp;
											{if isset="$item.status"}
												<span class="label label-primary-api-interactions" itemprop="status">Status:</span> {$item.status/}&nbsp;&nbsp;&nbsp;
											{/if}
										</div>
										<div class="panel-body">
											<pre>{$item.content/}</pre>
											<br/>
											{foreach from="$item.attachments" item="elem"}
											<div class="row">
												<div class="col-xs-1">
													<div class="panel panel-default">
														<div class="panel-heading">
															<span class="label label-primary-api-interactions" itemprop="attachment">Attachment:</span>
															<a href="{$site_url/}download/wish/{$wish.id/}/interaction/{$item.id/}/{$elem.name/}" download="{$elem.name/}">{$elem.name/}</a>&nbsp;&nbsp;&nbsp;&nbsp;
															<span class="label label-primary-api-interactions">Size:</span>{$elem.size/}
														</div>
													</div>
												</div>
											</div>
											{/foreach}
										</div>
									</div>
								</div>
							</div>
							{/foreach}
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

{if isset="$user"}
	<div class="btn-group">
		<a href="{$site_url/}resources/wish_detail/{$wish.id/}/interaction_form" class="btn btn-primary" itemprop="create-interaction-form" rel="create-interaction-form">Add Interaction</a>
	</div>
{/if}
