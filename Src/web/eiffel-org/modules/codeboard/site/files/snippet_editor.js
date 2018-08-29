//console.log('Start codeboard_editor...(jquery='+ jQuery().jquery +')');

var CBEDITOR = CBEDITOR || {};
CBEDITOR.count = 0;
CBEDITOR.endpoint = null;
//TODO support multiple CBEDITOR ...
CBEDITOR.form_data = null;
CBEDITOR.loaded = false;

CBEDITOR.initialize = function(a_editor) {
  CBEDITOR.endpoint = a_editor.attr("data-codeboard-endpoint");
  CBEDITOR.count = CBEDITOR.count + 1;
  if (CBEDITOR.count == 1) {
	var l_editor_id = "cbeditor_" + CBEDITOR.count;
	a_editor.attr("id", l_editor_id);
	$('<button type="button">Editor &gt;&gt;</button>').insertBefore(a_editor);
	var l_editor_button = $(a_editor).prev();
	$(l_editor_button).on('click', function() { 
		if (CBEDITOR.loaded) {
			CBEDITOR.unload(a_editor); 
			l_editor_button.html("Editor &gt;&gt;");
		} else {
			CBEDITOR.load(a_editor); 
			l_editor_button.html("&lt;&lt; Editor");
		}
	});
  }
}

CBEDITOR.unload = function(a_editor) {
	CBEDITOR.loaded = false;
	a_editor.text("");
}
CBEDITOR.load = function(a_editor) {
	CBEDITOR.loaded = true;
	a_editor.append(`
	<style>
	.codeboard-editor { width: 500px; margin-left: auto; margin-right: auto; }
	.codeboard-editor .message { margin: 3px; padding: 5px; border: solid 1px #090; background-color: #dfd; color: #090;}
	.codeboard-editor .error { border: solid 1px red; background-color: red; color: white; }
	.codeboard-editor .control { width: 100%;  }
	.codeboard-editor-inner { width: 100%; margin-top: 1rem; padding: .5rem; border: solid 1px #999; background-color: #ddd; }
	.codeboard-editor label { font-style: italic; color: #777; }
	.codeboard-editor textarea { width: 100%; height: 250px; }
	.codeboard-editor-inner input { margin-bottom: 5px; width: 100%; }
	</style>
	`
	);
	var l_control = $('<div class="control"/>');
	var l_cancel = $('<button type="button" name="cancel">&lt;&lt;</button>'); l_cancel.hide();
	var l_new = $('<button type="button" name="new">New</button>');
	var l_edit = $('<button type="button" name="edit">Edit...</button>');
	a_editor.append(l_control);
	l_control.append(l_cancel);
	l_control.append(l_new);
	l_control.append(l_edit);

	var l_error = $('<div class="message error"/>');
	var l_message = $('<div class="message"/>');

	var l_form = $('<div class="codeboard-editor-inner">');
	a_editor.append(l_form);
	l_form.append(l_error); l_error.hide();
	l_form.append(l_message); l_message.hide();

	var l_lang = $('<input type="text" name="lang" value="eiffel"/>');
	var l_desc = $('<input type="text" name="description" value=""/>');
	var l_text = $('<textarea name="code"></textarea>');
	l_form.append('<label for="lang">Language</label>'); l_form.append(l_lang); l_form.append("<br/>");
	l_form.append('<label for="description">Short description</label>'); l_form.append(l_desc); l_form.append("<br/>");
	l_form.append('<label for="text">Code</label>');
	l_form.append(l_text);
	CBEDITOR.form_data = {
			control: {
				div:l_control, 
				//button_back:l_back, 
				button_new:l_new, 
				button_edit:l_edit, 
				button_cancel:l_cancel
			},
			error:l_error,
			message:l_message,
			form:l_form, 
			lang:l_lang, 
			description:l_desc,
			text:l_text 
		};

	l_control.on('click', 'button[name=back]', CBEDITOR.reset);
	l_control.on('click', 'button[name=cancel]', CBEDITOR.reset);
	l_control.on('click', 'button[name=new]', function() {
			CBEDITOR.on_new_action (CBEDITOR.form_data);
		});

	l_control.on('click', 'button[name=edit]', CBEDITOR.on_edit_action);
}

CBEDITOR.reset = function() {
	//console.log ("Reset ...");
	CBEDITOR.reset_control_and_form();
	CBEDITOR.reset_error();
	CBEDITOR.reset_message();
	CBEDITOR.show_snippet({lang:"eiffel", description:"", code: ""});
}
CBEDITOR.reset_control_and_form = function() {
	//console.log ("Reset control and form...");
	var form_data = CBEDITOR.form_data;
	$(form_data.control.div).children("button,select").each (function() {
		var l_name =$(this).attr('name');
		if (l_name == 'new') {
			$(this).show();
		} else if (l_name == 'edit') {
			$(this).show();
		} else if (l_name == 'cancel') {
			$(this).hide();
		} else {
			$(this).remove();
		}
	});
	CBEDITOR.show_snippet({lang:"eiffel", description:"", code: ""});
}

CBEDITOR.show_message = function (msg) {
	CBEDITOR.reset_error();
	CBEDITOR.form_data.message.text(msg);
	CBEDITOR.form_data.message.show();
}
CBEDITOR.show_error = function (msg,info) {
	CBEDITOR.reset_message();
	if (info) {
		CBEDITOR.form_data.error.text("ERROR:"+ msg + " [" + info + "]");
	} else {
		CBEDITOR.form_data.error.text("ERROR:"+ msg);
	}
	CBEDITOR.form_data.error.show();
}
CBEDITOR.reset_error = function () {
	CBEDITOR.form_data.error.text("");
	CBEDITOR.form_data.error.hide();
}
CBEDITOR.reset_message = function () {
	CBEDITOR.form_data.message.text("");
	CBEDITOR.form_data.message.hide();
}
CBEDITOR.show_snippet = function (data) {
	CBEDITOR.form_data.lang.val(data.lang);
	CBEDITOR.form_data.description.val(data.description);
	CBEDITOR.form_data.text.val(data.code);
}

CBEDITOR.on_edit_action = function() {
	CBEDITOR.reset_error();

	var req = $.ajax({
					url: CBEDITOR.endpoint,
					type: 'GET'
				}
		);
	req.done(function(data) {
			var i;
			var html = '<select class="code_snippets">';
			html += '<option value="" selected="selected">Select code</option>';
			for (i = 1; i <= data.available_code_count; i++) {
				var snip = data._links['code-' + i];
				if (snip) {
					html += '<option value="'+snip.href+'">Code ' + i + '</option>';
				}
			}
			html += '</select>';
			CBEDITOR.form_data.control.button_new.hide();
			CBEDITOR.form_data.control.button_edit.hide();
			CBEDITOR.form_data.control.button_cancel.show();

			CBEDITOR.form_data.control.div.find("select.code_snippets").remove();

			CBEDITOR.form_data.control.div.append(html);
			CBEDITOR.form_data.control.div.find("select.code_snippets").change(function() { 
					CBEDITOR.on_edit_selected_action($(this).val());
				});
		}
		);	
	req.fail(function(data) { CBEDITOR.on_failure_action ("Could not get snippet list!", data); });
}
CBEDITOR.on_edit_selected_action = function(a_code_url) {
	var l_code_id = a_code_url.substr(a_code_url.lastIndexOf('/') + 1);
	if (l_code_id) {
		var req = $.ajax({
						url: a_code_url,
						type: 'GET'
					}
			);
		req.done(function(data) {
			CBEDITOR.reset_error();
			CBEDITOR.show_message("Code snippet loaded: " + a_code_url);
			CBEDITOR.show_snippet(data);

			CBEDITOR.form_data.control.div.find("button[name=save]").remove();
			CBEDITOR.form_data.control.div.find("button[name=delete]").remove();
			CBEDITOR.form_data.control.div.find("button[name=insert]").remove();

			var but_save = $('<button type="button" name="save">Save '+ l_code_id +'</button>');
			CBEDITOR.form_data.control.div.append(but_save);

			var but_delete = $('<button type="button" name="delete">Delete '+ l_code_id +'</button>');
			CBEDITOR.form_data.control.div.append(but_delete);

			var but_insert = $('<button type="button" name="insert">Insert new before '+ l_code_id +'</button>');
			CBEDITOR.form_data.control.div.append(but_insert);

			$(but_save).on('click', {url:a_code_url,codeid:l_code_id}, CBEDITOR.save_code_snippet_action);
			$(but_delete).on('click', {url:a_code_url,codeid:l_code_id}, CBEDITOR.delete_code_snippet_action);
			$(but_insert).on('click', {url:a_code_url, codeid:l_code_id}, CBEDITOR.insert_code_snippet_action);
		});
		req.fail(function(data) { CBEDITOR.on_failure_action ("Could not get snippet #"+ l_code_id +" information!", data); });
	}
}
CBEDITOR.save_code_snippet_action = function(ev) {
	var j = {
		"lang": CBEDITOR.form_data.lang.val() ,
		"description": CBEDITOR.form_data.description.val() ,
		"code": CBEDITOR.form_data.text.val()
	};

	var req = $.ajax({
					url: ev.data.url, 
					type: 'PUT', 
					contentType: 'application/json',
					dataType: 'json',
					data: JSON.stringify(j)
				}
		);
	req.done(function(data) {
			//CBEDITOR.form_data.control.button_cancel.hide();	
			//CBEDITOR.form_data.control.button_back.show();	
			CBEDITOR.show_message("Snippet code successfully saved!");
			}
		);	
	req.fail(function(data) { CBEDITOR.on_failure_action ("Could not update code snippet!", data); });
}
CBEDITOR.insert_code_snippet_action = function(ev) {
	var form_data = CBEDITOR.form_data;
	var j = {
		"code_id": ev.data.codeid ,
		"lang": form_data.lang.val() ,
		"description": form_data.description.val() ,
		"code": form_data.text.val()
	};

	var req = $.ajax({
					url: CBEDITOR.endpoint,
					type: 'POST', 
					contentType: 'application/json',
					dataType: 'json',
					data: JSON.stringify(j)
				}
		);
	req.done(function(data) {
			var l_code_url = data._links.self.href;
			CBEDITOR.show_message("Snippet code successfully inserted!");
			CBEDITOR.reset_control_and_form();
			}
		);	
	req.fail(function(data) { CBEDITOR.on_failure_action ("Could not insert new code snippet!", data); });

}
CBEDITOR.delete_code_snippet_action = function(ev) {
	var req = $.ajax({
					url: ev.data.url, 
					type: 'DELETE'
				}
		);
	req.done(function(data) {
			CBEDITOR.show_message("Snippet code successfully deleted!");
			CBEDITOR.reset_control_and_form();
			}
		);	
	req.fail(function(data) { CBEDITOR.on_failure_action ("Could not delete code snippet!", data); });

}

CBEDITOR.on_new_action = function(form_data) {
	CBEDITOR.reset_error();
	form_data.control.button_new.hide();
	form_data.control.button_edit.hide();
	form_data.control.button_cancel.show();
	var l_button_save = $('<button type="button" name="add">Save</button>');
	form_data.control.div.append(l_button_save);
	form_data.lang.val("eiffel");
	form_data.description.val("");
	form_data.text.val("class\n\tAPPLICATION\n\n\tfeature -- Access\n\nend");
	l_button_save.one('click', CBEDITOR.on_new_save_action);
}

CBEDITOR.on_new_save_action = function() {
	var form_data = CBEDITOR.form_data;
	var j = {
		"lang": form_data.lang.val() ,
		"description": form_data.description.val() ,
		"code": form_data.text.val()
	};

	var req = $.ajax({
					url: CBEDITOR.endpoint,
					type: 'POST', 
					contentType: 'application/json',
					dataType: 'json',
					data: JSON.stringify(j)
				}
		);
	req.done(function(data) {
			var l_code_url = data._links.self.href;
			//form_data.control.button_cancel.show();	
			//form_data.control.button_back.show();	
			CBEDITOR.show_message("Snippet code successfully created!");
			}
		);	
	req.fail(function(data) { CBEDITOR.on_failure_action ("Could not create new code snippet!", data); });

}
CBEDITOR.on_failure_action = function(msg, response_data) {
		var j = JSON.parse(response_data.responseText);
		if (j) {
			CBEDITOR.show_error(msg, j.error); 
		} else {
			CBEDITOR.show_error(msg, null); 
		}
}

$(document).ready(function() {
	$('.codeboard-editor').each (function() { CBEDITOR.initialize($(this)); });
});

