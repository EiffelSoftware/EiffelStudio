note
	description: "[
		{XP_TAG_VALUE_ARGUMENT}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_TAG_VALUE_ARGUMENT

inherit
	XP_TAG_ARGUMENT

create
	make

feature -- Implementation

	put_attribute_type: STRING
			-- <Precursor>
		do
			Result := "put_value_attribute"
		end

end
