note
	description: "Summary description for {PE_FIXUP_BLOCK}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_FIXUP_BLOCK

inherit

	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			create data.make_filled (0, 1, 2048)
		end

feature -- Access

	rva: INTEGER_32 assign set_rva
			-- `rva'

	size: INTEGER_32 assign set_size
			-- `size'

	data: ARRAY [INTEGER_16]
			-- 2048 bytes.

feature -- Element change

	set_rva (a_rva: like rva)
			-- Assign `rva' with `a_rva'.
		do
			rva := a_rva
		ensure
			rva_assigned: rva = a_rva
		end

	set_size (a_size: like size)
			-- Assign `size' with `a_size'.
		do
			size := a_size
		ensure
			size_assigned: size = a_size
		end


feature -- Measurement

	size_of: INTEGER
		local
			l_internal: INTERNAL
			n: INTEGER
			l_obj: PE_HEADER
		do
			create l_obj
			create l_internal
			n := l_internal.field_count (l_obj)
			across 1 |..| n as ic loop
				if attached l_internal.field (ic, l_obj) as l_field then
					if attached {INTEGER_32} l_field then
						Result := Result + {PLATFORM}.integer_32_bytes
					elseif attached {ARRAY [INTEGER_16]} l_field as l_arr then
						Result := Result + (l_arr.count * {PLATFORM}.integer_16_bytes)
					end
				end
			end
		ensure
			instance_free: class
		end


end
