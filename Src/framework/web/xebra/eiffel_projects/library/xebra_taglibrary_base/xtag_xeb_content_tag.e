note
	description: "[
		{XTAG_XEB_CONTENT_TAG}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_XEB_CONTENT_TAG

inherit
	XTAG_TAG_SERIALIZER
		redefine
			generates_render
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			make_base
			create text.make ("no content")
		end

feature {NONE} -- Access

	text: XTAG_TAG_ARGUMENT

feature -- Implementation

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		do
			write_string_to_result (text.value (current_controller_id), a_servlet_class.render_feature)
			generate_children (a_servlet_class, a_variable_table)
		end

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precursor>
		do
			if a_id.is_equal("text") then
				text := a_attribute
			end
		end

	generates_render: BOOLEAN = True

end
