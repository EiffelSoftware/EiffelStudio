
class WDocsEditor {
	constructor(a_editor) {
		this.editor = a_editor;
		this.id = a_editor.attr("wdocs-source-id");
		this.endpoint = null;
		this.preview = null;

		// Endpoint
		var l_url = $(location).attr('href');
		var i = l_url.lastIndexOf('/');
		this.endpoint = l_url.slice (0, i) + "/preview";

		// Status
		this.failures_count = 0;
		this.preview_selected = false;
		this.update_requested = false;		

		// Add buttons
		$('<div class="wdocs-controls"></div>').insertBefore(this.editor);
		this.controls = $(this.editor).prev();
		var but = $('<button type="button">Edit</button>');
		$(this.controls).append(but);
		this.edit_link = but;
		this.edit_link.css("font-weight", "bold");
		var but = $('<button type="button">Preview</button>');
		$(this.controls).append(but);
		this.preview_link = but;
		

		// Actions
		this.editor.change(this, this.on_source_changed);
		$(this.edit_link).on('click', this, function(event) { 
			if (event.data.preview_selected) {
				event.data.switch_to_edit(); 
			}
		});
		$(this.preview_link).on('click', this, function(event) { 
			if (event.data.preview_selected) {
				if (event.data.update_requested) {
					this.update_preview();
				}
			} else {
				event.data.switch_to_preview(); 
			}
		});
	}
	switch_to_edit() {
		this.preview_selected = false;
		this.edit_link.css("font-weight", "bold");
		this.preview_link.css("font-weight", "normal");
		this.preview.remove();
		this.editor.show();
	}
	switch_to_preview() {
		this.preview_selected = true;
		this.preview_link.css("font-weight", "bold");
		this.edit_link.css("font-weight", "normal");

		$('<div class="wikipage" wdocs-source-id=\"' + this.id + '\" style=\"padding: 3px; border: dotted 1px blue;\">Loading preview...</div>').insertBefore(this.editor);
		this.preview = this.editor.prev();
		this.editor.hide();
		this.update_preview();
	}
	on_source_changed(event) {
		event.data.update_requested = true;
		if (event.data.preview_selected) {
			event.data.update_preview(event.data);
		}
	}
	update_preview() {
		var d = { source: $(this.editor).val() } ;
		var posting = $.ajax ({
					url: this.endpoint,
					type: 'POST',
					data: d,
					context: this
				}
			);
		posting.done(function(data) { 
			this.failures_count = 0;
			$(this.preview).html(data); 
			this.update_requested = false;
		});	
		posting.fail(function(data) { 
			this.failures_count += 1;
			if (this.failures_count > 9) {
				$(this.preview).text("Error("+ this.failures_count +"): too many failures!");
				this.failures_count = 0;
				this.update_requested = true;
			} else {
				$(this.preview).text("Error("+ this.failures_count +"): next try in 5 second!");
				setTimeout(this.update_preview(this), 5000); /* 5 sec */
			}
		});
	}
}

$(document).ready(function() {
	var wdocs_editor_preview_count = 0;

	$("form#wdocs_edit textarea[name=source]").each(function() { 
		wdocs_editor_preview_count += 1;
		$(this).attr("wdocs-source-id", wdocs_editor_preview_count);
		let editor = new WDocsEditor($(this));
	});

})
