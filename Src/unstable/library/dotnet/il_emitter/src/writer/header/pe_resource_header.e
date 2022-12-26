note
	description: "Summary description for {PE_RESOURCE_HEADER}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_RESOURCE_HEADER

feature -- Access

	data_size: INTEGER_32 assign set_data_size
			-- `data_sIze'

	hrd_size: INTEGER_32 assign set_hrd_size
			-- `hrd_size'

feature -- Element change

	set_hrd_size (a_hrd_size: like hrd_size)
			-- Assign `hrd_size' with `a_hrd_size'.
		do
			hrd_size := a_hrd_size
		ensure
			hrd_size_assigned: hrd_size = a_hrd_size
		end

	set_data_size (a_data_size: like data_size)
			-- Assign `data_size' with `a_data_size'.
		do
			data_size := a_data_size
		ensure
			data_size_assigned: data_size = a_data_size
		end

feature -- Measurement

	size_of: INTEGER
		local
			l_internal: INTERNAL
			n: INTEGER
			l_obj: PE_RESOURCE_HEADER
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
