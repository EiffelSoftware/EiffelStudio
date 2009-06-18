note
	description: "[
		This is an obsolete class/tag.
		Acts like a xeb:container ({XTAG_XEB_CONTAINER_TAG}) but needs an
		additional attribute 'condition'. This tag is obsolete since 
		it can be simulated with a <xeb:container render="..." ..
	]"
	date: "$Date$"
	revision: "$Revision$"

obsolete class
	XTAG_XEB_IF_TAG

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
			create condition.make ("")
		end

feature {NONE} -- Access

	condition: XTAG_TAG_ARGUMENT

feature -- Implementation

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		do
			if not children.is_empty then
				a_servlet_class.render_feature.append_expression ("if " + current_controller_id + "." + condition.value (current_controller_id) + " then")
				generate_children (a_servlet_class, variable_table)
				a_servlet_class.render_feature.append_expression ("end -- if")
			end
		end

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precursor>
		do
			if a_id.is_equal("condition") then
				condition := a_attribute
			end
		end

	generates_render: BOOLEAN = True

end
