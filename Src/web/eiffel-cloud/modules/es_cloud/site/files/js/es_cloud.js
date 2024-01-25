class ESCL_inst_trash {
	constructor(a_line) {
		this.line = a_line;

		var l_url = $(location).attr('href');
		this.host_url = this.url_origin($(location).attr('href'));

		this.uid = this.line.attr('data-user-id');
		this.iid = this.line.attr('data-installation-id');
		this.failures_count = 0;
		this.endpoint = this.host_url.concat("/api/cloud/v1/account/", this.uid, "/installations/", this.iid);
		this.deleted = false;
	}
	url_origin(a_url){
		var l_url = a_url;
		if (typeof URL === "function") {
			var u = new URL(l_url);
			return u.origin;
		} else {
			var i = l_url.indexOf('//');
			if (i > 0) {
				var j = l_url.indexOf('/', i + 2);
				l_url = l_url.slice (0, j);
				return l_url;
			} else {
				var i = l_url.lastIndexOf('/');
				if (l_url.length == i + 1) {
					l_url = l_url.slice (0, i)
				}
				i = l_url.lastIndexOf('/');
				return l_url.slice (0, i);
			}
		}
	}	
	insert_form() {
		var but = $("<button title=\"Revoke installation\">&#x1F5D1; revoke</button>");
		this.line.append(but);
		this.discard_widget = but;

		$(this.discard_widget).on('click', this, function(event) { 
			if (event.data.deleted) {
			} else {
				var result = confirm(("You are about to revoke installation\n").concat(event.data.iid, "\nDo you confirm?"));
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

class ESCL_inst_reassign {
	constructor(a_line) {
		this.line = a_line;

		var l_url = $(location).attr('href');
		this.host_url = this.url_origin($(location).attr('href'));

		this.uid = this.line.attr('data-user-id');
		this.iid = this.line.attr('data-installation-id');
		this.lid = this.line.attr('data-license-id');
		this.nlid = this.line.attr('data-new-license-id');
		this.failures_count = 0;
		this.endpoint = this.host_url.concat("/api/cloud/v1/account/", this.uid, "/installations/", this.iid);
		this.deleted = false;
	}
	url_origin(a_url){
		var l_url = a_url;
		if (typeof URL === "function") {
			var u = new URL(l_url);
			return u.origin;
		} else {
			var i = l_url.indexOf('//');
			if (i > 0) {
				var j = l_url.indexOf('/', i + 2);
				l_url = l_url.slice (0, j);
				return l_url;
			} else {
				var i = l_url.lastIndexOf('/');
				if (l_url.length == i + 1) {
					l_url = l_url.slice (0, i)
				}
				i = l_url.lastIndexOf('/');
				return l_url.slice (0, i);
			}
		}
	}	
	insert_form() {
		var but = $("<button title=\"Assign installation to license\">&#x27F3; assign</button>");
		this.line.append(but);
		this.discard_widget = but;

		$(this.discard_widget).on('click', this, function(event) { 
			if (event.data.assigned) {
			} else {
				var result = confirm(("You are about to assign installation\n")
						.concat(event.data.iid, "\nto license ", event.data.nlid, "\nDo you confirm?"));
				if (result == true) {
					event.data.process_assign();
				} else {
				};
			}
		});
	}
	process_assign() {
		var posting = $.ajax ({
					url: this.endpoint,
					type: 'PUT',
					data: { installation_id: this.iid, 
							license_id: this.lid,
							new_license_id: this.nlid
					},
					context: this
				}
			);
		posting.done(function(data) { 
			this.assigned = true;
			this.line.append(data); 
			$(this.discard_link).remove();
			$(this.line).before("<li class=\"assigned\">Installation re-assigned</li>");
			$(this.line).fadeOut (1000); // 1 second
			setTimeout(function() { location.reload(); }, 3000); /* 3 sec */
		});	
		posting.fail(function(data) { 
			this.failures_count += 1;
			if (this.failures_count > 9) {
				this.line.append("<div>Too many failures ("+ this.failures_count + ")</div>");
				this.failures_count = 0;
			} else {
				this.line.append("<div>Error try again in 5 seconds (" + this.failures_count + ")</div>");
				setTimeout(function() { this.process_assign(this); }, 5000); /* 5 sec */
			}
		});
	}
}

$(document).ready(function() {
	$("div.es-installations li.discardable").each(function() { 
		let trash = new ESCL_inst_trash($(this));
		trash.insert_form();
	});

	$("div.es-installation li.available").each(function() { 
		let reassign = new ESCL_inst_reassign($(this));
		reassign.insert_form();
	});

})
