note

	description:

		"EWG config construct type names"

	copyright: "Copyright (c) 2004, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


class EWG_CONFIG_CONSTRUCT_TYPE_NAMES

inherit

	ANY

	EWG_SHARED_STRING_EQUALITY_TESTER
		export {NONE} all end

feature -- Names

	any_name: STRING = "any"
	none_name: STRING = "none"
	struct_name: STRING = "struct"
	union_name: STRING = "union"
	enum_name: STRING = "enum"
	function_name: STRING = "function"
	callback_name: STRING = "callback"
	macro_name: STRING = "macro"


feature -- Codes

	any_code: INTEGER = 1
	none_code: INTEGER = 2
	struct_code: INTEGER = 3
	union_code: INTEGER = 4
	enum_code: INTEGER = 5
	function_code: INTEGER = 6
	callback_code: INTEGER = 7
	macro_code: INTEGER = 8

feature -- Status

	is_valid_construct_type_name (a_name: STRING): BOOLEAN
			-- Is `a_name' a valid construct type name ?
		require
			a_name_not_void: a_name /= Void
		do
			Result := construct_type_name_table.has (a_name)
		end

	is_valid_construct_type_code (a_code: INTEGER): BOOLEAN
			-- Is `a_code' a valid format code ?
		do
			Result := construct_type_name_table.has_item (a_code)
		end

	construct_type_code_from_name (a_name: STRING): INTEGER
			-- Construct type code from construct type name
		require
			a_name_not_void: a_name /= Void
			a_name_valid_construct_type_name: is_valid_construct_type_name (a_name)
		do
			Result := construct_type_name_table.item (a_name)
		ensure
			valid_construct_type_code: is_valid_construct_type_code (Result)
		end

	construct_type_name_from_code (a_code: INTEGER): detachable STRING
			-- Construct type name from construct type code
		require
			a_code_valid_construct_type_code: is_valid_construct_type_code (a_code)
		local
			cs: DS_HASH_TABLE_CURSOR [INTEGER, STRING]
		do
			from
				cs := construct_type_name_table.new_cursor
				cs.start
			until
				cs.off or Result /= Void
			loop
				if cs.item = a_code then
					Result := cs.key
					cs.go_after
				else
					cs.forth
				end
			end
		ensure
--			construct_type_name_not_void: Result /= Void
			construct_type_name_valid: attached Result implies is_valid_construct_type_name (Result)
		end

feature {NONE} -- Implementation

	construct_type_name_table: DS_HASH_TABLE [INTEGER, STRING]
		once
			create Result.make_map (8)
			Result.set_key_equality_tester (string_equality_tester)
			Result.put_new (any_code, any_name)
			Result.put_new (none_code, none_name)
			Result.put_new (struct_code, struct_name)
			Result.put_new (union_code, union_name)
			Result.put_new (enum_code, enum_name)
			Result.put_new (function_code, function_name)
			Result.put_new (callback_code, callback_name)
			Result.put_new (macro_code, macro_name)
		ensure
			construct_type_name_table_not_void: Result /= Void
--			construct_type_name_table_doesnt_have_void_name: not Result.has (Void)
		end


end
