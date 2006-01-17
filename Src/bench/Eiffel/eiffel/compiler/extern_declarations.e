indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Extern declarations for final mode generation

class EXTERN_DECLARATIONS

inherit
	SHARED_INCLUDE

	SHARED_WORKBENCH

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make is
			-- Initialization
		do
			create routine_tables.make (50)
			create attribute_tables.make (50)
			create routines.make (50)
			create type_tables.make (50)
			create onces_table.make (10)
		end

feature -- Settings

	add_routine_table (rout_table: STRING) is
			-- Add one routine table to the current extern declarations.
		require
			rout_table_exists: rout_table /= Void
		do
			routine_tables.put (rout_table.twin)
		end

	add_attribute_table (attr_table: STRING) is
			-- Add one attribute offset table to the current extern declarations.
		require
			attr_table_exists: attr_table /= Void
		do
			attribute_tables.put (attr_table.twin)
		end

	add_once (type: TYPE_C; code_index: INTEGER; is_process_relative: BOOLEAN) is
			-- Add `once_name' to current extern declarations.
		require
			type__not_void: type /= Void
		do
			if not system.has_multithreaded or else is_process_relative then
				onces_table.put (type, code_index)
			end
		end

	add_type_table (type_table: STRING) is
			-- Add one type table to the current extern declarations.
		require
			type_table_exists: type_table /= Void
		do
			type_tables.put (type_table.twin)
		end

	add_routine (type: TYPE_C; rout_name: STRING) is
			-- Add one routine of name `rout_name' and C type `type`.
		require
			rout_name_exists: rout_name /= Void
			type_exists: type /= Void
		local
			r_name: STRING
		do
			create r_name.make (rout_name.count + 3)
			r_name.append (rout_name)
			r_name.append_character ('(')
			r_name.append_character (')')
			r_name.append_character (';')
			routines.put (type, r_name)
		end

	add_routine_with_signature (type: TYPE_C; rout_name: STRING; argument_types: ARRAY [STRING]) is
			-- Add one routine of name `rout_name' and C type `type' and with argument types
			-- `arguments_types
		require
			type_exists: type /= Void
			rout_name_exists: rout_name /= Void
		local
			i: INTEGER
			nb: INTEGER
			signature: STRING
			sep: STRING
		do
			create signature.make (48)
			signature.append (rout_name + "(")
			if argument_types /= Void then
				from
					sep := ", "
					i := 1
					nb := argument_types.count
				until
					i > nb
				loop
					if i /= 1 then
						signature.append (sep)
					end
					signature.append (argument_types @ i)
					i := i + 1
				end
			end
			signature.append (");")
			routines.put (type, signature)
		end

	wipe_out is
			-- Wipe out current structure
		do
			routines.clear_all
			routine_tables.clear_all
			attribute_tables.clear_all
			type_tables.clear_all
			onces_table.clear_all
		end

	generate_header_files (buffer: GENERATION_BUFFER) is
			-- Generate header files in `buffer'.
		require
			buffer_exists: buffer /= Void
			shared_include_queue_not_void: shared_include_queue /= Void
		local
			queue: like shared_include_queue
			l_names_heap: like Names_heap
		do
			queue := shared_include_queue
			if not queue.is_empty then
				l_names_heap := Names_heap
				from
					queue.start
				until
					queue.after
				loop
					buffer.put_string ("#include ")
					buffer.put_string (l_names_heap.item (queue.item_for_iteration))
					buffer.put_new_line
					queue.forth
				end
				queue.wipe_out
			end
		end

	generate (buffer: GENERATION_BUFFER) is
			-- Generate declarations in a file of name `file_name'.
		require
			buffer_not_void: buffer /= Void
		local
			local_routines: HASH_TABLE [TYPE_C, STRING]
			local_routine_tables: SEARCH_TABLE [STRING]
			local_attribute_tables: SEARCH_TABLE [STRING]
			local_type_tables: SEARCH_TABLE [STRING]
			local_onces: like onces_table
			local_once_prefix: STRING
		do
			from
				local_routines := routines
				local_routines.start
			until
				local_routines.after
			loop
				buffer.put_string ("%Nextern ")
				local_routines.item_for_iteration.generate (buffer)
				buffer.put_string (local_routines.key_for_iteration)
				local_routines.forth
			end

			from
				if system.has_multithreaded then
						-- Process-relative once
					local_once_prefix := "RTOPH"
				else
						-- Single-threaded application
					local_once_prefix := "RTOSH"
				end
				local_onces := onces_table
				local_onces.start
			until
				local_onces.after
			loop
				buffer.put_new_line
				buffer.put_string (local_once_prefix)
				if local_onces.item_for_iteration.is_void then
					buffer.put_string ("P(")
				else
					buffer.put_string ("F(")
					buffer.put_string (local_onces.item_for_iteration.c_string)
					buffer.put_character (',')
				end
				buffer.put_integer (local_onces.key_for_iteration)
				buffer.put_character (')')
				local_onces.forth
			end

			from
				local_routine_tables := routine_tables
				local_routine_tables.start
			until
				local_routine_tables.after
			loop
				buffer.put_string ("%Nextern char *(*")
				buffer.put_string (local_routine_tables.item_for_iteration)
				buffer.put_string ("[])();")
				local_routine_tables.forth
			end

			from
				local_attribute_tables := attribute_tables
				local_attribute_tables.start
			until
				local_attribute_tables.after
			loop
				buffer.put_string ("%Nextern long ")
				buffer.put_string (local_attribute_tables.item_for_iteration)
				buffer.put_string ("[];")
				local_attribute_tables.forth
			end

			from
				local_type_tables := type_tables
				local_type_tables.start
			until
				local_type_tables.after
			loop
				buffer.put_string ("%Nextern int16 ")
				buffer.put_string (local_type_tables.item_for_iteration)
				buffer.put_string ("[];")
				buffer.put_string ("%Nextern int16 *")
				buffer.put_string (local_type_tables.item_for_iteration)
				buffer.put_string ("_gen_type [];")
				local_type_tables.forth
			end
		end

feature {NONE} -- Attributes

	routine_tables: SEARCH_TABLE [STRING]
			-- Hash table of routine tables

	attribute_tables: SEARCH_TABLE [STRING]
			-- Attribute offset table ids

	type_tables: SEARCH_TABLE [STRING]
			-- Type table name

	routines: HASH_TABLE [TYPE_C, STRING]
			-- Routine names

	onces_table: HASH_TABLE [TYPE_C, INTEGER];
			-- Once names

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
