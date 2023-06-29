note
	description: "[
			Table that should be sorted.

			TODO: ClassLayout, DeclSecurity, FieldLayout, FieldRVA, GenericParam, GenericParamConstraint, NestedClass

		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_MD_SORTED_TABLE [G -> PE_MD_TABLE_COMPARABLE_ENTRY]

inherit
	PE_MD_TABLE [G]
		redefine
			check_validity
		end

feature -- Check validity

	check_validity
		local
			e,prev: PE_MD_TABLE_COMPARABLE_ENTRY
			is_sorted: BOOLEAN
			i: NATURAL_32
		do
			is_sorted := True
			i := 0
			across
				entries as ic
			until
				not is_sorted
			loop
				i := i + 1
				e := ic.item
				if prev /= Void then
					is_sorted := prev <= e
				end
				prev := e
			end

			if not is_sorted then
				report_error (create {PE_USER_ERROR}.make ({STRING_32} "Table not sorted (#"+ i.out + " 0x"+ (table_id.to_natural_32 |<< 24 | i).to_hex_string +"): " + sorting_information))
			end
		end

feature -- Sorting

	sorting_information: STRING_32
		deferred
		end


end
