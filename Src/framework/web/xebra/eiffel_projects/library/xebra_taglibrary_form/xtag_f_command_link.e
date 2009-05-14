note
	description: "[
		{XTAG_F_COMMAND_LINK}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_F_COMMAND_LINK

inherit
	XTAG_TAG_SERIALIZER
		redefine
			generates_render
			generates_postrender
		end

create
	make

feature -- Initialization

	make
			--
		do
			make_base
		end

feature -- Access

	action: STRING
			-- Action that should be executed on this link

	argument: STRING
			-- The argument for the action
			-- For instance an ID

	label: STRING
			-- The text of the link

feature -- Implementation

	generate (a_render_feature, a_prerender_post_feature, a_prerender_get_feature, a_afterrender_feature: XEL_FEATURE_ELEMENT; variable_table: TABLE [STRING, STRING])
			-- <Precursor>
		local
			unique_id, unique_var, unique_form_id: STRING
		do
			append_debug_info (a_servlet_class.render_feature)
				-- Figure out, if the post request comes from this link, if yes execute the function with the appropriate argument
			unique_id :=  a_prerender_post_feature.get_temp_variable
			unique_var :=  a_prerender_post_feature.get_temp_variable
			unique_form_id :=  a_prerender_post_feature.get_temp_variable
			a_prerender_post_feature.append_expression ("if attached request.arguments[" + unique_id + "] as " + unique_var + " then")
			a_render_feature.append_expression (Response_variable + ".append (" +
				a1 + unique_form_id +
				a2 + "%" + request.target_uri + %"" +
				a3
			)

			a_render_feature.append_expression (Response_variable + ".append (" +
				a4 + unique_form_id +
				a5 + unique_var_id +
				a6
			)

			a_prerender_post_feature.append_expression (Controller_variable + "." + action + " (" + unique_var + ")")

			a_render_feature.append_expression (Response_variable + ".append (%"</form>%")")
			a_prerender_post_feature.append_expression ("end")
		end

	put_attribute (id: STRING; a_attribute: STRING)
			-- <Precursor>
		do
			if id.is_equal ("label") then
				label := a_attribute
			end
			if id.is_equal ("action") then
				action := a_attribute
			end
			if id.is_equal ("argument") then
				argument := a_attribute
			end
		end

	generates_render: BOOLEAN = True
	generates_postrender: BOOLEAN = True

feature -- Constants

	a1: STRING = "<form id=%""
	a2: STRING = "%" method=%"post%" action=%""
	a3: STRING = "%">"
	a4: STRING = "<a href=%"#%" onclick=%"document.forms['"
	a5: STRING = "']['"
	a6: STRING = "'].value='"
	a7: STRING = "'; docuemnt.forms['"
	a8: STRING = "'].submit(); return false;%>"
	a9: STRING = "</a>"
	a10: STRING = "input type=%"hidden%" name =%""
	a11: STRING = "%" />"

end
