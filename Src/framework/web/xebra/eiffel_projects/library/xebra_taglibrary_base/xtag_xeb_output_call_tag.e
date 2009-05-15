note
	description: "Summary description for {XTAG_XEB_OUTPUT_CALL_TAG}."
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_XEB_OUTPUT_CALL_TAG

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
			text := ""
		end

feature -- Access

	text: STRING
			-- The name of the feature to call

feature -- Implementation

	internal_generate (servlet_class: XEL_SERVLET_CLASS_ELEMENT; variable_table: HASH_TABLE [STRING, STRING])
			-- <Precursor>
		do
			servlet_class.render_feature.append_expression (Response_variable_append + "(" + current_controller_id + "." + text + ".out)")
		end

	internal_put_attribute (id: STRING; a_attribute: STRING)
			-- <Precursor>
		do
			if id.is_equal ("value") then
				text := a_attribute
			end
		end

	generates_render: BOOLEAN = True

end
