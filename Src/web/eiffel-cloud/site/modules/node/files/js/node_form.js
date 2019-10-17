

class RCMS_node_editor {
	constructor(a_editor) {
		this.editor = a_editor;
		this.id = a_editor.attr("node-editor-content-id");
		this.endpoint = null;
		this.preview = null;

		// Get html elements
		this.form = this.editor.closest("form");
		this.format = $(this.form).find("select[name=format]").first();

		var l_url = $(location).attr('href');
		if (l_url.indexOf('/node/add') > 0) {
			this.endpoint = l_url.replace('/node/add', '/node/preview');
		} else {
			var i = l_url.lastIndexOf('/');
			this.endpoint = l_url.slice (0, i) + "/preview";
		}

		// Status
		this.failures_count = 0;
		this.preview_selected = false;
		this.update_requested = false;

		// Add buttons
		$('<div class="node-editor-content-controls"></div>').insertBefore(this.editor);
		this.controls = $(this.editor).prev();
		var but = $('<button type="button">Edit</button>');
		$(this.controls).append(but);
		this.edit_link = but;
		this.edit_link.css("font-weight", "bold");
		var but = $('<button type="button">Preview</button>');
		$(this.controls).append(but);
		this.preview_link = but;

		// Actions
		this.format.change(this, this.on_format_changed);
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

		$('<div node-editor-content-id=\"' + this.id + '\" style=\"padding: 3px; border: dotted 1px blue;\">Loading preview...</div>').insertBefore(this.editor);
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
	on_format_changed(event) {
		event.data.update_requested = true;
		if (event.data.preview_selected) {
			event.data.update_preview(event.data);
		}
	}
	update_preview() {
		var d = { format: $(this.format).val(), content: $(this.editor).val() } ;
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
	var node_editor_count = 0;

	$("form[id^=edit-] textarea[name=content]").each(function() { 
		node_editor_count += 1;
		$(this).attr("node-editor-content-id", node_editor_count);
		let editor = new RCMS_node_editor($(this));
	});

})

