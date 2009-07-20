note
	description: "[
		Displays the errors from a validation of an input field. Only works within the context
		of a form and a matching input-name to its own.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_F_VALIDATION_RESULT_TAG

inherit
	XTAG_TAG_SERIALIZER
		redefine
			generates_render
		end

create
	make

feature -- Initialization

	make
		do
			make_base
			create {XTAG_TAG_VALUE_ARGUMENT} name.make_default		
		end

feature -- Access

	name: XTAG_TAG_ARGUMENT
			-- Identification of the input field for the validation mapping
			
	variable: XTAG_TAG_ARGUMENT
			-- Iteration variable name

feature -- Implementation

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precusor>
		do
			if a_id.is_equal ("name") then
				name := a_attribute
			end
			if a_id.is_equal ("variable") then
				variable := a_attribute
			end
		end

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		local
			l_variable: STRING
		do
			if attached variable then
				l_variable := variable.plain_value (current_controller_id)
				a_servlet_class.render_html_page.append_local (l_variable, "STRING")
				a_servlet_class.render_html_page.append_expression ("if attached {LIST [STRING]} validation_errors [%"" + name.plain_value (current_controller_id) + "%"] as error_list then")
				a_servlet_class.render_html_page.append_expression ("from")
				a_servlet_class.render_html_page.append_expression ("error_list.start")
				a_servlet_class.render_html_page.append_expression ("until")
				a_servlet_class.render_html_page.append_expression ("error_list.after")
				a_servlet_class.render_html_page.append_expression ("loop")
				a_servlet_class.render_html_page.append_expression (l_variable + ":= error_list.item")
				generate_children (a_servlet_class, a_variable_table)
				a_servlet_class.render_html_page.append_expression ("error_list.forth")
				a_servlet_class.render_html_page.append_expression ("end")
				a_servlet_class.render_html_page.append_expression ("end")
			end
		end

	generates_render: BOOLEAN = True

end
