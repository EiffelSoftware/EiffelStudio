note
	description: "[
		Defines validator classes for an input field.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_F_CHECK_BOX_TAG

inherit
	XTAG_F_WRAPPABLE_CONTROL_TAG
		redefine
			make,
			internal_put_attribute
		end

create
	make

feature -- Initialization

	make
		do
			Precursor
			create {XTAG_TAG_VALUE_ARGUMENT} text.make_default
			create {XTAG_TAG_VALUE_ARGUMENT} is_checked.make ("False")
		ensure then
			text_attached: attached text
			is_checked_attached: attached is_checked
		end

feature {NONE} -- Access

	text: XTAG_TAG_ARGUMENT
			-- The text displayed beneath the checkbox
	
	is_checked: XTAG_TAG_ARGUMENT
			-- Is the checkbox checked?

feature -- Implementation

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precusor>
		do
			Precursor (a_id, a_attribute)
			if a_id.is_equal ("text") then
				text := a_attribute
			end
			if a_id.is_equal ("checked") then
				is_checked := a_attribute
			end
		end

	html_representation (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_name: STRING)
			-- <Precursor>
		local
			l_checked: STRING
		do
			if is_checked.value (current_controller_id).as_lower.is_equal ("true") then
				l_checked := "checked=%%%"checked%%%""
			else
				l_checked := ""
			end
			a_servlet_class.render_html_page.append_expression (response_variable_append + "(%"<input type=%%%"checkbox%%%"" + a_name + l_checked + "/>%")")
		end

end
