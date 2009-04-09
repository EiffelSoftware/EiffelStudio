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

create
	make

feature -- Initialization

	make
		do
			make_base
			value := ""
			action := ""
		end

feature -- Access

	value: STRING
			-- Caption of the button

	action: STRING
			-- Name of the feature which will be executed
			-- when the button is pressed

feature -- Implementation

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; variable_table: TABLE [STRING, STRING])
			-- <Precursor>
		local
			button_id: STRING
			variable: STRING
		do
			variable := variable_table [{XTAG_F_FORM_TAG}.form_var_key]
			button_id := variable + "_" + a_servlet_class.render_feature.get_unique_identifier

			a_servlet_class.render_feature.append_expression (response_variable_append + "(%"<button name=%%%"" + button_id + "%%%" type=%%%"button%%%">" + value + "</button>%")")
			a_servlet_class.prerender_post_feature.append_expression ("if " + request_variable + ".arguments.has_key (%"" + button_id + "%") then")
			a_servlet_class.prerender_post_feature.append_expression (controller_variable + "." + action + "(" + variable + ")")
			a_servlet_class.prerender_post_feature.append_expression ("end")
		end

	internal_put_attribute (id: STRING; a_attribute: STRING)
			-- <Precusor>
		do
			if id.is_equal ("value") then
				value := a_attribute
			end
			if id.is_equal ("action") then
				action := a_attribute
			end
		end

end
