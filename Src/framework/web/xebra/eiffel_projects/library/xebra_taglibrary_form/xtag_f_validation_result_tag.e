note
	description: "[
		Displays the errors from a validation of an input field. Only works within the context
		of a form and a matching input-name to its own.
	]"
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
			create name.make ("")
		end

feature -- Access

	name: XTAG_TAG_ARGUMENT
			-- Identification of the input field for the validation mapping

feature -- Implementation

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precusor>
		do
			if a_id.is_equal ("name") then
				name := a_attribute
			end
		end

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		local
			l_messages_var: STRING
		do
			l_messages_var := a_servlet_class.render_html_page.new_local ("LIST [STRING]")
			a_servlet_class.render_html_page.append_expression ("if attached {LIST [STRING]} validation_errors [%"" + name.plain_value (current_controller_id) + "%"] as error_list then")
			a_servlet_class.render_html_page.append_expression ("from")
			a_servlet_class.render_html_page.append_expression ("error_list.start")
			a_servlet_class.render_html_page.append_expression ("until")
			a_servlet_class.render_html_page.append_expression ("error_list.after")
			a_servlet_class.render_html_page.append_expression ("loop")
			write_string_to_result ("<br />", a_servlet_class.render_html_page)
			a_servlet_class.render_html_page.append_expression (response_variable_append + "(" + "error_list.item)")
			a_servlet_class.render_html_page.append_expression ("error_list.forth")
			a_servlet_class.render_html_page.append_expression ("end")
			a_servlet_class.render_html_page.append_expression ("end")
		end

	generates_render: BOOLEAN = True

end
