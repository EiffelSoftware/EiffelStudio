note
	description: "[
		{XTAG_F_BUTTON_TAG}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_F_BUTTON_TAG

inherit
	XTAG_TAG_SERIALIZER

create
	make

feature -- Initialization

	make
		do
			make_base
			value := ""
			action := ""
		end

feature -- Access

	value: STRING
			-- Caption of the button

	action: STRING
			-- Name of the feature which will be executed
			-- when the button is pressed

feature -- Implementation

	internal_generate (a_render_feature, a_prerender_post_feature, a_prerender_get_feature, a_afterrender_feature: XEL_FEATURE_ELEMENT; variable_table: TABLE [STRING, STRING])
			-- <Precursor>
		do
		end

	internal_put_attribute (id: STRING; a_attribute: STRING)
			-- <Precusor>
		do
			if id.is_equal ("value") then
				value := a_attribute
			end
			if id.is_equal ("action") then
				action := a_attribute
			end
		end

end
