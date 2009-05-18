note
	description: "[
		{XTAG_F_BUTTON_TAG}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_F_BUTTON_TAG

inherit
	XTAG_TAG_SERIALIZER
		redefine
			generates_render,
			generates_postrender
		end

create
	make

feature -- Initialization

	make
		do
			make_base
			value := ""
			action := ""
			type := "submit"
		end

feature -- Access

	value: STRING
			-- Caption of the button

	action: STRING
			-- Name of the feature which will be executed
			-- when the button is pressed

	type: STRING
			-- Type of the button (submit, push, etc.)

feature -- Implementation

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [STRING, STRING])
			-- <Precursor>
		local
			l_button_id: STRING
			l_variable: STRING
			l_redirect_var: STRING
		do
			l_variable := a_variable_table [{XTAG_F_FORM_TAG}.Form_var_key]
			l_button_id := l_variable + "_" + a_servlet_class.get_unique_identifier
			l_redirect_var := a_variable_table [{XTAG_F_FORM_TAG}.Form_var_redirect]

			a_servlet_class.render_feature.append_expression (response_variable_append + "(%"<button type=%%%"" + type + "%%%" name=%%%"" + l_button_id + "%%%" type=%%%"button%%%">" + value + "</button>%")")
			a_servlet_class.prerender_post_feature.append_expression ("if " + request_variable + ".arguments.has_key (%"" + l_button_id + "%") then")
			a_servlet_class.prerender_post_feature.append_expression (l_redirect_var + " := " + current_controller_id + "." + action + " (" + l_variable + ")")
			a_servlet_class.prerender_post_feature.append_expression ("end")
		end

	internal_put_attribute (a_id: STRING; a_attribute: STRING)
			-- <Precusor>
		do
			if a_id.is_equal ("value") then
				value := a_attribute
			end
			if a_id.is_equal ("action") then
				action := a_attribute
			end
			if a_id.is_equal ("type") then
				type := a_attribute
			end
		end

	generates_render: BOOLEAN = True
	generates_postrender: BOOLEAN = True

end
