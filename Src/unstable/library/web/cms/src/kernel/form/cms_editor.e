note
	description: "Class to import a WYSIWIG editor using javascript code"
	author: "Dario Bösch <daboesch@student.ethz.ch"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_EDITOR

feature -- Initialisation

	load_assets: STRING
			-- Loads all assest needed to show the editor.
		deferred
		end

feature -- Javascript

	javascript_replace_textarea (a_textarea: WSF_FORM_TEXTAREA): STRING
			-- Javascript code that replaces a textarea with the editor. The editor instance should be saved in editor_variable.
		deferred
		end

	javascript_restore_textarea (a_textarea: WSF_FORM_TEXTAREA): STRING
			-- Javascript code that restores a textarea
		deferred
		end

	javascript_textarea_to_editor (a_textarea: WSF_FORM_TEXTAREA): STRING
			-- Javascript code to display the textarea as a WYSIWIG editor as soon as the document is loaded.
		do
			Result := javascript_ready (javascript_replace_textarea (a_textarea))
		end

	javascript_textarea_to_editor_if_selected (a_textarea: WSF_FORM_TEXTAREA; a_select_field: WSF_FORM_SELECT; a_value: STRING): STRING
			-- Javascript code to display the textarea as a WYSIWIG editor if a_select_field has a_value,
		local
			initial_replace_code, on_select_replace_code: STRING
		do
				-- Javascript that replaces the textarea if a_value is selected at load time
			initial_replace_code := javascript_ready (javascript_if_selected (a_select_field, a_value, javascript_replace_textarea (a_textarea)))

				-- Javascript code that replaces the textarea as soon as value is selected at a_select_field
			on_select_replace_code := javascript_ready(
										javascript_init_editor_variable (a_textarea) +
										javascript_on_select (a_select_field, a_value,
											-- If a_value is selected, replace textarea
										javascript_replace_textarea (a_textarea),

											-- Otherwise restore it
										javascript_restore_textarea (a_textarea)
										)
									)

			Result := initial_replace_code + " " + on_select_replace_code
		end

	javascript_init_editor_variable (a_textarea: WSF_FORM_TEXTAREA): STRING
			-- Returns the javascript code that initializes a local variable to store the editor instance.
		do
			Result := "var " + editor_variable (a_textarea) + "; "
		end

	javascript_if_selected (a_select_field: WSF_FORM_SELECT; a_value: STRING; a_code: STRING): STRING
			-- Javascript that executes a_code if a_value is selected at a_select_field.
		do
			Result := "if($('#" + field_id (a_select_field) + "').val() == %"" + a_value + "%"){ " + a_code + " }"
		end

	javascript_ready (a_code: STRING): STRING
			-- Wraps the given javascript code with a ready statement,
			-- such that it's executed when the document has loaded.
		do
			Result := "$(function() { " + a_code + " });"
		end

	javascript_on_select (a_select_field: WSF_FORM_SELECT; a_value: STRING; a_then: STRING; a_else: STRING): STRING
			-- Javascript code that executes `a_then' if at the given `a_select_field'
			-- the given string `a_value' is selected, otherwise it executes `a_else'.
		do
			Result := "$('#" + field_id (a_select_field) + "').change(function(){"
				+		javascript_if_selected (a_select_field, a_value, a_then)
				+ 	"else{"
				+		a_else
				+ 	"}"
				+ "});"
		end

feature -- Helper

	field_id (a_select_field: WSF_FORM_SELECT): READABLE_STRING_8
			-- Id of the given field.
		do
			if attached a_select_field.css_id as a_id then
				Result := a_id
			else
				Result := a_select_field.name + "-select"
			end
		end

	editor_variable (a_textarea: WSF_FORM_TEXTAREA): READABLE_STRING_8
			-- Returns the variable name that stores the editor instance of the given textarea
		do
			Result := "cms_ckeditor_" + a_textarea.name
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
