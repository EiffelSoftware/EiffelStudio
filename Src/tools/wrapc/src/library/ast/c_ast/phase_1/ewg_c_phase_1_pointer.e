note

	description:

		"AST Element of Phase 1, represents pointers"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_PHASE_1_POINTER

create

	make,
	make_with_type_qualifier_list

feature

	make
			-- Create pointer without type qualifiers
		do
			create type_qualifier.make
		end

	make_with_type_qualifier_list (a_type_qualifier_list: DS_LINKED_LIST [EWG_C_PHASE_1_TYPE_QUALIFIER])
			-- Create pointer with type qualifiers
		require
			a_type_qualifer_list_not_void: a_type_qualifier_list /= Void
			a_type_qualifer_list_not_empty: not a_type_qualifier_list.is_empty
--			a_type_qualifer_list_not_has_void: not a_type_qualifier_list.has (Void)
		local
			cs: DS_LINKED_LIST_CURSOR [EWG_C_PHASE_1_TYPE_QUALIFIER]
		do
			make
			from
				cs := a_type_qualifier_list.new_cursor
				cs.start
			until
				cs.off
			loop
				type_qualifier.merge (cs.item)
				cs.forth
			end
		end

feature

	type_qualifier: EWG_C_PHASE_1_TYPE_QUALIFIER

invariant

	type_qualifier_not_void: type_qualifier /= Void

end
