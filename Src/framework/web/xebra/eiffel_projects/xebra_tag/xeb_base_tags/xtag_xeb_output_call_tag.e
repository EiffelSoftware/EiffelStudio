note
	description: "Summary description for {XTAG_XEB_OUTPUT_CALL_TAG}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_XEB_OUTPUT_CALL_TAG

inherit
	XTAG_TAG_SERIALIZER
		redefine
			generate
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

	generate (a_feature: XEL_FEATURE_ELEMENT)
			-- <Precursor>
		do
			a_feature.append_expression ("Result.append (controller." + text + ")")
		end

	put_attribute (id: STRING; a_attribute: STRING)
			-- <Precursor>
		do
			if id.is_equal ("value") then
				text := a_attribute
			end
		end

end
