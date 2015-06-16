note
	description: "Extends the WSF form textarea with features to add a WYSIWIG editor."
	author: "Dario Bösch <daboesch@student.ethz.ch"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_FORM_TEXTAREA

inherit
	WSF_FORM_TEXTAREA
		redefine
			make,
			append_item_to_html
		end

	CMS_EDITOR_CKEDITOR

create
	make

feature -- Initialisation

	make (a_name: like name)
			-- <Precursor>
		do
			precursor(a_name)

				-- By default we don't replace the textarea by an editor
			editor := False;
		end

feature -- Access

	editor : BOOLEAN
			-- True if the textarea should be replaced by the editor. Default is false.

	format_field : detachable WSF_FORM_SELECT
			-- Selection field for the format on that it depends, if the editor is shown or not.

	condition_value : detachable STRING

feature -- Editor

	show_as_editor
			-- The textarea will be replaced by a wysiwyg editor
		do
			editor := True
		end

	show_as_editor_if_selected (a_select_field : WSF_FORM_SELECT; a_value : STRING)
			-- Replaces the textarea only if a_select_field has a_value (or the value gets selected)
		do
			editor := True
			format_field := a_select_field
			condition_value := a_value
		end

feature -- Conversion

	append_item_to_html (a_theme: WSF_THEME; a_html: STRING_8)
		do
			-- Add javascript to replace textarea with editor
			precursor(a_theme, a_html)
			if editor then
				a_html.append (load_assets)
				a_html.append ("<script type=%"text/javascript%">");
				if attached format_field as l_field and then attached condition_value as l_value then
					a_html.append (javascript_textarea_to_editor_if_selected (Current, l_field, l_value))
				else
					a_html.append (javascript_textarea_to_editor (Current))
				end
				a_html.append ("</script>")
			end
		end

end
