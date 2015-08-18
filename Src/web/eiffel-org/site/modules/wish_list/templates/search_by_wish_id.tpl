<div class="row">
	<div class="col-xs-12">
		<form class="form-inline well" action="{$site_url/}resources/wish_detail/" id="wish" method="GET" itemprop="search">
			<div class="row">
				<div class="col-xs-1">
					<label class="control-label-api" itemprop="wish_number" data-original-title="Wish number you need to see.">View Wish #:</label>
				</div>
				<div class="col-xs-1">
					<input type="number" class="form-control form-bug-number-entry" min="1" name="search" placeholder="Wish #..." form="wish"/>
				</div>
				<div class="col-xs-1">
					<button type="submit" class="btn btn-default">Go</button>
				</div>
			</div>
		</form>
	</div>
</div>
