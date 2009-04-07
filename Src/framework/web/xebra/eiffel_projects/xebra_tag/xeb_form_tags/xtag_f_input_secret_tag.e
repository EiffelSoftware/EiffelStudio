note
	description: "[
		{XTAG_F_INPUT_SECRET_TAG}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_F_INPUT_SECRET_TAG

inherit
	XTAG_F_INPUT_TAG

feature -- Initialization

	make
		do
			make_base
		end

feature -- Implementation

	internal_generate (a_render_feature, a_prerender_post_feature, a_prerender_get_feature, a_afterrender_feature: XEL_FEATURE_ELEMENT; variable_table: TABLE [STRING, STRING])
			-- <Precursor>
		do
		end

end
