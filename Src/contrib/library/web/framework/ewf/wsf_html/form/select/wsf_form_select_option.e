note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	WSF_FORM_SELECT_OPTION

inherit
	WSF_FORM_SELECTABLE_ITEM

	SHARED_HTML_ENCODER

create
	make

feature {NONE} -- Initialization

	make (a_value: READABLE_STRING_GENERAL; a_text: detachable READABLE_STRING_GENERAL)
			-- Initialize `Current'.
		do
			value := a_value.as_string_32
			if a_text = Void then
				text := html_encoder.general_encoded_string (a_value)
			else
				text := a_text.to_string_32
			end
		end

feature -- Status

	is_selected: BOOLEAN

	is_same_value (v: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := value.same_string_general (v)
		end

	is_same_text (v: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := v.same_string (text)
		end

feature -- Access

	value: READABLE_STRING_32

	text: READABLE_STRING_32

	description: detachable READABLE_STRING_8

feature -- Change

	set_is_selected (b: like is_selected)
		do
			is_selected := b
		end

	set_description (d: like description)
		do
			description := d
		end

end
