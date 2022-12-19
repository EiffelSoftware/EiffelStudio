note
	description: "Summary description for {PE_RESOURCE_DIR_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_RESOURCE_DIR_ENTRY

inherit

	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			subdir_or_data := 31
			escape := 1
		end

feature -- Access

	rva_or_id: INTEGER_32 assign set_rva_or_id
			-- `rva_or_id'

	subdir_or_data: INTEGER_32 assign set_subdir_or_data
			-- `subdir_or_data'

	escape: INTEGER_32 assign set_escape
			-- `escape'

feature -- Element change

	set_rva_or_id (a_rva_or_id: like rva_or_id)
			-- Assign `rva_or_id' with `a_rva_or_id'.
		do
			rva_or_id := a_rva_or_id
		ensure
			rva_or_id_assigned: rva_or_id = a_rva_or_id
		end

	set_subdir_or_data (a_subdir_or_data: like subdir_or_data)
			-- Assign `subdir_or_data' with `a_subdir_or_data'.
		do
			subdir_or_data := a_subdir_or_data
		ensure
			subdir_or_data_assigned: subdir_or_data = a_subdir_or_data
		end

	set_escape (an_escape: like escape)
			-- Assign `escape' with `an_escape'.
		do
			escape := an_escape
		ensure
			escape_assigned: escape = an_escape
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
