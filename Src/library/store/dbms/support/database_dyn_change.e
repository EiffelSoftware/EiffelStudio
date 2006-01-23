indexing
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

	prepare (s: STRING) is
			-- Parse of the sql statement `s'
		require
			not_void: s /= Void
			meaning_full_statement: s.count > 0
		local
			parsed_s: STRING
			parsed: BOOLEAN
			ArgNum: INTEGER
		do
			if sql_string = Void then
				create sql_string.make (s.count)
			else
				sql_string.wipe_out
			end
			sql_string.append (s)
			s.wipe_out
			s.append (parse (sql_string))
			ArgNum := s.occurrences('?')

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
					db_spec.pre_immediate (descriptor, ArgNum)
				end
			end
			set_executed (FALSE)
			set_prepared (TRUE)
		ensure
			prepared_statement: is_prepared
			prepared_statement: not is_executed
		end

	execute is
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

	terminate is
		do
			db_spec.terminate_order (descriptor)
		end

feature -- Status Report

	is_allocatable : BOOLEAN is
		do
			Result := db_spec.descriptor_is_available
		end

feature {NONE} -- Implementation

	sql_string: STRING 

	descriptor: INTEGER;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DATABASE_DYN_CHANGE


