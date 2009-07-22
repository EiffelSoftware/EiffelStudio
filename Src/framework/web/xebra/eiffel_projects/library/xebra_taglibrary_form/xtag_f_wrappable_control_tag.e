note
	description: "[
		{XTAG_F_TEXTAREA_TAG}.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XTAG_F_WRAPPABLE_CONTROL_TAG

inherit
	XTAG_TAG_SERIALIZER
		redefine
			generates_render,
			generates_wrap
		end

feature -- Initialization

	make
		do
			make_base
			create {XTAG_TAG_VALUE_ARGUMENT} name.make_default()
			create {XTAG_TAG_VALUE_ARGUMENT} value.make_default()
		ensure
			name_attached: attached name
			value_attached: attached value
		end
		
feature -- Access

	name: XTAG_TAG_ARGUMENT
			-- Name for validation
			
	value: XTAG_TAG_ARGUMENT
			-- Text of the control (feature of object)

feature -- Implementation

	html_representation (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_name: STRING)
			-- Returns the html representation of the tag
			--`a_name': The id of the tag. Should be integrated as an attribute of the tag.
		require
			a_name_attached: attached a_name
			a_servlet_class_attached: attached a_servlet_class
		deferred
		end
		
	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precursor>
			-- Stores name for validation
		do
			if a_id.is_equal ("name") then
				name := a_attribute
			end
			if a_id.is_equal ("value") then
				value := a_attribute
			end
		end

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		local
			l_validator_var, l_validation_var, l_input_id: STRING
			l_validator_list: LIST [STRING]
		do
			if attached {LIST [STRING]} a_variable_table [{XTAG_F_FORM_TAG}.Form_agent_var] as l_form_expressions then
				if attached {STRING} a_variable_table [{XTAG_F_FORM_TAG}.Form_var_key] as l_variable then
					l_input_id := a_servlet_class.render_html_page.new_local ("STRING")

						-- Render html page
					a_servlet_class.render_html_page.append_expression (l_input_id + " := get_unique_id")
					html_representation (a_servlet_class, "name=%%%"" + l_input_id + "%%%"")

						-- Retrieve all validators
					create {ARRAYED_LIST [STRING]} l_validator_list.make (0)

					a_variable_table.put (l_validator_list, {XTAG_F_VALIDATOR_TAG}.Validator_tag_list_key)
					generate_children (a_servlet_class, a_variable_table)
					a_variable_table.remove ({XTAG_F_VALIDATOR_TAG}.Validator_tag_list_key)

						-- Validate the input
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
						-- If validation successful set the variable
					a_servlet_class.fill_bean.append_expression ("if " + l_validation_var + " then")
					a_servlet_class.fill_bean.append_expression (transform_to_correct_type (l_variable + "." + value.plain_value (current_controller_id),  "argument"))
					a_servlet_class.fill_bean.append_expression ("end")
					a_servlet_class.fill_bean.append_expression ("end")
				end
			end
		end

	transform_to_correct_type (a_variable_name, a_argument_name: STRING): STRING
			-- Generates an expression which holds the correct type 
			-- (checkbox=Boolean, input_text=String, etc.)
		require
			a_argument_name_attached: attached a_argument_name
			a_variable_name_attached: attached a_variable_name
		deferred			
		ensure
			Result_attached: attached Result
		end
			
	generates_render: BOOLEAN = True
	
	generates_wrap: BOOLEAN = True

end
