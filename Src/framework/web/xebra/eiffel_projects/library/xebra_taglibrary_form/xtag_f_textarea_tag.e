note
	description: "[
		{XTAG_F_TEXTAREA_TAG}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_F_TEXTAREA_TAG

inherit
	XTAG_TAG_SERIALIZER
		redefine
			generates_render,
			generates_postrender,
			generates_afterrender
		end

create
	make

feature -- Initialization

	make
		do
			make_base
			create value.make ("")
			create name.make ("")
			create text.make ("")
			create cols.make ("45")
			create rows.make ("5")
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

	cols, rows: XTAG_TAG_ARGUMENT
			-- Columns and rows

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
			if a_id.is_equal ("cols") then
				cols := a_attribute
			end
			if a_id.is_equal ("rows") then
				rows := a_attribute
			end
		end

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		local
			l_input_id: STRING
			l_validator_list: LIST [STRING]
			l_is_valid: STRING
			l_validator_temp: STRING
			l_message_var: STRING
		do
			if attached {STRING} a_variable_table [{XTAG_F_FORM_TAG}.Form_var_key] as l_variable then
				if attached {LIST[STRING]} a_variable_table [{XTAG_F_FORM_TAG}.Form_validation_booleans] as l_validation_vars then
					if attached {HASH_TABLE [STRING, STRING]} a_variable_table [{XTAG_F_FORM_TAG}.form_lazy_validation_table] as  l_validation_table then
						l_input_id := l_variable + "_" + a_servlet_class.get_unique_identifier

							-- render feature
						a_servlet_class.render_feature.append_expression (response_variable_append + "(%"<textarea rows=%%%"" + rows.value (current_controller_id) + "cols=%%%"" + cols.value (current_controller_id) +"%%%" name=%%%"" + l_input_id + "%%%">" + text.value (current_controller_id) + "%%%"</textarea>%")")

						create {ARRAYED_LIST [STRING]} l_validator_list.make (0)
						a_variable_table.put (l_validator_list, {XTAG_F_VALIDATOR_TAG}.Validator_tag_list_key)
						generate_children (a_servlet_class, a_variable_table)
						a_variable_table.remove ({XTAG_F_VALIDATOR_TAG}.Validator_tag_list_key)

							-- prerender post feature
						a_servlet_class.prerender_post_feature.append_expression ("if attached " +
							request_variable + ".arguments [%"" + l_input_id + "%"] as argument then")
						l_is_valid := a_servlet_class.prerender_post_feature.new_local ("BOOLEAN")
						l_validation_vars.extend (l_is_valid)
						a_servlet_class.prerender_post_feature.append_expression (l_is_valid + " := True")
						l_validator_temp := a_servlet_class.prerender_post_feature.new_local ("XWA_VALIDATOR")
						l_message_var := get_validation_local (l_validation_table, a_servlet_class, name.value (current_controller_id))
						if not a_variable_table.is_empty then
							a_servlet_class.afterrender_feature.append_expression (l_message_var + ".wipe_out")
							from
								l_validator_list.start
							until
								l_validator_list.after
							loop
								a_servlet_class.prerender_post_feature.append_expression ("create {" + l_validator_list.item + "}" + l_validator_temp + ".make")
								a_servlet_class.prerender_post_feature.append_expression (l_is_valid + " := " +
									l_is_valid + " and " + l_validator_temp + ".validate (argument)")

								a_servlet_class.prerender_post_feature.append_expression ("if not " + l_validator_temp + ".validate (argument)" + " then")
								a_servlet_class.prerender_post_feature.append_expression (l_message_var + ".extend (" + l_validator_temp + ".message)")
								a_servlet_class.prerender_post_feature.append_expression ("end")
								l_validator_list.forth
							end
							a_servlet_class.prerender_post_feature.append_expression ("if " + l_is_valid + " then")
						end
						a_servlet_class.prerender_post_feature.append_expression (l_variable + "." + value.value (current_controller_id) + " := argument")
						if not a_variable_table.is_empty then
							a_servlet_class.prerender_post_feature.append_expression ("end")
						end

						a_servlet_class.prerender_post_feature.append_expression ("end")
					end
				else
					a_servlet_class.render_feature.append_comment ("AN ERROR OCCURED WHILE GENERATING OF XTAG_F_INPUT_TAG!")
				end
			else
				a_servlet_class.render_feature.append_comment ("AN ERROR OCCURED WHILE GENERATING OF XTAG_F_INPUT_TAG!")
			end
		end


	generates_render: BOOLEAN = True
	generates_postrender: BOOLEAN = True
	generates_afterrender: BOOLEAN = True

end
