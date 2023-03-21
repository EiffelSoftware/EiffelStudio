note
	description: "Summary description for {PE_DOTNET_META_HEADER}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_DOTNET_META_HEADER

inherit
	ANY

create
	default_create,
	make_from_other

feature {NONE} -- Initialization

	make_from_other (a_other: PE_DOTNET_META_HEADER)
		do

		end

feature -- Access

	META_SIG: NATURAL_32 = 0x424A5342

	singature: NATURAL_32

	major: NATURAL_16

	minor: NATURAL_16

	reserved: NATURAL_32

feature -- Element Change

	set_signature (a_val: NATURAL)
			-- Set `signature` with `a_val`.
		do
			singature := a_val
		ensure
			signature_set: singature = a_Val
		end

	set_major (a_val: NATURAL_16)
			-- Set `major` with `a_val`.
		do
			major := a_val
		ensure
			major_set: major = a_val
		end

	set_minor (a_val: NATURAL_16)
			-- Set 	`minor` with `a_val`
		do
			minor := a_val
		ensure
			minor_set: minor = a_val
		end

	set_reserved (a_val: NATURAL)
			-- Set `reserved` with `a_val`
		do
			reserved := a_val
		ensure
			reserved_set: reserved = a_val
		end

feature -- Managed Pointer

	managed_pointer: MANAGED_POINTER
		local
			l_pos: INTEGER
		do
			create Result.make (size_of)
			l_pos := 0

				--signature
			Result.put_natural_32_le (singature, l_pos)
			l_pos := l_pos + {PLATFORM}.natural_32_bytes

				--major
			Result.put_natural_16_le (major, l_pos)
			l_pos := l_pos + {PLATFORM}.natural_16_bytes

				--minor
			Result.put_natural_16_le (minor, l_pos)
			l_pos := l_pos + {PLATFORM}.natural_16_bytes

				--reserved
			Result.put_natural_32_le (reserved, l_pos)
		end

feature -- Measurement

	size_of: INTEGER
		local
			l_internal: INTERNAL
			n: INTEGER
			l_obj: PE_DOTNET_META_HEADER
		do
			create l_obj
			create l_internal
			n := l_internal.field_count (l_obj)
			across 1 |..| n as ic loop
				if attached l_internal.field (ic, l_obj) as l_field then
					if attached {NATURAL_32} l_field then
						Result := Result + {PLATFORM}.natural_32_bytes
					elseif attached {NATURAL_16} l_field then
						Result := Result + {PLATFORM}.natural_16_bytes
					end
				end
			end
		ensure
			instance_free: class
		end

end
