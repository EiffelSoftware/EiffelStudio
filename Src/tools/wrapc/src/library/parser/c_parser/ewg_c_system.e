note

	description:

		"Represents the declarative part of a C System."

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_SYSTEM

inherit

	ANY

	EWG_SHARED_STRING_EQUALITY_TESTER
		export {NONE} all end

create

	make,
	make_with_processor

feature {NONE} -- Initialisation

	make
			-- Create a new C system.
		do
			reset
			create {EWG_C_AST_DECLARATION_NULL_PROCESSOR} declaration_processor.make
		end

	make_with_processor (a_declaration_processor: like declaration_processor)
			-- Create new C system using `a_declaration_processor' as
			-- declaration processor.
		require
			a_declaration_processor_not_void: a_declaration_processor /= Void
		do
			reset
			declaration_processor := a_declaration_processor
		ensure
			declaration_processor_set: declaration_processor = a_declaration_processor
		end

	add_builtin_types
			-- Add compiler built in types to the system.
		local
			builtin_va_list_alias: EWG_C_AST_ALIAS_TYPE
			cs: DS_LINKED_LIST_CURSOR [EWG_C_AST_TYPE]
		do
			-- This definition is a 'builtin' from gcc
			-- TODO: add '--enable-gcc-extensions' flag
			-- and add it only if it is present.
			-- TODO: the header name is a hack
			create builtin_va_list_alias.make ("__builtin_va_list", "builtin_gcc.h",
											 types.void_pointer_type)
			builtin_types.put_last (builtin_va_list_alias)

			from
				cs := builtin_types.new_cursor
				cs.start
			until
				cs.off
			loop
				types.add_type (cs.item)
				cs.forth
			end
			last_type := types.last_type
		end

feature {ANY} -- Initialisation

	reset
			-- Reset the C System
		do
			last_type := Void
			last_declaration := Void
			last_declaration_list := Void
			create types.make
			create declarations.make
			create builtin_types.make
			create macros.make
			add_builtin_types
		end

feature {ANY} -- The guts of the system

	types: EWG_C_AST_TYPE_SET
			-- All types in the system

	builtin_types: DS_LINKED_LIST [EWG_C_AST_TYPE]

	declarations: EWG_C_AST_DECLARATION_SET
			-- All declarations in the system

	macros: DS_LINKED_LIST [EWG_C_PHASE_1_MACRO]

feature {ANY}

	declaration_processor: EWG_C_AST_DECLARATION_PROCESSOR
			-- Declaration processor to notify about new declarations
			-- found.

	last_type: detachable EWG_C_AST_TYPE
			-- type last added to the system

	last_declaration: detachable EWG_C_AST_DECLARATION
			-- Last declaration made available via `make_declaration_from_type_and_declarator_available'

	last_declaration_list: detachable DS_ARRAYED_LIST [EWG_C_AST_DECLARATION]
			-- Last declaration list made available via `make_declaration_list_from_declarations_available'.


	add_macro (a_macro: EWG_C_PHASE_1_MACRO)
		do
			macros.force_last (a_macro)
		end

feature {EWG_C_PARSER_SKELETON}

	add_top_level_declaration (a_declaration: EWG_C_PHASE_1_DECLARATION)
			-- Split `a_declaration' into it's parts and add
			-- it's types and it's contained declarations into the C system
			-- Adds all types it finds on the way to the C system.
		require
			a_declaration_not_void: a_declaration /= Void
		local
			outer_type: EWG_C_AST_TYPE
			cs: DS_LINKED_LIST_CURSOR [EWG_C_PHASE_1_DECLARATOR]
		do
			if attached a_declaration.storage_class_specifiers as l_storage_class_specifiers and then
				attached a_declaration.type_qualifier as l_type_qualifier and then
				attached a_declaration.type_specifier as l_type_specifier and then
				attached a_declaration.header_file_name as l_header_file_name
			then
				make_type_from_declaration_specifiers_available (l_storage_class_specifiers,
																		 l_type_qualifier,
																		 l_type_specifier,
																		 l_header_file_name)
			end
			outer_type := last_type
			from
				cs := a_declaration.declarators.new_cursor
				cs.start
			until
				cs.off
			loop
				if attached outer_type then
					make_declaration_from_type_and_declarator_available (outer_type, cs.item)
					if attached a_declaration.storage_class_specifiers as l_storage_class_specifiers and then l_storage_class_specifiers.is_typedef then
						-- Add alias
						if attached last_declaration as l_declaration and then attached l_declaration.declarator as l_declarator then
							add_alias (l_declaration.type, l_declarator, l_declaration.header_file_name)
						end
						if attached last_declaration as l_declaration and then attached l_declaration.declarator as l_declarator then
							declaration_processor.process_typedef_declaration (l_declaration.type, l_declarator)
						end
					else
						-- Add declaration
						if attached last_declaration as l_declaration and then attached l_declaration.declarator as l_declarator then
							add_top_level_declaration_from_type_and_name (l_declaration.type, l_declarator, l_declaration.header_file_name)
						end

					end
				end
				cs.forth
			end
			if a_declaration.declarators.count = 0 and then attached outer_type then
				declaration_processor.process_type_declaration (outer_type)
			end
		end

feature {ANY} -- Add to the system

	add_alias (a_type: EWG_C_AST_TYPE; a_name: STRING; a_header_file_name: STRING)
			-- Add alias to `types', where 'a_name' is the
			-- the name of the alias, and 'a_type' its base.
			-- Make the new alias availabel via `last_type'
		require
			a_type_not_void: a_type /= Void
			a_type_in_system: types.has (a_type)
			a_name_not_void: a_name /= Void
			a_name_not_empty: a_name.count > 0
			a_name_valid_c_identifier: True -- TODO:
			a_header_file_name_not_void: a_header_file_name /= Void
		local
			a_alias: EWG_C_AST_ALIAS_TYPE
		do
			create a_alias.make (a_name, a_header_file_name, a_type)
			types.add_type (a_alias)
			last_type := types.last_type
		ensure
			last_type_not_void: last_type /= Void
			last_type_in_set: attached last_type as l_type implies types.has (l_type)
		end


	add_top_level_declaration_from_type_and_name (a_type: EWG_C_AST_TYPE; a_name: STRING; a_header_file_name: STRING)
			-- Add declaration to the system, where 'a_name' is the
			-- the name of the declaration, and 'a_type' its type.
			-- If the declaration is a function declaration make
			-- it available via `last_declaration'
		require
			a_type_not_void: a_type /= Void
			a_type_in_system: types.has (a_type)
			a_name_not_void: a_name /= Void
			a_name_not_empty: a_name.count > 0
			a_name_valid_c_identifier: True -- TODO:
			a_header_file_name_not_void: a_header_file_name /= Void
		local
			l_declaration: EWG_C_AST_DECLARATION
		do
			if attached {EWG_C_AST_FUNCTION_TYPE} a_type as a_function_type then
				if
					not should_exclude_function_declaration_with_name (a_name) and
						not (a_function_type.is_variadic and not a_function_type.has_ellipsis_parameter)
				then
					create {EWG_C_AST_FUNCTION_DECLARATION} l_declaration.make (a_name,
																										a_function_type,
																										a_header_file_name)
					declarations.add_declaration (l_declaration)
					last_declaration := declarations.last_declaration
				end
				declaration_processor.process_function_declaration (a_function_type, a_name)
			else
				declaration_processor.process_variable_declaration (a_type, a_name)
				create l_declaration.make (a_name, a_type, a_header_file_name)
				declarations.add_declaration (l_declaration)
				last_declaration := declarations.last_declaration
			end
		ensure
			last_declaration_not_void: last_declaration /= Void
		end

feature {NONE} -- Implementation

	make_type_from_declaration_specifiers_available (a_storage_class_specifiers: EWG_C_PHASE_1_STORAGE_CLASS_SPECIFIERS;
																	 a_type_qualifier: EWG_C_PHASE_1_TYPE_QUALIFIER;
																	 a_type_specifier: EWG_C_PHASE_1_TYPE_SPECIFIER;
																	 a_header_file_name: STRING)
			-- Merge the specifiers and qualifers and create a resulting type.
			-- Add it to the C system.
			-- Make it available via `last_type'.
			-- Adds all types it finds on the way to the C system.
		require
			a_storage_class_specifiers_not_void: a_storage_class_specifiers /= Void
			a_type_qualifier_not_void: a_type_qualifier /= Void
			a_type_specifier_not_void: a_type_specifier /= Void
			a_header_file_name_not_void: a_header_file_name /= Void
		local
			primitive: EWG_C_AST_PRIMITIVE_TYPE
			struct: EWG_C_AST_STRUCT_TYPE
			union: EWG_C_AST_UNION_TYPE
			enum: EWG_C_AST_ENUM_TYPE
			name: STRING
			type: EWG_C_AST_TYPE
			const: EWG_C_AST_CONST_TYPE
		do
			-- if we have a composite type with body
			-- process the body first
			if a_type_specifier.is_composite_type and a_type_specifier.has_members and then
				attached a_type_specifier.members as l_members
			then
				make_declaration_list_from_declarations_available (l_members)
			end

			name := a_type_specifier.name
			if name /= Void then
				if a_type_specifier.is_struct then
					type := types.find_struct_by_name (name)
				elseif a_type_specifier.is_union then
					type := types.find_union_by_name (name)
				elseif a_type_specifier.is_enum then
					type := types.find_enum_by_name (name)
				else
					-- could be a primitive type,
					-- alias, or function type
					type := types.find_primitive_by_name (name)
					if type = Void then
						type := types.find_alias_by_name (name)
					elseif type = Void then
						type := types.find_function_by_name (name)
					end
				end
			end

			if type = Void then
				-- type is not yet in list:
				-- add it
				if a_type_specifier.is_struct then
					create struct.make (name, a_header_file_name, Void)
					type := struct
				elseif a_type_specifier.is_union then
					create union.make (name, a_header_file_name, Void)
					type := union
				elseif a_type_specifier.is_enum then
					create enum.make (name, a_header_file_name, Void)
					type := enum
				else
					create primitive.make (name, a_header_file_name)
					type := primitive
				end
			end

			-- If we have a composite type which has members, add the body
			if a_type_specifier.is_composite_type and a_type_specifier.has_members then
				if attached {EWG_C_AST_COMPOSITE_TYPE} type as ctype then
					ctype.set_members (last_declaration_list)
					ctype.set_header_file_name (a_header_file_name)
				end
			end

			types.add_type (type)
			last_type := types.last_type

			if a_type_qualifier.is_const and then attached last_type as l_type then
				-- type is const, add const indirection
				create const.make (a_header_file_name, l_type)
				types.add_type (const)
				last_type := types.last_type
			end
		ensure
			last_type_not_void: last_type /= Void
			last_type__in_system:  attached last_type as l_type implies types.has (l_type)
		end

	make_declaration_list_from_declarations_available (a_declarations: DS_LINKED_LIST [EWG_C_PHASE_1_DECLARATION])
			-- Puts each declarator together with its type into a list and makes it
			-- available via `last_declaration_list'.
			-- Adds all types it finds on the way to the C system.
		require
			a_declarations_not_void: a_declarations /= Void
--			a_declarations_not_has_void: not a_declarations.has (Void)
		local
			outer_cs: DS_LINKED_LIST_CURSOR [EWG_C_PHASE_1_DECLARATION]
			inner_cs: DS_LINKED_LIST_CURSOR [EWG_C_PHASE_1_DECLARATOR]
			outer_type: EWG_C_AST_TYPE
			declaration_list: DS_ARRAYED_LIST [EWG_C_AST_DECLARATION]
		do
			from
				outer_cs := a_declarations.new_cursor
				outer_cs.start
				create declaration_list.make (a_declarations.count) -- TODO: get better default value
			until
				outer_cs.off
			loop
				if attached outer_cs.item.storage_class_specifiers as storage_class_specifiers and then
					attached outer_cs.item.type_qualifier as type_qualifier and then
					attached outer_cs.item.type_specifier as type_specifier
				then
					make_type_from_declaration_specifiers_available (storage_class_specifiers,
																	 type_qualifier,
																	 type_specifier,
																	 outer_cs.item.header_file_name)
				end
				outer_type := last_type
				from
					inner_cs := outer_cs.item.declarators.new_cursor
					inner_cs.start
				until
					inner_cs.off
				loop
					if attached outer_type then
						make_declaration_from_type_and_declarator_available (outer_type, inner_cs.item)
					end
					if attached last_declaration as l_declaration then
						declaration_list.force_last (l_declaration)
					end
					inner_cs.forth
				end
				outer_cs.forth
			end

			last_declaration_list := declaration_list
		ensure
			last_declartion_list_not_void: last_declaration_list /= Void
			types_of_members_in_system: attached last_declaration_list as l_declaration_list implies member_types_in_types (l_declaration_list)
		end

	make_declaration_from_type_and_declarator_available (a_type: EWG_C_AST_TYPE;
																		  a_declarator: EWG_C_PHASE_1_DECLARATOR)
			-- Find type name pair of `a_type' and `a_declarator' and make
			-- it available via `last_declaration'.
			-- Adds all new types it find on your way to the C system.
			-- This is non-trivial buisness, so here are a few examples
			-- in pseudo notation:
			-- 'input' -> (type, name)
			-- 'int foo' -> (int, foo)
			-- 'int* foo' -> (*->int, foo)
			-- 'int* foo[]' -> ([]->*->int, foo)
			-- 'int (*foo)[]' -> (*->[]->int, foo)
			-- 'void foo (void)' -> (void () (void), foo)
			-- 'void (*foo) (void)' -> (*->void () (void), foo)
		require
			a_type_not_void: a_type /= Void
			types_has_a_type: types.has (a_type)
			a_declarator_not_void: a_declarator /= Void
		do
			make_pointer_types_available (a_type, a_declarator)

			if attached last_type as l_last_type then
				make_function_type_available (l_last_type, a_declarator.direct_declarator, a_declarator.header_file_name)
			end

			if attached last_type as l_last_type then
				make_array_types_available (l_last_type, a_declarator.direct_declarator, a_declarator.header_file_name)
			end

			if attached last_type as l_last_type then
				if attached a_declarator.direct_declarator.declarator as l_declarator then
					-- dive in further
					make_declaration_from_type_and_declarator_available (l_last_type,
																			l_declarator)
				else
					-- We have reached the end of the rabit hole.
					-- The name of `a_declarator.direct_declarator.name' is
					-- definitly the name of the declarator.
					-- It might still be `Void' though, then it we have an
					-- anonymoys declarator. No problem though.
					create last_declaration.make (a_declarator.direct_declarator.name, l_last_type, a_declarator.header_file_name)
				end
			end

		ensure
			last_declaration_not_void: last_declaration /= Void
			type_of_last_declaration_in_system: attached last_declaration as l_declaration implies types.has (l_declaration.type)
		end


	make_pointer_types_available (a_type: EWG_C_AST_TYPE; a_declarator: EWG_C_PHASE_1_DECLARATOR)
			-- Create a chain of pointer types based on `a_type'.
			-- The chain will contain as many pointers as there are in `a_declarator'.
			-- Make top of chain available as `last_pointer'.
			-- Note that if no pointer is contained in
			-- `a_declarator' no chain will be created
			-- and `last_type' will be set to `a_type'.
		require
			a_type_not_void: a_type /= Void
			types_has_a_type: types.has (a_type)
			a_declarator_not_void: a_declarator /= Void
		local
			cs: DS_LINKED_LIST_CURSOR [EWG_C_PHASE_1_POINTER]
			outer_type: EWG_C_AST_TYPE
			pointer_type: EWG_C_AST_POINTER_TYPE
			const_type: EWG_C_AST_CONST_TYPE
		do
			from
				outer_type := a_type
				cs := a_declarator.pointers.new_cursor
				cs.start
			until
				cs.off
			loop
				if attached outer_type then
					create pointer_type.make (a_declarator.header_file_name, outer_type)
					types.add_type (pointer_type)
					last_type := types.last_type
					outer_type := last_type

					if cs.item.type_qualifier.is_const and then attached  outer_type then
						create const_type.make (a_declarator.header_file_name, outer_type)
						types.add_type (const_type)
						last_type := types.last_type
						outer_type := last_type
					end
				end

				cs.forth
			end
			last_type := outer_type
		ensure
			last_type_not_void: last_type /= Void
			no_pointers_means_last_type_is_a_type: a_declarator.pointers.count = 0 implies last_type = a_type
			pointers_means_last_type_is_array: a_declarator.pointers.count > 0 and then attached last_type as l_type implies l_type.skip_consts.is_pointer_type
		end

	make_array_types_available (a_type: EWG_C_AST_TYPE;
										 a_direct_declarator: EWG_C_PHASE_1_DIRECT_DECLARATOR;
										 a_header_file_name: STRING)
			-- Creates a chain of array types based on `a_type'.
			-- The chain contains as many arrays as there are in
			-- `a_direct_declarator'. Make top of chain available
			-- as `last_type'. Note that if no array is contained in
			-- `a_direct_declarator' no chain will be created
			-- and `last_type' will be set to `a_type'.
		require
			a_type_not_void: a_type /= Void
			types_has_a_type: types.has (a_type)
			a_direct_declarator_not_void: a_direct_declarator /= Void
			a_header_file_name_not_void: a_header_file_name /= Void
			a_header_file_name_not_empty: not a_header_file_name.is_empty
		local
			i: INTEGER
			array_type: EWG_C_AST_ARRAY_TYPE
			outer_type: EWG_C_AST_TYPE
		do
			from
				outer_type := a_type
				i := 1
			until
				i > a_direct_declarator.arrays.count
			loop
				if attached {EWG_C_PHASE_1_ARRAY} a_direct_declarator.arrays.item (i) as phase_1_array and then
					attached outer_type
				then
					if attached phase_1_array.size as l_size then
						create array_type.make_with_size (a_header_file_name, outer_type, l_size)
					else
						create array_type.make (a_header_file_name, outer_type)
					end
					types.add_type (array_type)
					last_type := types.last_type
					outer_type := last_type
				end
				i := i + 1
			end
			last_type := outer_type
		ensure
			last_type_not_void: last_type /= Void
			no_array_means_last_type_is_a_type: a_direct_declarator.arrays.count = 0 implies last_type = a_type
			arrays_means_last_type_is_array: a_direct_declarator.arrays.count > 0 and then attached last_type as l_type implies l_type.is_array_type
		end


	make_function_type_available (a_type: EWG_C_AST_TYPE;
											a_direct_declarator: EWG_C_PHASE_1_DIRECT_DECLARATOR;
											a_header_file_name: STRING)
			-- If `a_direct_declarator' indicated a function, create a new function type
			-- whos return type is `a_type'. Make the new function type available as
			-- `last_type'. If `a_direct_declarator' does not indicate a function,
			-- make `a_type' available via `last_type'.
		require
			a_type_not_void: a_type /= Void
			types_has_a_type: types.has (a_type)
			a_direct_declarator_not_void: a_direct_declarator /= Void
			a_header_file_name_not_void: a_header_file_name /= Void
			a_header_file_name_not_empty: not a_header_file_name.is_empty
		local
			a_function: EWG_C_AST_FUNCTION_TYPE
		do
			if a_direct_declarator.is_function_direct_declarator then
				if attached a_direct_declarator.parameters as l_parameters then
					make_declaration_list_from_declarations_available (l_parameters.parameter_list)
					-- Check for single anonymous void typed parameter.
					-- It means the function has no parameter
					if  attached last_declaration_list as l_last_declaration_list and then
						l_last_declaration_list.count = 1 and then
						l_last_declaration_list.first.declarator = Void and then
						types.void_type = l_last_declaration_list.first.type.skip_consts_and_aliases
					then
						create last_declaration_list.make_default
					end
					if attached last_declaration_list as l_last_declaration_list then
						create a_function.make (a_header_file_name,
														a_type,
														l_last_declaration_list)

						a_function.set_calling_convention (a_direct_declarator.calling_convention)
						a_function.set_ellipsis_parameter (l_parameters.has_ellipsis_parameter)
						types.add_type (a_function)
					end
					last_type := types.last_type
				end
			else
				last_type := a_type
			end
		ensure
			last_type_not_void: last_type /= Void
			no_function_means_last_type_is_a_type: not a_direct_declarator.is_function_direct_declarator implies last_type = a_type
			arrays_means_last_type_is_array: a_direct_declarator.is_function_direct_declarator implies attached last_type as l_last_type and then l_last_type.is_function_type
		end

feature {NONE} -- Status checks

	member_types_in_types (a_list: DS_BILINEAR [EWG_C_AST_DECLARATION]): BOOLEAN
			-- Result := for each `x' in `a_list' | types.has (x.type)
		require
			a_list_not_void: a_list /= Void
		local
			cs: DS_BILINEAR_CURSOR [EWG_C_AST_DECLARATION]
		do
			Result := True
			from
				cs := a_list.new_cursor
				cs.start
			until
				cs.off
			loop
				if not types.has (cs.item.type) then
					Result := False
					cs.go_after
				end
				cs.forth
			end
		end

feature {NONE} -- Implementation

	should_exclude_function_declaration_with_name (a_function_name: STRING): BOOLEAN
			-- Returns `True' if `a_function_declaration' should not be wrapped.
			-- This is a dirty hack to prevent compiler internal functions from beeing wrapped
			-- until there is a better mechanism to prevent this
			-- TODO: replace with default config rules
		require
			a_function_name_not_void: a_function_name /= Void
			a_function_name_not_empty: not a_function_name.is_empty
		do
			Result := excluded_function_names.has (a_function_name)
		end

	excluded_function_names: DS_HASH_SET [STRING]
			-- C functions that are known to have problems
		once
			create Result.make (11)
			Result.set_equality_tester (string_equality_tester)

				-- The following functions are problematic with VC
			Result.force ("_exception_code")
			Result.force ("_exception_info")
			Result.force ("_exception_termination")
			Result.force ("_abnormal_termination")

				-- TODO: `VarI4FromInt' shouldn't actually be exluded,
				-- but it cause a very weird
				-- "error C2065: 'VarI4FromI4' : undeclared identifier"
				-- error.
			Result.force ("VarI4FromInt")
		ensure
			excluded_function_names_not_void: Result /= Void
--			excluded_function_names_not_has_void: not Result.has (Void)
		end


feature

	set_declaration_processor (a_declaration_processor: like declaration_processor)
			-- Make `a_declaration_processor' the new `declaration_processor'.
		require
			a_declaration_processor_not_void: a_declaration_processor /= Void
		do
			declaration_processor := a_declaration_processor
		ensure
			declaration_processor_set: declaration_processor = a_declaration_processor
		end

invariant

	types_not_void: types /= Void
	declarations_not_void: declarations /= Void
	declaration_processor_not_void: declaration_processor /= Void

end
