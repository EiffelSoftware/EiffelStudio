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

	generate (a_feature: XEL_FEATURE_ELEMENT)
			-- <Precursor>
		do
			a_feature.append_expression ("if " + Controller_variable + "." + condition + " then")
			generate_children (a_feature)
			a_feature.append_expression ("end")
		end

	put_attribute (id: STRING; a_attribute: STRING)
			-- <Precursor>
		do
			if id.is_equal("condition") then
				condition := a_attribute
			end
		end
end
