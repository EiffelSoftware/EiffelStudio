note

	description:

		"AST Element of Phase 1, represents C declarators"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_PHASE_1_DECLARATOR

inherit

	ANY

	KL_IMPORTED_STRING_ROUTINES
		export
			{NONE} all
		end

create

	make,
	make_with_pointers,
	make_default

feature -- Intialization

	make_default
		do
			create direct_declarator.make ("Void")
			create header_file_name.make_empty
			create pointers.make
		end

	make (a_direct_declarator: EWG_C_PHASE_1_DIRECT_DECLARATOR; a_header_file_name: STRING)
		require
			a_direct_declarator_not_void: a_direct_declarator /= Void
			a_header_file_name_not_void: a_header_file_name /= Void
		do
			direct_declarator := a_direct_declarator
			header_file_name := a_header_file_name
			create pointers.make
		end

	make_with_pointers (a_direct_declarator: EWG_C_PHASE_1_DIRECT_DECLARATOR;
						a_pointers: DS_LINKED_LIST [EWG_C_PHASE_1_POINTER];
						a_header_file_name: STRING)
		require
			a_direct_declarator_not_void: a_direct_declarator /= Void
			a_pointers_not_void: a_pointers /= Void
			a_pointers_not_empty: a_pointers.count > 0
			a_header_file_name_not_void: a_header_file_name /= Void
		do
			make (a_direct_declarator, a_header_file_name)
			pointers.extend_last (a_pointers)
		end

feature

	add_pointers_front (a_pointers: DS_LINKED_LIST [EWG_C_PHASE_1_POINTER])
		do
			pointers.extend_last (a_pointers)
		end

	set_direct_declarator (a_direct_declarator: EWG_C_PHASE_1_DIRECT_DECLARATOR)
		do
			direct_declarator := a_direct_declarator
		end

feature

	header_file_name: STRING
			-- name of header this declarator has been found in

	pointers: DS_LINKED_LIST [EWG_C_PHASE_1_POINTER]
			-- zero or more

	direct_declarator: EWG_C_PHASE_1_DIRECT_DECLARATOR
			-- direct_declarator nested inside

	arrays_indirect: DS_LINKED_LIST [EWG_C_PHASE_1_ARRAY]
			-- arrays from a (possibly recursivly nested)
			-- direct declarator
		do
			Result := direct_declarator.arrays_indirect
		ensure
			result_not_void: Result /= Void
		end

	pointers_indirect: DS_LINKED_LIST [EWG_C_PHASE_1_POINTER]
			-- pointers from this declarator and (possibly recursivly nested)
			-- direct declarators
		do
			Result := pointers.twin
			Result.extend_last (direct_declarator.pointers_indirect)
		ensure
			result_not_void: Result /= Void
		end

feature

	name: detachable STRING
		require
			not_abstract: not is_abstract
		do
			Result := direct_declarator.nested_name
		end

	is_abstract: BOOLEAN
			-- Abstract declarators have no name.
		do
			Result := direct_declarator.is_abstract
		end

	has_abstract_parameter_declarator: BOOLEAN
			-- Does this declaration contain parameters and is any of those parameters abstract?
		do
			Result := direct_declarator.parameters /= Void and then
						direct_declarator.has_abstract_parameter_declaration
		end

feature

	make_concrete (a_name: STRING)
			-- Give the (abstract) declarator a (pseudo) name.
		require
			is_abstract: is_abstract
			a_name_not_void: a_name /= Void
			a_name_not_empty: a_name.count > 0
		do
			direct_declarator.make_concrete (a_name)
		ensure
			not_abstract: not is_abstract
		end

feature

	c_code: STRING
		local
			cs: DS_LINEAR_CURSOR [EWG_C_PHASE_1_POINTER]
		do
			create Result.make (10)
			from
				cs := pointers.new_cursor
				cs.start
			until
				cs.off
			loop
				Result.append_character ('*')
				Result.append_string (cs.item.type_qualifier.c_code)
				cs.forth
			end
			Result.append_string (direct_declarator.c_code)
		ensure
			result_not_void: Result /= Void
		end

invariant

	direct_declarator_not_void: direct_declarator /= Void
	pointers_not_void: pointers /= Void
	header_file_name_not_void: header_file_name /= Void

end
