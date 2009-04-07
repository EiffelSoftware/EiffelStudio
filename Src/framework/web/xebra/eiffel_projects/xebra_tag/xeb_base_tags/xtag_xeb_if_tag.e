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

	internal_generate (a_render_feature, a_prerender_post_feature, a_prerender_get_feature, a_afterrender_feature: XEL_FEATURE_ELEMENT; variable_table: TABLE [STRING, STRING])
			-- <Precursor>
		do
			append_debug_info (a_render_feature)
			a_render_feature.append_expression ("if " + Controller_variable + "." + condition + " then")
			generate_children (a_render_feature, a_prerender_post_feature, a_prerender_get_feature, a_afterrender_feature, variable_table)
			a_render_feature.append_expression ("end")
		end

	internal_put_attribute (id: STRING; a_attribute: STRING)
			-- <Precursor>
		do
			if id.is_equal("condition") then
				condition := a_attribute
			end
		end
end
