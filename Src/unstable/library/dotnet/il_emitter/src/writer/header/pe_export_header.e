note
	description: "Summary description for {PE_EXPORT_HEADER}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_EXPORT_HEADER

feature -- Access

	flags: INTEGER_32 assign set_flags
			-- `flags'

	time: INTEGER_32 assign set_time
			-- `time'

	version: INTEGER_32 assign set_version
			-- `version'

	exe_name_rva: INTEGER_32 assign set_exe_name_rva
			-- `exe_name_rva'

	ord_base: INTEGER_32 assign set_ord_base
			-- `ord_base'

	n_eat_entries: INTEGER_32 assign set_n_eat_entries
			-- `n_eat_entries'

	n_name_ptrs: INTEGER_32 assign set_n_name_ptrs
			-- `n_name_ptrs'

	address_rva: INTEGER_32 assign set_address_rva
			-- `address_rva'

	name_rva: INTEGER_32 assign set_name_rva
			-- `name_rva'

	ordinal_rva: INTEGER_32 assign set_ordinal_rva
			-- `ordinal_rva'

feature -- Element change

	set_flags (a_flags: like flags)
			-- Assign `flags' with `a_flags'.
		do
			flags := a_flags
		ensure
			flags_assigned: flags = a_flags
		end

	set_time (a_time: like time)
			-- Assign `time' with `a_time'.
		do
			time := a_time
		ensure
			time_assigned: time = a_time
		end

	set_version (a_version: like version)
			-- Assign `version' with `a_version'.
		do
			version := a_version
		ensure
			version_assigned: version = a_version
		end

	set_exe_name_rva (an_exe_name_rva: like exe_name_rva)
			-- Assign `exe_name_rva' with `an_exe_name_rva'.
		do
			exe_name_rva := an_exe_name_rva
		ensure
			exe_name_rva_assigned: exe_name_rva = an_exe_name_rva
		end

	set_ord_base (an_ord_base: like ord_base)
			-- Assign `ord_base' with `an_ord_base'.
		do
			ord_base := an_ord_base
		ensure
			ord_base_assigned: ord_base = an_ord_base
		end

	set_n_eat_entries (a_n_eat_entries: like n_eat_entries)
			-- Assign `n_eat_entries' with `a_n_eat_entries'.
		do
			n_eat_entries := a_n_eat_entries
		ensure
			n_eat_entries_assigned: n_eat_entries = a_n_eat_entries
		end

	set_n_name_ptrs (a_n_name_ptrs: like n_name_ptrs)
			-- Assign `n_name_ptrs' with `a_n_name_ptrs'.
		do
			n_name_ptrs := a_n_name_ptrs
		ensure
			n_name_ptrs_assigned: n_name_ptrs = a_n_name_ptrs
		end

	set_address_rva (an_address_rva: like address_rva)
			-- Assign `address_rva' with `an_address_rva'.
		do
			address_rva := an_address_rva
		ensure
			address_rva_assigned: address_rva = an_address_rva
		end

	set_name_rva (a_name_rva: like name_rva)
			-- Assign `name_rva' with `a_name_rva'.
		do
			name_rva := a_name_rva
		ensure
			name_rva_assigned: name_rva = a_name_rva
		end

	set_ordinal_rva (an_ordinal_rva: like ordinal_rva)
			-- Assign `ordinal_rva' with `an_ordinal_rva'.
		do
			ordinal_rva := an_ordinal_rva
		ensure
			ordinal_rva_assigned: ordinal_rva = an_ordinal_rva
		end

feature -- Measurement

	size_of: INTEGER
		local
			l_internal: INTERNAL
			n: INTEGER
			l_obj: PE_EXPORT_HEADER
		do
			create l_obj
			create l_internal
			n := l_internal.field_count (l_obj)
			across 1 |..| n as ic loop
				if attached l_internal.field (ic, l_obj) as l_field then
					if attached {INTEGER_32} l_field then
						Result := Result + {PLATFORM}.integer_32_bytes
					end
				end
			end
		ensure
			instance_free: class
		end


end
