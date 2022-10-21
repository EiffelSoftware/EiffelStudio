note
	description: "Summary description for {CIL_CUSTOM_ATTRIBUTE_DESCRIPTOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_CUSTOM_ATTRIBUTE_DESCRIPTOR


create
	make

feature {NONE} -- Initialization

	make
		do
			create name.make_empty
			size := 0
			create data.make_empty
		ensure
			name_empty: name.is_empty
			size_zero: size = 0
			data_emtpy: data.is_empty
		end
feature -- Access

	name: STRING_32
		-- the name.

	size: NATURAL_32

	data: ARRAY [NATURAL_32]

feature -- Operations

	-- bool operator() (const CustomAttributeDescriptor *left, const CustomAttributeDescriptor *right) const;
end
