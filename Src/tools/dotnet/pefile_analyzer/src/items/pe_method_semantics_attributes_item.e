note
	description: "[
			See II.23.1.12 MethodSemanticsAttributes
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_METHOD_SEMANTICS_ATTRIBUTES_ITEM

inherit
	PE_INTEGER_16_ITEM
		redefine
			make_from_item
		end

	PE_ATTRIBUTES_ITEM
		rename
			has_flag_16 as has_flag
		end

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

			if has_flag (0x0, Setter,	v) then Result.append ("Setter ") end
			if has_flag (0x0, Getter,	v) then Result.append ("Getter ") end
			if has_flag (0x0, Other,	v) then Result.append ("Other ") end
			if has_flag (0x0, AddOn,	v) then Result.append ("AddOn ") end
			if has_flag (0x0, RemoveOn,	v) then Result.append ("RemoveOn ") end
			if has_flag (0x0, Fire,		v) then Result.append ("Fire ") end
		end

--	to_string: STRING_32
--		do
--			Result := to_flags_string + Precursor
--		end

feature -- Flags

	Setter: NATURAL_16 = 0x0001	-- Setter for property
	Getter: NATURAL_16 = 0x0002	-- Getter for property
	Other: NATURAL_16 = 0x0004	-- Other method for property or event
	AddOn: NATURAL_16 = 0x0008	-- AddOn method for event. This refers to the required add_ method for events. (§22.13)
	RemoveOn: NATURAL_16 = 0x0010	-- RemoveOn method for event. . This refers to the required remove_ method for events. (§22.13)
	Fire: NATURAL_16 = 0x0020	-- Fire method for event. This refers to the optional raise_ method for events. (§22.13)

end
