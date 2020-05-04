class ESCL_inst_trash {
	constructor(a_line) {
		this.line = a_line;

		var l_url = $(location).attr('href');
		var i = l_url.lastIndexOf('/');
		l_url = l_url.slice (0, i)
		i = l_url.lastIndexOf('/');
		this.host_url = l_url.slice (0, i)

		this.uid = this.line.attr('data-user-id');
		this.iid = this.line.attr('data-installation-id');
		this.failures_count = 0;
		this.endpoint = this.host_url.concat("/api/cloud/v1/account/", this.uid, "/installations/", this.iid);
		this.deleted = false;
	}
	insert_form() {
		var but = $("<button title=\"Revoke installation\">&#x1F5D1;</button>");
		this.line.append(but);
		this.discard_widget = but;

		$(this.discard_widget).on('click', this, function(event) { 
			if (event.data.deleted) {
			} else {
				var result = confirm(("You are about to revoke installation\n").concat(event.data.iid, "\nDo you confirm ?"));
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
			$(this.line).before("<li class=\"discarded\">Installation discarded</li>");
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
	$("div.es-installations li.discardable").each(function() { 
		let trash = new ESCL_inst_trash($(this));
		trash.insert_form();
	});

})
