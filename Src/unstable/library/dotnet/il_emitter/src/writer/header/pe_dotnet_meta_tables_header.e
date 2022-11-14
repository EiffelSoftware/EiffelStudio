note
	description: "Summary description for {DOTNET_META_TABLES_HEADER}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_DOTNET_META_TABLES_HEADER

feature -- Access

	reserved1: NATURAL_32 assign set_reserved1
			-- `reserved1'

	major_version: NATURAL_8 assign set_major_version
			-- `major_version'

	minor_version: NATURAL_8 assign set_minor_version
			-- `minor_version'

	heap_offset_sizes: NATURAL_8 assign set_heap_offset_sizes
			-- `heap_offset_sizes'

	reserved2: NATURAL_8 assign set_reserved2
			-- `reserved2'

	mask_valid: INTEGER_64 assign set_mask_valid
			-- `mask_valid'

	mask_sorted: INTEGER_64 assign set_mask_sorted
			-- `mask_sorted'

feature -- Element change

	set_reserved1 (a_reserved1: like reserved1)
			-- Assign `reserved1' with `a_reserved1'.
		do
			reserved1 := a_reserved1
		ensure
			reserved1_assigned: reserved1 = a_reserved1
		end

	set_major_version (a_major_version: like major_version)
			-- Assign `major_version' with `a_major_version'.
		do
			major_version := a_major_version
		ensure
			major_version_assigned: major_version = a_major_version
		end

	set_minor_version (a_minor_version: like minor_version)
			-- Assign `minor_version' with `a_minor_version'.
		do
			minor_version := a_minor_version
		ensure
			minor_version_assigned: minor_version = a_minor_version
		end

	set_heap_offset_sizes (a_heap_offset_sizes: like heap_offset_sizes)
			-- Assign `heap_offset_sizes' with `a_heap_offset_sizes'.
		do
			heap_offset_sizes := a_heap_offset_sizes
		ensure
			heap_offset_sizes_assigned: heap_offset_sizes = a_heap_offset_sizes
		end

	set_reserved2 (a_reserved2: like reserved2)
			-- Assign `reserved2' with `a_reserved2'.
		do
			reserved2 := a_reserved2
		ensure
			reserved2_assigned: reserved2 = a_reserved2
		end

	set_mask_valid (a_mask_valid: like mask_valid)
			-- Assign `mask_valid' with `a_mask_valid'.
		do
			mask_valid := a_mask_valid
		ensure
			mask_valid_assigned: mask_valid = a_mask_valid
		end

	set_mask_sorted (a_mask_sorted: like mask_sorted)
			-- Assign `mask_sorted' with `a_mask_sorted'.
		do
			mask_sorted := a_mask_sorted
		ensure
			mask_sorted_assigned: mask_sorted = a_mask_sorted
		end

feature -- Measurement

	size_of: INTEGER
		local
			l_internal: INTERNAL
			n: INTEGER
			l_obj: PE_DOTNET_META_TABLES_HEADER
			l_size: INTEGER
		do
			create l_obj
			create l_internal
			n := l_internal.field_count (l_obj)
			across 1 |..| n as ic loop
				if attached l_internal.field (ic, l_obj) as l_field then
					if attached {NATURAL_8} l_field then
						Result := Result + {PLATFORM}.natural_8_bytes
					elseif attached {NATURAL_32} l_field as l_arr then
						Result := Result + {PLATFORM}.natural_32_bytes
					elseif attached {INTEGER_64} l_field as l_arr then
						Result := Result + {PLATFORM}.integer_64_bytes
					end
				end
			end
		ensure
			instance_free: class
		end

end
