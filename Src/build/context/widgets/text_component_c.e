indexing
	description: "Context that represents a text component (EV_TEXT_COMPONENT)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEXT_COMPONENT_C

inherit
	PRIMITIVE_C
		redefine
			gui_object,
			reset_modified_flags
		end

feature -- Status report

	text: STRING is
		do
			Result := gui_object.text
		end

	is_field: BOOLEAN is
		do
			Result := False
		end

	default_text: STRING
			-- Default text displayed in the text component

	is_editable: BOOLEAN is
		do
			Result := gui_object.is_editable
		end

	default_text_modified: BOOLEAN

feature -- Status setting

	set_text (txt: STRING) is
		do
			gui_object.set_text (txt)
		end

	set_default_text (txt: STRING) is
		do
			default_text_modified := True
			default_text := txt
		end

	set_editable (flag: BOOLEAN) is
		do
			gui_object.set_editable (flag)
		end

	reset_modified_flags is
		do
			Precursor
			default_text_modified := False
		end

feature -- Implementation

	gui_object: EV_TEXT_COMPONENT

end -- class TEXT_COMPONENT_C

