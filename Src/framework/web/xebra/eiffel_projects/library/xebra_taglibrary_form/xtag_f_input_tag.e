note
	description: "[
		Generic class for input fields. Handles automatic setting of values to the
		warapped object depending on the validation (if any).
		Can only be used in the context of a {XTAG_F_FORM_TAG}.
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
			generates_wrap
		end

feature -- Initialization

	make_base
		do
			Precursor
			create {XTAG_TAG_VALUE_ARGUMENT}value.make_default
			create {XTAG_TAG_VALUE_ARGUMENT}name.make_default
			create {XTAG_TAG_VALUE_ARGUMENT}text.make_default
		ensure then
			value_attached: attached value
			name_attached: attached name
			text_attached: attached text
		end

feature -- Access

	value: XTAG_TAG_ARGUMENT
			-- Text of the input field (feature of object)

	text: XTAG_TAG_ARGUMENT
			-- Text in the input field

	name: XTAG_TAG_ARGUMENT
			-- Identification of the input field for the data object mapping for validation

feature -- Implementation

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precusor>
		do
			if a_id.is_equal ("value") then
				value := a_attribute
			end
			if a_id.is_equal ("name") then
				name := a_attribute
			end
			if a_id.is_equal ("text") then
				text := a_attribute
			end
		end

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		local
			l_input_id: STRING
			l_validator_list: LIST [STRING]
			l_validator_var, l_validation_var: STRING
		do
			if attached {LIST [STRING]} a_variable_table [{XTAG_F_FORM_TAG}.Form_agent_var] as l_form_expressions then
				if attached {STRING} a_variable_table [{XTAG_F_FORM_TAG}.Form_var_key] as l_variable then
					l_input_id := a_servlet_class.render_html_page.new_local ("STRING")

						-- RENDER HTML PAGE
					a_servlet_class.render_html_page.append_expression (l_input_id + " := get_unique_id")
					a_servlet_class.render_html_page.append_expression
						(response_variable_append + "(%"<input type=%%%"" + input_type +"%%%" name=%%%"" +
						 l_input_id + "%%%" value=%%%"" + text.value (current_controller_id) + "%%%" />%")")

						-- WRAP FORM TO INTERNAL REPRESENTATION
					create {ARRAYED_LIST [STRING]} l_validator_list.make (0)

					a_variable_table.put (l_validator_list, {XTAG_F_VALIDATOR_TAG}.Validator_tag_list_key)
					generate_children (a_servlet_class, a_variable_table)
					a_variable_table.remove ({XTAG_F_VALIDATOR_TAG}.Validator_tag_list_key)

						-- FORM EXPRESSIONS
					a_servlet_class.fill_bean.append_expression ("if attached a_request.argument_table [%"" + l_input_id + "%"] as argument then")
					l_validation_var := a_servlet_class.fill_bean.new_local ("BOOLEAN")
					a_servlet_class.fill_bean.append_expression (l_validation_var + " := True")
					if not l_validator_list.is_empty then
						l_validator_var := a_servlet_class.fill_bean.new_local ("XWA_VALIDATOR")
						from -- Loop over all validators
							l_validator_list.start
						until
							l_validator_list.after
						loop
							a_servlet_class.fill_bean.append_expression ("create {" + l_validator_list.item + "}" +  l_validator_var + ".make")
							a_servlet_class.fill_bean.append_expression ("if not " + l_validator_var + ".validate (argument) then")
							a_servlet_class.fill_bean.append_expression (l_validation_var + " := False")
							a_servlet_class.fill_bean.append_expression ("add_error (%"" + name.plain_value (current_controller_id) + "%", " + l_validator_var + ".message)")
							a_servlet_class.fill_bean.append_expression ("end")
							l_validator_list.forth
						end
					end
					a_servlet_class.fill_bean.append_expression ("Result := Result and " + l_validation_var)
					a_servlet_class.fill_bean.append_expression ("if " + l_validation_var + " then")
					a_servlet_class.fill_bean.append_expression (l_variable + "." + value.plain_value (current_controller_id) + " := argument")
					a_servlet_class.fill_bean.append_expression ("end")
					a_servlet_class.fill_bean.append_expression ("end")
				end
			end
		end

	input_type: STRING
			-- Returns the type of input it represents (input, secret, etc.)
		deferred
		ensure
			result_attached: attached Result
		end

	generates_render: BOOLEAN = True
	generates_wrap: BOOLEAN = True

end
