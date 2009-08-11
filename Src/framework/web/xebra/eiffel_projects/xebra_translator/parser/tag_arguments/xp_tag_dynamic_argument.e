note
	description: "[
		{XP_TAG_DYNAMIC_ARGUMENT}.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_TAG_DYNAMIC_ARGUMENT

inherit
	XP_TAG_ARGUMENT

create
	make

feature -- Implementation

	put_attribute_type: STRING
			-- <Precursor>
		do
			Result := "put_dynamic_attribute"
		end

end
