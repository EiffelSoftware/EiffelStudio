class ROCSHOP_cart {
	constructor(a_div) {
		this.cart_div = a_div.find('div.shop-cart').first();
		this.payment = a_div.find('form#stripe-payment').first();

		this.cid = this.cart_div.attr('data-cid');
		this.currency = this.cart_div.attr('data-currency');
		this.table = this.cart_div.find('table.shop-cart').first();
		this.total = this.table.find("td.total").first();
		this.total_cents=0;
		//console.log(this.payment);

		var l_url = $(location).attr('href');
		var i = l_url.lastIndexOf('/');
		l_url = l_url.slice (0, i)
		i = l_url.lastIndexOf('/');
		l_url = l_url.slice (0, i)
		i = l_url.lastIndexOf('/');
		this.host_url = l_url.slice (0, i)
		//console.log (this.host_url);

		var cart=this;
		this.table.find("tr.cart-item").each(function() { 
			let item = new ROCSHOP_cart_item(cart, $(this));
			item.apply();
		});
	};

	update_total() {
		this.get_cart_total();
	}
	get_cart_total() {
		var cart=this;
		cart.total_cents=0;
		cart.total.text("0");
		$.when(this.table.find("tr.cart-item").each (function() {
			var td_quantity = parseInt($(this).find("td.cart-item-count").first().attr('data-quantity'));
			var td_price = parseInt($(this).find("td.cart-item-data").first().attr('data-price'));
			var td_total = cart.total_cents;
			td_total = td_total + td_quantity * td_price;
			cart.total_cents = td_total;
			var s = Math.trunc(td_total / 100);
			if (td_total % 100 > 0) {
				if (td_total % 100 < 10) {
					s = s + ".0" + td_total % 100;
				} else {
					s = s + "." + td_total % 100;
				}
			}
			if (cart.currency == "usd") {
				cart.total.text("$" + s);
			} else {
				cart.total.text(s + " " + cart.currency);
			}
		})).done (function() {
			//console.log("total updated to " + cart.total_cents);
			if (cart.payment != null) {
			//console.log("update payment ...");
				if (cart.total_cents == 0) {
					cart.payment.fadeOut(1000);
				} else {
					cart.payment.fadeIn();
				}
			} else {
			//console.log(cart.payment);
			}
		});
	};
}

class ROCSHOP_cart_item {
	constructor(a_cart, a_line) {
		this.cart = a_cart;
		this.line = a_line;
		this.quantity = a_line.find("td.cart-item-count").first();

		this.item_provider = this.line.attr('data-item-provider');
		this.item_code = this.line.attr('data-item-code');
		this.failures_count = 0;
		this.endpoint = this.cart.host_url.concat("/api/shop/carts/", this.cart.cid, '/', this.item_provider, '/', this.item_code);
		this.deleted = false;
	}
	apply() {
		this.insert_trash();
		this.insert_quantity_modifier();
	}

	insert_quantity_modifier() {
		var more = $(' <span class="more">&#8853;</span>');
		var div = $('<div class="quantity-modifier"></div>');
		$(div).append (more);
		var q = parseInt((this.quantity).attr("data-quantity"));
		if (q > 0) {
			var less = $(' <span class="less">&#8854;</span>');
			$(div).append (less);
			less.on('click', this, function(event) { 
				event.data.add_quantity(-1);
			});
		}
		this.quantity.append(div);
		more.on('click', this, function(event) { 
			event.data.add_quantity(1);
		});
	}
	add_quantity(i) {
		var q = parseInt((this.quantity).attr("data-quantity"));
		q = q + i;

		var posting = $.ajax ({
					url: this.endpoint.concat('/quantity/', q),
					type: 'PUT',
					context: this
				}
			);
		posting.done(function(data) { 
			this.quantity.attr("data-quantity", q);
			this.quantity.text (q);
			this.cart.update_total(); 
			this.insert_quantity_modifier();
				// 1 second
		});	
		posting.fail(function(data) { 
			this.failures_count += 1;
			if (this.failures_count > 9) {
				this.line.append("<div>Too many failures ("+ this.failures_count + ")</div>");
				this.failures_count = 0;
			} else {
				this.line.append("<div>Error try again in 5 seconds (" + this.failures_count + ")</div>");
				setTimeout(this.add_quantity(i), 5000); /* 5 sec */
			}
		});
	};

	insert_trash() {
		var but = $("<button class=\"remover\" title=\"Remove item\">&#10060;</button>");
		this.line.append(but);
		this.discard_widget = but;

		$(this.discard_widget).on('click', this, function(event) { 
			if (event.data.deleted) {
			} else {
				var result = confirm(("You are about to remove cart item\n").concat(event.data.item_code, "\nDo you confirm?"));
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
			var this_line=this.line;
			var this_cart=this.cart;
			$.when(this_line.fadeOut (1000)).done(function() {
				this_line.remove(); this_cart.update_total(); 
			});
				// 1 second
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
	$("div.shop-cart-page").each(function() {
		let cart = new ROCSHOP_cart($(this));
	});

})
