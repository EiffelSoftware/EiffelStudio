note
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

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature -- Initialization

	make
			-- Initialization
		do
			create routine_tables.make (50)
			create attribute_tables.make (50)
			create routines.make (50)
			create wrappers.make (50)
			create type_tables.make (50)
			create onces_table.make (10)
		end

feature -- Settings

	add_once (type: TYPE_C; code_index: INTEGER; is_process_relative, is_object_relative: BOOLEAN)
			-- Add `once_name' to current extern declarations.
		require
			type__not_void: type /= Void
			is_not_object_relative: not is_object_relative
		do
			if
				not system.has_multithreaded -- ie: single threaded
				or else is_process_relative -- ie: multi threaded and process relative once
			then
				onces_table.put (type, code_index)
			end
		end

	wipe_out
			-- Wipe out current structure
		do
			routines.wipe_out
			wrappers.wipe_out
			routine_tables.wipe_out
			attribute_tables.wipe_out
			type_tables.wipe_out
			onces_table.wipe_out
		end

	generate_header_files (buffer: GENERATION_BUFFER)
			-- Generate header files in `buffer'.
		require
			buffer_exists: buffer /= Void
		local
			l_queue: like shared_include_queue
			l_names_heap: like Names_heap
			l_list: ARRAYED_LIST [INTEGER]
			l_table: like shared_unicity_of_includes
			l_header_id: INTEGER
		do
			l_queue := shared_include_queue
			if not l_queue.is_empty then
				l_names_heap := Names_heap
				l_table := shared_unicity_of_includes
				l_table.wipe_out
				from
					l_queue.start
				until
					l_queue.after
				loop
					from
						l_list := l_queue.item_for_iteration
						l_list.start
					until
						l_list.after
					loop
						l_header_id := l_list.item
						l_table.search (l_header_id)
						if not l_table.found then
							l_table.put (l_header_id)
							buffer.put_new_line
							buffer.put_string ("#include ")
							buffer.put_string (l_names_heap.item (l_header_id))
						end
						l_list.forth
					end
					l_queue.forth
				end
				l_queue.wipe_out
			end
		end

	generate (buffer: GENERATION_BUFFER)
			-- Generate declarations in a file of name `file_name'.
		require
			buffer_not_void: buffer /= Void
		local
			local_routines: like routines
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
				buffer.put_new_line
				buffer.put_string ({C_CONST}.extern)
				buffer.put_character (' ')
				buffer.put_string (local_routines.item_for_iteration)
				local_routines.forth
			end

			from
				local_routines := wrappers
				local_routines.start
			until
				local_routines.after
			loop
				buffer.put_new_line
				buffer.put_string ({C_CONST}.static)
				buffer.put_character (' ')
				buffer.put_string (local_routines.item_for_iteration)
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
				buffer.put_string ("%Nextern EIF_TYPE_INDEX ")
				buffer.put_string (local_type_tables.item_for_iteration)
				buffer.put_string ("[];")
				buffer.put_string ("%Nextern EIF_TYPE_INDEX *")
				buffer.put_string (local_type_tables.item_for_iteration)
				buffer.put_string ("_gen_type [];")
				local_type_tables.forth
			end
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Settings

	add_routine_table (rout_table: STRING)
			-- Add one routine table to the current extern declarations.
		require
			rout_table_exists: rout_table /= Void
		do
			routine_tables.put (rout_table.string)
		end

	add_attribute_table (attr_table: STRING)
			-- Add one attribute offset table to the current extern declarations.
		require
			attr_table_exists: attr_table /= Void
		do
			attribute_tables.put (attr_table.string)
		end

	add_type_table (type_table: STRING)
			-- Add one type table to the current extern declarations.
		require
			type_table_exists: type_table /= Void
		do
			type_tables.put (type_table.string)
		end

	add_routine (type: TYPE_C; rout_name: READABLE_STRING_8)
			-- Add one routine of name `rout_name' and C type `type`.
		require
			rout_name_exists: rout_name /= Void
			type_exists: type /= Void
		do
			routines.put (new_signature (type.c_string, rout_name, Void))
		end

	add_routine_with_signature (type: STRING; rout_name: READABLE_STRING_8; argument_types: ARRAY [STRING])
			-- Add one routine of name `rout_name' and C type `type' and with argument types
			-- `arguments_types
		require
			type_exists: type /= Void
			rout_name_exists: rout_name /= Void
		do
			routines.put (new_signature (type, rout_name, argument_types))
		end

	add_wrapper_with_signature (type: STRING; rout_name: READABLE_STRING_8; argument_types: ARRAY [STRING])
			-- Add one routine of name `rout_name' and C type `type' and with argument types
			-- `arguments_types
		require
			type_exists: type /= Void
			rout_name_exists: rout_name /= Void
		do
			wrappers.put (new_signature (type, rout_name, argument_types))
		end

feature {NONE} -- Implementation

	new_signature (type: STRING; rout_name: READABLE_STRING_8; argument_types: ARRAY [STRING]): STRING
			-- Add one routine of name `rout_name' and C type `type' and with argument types
			-- `arguments_types
		require
			type_exists: type /= Void
			rout_name_exists: rout_name /= Void
		local
			i: INTEGER
			nb: INTEGER
		do
			create Result.make (48)
			Result.append (type)
			Result.append_character (' ')
			Result.append (rout_name)
			Result.append_character ('(')
			if argument_types /= Void then
				from
					i := 1
					nb := argument_types.count
				until
					i > nb
				loop
					if i /= 1 then
						Result.append_character (',')
						Result.append_character (' ')
					end
					Result.append (argument_types [i])
					i := i + 1
				end
			end
			Result.append_character (')')
			Result.append_character (';')
		ensure
			new_signature_not_void: Result /= Void
		end

feature {NONE} -- Attributes

	routine_tables: SEARCH_TABLE [STRING]
			-- Hash table of routine tables

	attribute_tables: SEARCH_TABLE [STRING]
			-- Attribute offset table ids

	type_tables: SEARCH_TABLE [STRING]
			-- Type table name

	routines: SEARCH_TABLE [STRING]
			-- Routine names

	wrappers: SEARCH_TABLE [STRING]
			-- Polymorphic wrappers

	onces_table: HASH_TABLE [TYPE_C, INTEGER];
			-- Once names

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
