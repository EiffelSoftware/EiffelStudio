note
	description: "[
		{XTAG_F_TEXTAREA_TAG}.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_F_TEXTAREA_TAG

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
			create {XTAG_TAG_VALUE_ARGUMENT} value.make_default
			create {XTAG_TAG_VALUE_ARGUMENT} name.make_default
			create {XTAG_TAG_VALUE_ARGUMENT} text.make_default
			create {XTAG_TAG_VALUE_ARGUMENT} cols.make ("45")
			create {XTAG_TAG_VALUE_ARGUMENT} rows.make ("5")
		ensure then
			value_attached: attached value
			name_attached: attached name
			text_attached: attached text
		end

feature -- Access

	text: XTAG_TAG_ARGUMENT
			-- Text in the input field

	cols, rows: XTAG_TAG_ARGUMENT
			-- Columns and rows

feature -- Implementation

	html_representation (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_name: STRING)
			-- <Precursor>
		do
			a_servlet_class.render_html_page.append_expression (response_variable_append +
				"(%"<textarea rows=%%%"" + rows.value (current_controller_id) + "%%%" cols=%%%"" +
				cols.value (current_controller_id) +"%%%" name=%%%"" + a_name + "%%%">" +
				text.value (current_controller_id) + "</textarea>%")")
		end


	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precursor>
		do
			Precursor (a_id, a_attribute)
			if a_id.is_equal ("text") then
				text := a_attribute
			end
			if a_id.is_equal ("cols") then
				cols := a_attribute
			end
			if a_id.is_equal ("rows") then
				rows := a_attribute
			end
		end
		
	transform_to_correct_type (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_name, a_argument_name: STRING): STRING
			-- <Precursor>
		do
			Result := a_variable_name + " := " + a_argument_name
		end

end
