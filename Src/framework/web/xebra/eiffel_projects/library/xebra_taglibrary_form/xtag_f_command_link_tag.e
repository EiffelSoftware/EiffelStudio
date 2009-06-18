note
	description: "[
		{XTAG_F_COMMAND_LINK}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_F_COMMAND_LINK_TAG

inherit
	XTAG_TAG_SERIALIZER
		redefine
			generates_render
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

	action: XTAG_TAG_ARGUMENT
			-- Action that should be executed on this link

	label: XTAG_TAG_ARGUMENT
			-- The text of the link

	variable: XTAG_TAG_ARGUMENT
			-- Variable which has to be past to the callee

feature -- Implementation

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		local
			l_unique_id,
			l_unique_var: STRING
			l_attached_var: STRING
		do
			if attached {STRING} a_variable_table [{XTAG_F_FORM_TAG}.form_id] as l_unique_form_id then
				if attached {LIST [STRING]} a_variable_table [{XTAG_F_FORM_TAG}.Form_agent_var] as l_form_expressions then
						-- Figure out, if the post request comes from this link, if yes execute the function with the appropriate argument
					l_unique_id :=  a_servlet_class.render_html_page.new_uid
					l_unique_var :=  a_servlet_class.render_html_page.new_local ("STRING")
					a_servlet_class.render_html_page.append_expression (l_unique_var + " := get_unique_id")

					a_servlet_class.render_html_page.append_expression (Response_variable + ".append (%"" +
						forms1 + l_unique_form_id +
						forms2 + l_unique_var +
						value + "%" + " + l_unique_var + "+ %"" +
						submit + l_unique_form_id +
						stopsubmit + label.value (current_controller_id) +
						stopahref +
						inputname + l_unique_var +
						stopinput +
						"%")"
					)
					a_servlet_class.render_html_page.append_expression ("agent_table [" + l_unique_var + "] := agent (a_request: XH_REQUEST; a_object: ANY) do")
					a_servlet_class.render_html_page.append_expression (current_controller_id + "." + action.value (current_controller_id) + " (a_object)")
					a_servlet_class.render_html_page.append_expression ("end (?, " + variable.value (current_controller_id) + ") -- COMMAND_TAG")

					l_attached_var := a_servlet_class.render_html_page.new_uid
					l_form_expressions.extend ("if attached a_request.arguments [%"" + l_unique_var + "%"] as " + l_attached_var +" then")
					l_form_expressions.extend ("if attached agent_table [" + l_attached_var + "] then")
					l_form_expressions.extend ("agent_table [" + l_attached_var + "].call ([a_request])")
					l_form_expressions.extend ("end")
					l_form_expressions.extend ("end")
				else
					a_servlet_class.render_html_page.append_comment ("AN ERROR OCCURED WHILE GENERATION OF XTAG_F_COMMAND_LINK_TAG!")
				end
			else
				a_servlet_class.render_html_page.append_comment ("AN ERROR OCCURED WHILE GENERATION OF XTAG_F_COMMAND_LINK_TAG!")
			end
		end

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precursor>
		do
			if a_id.is_equal ("label") then
				label := a_attribute
			end
			if a_id.is_equal ("action") then
				action := a_attribute
			end
			if a_id.is_equal ("variable") then
				variable := a_attribute
			end
		end

	generates_render: BOOLEAN = True

feature -- Constants

	forms1: STRING = "<a href=%%%"#%%%" onclick=%%%"document.forms['"
	forms2: STRING = "']['"
	value: STRING = "'].value='"
	submit: STRING = "'; document.forms['"
	stopsubmit: STRING = "'].submit(); return false;%%%">"
	stopahref: STRING = "</a>"
	inputname: STRING = "<input type=%%%"hidden%%%" name =%%%""
	stopinput: STRING = "%%%" />"

end
