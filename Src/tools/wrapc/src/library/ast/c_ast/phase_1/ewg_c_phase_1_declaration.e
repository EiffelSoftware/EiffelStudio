note

	description:

		"AST Element of Phase 1, represents C declarations"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_PHASE_1_DECLARATION

create

	make,
	make_with_one_declarator,
	make_without_declarator

feature

	make (a_declaration_specifiers: DS_LINKED_LIST [ANY];
		  a_declarators: DS_LINKED_LIST [EWG_C_PHASE_1_DECLARATOR];
		  a_header_file_name: STRING)
		require
			a_declaration_specifiers_not_void: a_declaration_specifiers /= Void
			a_declarators_not_void: a_declarators /= Void
			a_header_file_name_not_empty: not a_header_file_name.is_empty
		do
			declarators := a_declarators
			header_file_name := a_header_file_name
			merge_specifiers (a_declaration_specifiers)
		end

	make_with_one_declarator (a_declaration_specifiers: DS_LINKED_LIST [ANY];
			  a_declarator: EWG_C_PHASE_1_DECLARATOR;
			  a_header_file_name: STRING)
		require
			a_declaration_specifiers_not_void: a_declaration_specifiers /= Void
			a_declarator_not_void: a_declarator /= Void
			a_header_file_name_not_empty: not a_header_file_name.is_empty
		do
			create declarators.make
			declarators.put_last (a_declarator)
			header_file_name := a_header_file_name
			merge_specifiers (a_declaration_specifiers)
		end

	make_without_declarator (a_declaration_specifiers: DS_LINKED_LIST [ANY];
			  a_header_file_name: STRING)
		require
			a_declaration_specifiers_not_void: a_declaration_specifiers /= Void
			a_header_file_name_not_empty: not a_header_file_name.is_empty
		do
			create declarators.make
			header_file_name := a_header_file_name
			merge_specifiers (a_declaration_specifiers)
		end

feature

	storage_class_specifiers: detachable EWG_C_PHASE_1_STORAGE_CLASS_SPECIFIERS

	type_qualifier: detachable EWG_C_PHASE_1_TYPE_QUALIFIER

	type_specifier: detachable EWG_C_PHASE_1_TYPE_SPECIFIER

	declarators: DS_LINKED_LIST [EWG_C_PHASE_1_DECLARATOR]
			-- if this is a parameter declaration
			-- there must be exactly one declarator
			-- for general declarations there can be
			-- zero or more

	header_file_name: STRING
			-- name of header file this declaration was found in

feature {ANY}

	first_declarator: EWG_C_PHASE_1_DECLARATOR
		do
			Result := declarators.first
		end

	has_abstract_declarator: BOOLEAN
			-- Does this declaration contain a declarator which is abstract?
		local
			cs: DS_LINKED_LIST_CURSOR [EWG_C_PHASE_1_DECLARATOR]
		do
			from
				cs := declarators.new_cursor
				cs.start
			until
				cs.off
			loop
				if cs.item.is_abstract then
					Result := True
					cs.go_after
				else
					cs.forth
				end
			end
		end

	has_abstract_declarator_recursive: BOOLEAN
			-- Does this declaration or a declaration contained in this declaration contain
			-- a declarator which is abstract?
		local
			cs: DS_LINKED_LIST_CURSOR [EWG_C_PHASE_1_DECLARATOR]
		do
			Result := has_abstract_declarator
			if not Result then
				from
					cs := declarators.new_cursor
					cs.start
				until
					cs.off
				loop
					if cs.item.has_abstract_parameter_declarator then
						Result := True
						cs.go_after
					else
						cs.forth
					end
				end
			end
		end

feature {NONE}

	merge_specifiers (a_declaration_specifiers: DS_LINKED_LIST [ANY])
			-- input is supposed to contain objects of type:
			-- EWG_C_PHASE_1_STORAGE_CLASS_SPECIFIERS and
			-- EWG_C_PHASE_1_TYPE_QUALIFIER and
			-- EWG_C_PHASE_1_TYPE_SPECIFIER
			-- This feature merges objects of the same type and
			-- sets the attributes `storage_class_specifiers',
			-- `type_qualifier' and `type_specifier' correspondingly
		require
			a_declaration_specifiers_not_void: a_declaration_specifiers /= Void
			type_specifier_is_void: type_specifier = Void
			type_qualifier_is_void: type_qualifier = Void
			storage_class_specifiers_is_void: storage_class_specifiers = Void
		local
			cs: DS_LINKED_LIST_CURSOR [ANY]
			l_type_specifier: like type_specifier
			l_type_qualifier: like type_qualifier
			l_storage_class_specifiers: like storage_class_specifiers
		do
			l_type_specifier := type_specifier
			l_type_qualifier := type_qualifier
			l_storage_class_specifiers := storage_class_specifiers
			from
				cs := a_declaration_specifiers.new_cursor
				cs.start
			until
				cs.off
			loop
				if attached {EWG_C_PHASE_1_TYPE_SPECIFIER} cs.item as type_spec then
					if l_type_specifier = Void then
						l_type_specifier := type_spec
					else
						-- if there is more than one type specifier
						-- non must be composite.
						-- you cannot for example have a 'singed struct foo'
							check
								result_third_not_composite: not l_type_specifier.is_composite_type
								type_spec_not_composite: not type_spec.is_composite_type
							end
						-- since they are both non composite, we can safely
						-- join the names
						l_type_specifier.append_name (type_spec)
					end
				end

				if attached {EWG_C_PHASE_1_STORAGE_CLASS_SPECIFIERS} cs.item as st_cls_spec then
					if l_storage_class_specifiers = Void then
						l_storage_class_specifiers := st_cls_spec
					else
						l_storage_class_specifiers.merge (st_cls_spec)
					end
				end

				if attached {EWG_C_PHASE_1_TYPE_QUALIFIER} cs.item as  type_qual then
					if l_type_qualifier = Void then
						l_type_qualifier := type_qual
					else
						l_type_qualifier.merge (type_qual)
					end
				end

				cs.forth
			end
			if l_type_specifier = Void then
				-- weird rule of C number 321 says:
				-- if the type specifier is missing
				-- assume 'int'
				create l_type_specifier.make ("int")
			end

			if l_type_qualifier = Void then
				create l_type_qualifier.make
			end

			if l_storage_class_specifiers = Void then
				create l_storage_class_specifiers.make
			end

			type_specifier := l_type_specifier
			type_qualifier := l_type_qualifier
			storage_class_specifiers := l_storage_class_specifiers

		end

invariant

	declarators_not_void: declarators /= Void

	type_specifier_not_void: type_specifier /= Void

	type_qualifier_not_void: type_qualifier /= Void

	storage_class_specifiers_not_void: storage_class_specifiers /= Void

	header_file_name_not_void: header_file_name /= Void

end
