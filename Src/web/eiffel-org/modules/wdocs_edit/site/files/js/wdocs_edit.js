

class WDocsEditor {
	constructor(a_editor) {
		this.editor = a_editor;
		this.id = a_editor.attr("wdocs-source-id");
		this.endpoint = null;
		this.preview = null;
		$('<div class="wdocs-controls"></div>').insertBefore(this.editor);
		this.controls = $(this.editor).prev();

		var but = $('<button type="button">Edit</button>');
		$(this.controls).append(but);
		this.edit_link = but;
		this.edit_link.css("font-weight", "bold");

		var but = $('<button type="button">Preview</button>');
		$(this.controls).append(but);
		this.preview_link = but;

		var l_url = $(location).attr('href');
		var i = l_url.lastIndexOf('/');
		this.endpoint = l_url.slice (0, i) + "/preview";
		this.failures_count = 0;
		this.preview_selected = false;
		this.source_changed = false;

		this.editor.change(this, this.on_source_changed);
		$(this.edit_link).on('click', this, function(event) { 
			if (event.data.preview_selected) {
				event.data.switch_to_edit(); 
			}
		});
		$(this.preview_link).on('click', this, function(event) { 
			if (!event.data.preview_selected) {
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
	on_source_changed() {
		this.source_changed = true;
		if (this.preview_selected) {
			this.update_preview();
		}
	}
	update_preview() {
		var posting = $.ajax ({
					url: this.endpoint,
					type: 'POST',
					context: this,
					data: { source: $(this.editor).val() }
				}
			);
		posting.done(function(data) { 
			this.failures_count = 0;
			$(this.preview).html(data); 
			this.source_changed = false;
		});	
		posting.fail(function(data) { 
			this.failures_count += 1;
			if (this.failures_count > 5) {
				$(this.preview).text("Error: too many failures!");
			} else {
				$(this.preview).text("Error: next try in 1 second!");
				setTimeout(this.update_preview, 1000); /* 1 sec */
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

		//WDocsEditMod.preparePreview($(this), wdocs_editor_preview_count);
	});

})
