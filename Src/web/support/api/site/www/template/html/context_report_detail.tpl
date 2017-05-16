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
									<span class="label label-primary-api-default" itemprop="responsible">Responsible:</span> <span>{$report.assigned.name/}</span> <br/>
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


