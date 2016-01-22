<h1 class="sub-header">PR# {$report.number/} {htmlentities}{$report.synopsis/}{/htmlentities} </h1>
<div class="row">
	<div class="col-xs-12">
		<div class="panel panel-default">
			<div class="panel-heading"><strong>Problem Report Summary</strong></div>
			<div class="panel-body">
				<div class="form-horizontal">
					<!--form -->
					<div class="row">
						<div class="span8">
							<div class="row">
								<div class="col-xs-4">
									<span class="label label-primary-api-default" itemprop="submitter">Submitter:</span>	<span>{$report.contact.name/}</span> <br/>
								</div>
								<div class="col-xs-4">
									<span class="label label-primary-api-default" itemprop="category">Category:</span>	<span>{$report.category.synopsis/}</span> <br/>
								</div>
								<div class="col-xs-4">
									<span class="label label-primary-api-default" itemprop="priority">Priority:</span>	<span>{$report.priority.synopsis/}</span> <br/>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-4">
									<span class="label label-primary-api-default" itemprop="date">Date:</span>	<span>{$report.submission_date_output/}</span> <br/>
								</div>
								<div class="col-xs-4">
									<span class="label label-primary-api-default" itemprop="class">Class:</span>	<span>{$report.report_class.synopsis/}</span> <br/>
								</div>
								<div class="col-xs-4">
									<span class="label label-primary-api-default" itemprop="severity">Severity:</span> <span>{$report.severity.synopsis/}</span> <br/>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-4">
									<span class="label label-primary-api-default" itemprop="report_number">Number:</span>	<span>{$report.number/}</span> <br/>
								</div>
								<div class="col-xs-4">
									<span class="label label-primary-api-default" itemprop="release">Release:</span>	<span>{$report.release/}</span> <br/>
								</div>
								{if condition="$report.confidential"}
									<div class="col-xs-4">
										<span class="label label-primary-api-default" itemprop="confidential">Confidential:</span> <span>Yes</span> <br/>
									</div>
								{/if}
								{unless condition="$report.confidential"}
									<div class="col-xs-4">
										<span class="label label-primary-api-default" itemprop="confidential">Confidential:</span> <span>No</span> <br/>
									</div>
								{/unless}
							</div>
							<div class="row">
								<div class="col-xs-4">
									<span class="label label-primary-api-default" itemprop="status">Status:</span> <span>{$report.status.synopsis/}</span> <br/>
								</div>
								<div class="col-xs-4">
									<span class="label label-primary-api-default" itemprop="responsible">Responsible:</span> <span></span> <br/>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<span class="label label-primary-api-default" itemprop="environment">Environment:</span> <span>{$report.environment/}</span> <br/>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<span class="label label-primary-api-default" itemprop="synopsis">Synopsis:</span> <span>{htmlentities}{$report.synopsis/}{/htmlentities}</span> <br/>
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
										<div class="panel-body" id="textarea_17">
												<pre>{htmlentities}{$report.description/}{/htmlentities}</pre>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="panel panel-default">
										<div class="panel-heading" itemprop="to_reproduce"><strong>To Reproduce</strong></div>
										<div class="panel-body" id="textarea_7">
											  	<pre>{htmlentities}{$report.to_reproduce/}{/htmlentities}</pre>
										</div>
									</div>
								</div>
							</div>
						</div><!-- span -->
					</div><!--form -->
				</div>
			</div>
		</div>
	</div>
</div>

{if isset="$user"}
	<div class="row">
		<div class="col-xs-5">
			<span class="label label-primary-api-default" itemprop="status"><br/>
		</div>
		<div class="col-xs-6">
				<div class="btn-group">
						<a href="{$host/}/report_detail/{$report.number/}/interaction_form" class="btn btn-primary" itemprop="create-interaction-form" rel="create-interaction-form">Add Interaction</a>
				</div>
		</div>
		<div class="col-xs-2">
			<span class="label label-primary-api-default" itemprop="status"><br/>
		</div>

	</div>
{/if}


<div class="row">
	<div class="col-xs-12">
		<div class="panel panel-default">
			<div class="panel-heading"><strong>Problem Report Interactions</strong></div>
			<div class="panel-body">
				<div class="form-horizontal">
					<!--form -->
					<div class="row">
						<div class="span8">
							{foreach from="$report.interactions" item="item"}
							<div class="row">
								<div class="col-xs-12">
									{if condition="$item.private"}
										<div class="panel panel-default private-panel-border">
											<div class="panel-heading private-panel">
									{/if}
									{unless condition="$item.private"}
										<div class="panel panel-default">
											<div class="panel-heading">
									{/unless}
											<span class="label label-primary-api-interactions" itemprop="submitter">From:</span>{$item.contact.name/}&nbsp;&nbsp;&nbsp;
											<span class="label label-primary-api-interactions" itemprop="date">Date:</span>{$item.date_output/}&nbsp;&nbsp;&nbsp;
											{if isset="$item.status"
}												<span class="label label-primary-api-interactions" itemprop="status">Status:</span> {$item.status/}&nbsp;&nbsp;&nbsp;
											{/if}
											<span class="label-left label-primary-api-interactions" itemprop="download"><a href="{$host/}/report_interaction/{$item.id/}.txt">Download</a>&nbsp;&nbsp;&nbsp;</span>
										</div>
										<div class="panel-body" id="textarea_17">
                                            {if isset="$item.content_truncated"}
										 	<pre>{htmlentities}{$item.content_truncated/}{/htmlentities}</pre>
											{/if}
											{unless isset="$item.content_truncated"}
										 	<pre>{htmlentities}{$item.content/}{/htmlentities}</pre>
											{/unless}
											
											<br/>
											{foreach from="$item.attachments" item="elem"}
											<div class="row">
												<div class="col-xs-1">
													<div class="panel panel-default">
														<div class="panel-heading">
															<span class="label label-primary-api-interactions" itemprop="attachment">Attachment:</span>
															<a href="{$host/}/report_interaction/{$elem.id/}/{$elem.name/}"	download="{$elem.name/}">{$elem.name/}</a>&nbsp;&nbsp;&nbsp;&nbsp;
															<span class="label label-primary-api-interactions">Size:</span>{$elem.bytes_count/}
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
		<div class="row">
		<div class="col-xs-5">
			<span class="label label-primary-api-default" itemprop="status"><br/>
		</div>
		<div class="col-xs-6">
				<div class="btn-group">
						<a href="{$host/}/report_detail/{$report.number/}/interaction_form" class="btn btn-primary" itemprop="create-interaction-form" rel="create-interaction-form">Add Interaction</a>
				</div>
		</div>
		<div class="col-xs-2">
			<span class="label label-primary-api-default" itemprop="status"><br/>
		</div>

	</div>
{/if}
