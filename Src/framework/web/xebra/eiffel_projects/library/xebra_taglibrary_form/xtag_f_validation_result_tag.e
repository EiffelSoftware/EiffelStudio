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
			name := ""
		end

feature -- Access

	name: STRING
			-- Identification of the input field for the validation mapping

feature -- Implementation

	internal_put_attribute (a_id: STRING; a_attribute: STRING)
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
			if attached {HASH_TABLE [STRING, STRING]} a_variable_table [{XTAG_F_FORM_TAG}.Form_lazy_validation_table] as l_lazy_table then
				l_messages_var := get_validation_local (l_lazy_table, a_servlet_class, name)
				a_servlet_class.render_feature.append_expression ("from")
				a_servlet_class.render_feature.append_expression (l_messages_var + ".start")
				a_servlet_class.render_feature.append_expression ("until")
				a_servlet_class.render_feature.append_expression (l_messages_var + ".after")
				a_servlet_class.render_feature.append_expression ("loop")
				a_servlet_class.render_feature.append_expression (response_variable_append + "(" + l_messages_var + ".item)")
				a_servlet_class.render_feature.append_expression (l_messages_var + ".forth")
				a_servlet_class.render_feature.append_expression ("end")
			end
		end

	generates_render: BOOLEAN = True

end
