note
	description: "Summary description for {XEB_DISPLAY_TAG}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	XEB_DISPLAY_TAG

inherit
	TAG_SERIALIZER
		redefine
			output
		end

create
	make

feature -- Access

	make
		do
			make_base
			create {CONSTANT_ATTRIBUTE} feature_name.make ("")
		end

	feature_name: TAG_ATTRIBUTE
			-- The name of the feature to call

	output (parent: SERVLET; buf: INDENDATION_STREAM)
			-- <Precursor>
		do
			buf.put_string (parent.call_on_controller_with_result (feature_name.value (parent)))
		end

	put_attribute (id: STRING; a_attribute: TAG_ATTRIBUTE)
		do
			if id.is_equal ("feature") then
				feature_name := a_attribute
			end
		end

end
