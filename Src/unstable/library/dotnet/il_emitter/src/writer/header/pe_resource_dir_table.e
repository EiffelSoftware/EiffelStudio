note
	description: "Summary description for {PE_RESOURCE_DIR_TABLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_RESOURCE_DIR_TABLE

feature -- Access

	resource_flags: INTEGER_32 assign set_resource_flags
			-- `resource_flags'

	time: INTEGER_32 assign set_time
			-- `time'

	version: INTEGER_32 assign set_version
			-- `version'

	name_entry: INTEGER_16 assign set_name_entry
			-- `name_entry'

	ident_entry: INTEGER_16 assign set_ident_entry
			-- `ident_entry'

feature -- Element change

	set_resource_flags (a_resource_flags: like resource_flags)
			-- Assign `resource_flags' with `a_resource_flags'.
		do
			resource_flags := a_resource_flags
		ensure
			resource_flags_assigned: resource_flags = a_resource_flags
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

	set_name_entry (a_name_entry: like name_entry)
			-- Assign `name_entry' with `a_name_entry'.
		do
			name_entry := a_name_entry
		ensure
			name_entry_assigned: name_entry = a_name_entry
		end

	set_ident_entry (an_ident_entry: like ident_entry)
			-- Assign `ident_entry' with `an_ident_entry'.
		do
			ident_entry := an_ident_entry
		ensure
			ident_entry_assigned: ident_entry = an_ident_entry
		end


feature -- Measurement

	size_of: INTEGER
		local
			l_internal: INTERNAL
			n: INTEGER
			l_obj: PE_OBJECT
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
