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
			generates_render,
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

	label: STRING
			-- The text of the link

	redirect: STRING
			-- Where should the page redirect after the link has been clicked

feature -- Implementation

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [STRING, STRING])
			-- <Precursor>
		local
			l_unique_id,
			l_unique_var,
			l_unique_form_id,
			l_redirect_var: STRING
		do
				-- Figure out, if the post request comes from this link, if yes execute the function with the appropriate argument
			l_unique_id :=  a_servlet_class.prerender_post_feature.new_local ("STRING")
			l_unique_var :=  a_servlet_class.prerender_post_feature.new_uid
			l_unique_form_id := a_variable_table [{XTAG_F_FORM_TAG}.form_id]

			a_servlet_class.render_feature.append_expression (Response_variable + ".append (%"" +
				forms1 + l_unique_form_id +
				forms2 + l_unique_var +
				value +
				submit + l_unique_form_id +
				stopsubmit + label +
				stopahref +
				inputname + l_unique_var +
				stopinput +
				"%")"
			)
			l_redirect_var := a_variable_table [{XTAG_F_FORM_TAG}.form_var_redirect]
			a_servlet_class.prerender_post_feature.append_expression ("if attached request.arguments[%"" + l_unique_var + "%"] as argument then")
			a_servlet_class.prerender_post_feature.append_expression (l_redirect_var + " := " + current_controller_id + "." + action + " (argument)")
			a_servlet_class.prerender_post_feature.append_expression ("end")
		end

	internal_put_attribute (a_id: STRING; a_attribute: STRING)
			-- <Precursor>
		do
			if a_id.is_equal ("label") then
				label := a_attribute
			end
			if a_id.is_equal ("action") then
				action := a_attribute
			end
			if a_id.is_equal ("redirect") then
				redirect := a_attribute
			end
		end

	generates_render: BOOLEAN = True
	generates_postrender: BOOLEAN = True

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
