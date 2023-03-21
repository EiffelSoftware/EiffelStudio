note
	description: "Summary description for {PE_FIXUP_HOLD}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_FIXUP_HOLD


feature -- Access

	offset: INTEGER_32 assign set_offset
			-- `offset'

	type: NATURAL_8 assign set_type
			-- `type'

feature -- Element change

	set_offset (an_offset: like offset)
			-- Assign `offset' with `an_offset'.
		do
			offset := an_offset
		ensure
			offset_assigned: offset = an_offset
		end


	set_type (a_type: like type)
			-- Assign `type' with `a_type'.
		do
			type := a_type
		ensure
			type_assigned: type = a_type
		end

feature -- Measurement

	size_of: INTEGER
		local
			l_internal: INTERNAL
			n: INTEGER
			l_obj: PE_FIXUP_HOLD
		do
			create l_obj
			create l_internal
			n := l_internal.field_count (l_obj)
			across 1 |..| n as ic loop
				if attached l_internal.field (ic, l_obj) as l_field then
					if attached {INTEGER_32} l_field then
						Result := Result + {PLATFORM}.integer_32_bytes
					elseif attached {NATURAL_8} l_field then
						Result := Result + {PLATFORM}.natural_8_bytes
					end

				end
			end
		ensure
			instance_free: class
		end

end
