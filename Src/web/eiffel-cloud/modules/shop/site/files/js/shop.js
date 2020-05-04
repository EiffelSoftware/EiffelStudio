class ROCSHOP_item_trash {
	constructor(a_cid, a_line) {
		this.cid = a_cid;
		this.line = a_line;

		var l_url = $(location).attr('href');
		var i = l_url.lastIndexOf('/');
		l_url = l_url.slice (0, i)
		i = l_url.lastIndexOf('/');
		l_url = l_url.slice (0, i)
		i = l_url.lastIndexOf('/');
		this.host_url = l_url.slice (0, i)
		console.log (this.host_url);

		this.item_provider = this.line.attr('data-item-provider');
		this.item_code = this.line.attr('data-item-code');
		this.failures_count = 0;
		this.endpoint = this.host_url.concat("/api/shop/carts/", this.cid, '/', this.item_provider, '/', this.item_code);
		this.deleted = false;
	}
	insert_form() {
		var but = $("<button class=\"remover\" title=\"Remove item\">&#10060;</button>");
		this.line.append(but);
		this.discard_widget = but;

		$(this.discard_widget).on('click', this, function(event) { 
			if (event.data.deleted) {
			} else {
				var result = confirm(("You are about to remove cart item\n").concat(event.data.iid, "\nDo you confirm ?"));
				if (result == true) {
					event.data.process_discard();
				} else {
				};
			}
		});
	}
	process_discard() {
		var posting = $.ajax ({
					url: this.endpoint,
					type: 'DELETE',
					context: this
				}
			);
		posting.done(function(data) { 
			this.deleted = true;
			this.line.append(data); 
			$(this.discard_link).remove();
			$(this.line).fadeOut (1000); // 1 second
		});	
		posting.fail(function(data) { 
			this.failures_count += 1;
			if (this.failures_count > 9) {
				this.line.append("<div>Too many failures ("+ this.failures_count + ")</div>");
				this.failures_count = 0;
			} else {
				this.line.append("<div>Error try again in 5 seconds (" + this.failures_count + ")</div>");
				setTimeout(this.process_discard(this), 5000); /* 5 sec */
			}
		});
	}
}

$(document).ready(function() {
	$("div.shop-cart").each(function() {
		var cid = $(this).attr('data-cid');
		console.log("shop-cart " + cid);
		$("table.shop-cart tr.cart-item").each(function() { 
			console.log("shop-item " + cid);
			let trash = new ROCSHOP_item_trash(cid, $(this));
			trash.insert_form();
		});
	});

})
