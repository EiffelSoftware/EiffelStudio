note
	description: "Summary description for {PE_ATTRIBUTES_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_ATTRIBUTES_ITEM

feature -- Conversion

	to_flags_string: STRING_8
		deferred
		end

feature -- Status report		

	has_flag_16 (a_mask, a_flag, a_value: NATURAL_16): BOOLEAN
		local
			v: NATURAL_16
		do
			v := a_value
			if a_mask /= 0x0 then
				v := a_value & a_mask
			end
			Result := (v & a_flag) = a_flag
		end

	has_flag_32 (a_mask, a_flag, a_value: NATURAL_32): BOOLEAN
		local
			v: NATURAL_32
		do
			v := a_value
			if a_mask /= 0x0 then
				v := a_value & a_mask
			end
			Result := (v & a_flag) = a_flag
		end

end
