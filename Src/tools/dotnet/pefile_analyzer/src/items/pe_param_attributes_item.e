note
	description: "[
			See II.23.1.13 ParamAttributes
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_PARAM_ATTRIBUTES_ITEM

inherit
	PE_INTEGER_16_ITEM
		redefine
			to_string,
			make_from_item
		end

	PE_ATTRIBUTES_ITEM

create
	make,
	make_from_item

convert
	value: {INTEGER_16}

feature {NONE} -- Initialization	

	make_from_item (a_item: PE_ITEM)
		do
			Precursor (a_item)
			value := pointer.read_integer_16_le (0)
		end

feature -- Status report

	to_flags_string: STRING_8
		local
			v: NATURAL_16
			t: NATURAL_16
		do
			create Result.make (0)
			v := value.to_natural_16

			t := v

			if (t & In) = In then
				Result.append ("In ")
			end
			if (t & Out_) = Out_ then
				Result.append ("Out ")
			end
			if (t & Optional) = Optional then
				Result.append ("Optional ")
			end
			if (t & HasDefault) = HasDefault then
				Result.append ("HasDefault ")
			end
			if (t & HasFieldMarshal) = HasFieldMarshal then
				Result.append ("HasFieldMarshal ")
			end
			if (t & Unused) = Unused then
				Result.append ("Unused ")
			end
		end

	to_string: STRING_32
		do
			Result := to_flags_string + Precursor
		end

feature -- Flags

	In: NATURAL_32 = 0x0001	-- Param is [In]
	Out_: NATURAL_32 = 0x0002	-- Param is [out]
	Optional: NATURAL_32 = 0x0010	-- Param is optional
	HasDefault: NATURAL_32 = 0x1000	-- Param has default value
	HasFieldMarshal: NATURAL_32 = 0x2000	-- Param has FieldMarshal
	Unused: NATURAL_32 = 0xcfe0	-- Reserved: shall be zero in a conforming implementatio

end
