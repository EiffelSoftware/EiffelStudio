note
	description: "[
		Generic class for input fields. Handles automatic setting of values to the
		warapped object depending on the validation (if any).
		Can only be used in the context of a {XTAG_F_FORM_TAG}.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XTAG_F_INPUT_TAG

inherit
	XTAG_F_WRAPPABLE_CONTROL_TAG
		redefine
			make,
			internal_put_attribute
		end

feature -- Initialization

	make
		do
			Precursor
			create {XTAG_TAG_VALUE_ARGUMENT} text.make_default
			create {XTAG_TAG_VALUE_ARGUMENT} size.make ("20")
		ensure then
			text_attached: attached text
			size_attached: attached size
		end

feature -- Access

	text: XTAG_TAG_ARGUMENT
			-- Text in the input field
		
	size: XTAG_TAG_ARGUMENT
			-- The size of the input field
			
	max_length: XTAG_TAG_ARGUMENT
			-- The maximal length of the field

feature -- Implementation

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precusor>
		do
			Precursor (a_id, a_attribute)
			if a_id.is_equal ("text") then
				text := a_attribute
			end
			if a_id.is_equal ("size") then
				size := a_attribute
			end
			if a_id.is_equal ("max_length") then
				max_length := a_attribute
			end
		end
		
	html_representation (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_name: STRING)
			-- <Precursor>
		local
			l_max_length: STRING
		do
			if attached max_length then
				l_max_length := "maxLength=%%%"" + max_length.value (current_controller_id) + "%%%""
			else
				l_max_length := ""
			end
			a_servlet_class.render_html_page.append_expression (response_variable_append + "(%"<input type=%%%"" + input_type + "%%%" value=%%%"" + text.value (current_controller_id) +  "%%%"" + "size=%%%"" + size.value (current_controller_id) + "%%%"" + a_name + " " + l_max_length + "/>%")")
		end
	
	input_type: STRING
			-- What type of input is this?
		deferred
		ensure
			Result_attached: attached Result
		end	

end
