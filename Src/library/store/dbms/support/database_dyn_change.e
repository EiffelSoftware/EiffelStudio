note
	description: "Implementation of DB_DYN_CHANGE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_DYN_CHANGE [G -> DATABASE create default_create end]

inherit
	DATABASE_CHANGE [G]

		rename
			put as normal_put
		undefine
			set_map_name, unset_map_name, is_mapped, mapped_value, clear_all,
			replacement_string
		end

	PARAMETER_HDL
		undefine
			out, copy, is_equal
		end

create
	make

create {DATABASE_DYN_CHANGE}
	string_make

feature

	prepare (s: STRING_8)
			-- Parse of the sql statement `s'
		obsolete
			"Use `prepare_32' instead."
		require
			not_void: s /= Void
			meaning_full_statement: s.count > 0
		do
			prepare_32 (s)
		end

	prepare_32 (s: STRING_32)
			-- Parse of the sql statement `s'
		require
			not_void: s /= Void
			meaning_full_statement: s.count > 0
		local
			parsed_s: STRING_32
			parsed: BOOLEAN
			arg_num: INTEGER
			l_sql_string: like sql_string_32
		do
			l_sql_string := sql_string_32
			if l_sql_string = Void then
				create l_sql_string.make (s.count)
				sql_string_32 := l_sql_string
			else
				l_sql_string.wipe_out
			end
			l_sql_string.append (s)
			s.wipe_out
			s.append (parse_32 (l_sql_string))
			arg_num := s.occurrences({CHARACTER_32} '?')

			descriptor := db_spec.new_descriptor
			if not db_spec.normal_parse then
				parsed := db_spec.parse (descriptor, ht, ht_order, handle, s)
			end
			if not parsed then
				parsed_s := s
				if is_ok then
					db_spec.init_order (descriptor, parsed_s)
				end
				if is_ok then
					db_spec.pre_immediate (descriptor, arg_num)
				end
			end
			set_executed (False)
			set_prepared (True)
		ensure
			prepared_statement: is_prepared
			prepared_statement: not is_executed
		end

	execute
			-- Execute the sql statement
		require
			prepared_statement: is_prepared
		do
			if is_ok then
				db_spec.unset_catalog_flag(descriptor)
			end
			if is_ok then
				db_spec.start_order (descriptor)
			end
			set_executed (True)
		ensure
			executed_statement: is_executed
		end

	terminate
		do
			db_spec.terminate_order (descriptor)
		end

feature -- Status Report

	is_allocatable : BOOLEAN
		do
			Result := db_spec.descriptor_is_available
		end

feature {NONE} -- Implementation

	sql_string_32: detachable STRING_32
			-- Buffer for storing SQL string in `prepare_32'.

	descriptor: INTEGER;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
