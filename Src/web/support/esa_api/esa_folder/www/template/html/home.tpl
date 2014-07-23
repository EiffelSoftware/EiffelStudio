<!DOCTYPE html>
<html lang="en">
	{include file="master/head.tpl"/}
	<body>
		 {include file="navbar.tpl"/}
		<div class="main">
			<div class="container">
				<div class="jumbotron">
					<h1>Eiffel Software Support</h1>
					<small>The Eiffel Software Support web site, your one stop destination for information and support on Eiffel products and technologies.</small>
				</div>
			</div>
			<div class="container-fluid">
				<div class="row">
					<div class="col-xs-6">
						<div class="row">
							<div class="col-xs-2"></div>
							<div class="col-xs-8">
								<h2 class="info">Assisted Support</h2>
								<p style="width:360px">View and submit problem and bug reports to the Eiffel Software Team through this web site.
									Customers with a higher priority <a href="http://www.eiffel.com/services/support/" target="_blank" class="info">Support Plan</a> receive faster response times and problem resolution.
									Additional support options include email, phone, fax and <a href="http://www.eiffel.com/services/training/index.html" target="_blank" class="info">training courses</a> from an Eiffel Software professional.
								</p>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="row">
							<div class="col-xs-2"></div>
							<div class="col-xs-8">
								<h2>Self-Support</h2>
								<p style="width:360px">Learn more about Eiffel Technologies from various online resources. Browse our full <a href="http://docs.eiffel.com/" target="_blank" class="info">online documentation</a> and <a href="http://www.eiffel.com/search/search.html"target="_blank" class="info">technical archives</a>, purchase educational and reference material, or join the <a href="http://groups.yahoo.com/group/eiffel_software/" target="_blank" class="info">Eiffel User Group</a> to discuss issues and get help.</p>
							</div>
							<div class="col-xs-2"></div>
						</div>
					</div>
				</div>
			</div>
			<hr>
			<div id="footer">
				<small>
					<center>
						<p class="text-muted"><a href="{$host/}/static/doc/esa_doc.html" target="_blank" class="info">API Documentation </a>&nbsp;&nbsp;&nbsp;
						<a href="http://www.eiffel.com/company/contact/" target="_blank" class="info">Questions? Comments? Let us know! </a></p>
						<p>© Copyright 2014 Eiffel Software -- <a href="http://www.eiffel.com/privacy-policy" target="_blank" class="info">Privacy Policy</a>
					</center>
				</small>
			</div>
		</div>
		<!-- Placed at the end of the document so the pages load faster -->
		{include file="optional_enhancement_js.tpl"/}
	</body>
</html>
