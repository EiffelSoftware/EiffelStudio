-- Extern declarations for final mode generation in DLE mode

class 

	DLE_EXTERN_DECLARATIONS

inherit

	EXTERN_DECLARATIONS
		redefine
			generate, make, add_skeleton_attribute_table,
			wipe_out
		end;

	SHARED_DLE

creation

	make

feature -- Initialization

	make is
			-- Initialization.
		do
			!!routine_tables.make (100);
			!!attribute_tables.make (100);
			!!skeleton_attribute_tables.make (100);
			!!routines.make (100);
			!!type_tables.make (100);
			!!dle_tables.make (100)
		end;
		
feature {NONE} -- Access

	skeleton_attribute_tables: SEARCH_TABLE [STRING];
			-- Attribute offset table ids when generating the skeleton

	dle_tables: SEARCH_TABLE [STRING];
			-- Routine/attribute tables that need to be initialized
			-- (pointer assignment to the corresponding static table)

	table_prefix: STRING is
			-- Prefix for tables of extendible or dynamic systems
		once
			if System.is_dynamic then
				Result := dynamic_prefix
			else
				Result := static_prefix
			end
		end;

feature -- Generation

	add_skeleton_attribute_table (attr_table: STRING) is
			-- Add one attribute offset table to the current extern
			-- declarations when generating the skeleton.
		do
			skeleton_attribute_tables.put (attr_table)
		end;

	add_dle_table (table_name: STRING) is
			-- Add one routine/attribute table to be initialized.
		require
			table_name_exists: table_name /= Void
		do
			dle_tables.put (table_name)
		end;

	wipe_out is
			-- Wipe out current structure.
		do
			routines.clear_all;
			routine_tables.clear_all;
			attribute_tables.clear_all;
			skeleton_attribute_tables.clear_all;
			type_tables.clear_all;
			dle_tables.clear_all
		end;

	generate (file_name: STRING) is
			-- Generate declarations in a file of name `file_name'.
		local
			f: INDENT_FILE
		do	
			!!f.make (file_name);
			f.open_write;

			f.putstring ("#include %"portable.h%"%N%N");

				-- now generate the include files required by externals
			generate_header_files (f)

			from
				routines.start
			until
				routines.after
			loop
				f.putstring ("extern ");
				routines.item_for_iteration.generate (f);
				f.putstring (routines.key_for_iteration);
				f.putstring ("();%N");
				routines.forth
			end;
			from
				routine_tables.start
			until
				routine_tables.after
			loop
				f.putstring ("extern fnptr *");
				f.putstring (routine_tables.item_for_iteration);
				f.putstring (";%N");
				routine_tables.forth
			end;
			from
				attribute_tables.start
			until
				attribute_tables.after
			loop
				f.putstring ("extern long *");
				f.putstring (attribute_tables.item_for_iteration);
				f.putstring (";%N");
				attribute_tables.forth
			end;
			from
				skeleton_attribute_tables.start
			until
				skeleton_attribute_tables.after
			loop
				f.putstring ("extern long ");
				f.putstring (Table_prefix);
				f.putstring (skeleton_attribute_tables.item_for_iteration);
				f.putstring ("[];%N");
				skeleton_attribute_tables.forth
			end;
			from
				type_tables.start
			until
				type_tables.after
			loop
				f.putstring ("extern int16 *");
				f.putstring (type_tables.item_for_iteration);
				f.putstring (";%N");
				type_tables.forth;
			end;

			f.close
		end;
	
	generate_dle (file: INDENT_FILE) is
			-- Generate the body of the initialization function of
			-- routine/attribute tables (assignments of pointers
			-- to static tables) in `file'.
		require
			file_exists: file /= Void;
			is_open:file.is_open_write
		local
			table_name: STRING
		do
			from
				dle_tables.start
			until
				dle_tables.after
			loop
				table_name := dle_tables.item_for_iteration;
				file.putstring (table_name);
				file.putstring (" = ");
				file.putstring (Table_prefix);
				file.putstring (table_name);
				file.putchar (';');
				file.new_line;
				dle_tables.forth
			end
		end;

invariant

	dle_system: System.is_dynamic or System.extendible

end -- class DLE_EXTERN_DECLARATIONS
