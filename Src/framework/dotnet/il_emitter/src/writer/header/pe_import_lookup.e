note
	description: "Summary description for {PE_IMPORT_LOOKUP}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_IMPORT_LOOKUP

inherit

	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			ord_or_rva := 31
			import_by_ordinal := 1
		end

feature -- Access

	ord_or_rva: INTEGER_32 assign set_ord_or_rva
			-- `ord_or_rva'

	import_by_ordinal: INTEGER_32 assign set_import_by_ordinal
			-- `import_by_ordinal'

feature -- Element change

	set_ord_or_rva (an_ord_or_rva: like ord_or_rva)
			-- Assign `ord_or_rva' with `an_ord_or_rva'.
		do
			ord_or_rva := an_ord_or_rva
		ensure
			ord_or_rva_assigned: ord_or_rva = an_ord_or_rva
		end

	set_import_by_ordinal (an_import_by_ordinal: like import_by_ordinal)
			-- Assign `import_by_ordinal' with `an_import_by_ordinal'.
		do
			import_by_ordinal := an_import_by_ordinal
		ensure
			import_by_ordinal_assigned: import_by_ordinal = an_import_by_ordinal
		end

feature -- Measurement

	size_of: INTEGER
		local
			l_internal: INTERNAL
			n: INTEGER
			l_obj: PE_IMPORT_LOOKUP
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
