-- Extern declarations for final mode generation

class EXTERN_DECLARATIONS

inherit
	SHARED_INCLUDE;
	SHARED_WORKBENCH

creation
	make

feature

	routine_tables: SEARCH_TABLE [STRING];
			-- Hash table of routine tables

	attribute_tables: SEARCH_TABLE [STRING];
			-- Attribute offset table ids

	type_tables: SEARCH_TABLE [STRING];
			-- Type table name

	routines: EXTEND_TABLE [TYPE_C, STRING];
			-- Routine names

	make is
			-- Initialization
		do
			!!routine_tables.make (100);
			!!attribute_tables.make (100);
			!!routines.make (100);
			!!type_tables.make (100);
		end;

	add_routine_table (rout_table: STRING) is
			-- Add one routine table to the current extern declarations.
		require
			rout_table_exists: rout_table /= Void;
		do
			routine_tables.put (rout_table);
		end;

	add_attribute_table (attr_table: STRING) is
			-- Add one attribute offset table to the current extern declarations.
		require
			attr_table_exists: attr_table /= Void
		do
			attribute_tables.put (attr_table);
		end;

	add_skeleton_attribute_table (attr_table: STRING) is
			-- Add one attribute offset table to the current extern
			-- declarations when generating the skeleton.
		require
			attr_table_exists: attr_table /= Void
		do
			attribute_tables.put (attr_table)
		end;

	add_type_table (type_table: STRING) is
			-- Add one type table to the current extern declarations.
		require
			type_table_exists: type_table /= Void
		do
			type_tables.put (type_table);
		end;

	add_routine (type: TYPE_C; rout_name: STRING) is
			-- Add one routine of name `rout_name' and C type `type`.
		require
			rout_name_exists: rout_name /= Void;
			type_exists: type /= Void;
		do
			rout_name.append ("();")
			routines.put (type, rout_name);
		end;

	add_routine_with_signature (type: TYPE_C; rout_name: STRING; argument_types: ARRAY [STRING]) is
			-- Add one routine of name `rout_name' and C type `type' and with argument types
			-- `arguments_types
		local
			i: INTEGER
			nb: INTEGER
			signature: STRING
			sep: STRING
		do
			from
				create signature.make (48)
				signature.append (rout_name + "(")
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
			signature.append (");")
			routines.put (type, signature)
		end

	wipe_out is
			-- Wipe out current structure
		do
			routines.clear_all;
			routine_tables.clear_all;
			attribute_tables.clear_all;
			type_tables.clear_all;
		end;

	generate_header_files (buffer: GENERATION_BUFFER) is
			-- Generate header files in `buffer'.
		require
			buffer_exists: buffer /= Void;
		local
			queue: like shared_include_queue
		do
			queue := shared_include_queue
			if queue /= Void then
				from
					buffer.end_c_specific_code
				until
					queue.empty
				loop
					buffer.putstring ("#include ");
					buffer.putstring (queue.item);
					buffer.new_line;
					queue.remove;
				end;
				buffer.start_c_specific_code
			end;
		end;

	generate_header (buffer: GENERATION_BUFFER) is
			-- Generate the run-time header file includes
		require
			buffer_not_void: buffer /= Void
		do
			buffer.putstring ("#include %"eif_portable.h%"%N%
					%#include %"eif_macros.h%"%N%N");
			buffer.start_c_specific_code
		end

	generate (buffer: GENERATION_BUFFER) is
			-- Generate declarations in a file of name `file_name'.
		require
			buffer_not_void: buffer /= Void
		local
			local_routines: EXTEND_TABLE [TYPE_C, STRING]
			local_routine_tables: SEARCH_TABLE [STRING]
			local_attribute_tables: SEARCH_TABLE [STRING]
			local_type_tables: SEARCH_TABLE [STRING]
		do
				-- generate the include files required by externals
			generate_header_files (buffer);

			from
				local_routines := routines
				local_routines.start
			until
				local_routines.after
			loop
				buffer.putstring ("%Nextern ");
				local_routines.item_for_iteration.generate (buffer);
				buffer.putstring (local_routines.key_for_iteration);
--				buffer.putstring ("();%N");
				local_routines.forth;
			end;

			from
				local_routine_tables := routine_tables
				local_routine_tables.start
			until
				local_routine_tables.after
			loop
				buffer.putstring ("extern fnptr ");
				buffer.putstring (local_routine_tables.item_for_iteration);
				buffer.putstring ("[];%N");
				local_routine_tables.forth;
			end;

			from
				local_attribute_tables := attribute_tables
				local_attribute_tables.start
			until
				local_attribute_tables.after
			loop
				buffer.putstring ("extern long ");
				buffer.putstring (local_attribute_tables.item_for_iteration);
				buffer.putstring ("[];%N");
				local_attribute_tables.forth;
			end;

			from
				local_type_tables := type_tables
				local_type_tables.start
			until
				local_type_tables.after
			loop
				buffer.putstring ("extern int16 ");
				buffer.putstring (local_type_tables.item_for_iteration);
				buffer.putstring ("[];%N");
				buffer.putstring ("extern int16 *");
				buffer.putstring (local_type_tables.item_for_iteration);
				buffer.putstring ("_gen_type [];%N");
				local_type_tables.forth;
			end;
			buffer.end_c_specific_code
		end;

end
