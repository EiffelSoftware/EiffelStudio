note
	description: "[
		A button tag to display a html button. It has to be placed into a
		{XTAG_F_FORM_TAG}.
		Everytime the button is pushed (and the validation was successfull) a (defined)
		action is performed. The action is a function with one argument. It expects
		the filled out object of the form and returns the page to which the server
		should redirect.
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
			create value.make ("")
			create action.make ("")
			create type.make ("")
		ensure
			value_attached: attached value
			action_attached: attached action
			type_attached: attached type
		end

feature -- Access

	value: XTAG_TAG_ARGUMENT
			-- Caption of the button

	action: XTAG_TAG_ARGUMENT
			-- Name of the feature which will be executed
			-- when the button is pressed

	type: XTAG_TAG_ARGUMENT
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

						a_servlet_class.render_feature.append_expression (response_variable_append + "(%"<button type=%%%"" + type.value (current_controller_id) + "%%%" name=%%%"" + l_button_id + "%%%" type=%%%"button%%%">" + value.value (current_controller_id) + "</button>%")")
						a_servlet_class.prerender_post_feature.append_expression ("if " + concatenate_with ("and", l_validation_vars) + " and " + request_variable + ".arguments.has_key (%"" + l_button_id + "%") then")
						a_servlet_class.prerender_post_feature.append_expression (l_agent_var + " := agent " + current_controller_id + "." + action.value (current_controller_id))
						a_servlet_class.prerender_post_feature.append_expression ("end")
					end
				end
			else
				a_servlet_class.render_feature.append_comment ("AN ERROR OCCURED WHILE GENERATING XTAG_F_BUTTON_TAG")
			end
		end

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
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
