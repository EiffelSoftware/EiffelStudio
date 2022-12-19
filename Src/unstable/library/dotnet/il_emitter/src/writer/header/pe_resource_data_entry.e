note
	description: "Summary description for {PE_RESOURCE_DATA_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_RESOURCE_DATA_ENTRY



feature -- Access

	rva: INTEGER_32 assign set_rva
			-- `rva'

	size: INTEGER_32 assign set_size
			-- `size'

	code_page: INTEGER_32 assign set_code_page
			-- `code_page'

	reserved: INTEGER_32 assign set_reserved
			-- `reserved'

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

	set_code_page (a_code_page: like code_page)
			-- Assign `code_page' with `a_code_page'.
		do
			code_page := a_code_page
		ensure
			code_page_assigned: code_page = a_code_page
		end

	set_reserved (a_reserved: like reserved)
			-- Assign `reserved' with `a_reserved'.
		do
			reserved := a_reserved
		ensure
			reserved_assigned: reserved = a_reserved
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
