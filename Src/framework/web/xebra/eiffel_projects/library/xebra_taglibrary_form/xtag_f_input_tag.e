note
	description: "[
		{XTAG_F_INPUT_TAG}.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XTAG_F_INPUT_TAG

inherit
	XTAG_TAG_SERIALIZER
		redefine
			make_base,
			generates_render,
			generates_postrender
		end

feature -- Initialization

	make_base
		do
			Precursor
			value := ""
			name := ""
		end

feature -- Access

	value: STRING
			-- Text of the input field

	name: STRING
			-- Identification of the input field for the data object mapping

feature -- Implementation

	internal_put_attribute (a_id: STRING; a_attribute: STRING)
			-- <Precusor>
		do
			if a_id.is_equal ("value") then
				value := a_attribute
			end
			if a_id.is_equal ("name") then
				name := a_attribute
			end
		end

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [STRING, STRING])
			-- <Precursor>
		local
			l_input_id, l_variable: STRING
		do
			l_variable := a_variable_table [{XTAG_F_FORM_TAG}.form_var_key]
			l_input_id := l_variable + "_" + a_servlet_class.get_unique_identifier
			a_servlet_class.render_feature.append_expression (response_variable_append + "(%"<input type=%%%"input%%%" name=%%%"" + l_input_id + "%%%" value=%%%"%" +" + l_variable + "." + value + " + %"%%%" />%")")
			a_servlet_class.prerender_post_feature.append_expression ("if attached " + request_variable + ".arguments [%"" + l_input_id + "%"] as argument then")
			a_servlet_class.prerender_post_feature.append_expression (l_variable + "." + value + " := argument")
			a_servlet_class.prerender_post_feature.append_expression ("end")
		end

	generates_render: BOOLEAN = True
	generates_postrender: BOOLEAN = True

end
