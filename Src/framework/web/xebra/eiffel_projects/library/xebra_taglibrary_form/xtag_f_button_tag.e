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

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		local
			l_button_id: STRING
		do
			if attached {STRING} a_variable_table [{XTAG_F_FORM_TAG}.Form_var_key] as l_variable then
				if attached {STRING} a_variable_table [{XTAG_F_FORM_TAG}.Form_agent_var] as l_agent_var then
					if attached {LIST [STRING]} a_variable_table [{XTAG_F_FORM_TAG}.form_validation_booleans] as l_validation_vars then
						l_button_id := l_variable + "_" + a_servlet_class.get_unique_identifier

						a_servlet_class.render_feature.append_expression (response_variable_append + "(%"<button type=%%%"" + type + "%%%" name=%%%"" + l_button_id + "%%%" type=%%%"button%%%">" + value + "</button>%")")
						a_servlet_class.prerender_post_feature.append_expression ("if " + concatenate_with ("and", l_validation_vars) + " and " + request_variable + ".arguments.has_key (%"" + l_button_id + "%") then")
						a_servlet_class.prerender_post_feature.append_expression (l_agent_var + " := agent " + current_controller_id + "." + action)
						a_servlet_class.prerender_post_feature.append_expression ("end")
					end
				end
			else
				a_servlet_class.render_feature.append_comment ("AN ERROR OCCURED WHILE GENERATION OF XTAG_F_COMMAND_LINK_TAG!")
			end
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
