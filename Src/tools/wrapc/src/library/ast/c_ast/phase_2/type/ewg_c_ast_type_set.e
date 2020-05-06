note

	description:

		"Represents a set of EWG_C_AST_TYPE elements"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_AST_TYPE_SET

inherit

	ANY

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

	EWG_C_AST_SHARED_TYPE_EQUALITY_TESTER
		export {NONE} all end

	EWG_SHARED_STRING_EQUALITY_TESTER
		export {NONE} all end

create

	make

feature {NONE} -- Initialisation

	make
		do
			create type_table.make (Initial_type_table_size)
			type_table.set_equality_tester (type_equality_tester)
			create named_struct_table.make_map (Initial_named_type_table_size)
			named_struct_table.set_equality_tester (struct_equality_tester)
			named_struct_table.set_key_equality_tester (string_equality_tester)
			create named_union_table.make_map (Initial_named_type_table_size)
			named_union_table.set_equality_tester (union_equality_tester)
			named_union_table.set_key_equality_tester (string_equality_tester)
			create named_enum_table.make_map (Initial_named_type_table_size)
			named_enum_table.set_equality_tester (enum_equality_tester)
			named_enum_table.set_key_equality_tester (string_equality_tester)
			create named_primitive_table.make_map (Initial_named_type_table_size)
			named_primitive_table.set_equality_tester (primitive_equality_tester)
			named_primitive_table.set_key_equality_tester (string_equality_tester)
			create named_alias_table.make_map (Initial_named_type_table_size)
			named_alias_table.set_equality_tester (alias_equality_tester)
			named_alias_table.set_key_equality_tester (string_equality_tester)
			create named_function_table.make_map (Initial_named_type_table_size)
			named_function_table.set_equality_tester (function_equality_tester)
			named_function_table.set_key_equality_tester (string_equality_tester)
			add_common_types
		end

	add_common_types
		do
			-- TODO: what to do with header names?
			create void_type.make ("void", "void_needs_no_header.h")
			add_type (void_type)
			create void_pointer_type.make ("void_pointer_needs_no_header.h", void_type)
			add_type (void_pointer_type)
			create float_type.make ("float", "float_needs_no_header.h")
			add_type (float_type)
			create const_float_type.make ("const_float_needs_no_header.h", float_type)
			add_type (const_float_type)
			create double_type.make ("double", "double_needs_no_header.h")
			add_type (double_type)
			create const_double_type.make ("const_double_needs_no_header.h", double_type)
			add_type (const_double_type)
		end

feature {ANY} -- Basic Access

	last_type: detachable EWG_C_AST_TYPE
			-- Last type added to the set

feature {ANY} -- Status checkers

	has (a_type: EWG_C_AST_TYPE): BOOLEAN
			-- Is `a_type' in the set?
		require
			a_type_not_void: a_type /= Void
			nested_types_in_set: nested_types_of_type_in_set_recursive (a_type)
		do
			Result := type_table.has (a_type)
		end


	find_struct_by_name (a_name: STRING): detachable EWG_C_AST_STRUCT_TYPE
			-- Looks if a struct with the name `a_name' is already
			-- in the set. If this is the case, return that type.
			-- otherwise return `Void'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: a_name.count > 0
		do
			if named_struct_table.has (a_name) then
				Result := named_struct_table.item (a_name)
			end
		end

	find_enum_by_name (a_name: STRING): detachable EWG_C_AST_ENUM_TYPE
			-- Looks if a enum with the name `a_name' is already
			-- in the set. If this is the case, return that type.
			-- otherwise return `Void'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: a_name.count > 0
		do
			if named_enum_table.has (a_name) then
				Result := named_enum_table.item (a_name)
			end
		end

	find_union_by_name (a_name: STRING): detachable EWG_C_AST_UNION_TYPE
			-- Looks if a union with the name `a_name' is already
			-- in the set. If this is the case, return that type.
			-- otherwise return `Void'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: a_name.count > 0
		do
			if named_union_table.has (a_name) then
				Result := named_union_table.item (a_name)
			end
		end

	find_primitive_by_name (a_name: STRING): detachable EWG_C_AST_PRIMITIVE_TYPE
			-- Looks if a primitive with the name `a_name' is already
			-- in the set. If this is the case, return that type.
			-- otherwise return `Void'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: a_name.count > 0
		do
			if named_primitive_table.has (a_name) then
				Result := named_primitive_table.item (a_name)
			end
		end


	find_alias_by_name (a_name: STRING): detachable EWG_C_AST_ALIAS_TYPE
			-- Looks if a alias with the name `a_name' is already
			-- in the set. If this is the case, return that type.
			-- otherwise return `Void'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: a_name.count > 0
		do
			if named_alias_table.has (a_name) then
				Result := named_alias_table.item (a_name)
			end
		end

	find_function_by_name (a_name: STRING): detachable EWG_C_AST_FUNCTION_TYPE
			-- Looks if a function with the name `a_name' is already
			-- in the set. If this is the case, return that type.
			-- otherwise return `Void'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: a_name.count > 0
		do
			if named_function_table.has (a_name) then
				Result := named_function_table.item (a_name)
			end
		end

	count: INTEGER
			-- Number of types in set
		do
			Result := type_table.count
		ensure
			count_greater_equal_zero: Result >= 0
		end

	new_cursor: DS_BILINEAR_CURSOR [EWG_C_AST_TYPE]
			-- Return a new curser over all types in the set
		do
			Result := type_table.new_cursor
		ensure
			result_not_void: Result /= Void
		end

	new_alias_cursor: DS_HASH_TABLE_CURSOR [EWG_C_AST_ALIAS_TYPE, STRING]
			-- Return a new cursor over all aliases in the set
			-- TODO: return DS_BILINEAR_CURSOR or similar
			-- TODO: add iterator factory for other types as well
		do
			Result := named_alias_table.new_cursor
		ensure
			result_not_void: Result /= Void
		end

	alias_types_count: INTEGER
			-- Number of alias types in system
		do
			Result := named_alias_table.count
		ensure
			result_greater_equal_zero: Result >= 0
		end

feature {ANY} -- Common types

	void_type: EWG_C_AST_PRIMITIVE_TYPE
			-- The pseudo C type 'void'

	void_pointer_type: EWG_C_AST_POINTER_TYPE
			-- The infamous C type 'void*'

	float_type: EWG_C_AST_PRIMITIVE_TYPE
			-- The 'float' type

	const_float_type: EWG_C_AST_CONST_TYPE
			-- The 'const float' type

	double_type: EWG_C_AST_PRIMITIVE_TYPE
			-- The 'double' type

	const_double_type: EWG_C_AST_CONST_TYPE
			-- The 'const double' type

feature {ANY} -- Properties of types, TODO: refactore to be in EWG_C_AST_TYPE

	is_type_alive (a_type: EWG_C_AST_TYPE): BOOLEAN
			-- Does anybody refere to `a_type'?
			-- If not, the type is considered to be dead.
			-- Notice, that this does not count references from
			-- declarations. It cannot because this class only
			-- deals with types, not declarations (it doesnt even
			-- know about declarations, except for this comment :)
		require
			a_type_not_void: a_type /= Void
			a_type_in_set: has (a_type)
		local
			cs: DS_BILINEAR_CURSOR [EWG_C_AST_TYPE]
		do
			Result := False
			from
				cs := type_table.new_cursor
				cs.start
			until
				cs.off
			loop
				-- We do not need to look at indirectly nested types,
				-- since every indirectly nested type will be a directly
				-- nested type of some type in `types' anyway.
				if
					cs.item.directly_nested_types.has (a_type) = True
				then
					Result := True
					cs.go_after
				end
				cs.forth
			end
		end

	is_type_removable (a_type: EWG_C_AST_TYPE): BOOLEAN
			-- Can `a_type' be removed without rendering the set
			-- inconsistent?
			-- This usually menas, if the type in question is considered
			-- dead (see `is_type_alive' above), but there are a few
			-- special other types that must not be removed from the
			-- set (`void' and `void*').
		require
			a_type_not_void: a_type /= Void
			a_type_in_set: has (a_type)
		do
			Result := a_type /= void_type and a_type /= void_pointer_type and not is_type_alive (a_type)
		end

feature {ANY} -- Expensive Status checkers that may be disabled

	has_recursive (a_type: EWG_C_AST_TYPE): BOOLEAN
			-- Is `a_type' in the set and are all types
			-- recursivly contained in `a_type' in the
			-- set as well?
			-- This is a very expensive check, performance wise.
			-- It will only be executed with
			-- 'debug ("EWG_EXPENSIVE_PHASE_2_ASSERTIONS")'
			-- enabled.
		require
			a_type_not_void: a_type /= Void
		local
			a_already_checked: DS_LINKED_LIST [EWG_C_AST_TYPE]
		do
			Result := True
			debug ("EWG_EXPENSIVE_PHASE_2_ASSERTIONS")
				create a_already_checked.make
				Result := has (a_type) and
								types_of_list_in_set_with_already_checked_list (a_type.directly_nested_types,
																				a_already_checked)
			end
		end

	nested_types_in_set_recursive: BOOLEAN
			-- Check if for every type in the set
			-- it's subtypes are in the set as well.
			-- This is a very expensive check, performance wise.
			-- It will only be executed with
			-- 'debug ("EWG_EXPENSIVE_PHASE_2_ASSERTIONS")'
			-- enabled.
		local
			a_already_checked: DS_LINKED_LIST [EWG_C_AST_TYPE]
		do
			Result := True
			debug ("EWG_EXPENSIVE_PHASE_2_ASSERTIONS")
				create a_already_checked.make
				Result := nested_types_in_set_with_already_checked_list (a_already_checked)
			end
		end

	nested_types_of_type_in_set_recursive (a_type: EWG_C_AST_TYPE): BOOLEAN
			-- Check if the subtypes of `a_type'
			-- are in the set.
		require
			a_type_not_void: a_type /= Void
		local
			a_already_checked: DS_LINKED_LIST [EWG_C_AST_TYPE]
		do
			create a_already_checked.make
			Result := types_of_list_in_set_with_already_checked_list (a_type.directly_nested_types,
																	  a_already_checked)
		end

	types_in_list_recursive (a_list: DS_BILINEAR [EWG_C_AST_TYPE]): BOOLEAN
			-- Is every element of `a_list' in the set?
			-- Check for every type contained in every element (recursivly)
			-- that it is in the set as well?
			-- This is a very expensive check, performance wise.
			-- It will only be executed with
			-- 'debug ("EWG_EXPENSIVE_PHASE_2_ASSERTIONS")'
			-- enabled.
		require
			a_list_not_void: a_list /= Void
--			a_list_not_has_void: not a_list.has (Void)
		local
			a_already_checked: DS_LINKED_LIST [EWG_C_AST_TYPE]
		do
			Result := True
			debug ("EWG_EXPENSIVE_PHASE_2_ASSERTIONS")
				create a_already_checked.make
				Result := types_of_list_in_set_with_already_checked_list (a_list, a_already_checked)
			end
		end

	has_void_type: BOOLEAN
			-- Is the type `void' in the set?
			-- This is a very expensive check, performance wise.
			-- It will only be executed with
			-- 'debug ("EWG_EXPENSIVE_PHASE_2_ASSERTIONS")'
			-- enabled.
		do
			Result := True
			debug ("EWG_EXPENSIVE_PHASE_2_ASSERTIONS")
				Result := has (void_type)
			end
		end

	has_void_pointer_type: BOOLEAN
			-- Is the type `void*' in the set?
			-- This is a very expensive check, performance wise.
			-- It will only be executed with
			-- 'debug ("EWG_EXPENSIVE_PHASE_2_ASSERTIONS")'
			-- enabled.
		do
			Result := True
			debug ("EWG_EXPENSIVE_PHASE_2_ASSERTIONS")
				Result := has (void_pointer_type)
			end
		end

feature {ANY} -- Add/Remove types

	add_type (a_type: EWG_C_AST_TYPE)
			-- Add `a_type' to set if
			-- not another equal type is already in the set.
			-- Set `last_type' to `a_type' if it has been added,
			-- otherwise set `last_type' to be the equal type in
			-- `types'.
		require
			a_type_not_void: a_type /= Void
			nested_types_in_set: nested_types_of_type_in_set_recursive (a_type)
		do
			type_table.search (a_type)
			if type_table.found then
				last_type := type_table.found_item
			else
				type_table.force_new (a_type)
				last_type := a_type
				-- In the code below there really should be
				-- used `named_*_table.force_new' instead of
				-- `named_*_table.force', but MS allows
				-- "redefinitions" (see test case header "test_75.h" for an example)
				-- TODO: now what if because of a redefinition a type gets removed from
				-- the system, that is references by another type... this will bring trouble:
				-- investigate further
--				if not a_type.is_anonymous then
				if attached a_type.name as l_name then -- not a_type.is_anonymous
					if attached {EWG_C_AST_STRUCT_TYPE} a_type as struct then
						named_struct_table.force (struct, l_name)
					elseif attached {EWG_C_AST_UNION_TYPE} a_type as union then
						named_union_table.force (union, l_name)
					elseif attached {EWG_C_AST_ENUM_TYPE} a_type as enum then
						named_enum_table.force (enum, l_name)
					elseif attached {EWG_C_AST_PRIMITIVE_TYPE} a_type as primitive then
						named_primitive_table.force (primitive, l_name)
					elseif attached {EWG_C_AST_ALIAS_TYPE} a_type as a_alias then
						named_alias_table.force (a_alias, l_name)
					elseif attached {EWG_C_AST_ARRAY_TYPE} a_type as array then
							check
								arrays_are_anonymous: False
							end
					elseif attached {EWG_C_AST_CONST_TYPE} a_type as const then
							check
								consts_are_anonymous: False
							end
					elseif attached {EWG_C_AST_POINTER_TYPE} a_type as pointer then
							check
								pointers_are_anonymous: False
							end
					elseif attached {EWG_C_AST_FUNCTION_TYPE} a_type as function then
						named_function_table.force (function, l_name)
					elseif attached {EWG_C_AST_EIFFEL_OBJECT_TYPE} a_type as eiffel then
							check
								eiffel_object_types_are_anonymous: False
							end
					end
				end
			end
		ensure
			last_type_not_void: last_type /= Void
			last_type_in_set: attached last_type as l_type implies has (l_type)
			type_type_in_set_recursive: attached last_type as l_type implies has_recursive (l_type)
			last_type_equal_to_a_type: attached last_type as l_type implies type_equality_tester.test (l_type, a_type)
		end

	remove_type (a_type: EWG_C_AST_TYPE)
			-- Remove `a_type' from system.
			-- Note that `a_type' must be in the system
			-- in order for it to be removed.
		require
			a_type_not_void: a_type /= Void
			a_type_in_set: has (a_type)
			a_type_removable: is_type_removable (a_type)
		do
			type_table.remove (a_type)
			if attached a_type.name as l_name then  -- not not a_type.is_anonymous
				if attached {EWG_C_AST_STRUCT_TYPE} a_type as struct then
					named_struct_table.remove (l_name)
				elseif attached {EWG_C_AST_UNION_TYPE} a_type as union then
					named_union_table.remove (l_name)
				elseif attached {EWG_C_AST_ENUM_TYPE} a_type as enum then
					named_enum_table.remove (l_name)
				elseif attached {EWG_C_AST_PRIMITIVE_TYPE} a_type as primitive  then
					named_primitive_table.remove (l_name)
				elseif attached {EWG_C_AST_ALIAS_TYPE} a_type as a_alias then
					named_alias_table.remove (l_name)
				elseif attached {EWG_C_AST_ARRAY_TYPE} a_type as array then
							check
								arrays_are_anonymous: False
							end
				elseif attached {EWG_C_AST_CONST_TYPE} a_type as const then
							check
								consts_are_anonymous: False
							end
				elseif attached {EWG_C_AST_POINTER_TYPE} a_type as pointer then
							check
								pointers_are_anonymous: False
							end
				elseif attached {EWG_C_AST_FUNCTION_TYPE} a_type as function  then
					named_function_table.remove (l_name)
				elseif attached {EWG_C_AST_EIFFEL_OBJECT_TYPE} a_type as eiffel then
						check
							eiffel_object_types_are_anonymous: False
						end
				end
			end
		ensure
			type_not_in_set: not has (a_type)
		end

feature {NONE} -- Implementation helpers for queries

	all_named_items_of_type_table_in_named_table: BOOLEAN
			-- are all items of `type_table' in some named table as well?
		local
			cs: DS_BILINEAR_CURSOR [EWG_C_AST_TYPE]
		do
			Result := True
			from
				cs := type_table.new_cursor
				cs.start
			until
				cs.off
			loop
				if not cs.item.is_anonymous and then attached cs.item.name as l_name then
					if
						not named_struct_table.has (l_name) and
										named_enum_table.has (l_name) and
										named_union_table.has (l_name) and
										named_primitive_table.has (l_name) and
										named_alias_table.has (l_name) and
										named_function_table.has (l_name)
					then
						Result := False
						cs.go_after
					end
				end
				cs.forth
			end
		end

	all_items_of_all_named_tables_in_type_table: BOOLEAN
			-- Are all items of all named tables in the `type_table' as well?
		do
			Result := all_items_of_named_table_in_type_table (named_struct_table) and
							all_items_of_named_table_in_type_table (named_enum_table) and
							all_items_of_named_table_in_type_table (named_union_table) and
							all_items_of_named_table_in_type_table (named_primitive_table) and
							all_items_of_named_table_in_type_table (named_alias_table) and
							all_items_of_named_table_in_type_table (named_function_table)
		end

	all_items_of_named_table_in_type_table (a_table: DS_HASH_TABLE[EWG_C_AST_TYPE, STRING]): BOOLEAN
			-- Are all items of the named table `a_table' in `type_table'
			-- as well?
		require
			a_table_not_void: a_table /= Void
		local
			cs: DS_HASH_TABLE_CURSOR [EWG_C_AST_TYPE, STRING]
		do
			Result := True
			from
				cs := a_table.new_cursor
				cs.start
			until
				cs.off
			loop
				if not type_table.has (cs.item) then
					Result := False
					cs.go_after
				end
				cs.forth
			end
		end

	nested_types_in_set_with_already_checked_list (a_already_checked: DS_LINKED_LIST [EWG_C_AST_TYPE]): BOOLEAN
			-- Check if for every type in `types'
			-- it's subtypes are in `types' as well.
			-- `a_already_checked' is a list of types that are known to be in
			-- the set. This is to avoid infinite recursion.
		require
			a_already_checked_not_void: a_already_checked /= Void
--			a_already_checked_not_has_void: not a_already_checked.has (Void)
		local
			cs: DS_BILINEAR_CURSOR [EWG_C_AST_TYPE]
		do
			Result := True
			from
				cs := type_table.new_cursor
				cs.start
			until
				cs.off
			loop
				if not a_already_checked.has (cs.item) then
					a_already_checked.put_last (cs.item)
					if not types_of_list_in_set_with_already_checked_list (cs.item.directly_nested_types,
																			a_already_checked) then
						Result := False
						cs.go_after
					end
				end
				cs.forth
			end
		end

	types_of_list_in_set_with_already_checked_list (a_list: DS_BILINEAR [EWG_C_AST_TYPE]; a_already_checked: DS_LINKED_LIST [EWG_C_AST_TYPE]): BOOLEAN
			-- Is every element of `a_list' in `types'?
			-- Check for every type contained in every element (recursivly)
			-- that it is in the set as well?
			-- `a_already_checked' is a list of types that are known to be in
			-- the set. This is to avoid infinite recursion.
		require
			a_list_not_void: a_list /= Void
--			a_list_not_has_void: not a_list.has (Void)
			a_already_checked_not_void: a_already_checked /= Void
--			a_already_checked_not_has_void: not a_already_checked.has (Void)
		local
			cs: DS_BILINEAR_CURSOR [EWG_C_AST_TYPE]
		do
			Result := True
			from
				cs := a_list.new_cursor
				cs.start
			until
				cs.off
			loop
				if not a_already_checked.has (cs.item) then
					a_already_checked.put_last (cs.item)
					if
						not has (cs.item) and not
						types_of_list_in_set_with_already_checked_list (cs.item.directly_nested_types,
																		a_already_checked)
					then
						Result := False
						cs.go_after
					end
				end
				cs.forth
			end
		end

feature {NONE} -- Implementation

	type_table: DS_HASH_SET [EWG_C_AST_TYPE]
			-- The main type table.
			-- This set stores all types found in the system.

	named_struct_table: DS_HASH_TABLE [EWG_C_AST_STRUCT_TYPE, STRING]
			-- This hash table stores all named (as in not anonymous)
			-- struct types found in the system via a mapping from its
			-- name to its type. This table exists to speed up the time
			-- required to find a struct via its name.

	named_union_table: DS_HASH_TABLE [EWG_C_AST_UNION_TYPE, STRING]
			-- This hash table stores all named (as in not anonymous)
			-- union types found in the system via a mapping from its
			-- name to its type. This table exists to speed up the time
			-- required to find a union via its name.

	named_enum_table: DS_HASH_TABLE [EWG_C_AST_ENUM_TYPE, STRING]
			-- This hash table stores all named (as in not anonymous)
			-- enum types found in the system via a mapping from its
			-- name to its type. This table exists to speed up the time
			-- required to find a enum via its name.

	named_primitive_table: DS_HASH_TABLE [EWG_C_AST_PRIMITIVE_TYPE, STRING]
			-- This hash table stores all named (as in not anonymous)
			-- primitive types found in the system via a mapping from its
			-- name to its type. This table exists to speed up the time
			-- required to find a primitive via its name.

	named_alias_table: DS_HASH_TABLE [EWG_C_AST_ALIAS_TYPE, STRING]
			-- This hash table stores all named (as in not anonymous)
			-- alias types found in the system via a mapping from its
			-- name to its type. This table exists to speed up the time
			-- required to find an alias via its name.

	named_function_table: DS_HASH_TABLE [EWG_C_AST_FUNCTION_TYPE, STRING]
			-- This hash table stores all named (as in not anonymous)
			-- function types found in the system via a mapping from its
			-- name to its type. This table exists to speed up the time
			-- required to find a function type via its name.

	Initial_type_table_size: INTEGER = 20000
			-- Initial size of the `type_table.

	Initial_named_type_table_size: INTEGER = 6000
			-- Initial size of the `named_*_table's.

invariant

	nested_types_in_set: nested_types_in_set_recursive
	has_void: has_void_type
	has_void_pointer: has_void_pointer_type
	type_table_not_void: type_table /= Void
	named_struct_table_not_void: named_struct_table /= Void
	named_union_table_not_void: named_union_table /= Void
	named_enum_table_not_void: named_enum_table /= Void
	named_primitve_table_not_void: named_primitive_table /= Void
	named_alias_table_not_void: named_alias_table /= Void
--	has_not_void: not type_table.has (Void)
	all_items_of_all_named_tables_in_type_table: all_items_of_all_named_tables_in_type_table
	all_named_items_of_type_table_in_named_table: all_named_items_of_type_table_in_named_table

end
