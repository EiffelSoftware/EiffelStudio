note
	description: "Summary description for {CMS_EDITOR_CKEDITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_EDITOR_CKEDITOR

inherit
	CMS_EDITOR

feature -- Initialisation

	load_assets: STRING
			-- <Precursor>
		do
			Result := "<script src=%"//cdn.ckeditor.com/4.4.7/standard/ckeditor.js%"></script>"
		end

feature -- Javascript

	javascript_replace_textarea (a_textarea: WSF_FORM_TEXTAREA): STRING
			-- <Precursor>
		do
				-- Replaces the textarea with an editor instance.
				-- Save the instance in a variable.
			Result := "$(%"textarea[name="+ a_textarea.name +"]%").each(function() {"
			Result.append (editor_variable (a_textarea) + " = CKEDITOR.replace(this);")
			Result.append ("});")
		end

	javascript_restore_textarea (a_textarea: WSF_FORM_TEXTAREA): STRING
			-- <Precursor>
		do
				-- Replaces the textarea with an editor instance.
				-- Save the instance in a variable.
			Result := "if (" + editor_variable (a_textarea) + " != undefined) " + editor_variable (a_textarea) + ".destroy();"
		end

note
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
