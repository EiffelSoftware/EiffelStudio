//DBG.log('Start codeboard_editor...(jquery='+ jQuery().jquery +')');
//

var DBG = DBG || {}
DBG.log = function (msg) { /* console.log (msg); */ };
DBG.dir = function (msg) { /* console.dir (msg); */ };

class CodeEditor {
	constructor(a_editor) {
		this.editor = a_editor;
		this.id = a_editor.attr("id");
		this.loaded = false;
		this.endpoint = a_editor.attr("data-codeboard-endpoint");
		this.controls = {};
		this.fields = {};
		this.messages = {};

		$('<button type="button">Editor &gt;&gt;</button>').insertBefore(this.editor);
		var l_editor_button = $(this.editor).prev();

		$(l_editor_button).on('click', this, function(event) { 
			//console.dir(event.data);
			if (event.data.loaded) {
				event.data.unload_editor(); 
				l_editor_button.html("Editor &gt;&gt;");
			} else {
				event.data.load_editor(); 
				l_editor_button.html("&lt;&lt; Editor");
			}
		});
	};
	
	fields_as_json() {
		let j = {}
		let v = null;
		if (this.fields.locked.attr('checked')) {
			j.is_locked = true;
		}
		j.lang = this.fields.lang.val();
		j.code = this.fields.text.val();
		v = this.fields.caption.val(); if (v.length !== 0) { j.caption = v; }
		v = this.fields.link.val(); if (v.length !== 0) {
			j.link = v; 
		}
		return j;
	}
	unload_editor() {
		this.loaded = false;
		this.editor.text("");
	}

	put_new_control_button(a_name, a_title, a_tooltip=null, a_hidden=false) {
		let but=null;
		if (a_tooltip) {
			but =  $('<button type="button" name="' + a_name + '" title="' + a_tooltip + '">' + a_title + '</button>');
		} else {
			but =  $('<button type="button" name="' + a_name + '" title="' + a_title + '">' + a_title + '</button>');
		}
		this.remove_control_button (a_name);
		this.controls["button_" + a_name] = but;
		this.controls.div.append(but);
		if (a_hidden) { but.hide(); }
	}

	remove_control_button(a_name) {
		let but = this.controls['button_' + a_name];
		if (but) {
			delete this.controls['button_' + a_name];
			$(but).remove();
		}
	}

	load_editor() {
		this.loaded = true;
		this.editor.append(`
		<style>
		.codeboard-editor { width: 500px; margin-left: auto; margin-right: auto; }
		.codeboard-editor .message { margin: 3px; padding: 5px; border: solid 1px #090; background-color: #dfd; color: #090;}
		.codeboard-editor .error { border: solid 1px red; background-color: red; color: white; }
		.codeboard-editor .control { width: 100%;  }
		.codeboard-editor button { padding: 2px; margin-left: 3px; }
		.codeboard-editor-fields { width: 100%; margin-top: 1rem; padding: .5rem; border: solid 1px #999; background-color: #ddd; }
		.codeboard-editor-fields.locked { border: solid 1px red; background-color: #fcc;}
		.codeboard-editor label { font-style: italic; color: #777; }
		.codeboard-editor textarea { width: 100%; height: 250px; }
		.codeboard-editor-fields input { margin-bottom: 5px; width: 100%; }
		.codeboard-editor-fields div.code-locked { display: none; }
		.codeboard-editor-fields.locked div.code-locked { display: block; color: red; font-weight: bold; }
		</style>
		`
		);

			// Control bar
		var l_controls = $('<div class="control"/>');
		this.editor.append(l_controls);
		this.controls['div'] = l_controls;
		this.put_new_control_button ('cancel', '&lt;&lt;', "Cancel", true);
		this.put_new_control_button ('new', 'New', "New");
		this.put_new_control_button ('edit', 'Edit...', "Edit existing codes");

			// Messages
		this.messages = {
				error:$('<div class="message error"/>'),
				message:$('<div class="message"/>')
			}
		this.editor.append(this.messages.error); this.messages.error.hide();
		this.editor.append(this.messages.message); this.messages.message.hide();


			// Web form
		var l_fields = $('<div class="codeboard-editor-fields">');
		this.editor.append(l_fields);
		this.fields = {
			div:l_fields,
			locked:$('<input type="checkbox" name="locked" value="no" style="display: none"/>'),
			lang:$('<input type="text" name="lang" value="eiffel"/>'),
			caption:$('<input type="text" name="caption" placeholder="one line caption..."/>'),
			link:$('<input type="url" name="link" value="" placeholder="Enter an associated url ..." />'),
			text:$('<textarea name="code" required="required"></textarea>')
		}
		l_fields.append('<div class="code-locked">This item is locked!</div>'); l_fields.append(this.fields.locked);
		l_fields.append('<label for="lang">Language</label>'); l_fields.append(this.fields.lang); 
		l_fields.append('<br/><label for="caption">Optional caption</label>'); l_fields.append(this.fields.caption);
		l_fields.append('<br/><label for="link">Optional link</label>'); l_fields.append(this.fields.link);
		l_fields.append('<br/><label for="text">Code</label>'); l_fields.append(this.fields.text);
		
			// Actions
		l_controls.on('click', 'button[name=back]', this, function (event) { event.data.reset() });
		l_controls.on('click', 'button[name=cancel]', this, function (event) { event.data.reset() });
		l_controls.on('click', 'button[name=new]', this, function(event) {
				event.data.on_new_action ();
			});
		l_controls.on('click', 'button[name=edit]', this, function (event) { event.data.on_edit_action() });
	}

	reset() {
		DBG.log ("Reset ...");
		this.reset_control_and_form();
		this.reset_error();
		this.reset_message();
		this.show_snippet(null);
	}
	reset_control_and_form() {
		DBG.log ("Reset control and form...");
		var editor = this;
		$(this.controls.div).children("button,select").each (function() {
			let l_name =$(this).attr('name');
			if (l_name == 'new') {
				$(this).show();
			} else if (l_name == 'edit') {
				$(this).show();
			} else if (l_name == 'cancel') {
				$(this).hide();
			} else {
				$(this).remove();
				delete editor.remove_control_button(l_name);
			}
		});
		this.show_snippet(null);
	}

	show_message(msg,opt=null) {
		this.reset_error();
		this.messages.message.text(msg);
		this.messages.message.show();
		if (opt == 'fadeout') {
			this.messages.message.fadeOut(3000);
		}
	}

	show_error(msg,info,opt=null) {
		this.reset_message();
		if (info) {
			this.messages.error.text("ERROR:"+ msg + " [" + info + "]");
		} else {
			this.messages.error.text("ERROR:"+ msg);
		}
		this.messages.error.show();
		if (opt == 'fadeout') {
			this.messages.error.fadeOut(5000);
		}
	}

	reset_error() {
		DBG.log ("Reset error...");
		this.messages.error.text("");
		this.messages.error.hide();
	}
	reset_message() {
		DBG.log ("Reset message...");
		this.messages.message.text("");
		this.messages.message.hide();
	}
	reset_messages() {
		this.reset_error();
		this.reset_message();
	}
	show_snippet(data) {
		DBG.log ("show_snippet");
		DBG.dir (data);
		if (data) {
			if ("is_locked" in data) {
				this.fields.locked.prop("checked", data.is_locked);
			} else {
				this.fields.locked.prop("checked", false);
			}
			this.fields.lang.val(data.lang);
			this.fields.caption.val(data.caption);
			this.fields.text.val(data.code);
			this.fields.link.val(data.link);

			this.fields.text.addClass("prettyprint");
			if (data.lang) {
				this.fields.text.addClass("lang-" + data.lang);
			}
		} else {
			this.fields.locked.prop("checked", false);
			this.fields.lang.val("eiffel");
			this.fields.caption.val("");
			this.fields.text.val("");
			this.fields.link.val("");

			this.fields.text.removeClass("prettyprint");
			this.fields.text.removeClass("lang-*");
		}
	}

	on_edit_action(){
		this.reset_error();

		var req = $.ajax({
						url: this.endpoint,
						type: 'GET',
						context: this
					}
			);
		req.done(function(data) {
				var i;
				var html = '<select class="code_snippets">';
				html += '<option value="" selected="selected">Select code</option>';
				for (i = 1; i <= data.code_count; i++) {
					var snip = data._links['code-' + i];
					if (snip) {
						html += '<option value="'+snip.href+'">Code ' + i + '</option>';
					}
				}
				html += '</select>';
				this.controls.button_new.hide();
				this.controls.button_edit.hide();
				this.controls.button_cancel.show();

				this.controls.div.find("select.code_snippets").remove();

				this.controls.div.append(html);
				this.controls.div.find("select.code_snippets").change(this, function(event) { 
						event.data.on_edit_selected_action($(this).val());
					});
			}
			);	
		req.fail(function(data) { this.on_failure_action ("Could not get snippet list!", data); });
	}
	on_edit_selected_action(a_code_url) {
		var l_code_id = a_code_url.substr(a_code_url.lastIndexOf('/') + 1);
		if (l_code_id) {
			this.reset_message();
			var req = $.ajax({
							url: a_code_url,
							type: 'GET',
							context: this
						}
				);
			req.done(function(data) {
				this.reset_error();
				this.show_message("Code snippet loaded: " + a_code_url, 'fadeout');
				this.show_snippet(data);

				this.remove_control_button('lock');
				this.remove_control_button('unlock');
				this.remove_control_button('save');
				this.remove_control_button('delete');
				this.remove_control_button('insert');
				this.remove_control_button('unlock');
				if (data.is_locked) {
					this.fields.div.attr('disabled', 'disabled');
					this.fields.div.addClass("locked");
					this.put_new_control_button("unlock", 'Unlock &#128275;', "Unlock" + l_code_id); // Unlock

					this.controls.button_unlock.on('click', {obj:this, info:{url:a_code_url,codeid:l_code_id}}, function (event) { event.data.obj.unlock_code_snippet_action(event.data.info) });
				} else {
					this.fields.div.removeAttr('disabled');
					this.fields.div.removeClass("locked");
					this.put_new_control_button("lock", '&#128274;', "Lock code " + l_code_id); // Lock
					this.put_new_control_button("save", 'Save', "Save code " + l_code_id);
					this.put_new_control_button("delete", 'Del', "Delete code " + l_code_id);
					this.put_new_control_button("insert", 'Insert before ' + l_code_id, "Insert before code " + l_code_id);

					this.controls.button_save.on('click', {obj:this, info:{url:a_code_url,codeid:l_code_id}}, function (event) { event.data.obj.save_code_snippet_action(event.data.info) });
					this.controls.button_delete.on('click', {obj:this, info:{url:a_code_url,codeid:l_code_id}}, function (event) { event.data.obj.delete_code_snippet_action(event.data.info) });
					this.controls.button_insert.on('click', {obj:this, info:{url:a_code_url,codeid:l_code_id}}, function (event) { event.data.obj.insert_code_snippet_action() });
					this.controls.button_lock.on('click', {obj:this, info:{url:a_code_url,codeid:l_code_id}}, function (event) { event.data.obj.lock_code_snippet_action(event.data.info) });
				}
			});
			req.fail(function(data) { this.on_failure_action ("Could not get snippet #"+ l_code_id +" information!", data); });
		}
	}
	unlock_code_snippet_action(info){
		let j = this.fields_as_json();
		j.is_locked = false;
		let req = $.ajax({
						url: info.url, 
						type: 'PUT', 
						context: this,
						contentType: 'application/json',
						dataType: 'json',
						data: JSON.stringify(j)
					}
			);
		req.done(function(data) {
				this.on_edit_selected_action(info.url);
				this.show_message("Snippet code successfully unlocked!",'fadeout');
				}
			);	
		req.fail(function(data) { this.on_failure_action ("Could not unlock code snippet!", data); });
	}
	lock_code_snippet_action(info){
		let j = this.fields_as_json();
		j.is_locked = true;
		let req = $.ajax({
						url: info.url, 
						type: 'PUT', 
						context: this,
						contentType: 'application/json',
						dataType: 'json',
						data: JSON.stringify(j)
					}
			);
		req.done(function(data) {
				this.on_edit_selected_action(info.url);
				this.show_message("Snippet code successfully locked!",'fadeout');
				}
			);	
		req.fail(function(data) { this.on_failure_action ("Could not lock code snippet!", data); });
	}
	save_code_snippet_action(info){
		var req = $.ajax({
						url: info.url, 
						type: 'PUT', 
						context: this,
						contentType: 'application/json',
						dataType: 'json',
						data: JSON.stringify(this.fields_as_json())
					}
			);
		req.done(function(data) {
				this.show_message("Snippet code successfully saved!",'fadeout');
				}
			);	
		req.fail(function(data) { this.on_failure_action ("Could not update code snippet!", data); });
	}
	insert_code_snippet_action() {
		var req = $.ajax({
						url: this.endpoint,
						type: 'POST', 
						context: this,
						contentType: 'application/json',
						dataType: 'json',
						data: JSON.stringify(this.fields_as_json())
					}
			);
		req.done(function(data) {
				var l_code_url = data._links.self.href;
				this.show_message("Snippet code successfully inserted!",'fadeout');
				this.reset_control_and_form();
				}
			);	
		req.fail(function(data) { this.on_failure_action ("Could not insert new code snippet!", data); });

	}
	delete_code_snippet_action(info) {
		var req = $.ajax({
						url: info.url, 
						type: 'DELETE',
						context: this,
					}
			);
		req.done(function(data) {
				this.show_message("Snippet code successfully deleted!",'fadeout');
				this.reset_control_and_form();
				}
			);	
		req.fail(function(data) { this.on_failure_action ("Could not delete code snippet!", data); });

	}

	on_new_action() {
		this.reset_error();
		this.controls.button_new.hide();
		this.controls.button_edit.hide();
		this.controls.button_cancel.show();
		this.put_new_control_button("add", "Create", "Save");
		this.show_snippet(null);
		this.fields.lang.val("eiffel");
		this.fields.caption.val("");
		this.fields.text.val("class\n\tAPPLICATION\n\nfeature -- Access\n\nend");
		this.controls.button_add.one('click', this, function (event) { event.data.on_new_save_action() });
	}

	on_new_save_action() {
		var req = $.ajax({
						url: this.endpoint,
						type: 'POST', 
						context: this,
						contentType: 'application/json',
						dataType: 'json',
						data: JSON.stringify(this.fields_as_json())
					}
			);
		req.done(function(data) {
				var l_code_url = data._links.self.href;
				//controls.button_cancel.show();	
				//controls.button_back.show();	
				this.show_message("Snippet code successfully created!",'fadeout');
				}
			);	
		req.fail(function(data) { this.on_failure_action ("Could not create new code snippet!", data); });

	}
	on_failure_action(msg, response_data) {
			var j = JSON.parse(response_data.responseText);
			if (j) {
				this.show_error(msg, j.error); 
			} else {
				this.show_error(msg, null); 
			}
	}

} // end of class CodeEditor

$(document).ready(function() {
	var code_editor_count = 0;
	$('.codeboard-editor').each (function() { 
		code_editor_count += 1;
		$(this).attr("id", "cbeditor_" + code_editor_count);
		let editor = new CodeEditor($(this));
	});
});

