-- Extern declarations for final mode generation

class EXTERN_DECLARATIONS

inherit
	SHARED_INCLUDE

	SHARED_WORKBENCH

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

creation
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
			routine_tables.put (clone (rout_table))
		end

	add_attribute_table (attr_table: STRING) is
			-- Add one attribute offset table to the current extern declarations.
		require
			attr_table_exists: attr_table /= Void
		do
			attribute_tables.put (clone (attr_table))
		end

	add_once (type: TYPE_C; once_name: STRING) is
			-- Add `once_name' to current extern declarations.
		require
			type__not_void: type /= Void
			once_name_not_void: once_name /= Void
		do
			onces_table.put (type, clone (once_name))
		end

	add_type_table (type_table: STRING) is
			-- Add one type table to the current extern declarations.
		require
			type_table_exists: type_table /= Void
		do
			type_tables.put (clone (type_table))
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
			shared_include_queue_not_empty: not shared_include_queue.is_empty
		local
			queue: like shared_include_queue
			l_names_heap: like Names_heap
		do
			queue := shared_include_queue
			l_names_heap := Names_heap
			from
				queue.start
			until
				queue.after
			loop
				buffer.putstring ("#include ")
				buffer.putstring (l_names_heap.item (queue.item_for_iteration))
				buffer.new_line
				queue.forth
			end
			queue.wipe_out
		end

	generate_header (buffer: GENERATION_BUFFER) is
			-- Generate the run-time header file includes
		require
			buffer_not_void: buffer /= Void
		do
			buffer.putstring ("%N#include %"eif_portable.h%"%N%
					%#include %"eif_macros.h%"%N%N")
			buffer.start_c_specific_code
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
			local_onces: HASH_TABLE [TYPE_C, STRING]
		do
			if not shared_include_queue.is_empty then
				buffer.end_c_specific_code
					-- generate the include files required by externals
				generate_header_files (buffer)
				buffer.start_c_specific_code
			end

			from
				local_routines := routines
				local_routines.start
			until
				local_routines.after
			loop
				buffer.putstring ("%Nextern ")
				local_routines.item_for_iteration.generate (buffer)
				buffer.putstring (local_routines.key_for_iteration)
				local_routines.forth
			end

			from
				local_onces := onces_table
				local_onces.start
			until
				local_onces.after
			loop
				if not local_onces.item_for_iteration.is_void then
					buffer.putstring ("%Nextern ")
					local_onces.item_for_iteration.generate (buffer)
					buffer.putstring (local_onces.key_for_iteration)
					buffer.putstring ("_result;")
				end
				buffer.putstring ("%Nextern EIF_BOOLEAN ")
				buffer.putstring (local_onces.key_for_iteration)
				buffer.putstring ("_done;")
				local_onces.forth
			end

			from
				local_routine_tables := routine_tables
				local_routine_tables.start
			until
				local_routine_tables.after
			loop
				buffer.putstring ("%Nextern char *(*")
				buffer.putstring (local_routine_tables.item_for_iteration)
				buffer.putstring ("[])();")
				local_routine_tables.forth
			end

			from
				local_attribute_tables := attribute_tables
				local_attribute_tables.start
			until
				local_attribute_tables.after
			loop
				buffer.putstring ("%Nextern long ")
				buffer.putstring (local_attribute_tables.item_for_iteration)
				buffer.putstring ("[];")
				local_attribute_tables.forth
			end

			from
				local_type_tables := type_tables
				local_type_tables.start
			until
				local_type_tables.after
			loop
				buffer.putstring ("%Nextern int16 ")
				buffer.putstring (local_type_tables.item_for_iteration)
				buffer.putstring ("[];")
				buffer.putstring ("%Nextern int16 *")
				buffer.putstring (local_type_tables.item_for_iteration)
				buffer.putstring ("_gen_type [];")
				local_type_tables.forth
			end
			buffer.end_c_specific_code
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

	onces_table: HASH_TABLE [TYPE_C, STRING]
			-- Once names

end
