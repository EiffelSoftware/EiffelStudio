<h1 class="sub-header">PR# {$report.number/} {$report.synopsis/} </h1>
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
								<div class="col-xs-4">
									<span class="label label-primary-api-default" itemprop="confidential">Confidential:</span> <span>{$report.confidential/}</span> <br/>
								</div>
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
									<span class="label label-primary-api-default" itemprop="synopsis">Synopsis:</span> <span>{$report.synopsis/}</span> <br/>
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
											<textarea class="form-control input-xlarge" style="border: none ;background-color:white;" rows="17">{$report.description/}</textarea>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="panel panel-default">
										<div class="panel-heading" itemprop="to_reproduce"><strong>To Reproduce</strong></div>
										<div class="panel-body">
											<textarea class="form-control input-xlarge" style="border: none ;background-color:white;" rows="7">{$report.to_reproduce/}</textarea>
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
	<div class="btn-group">
		<a href="{$host/}/report_detail/{$report.number/}/interaction_form" class="btn btn-primary" itemprop="create-interaction-form" rel="create-interaction-form">Add Interaction</a>
	</div>
{/if}
