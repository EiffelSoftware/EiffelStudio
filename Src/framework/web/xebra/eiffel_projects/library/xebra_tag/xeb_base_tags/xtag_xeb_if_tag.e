note
	description: "[
		{XTAG_XEB_IF_TAG}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_XEB_IF_TAG

inherit
	XTAG_TAG_SERIALIZER

create
	make

feature {NONE} -- Initialization

	make
		do
			make_base
			condition := ""
		end

feature {NONE} -- Access

	condition: STRING

feature -- Implementation

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; variable_table: TABLE [STRING, STRING])
			-- <Precursor>
		do
			if not children.is_empty then
				a_servlet_class.render_feature.append_expression ("if " + Controller_variable + "." + condition + " then")
				generate_children (a_servlet_class, variable_table)
				a_servlet_class.render_feature.append_expression ("end")
			end
		end

	internal_put_attribute (id: STRING; a_attribute: STRING)
			-- <Precursor>
		do
			if id.is_equal("condition") then
				condition := a_attribute
			end
		end
end
