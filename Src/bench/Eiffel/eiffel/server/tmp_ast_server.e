-- Server abstract synax tree on temporary file for AST. This server is
-- used during the compilation. The goal is to merge the file Tmp_ast_file
-- and Ast_file if the compilation is successfull.

class TMP_AST_SERVER 

inherit

	SERVER [CLASS_AS]
		rename
			make as basic_make,
			put as old_put
		redefine
			make_index, init_file
		end;

	SERVER [CLASS_AS]
		redefine
			put, make_index, make, init_file
		select
			put, make
		end

creation

	make
	
feature 

	index: EXTEND_TABLE [READ_INFO, INTEGER];
			-- Offsets of objects tracked by the store append: offsets in
			-- file Tmp_ast_file of instances of FEATURE_AS are put
			-- in the hash table with keys the object ids of the
			-- instances

	invariant_info: READ_INFO;
			-- Information about invariant clause

	last_offset: INTEGER;
			-- Offset of the last introduced class

	last_id: INTEGER;
			-- Id of the current inserted class

	make is
			-- Initialization
		do
			basic_make;
			!!index.make (50);
		end;

	Cache: AST_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	put (t: CLASS_AS) is
			-- Append object `t' in file ".TMP_AST".
		do
			index.clear_all;
			last_id := t.id;
				-- Write data structure in file `file'
			old_put (t);
		end;

	init_file (server_file: SERVER_FILE) is
			-- Initialize server file `server_file' before writing in
			-- it.
		local
			file_desc: INTEGER;
		do
			file_desc := server_file.descriptor;
			c_sv_init (file_desc);
			last_offset := fpos2 (file_desc);
		end;

	make_index (obj: ANY; file_position, object_count: INTEGER) is
			-- Store object `obj' and track the instances
			-- of FEATURE_AS and INVARIANT_AS
		local
			read_info: READ_INFO;
			is_feature, is_invariant: BOOLEAN;
			feat: FEATURE_AS;
		do
			is_feature := is_feature_as ($obj);
			is_invariant := is_invariant_as ($obj);
			if is_feature or else is_invariant then
					-- Put `obj' in the index.
				!!read_info;
				read_info.set_offset (file_position - last_offset);
				read_info.set_class_id (last_id);
				read_info.set_object_count (object_count);
				if is_feature then
					feat ?= obj;
					index.force (read_info, feat.id);
				else
					invariant_info := read_info;
				end;
			end;
		end;

	clear_index is
			-- Clear `index'.
		do
			index.clear_all;
			invariant_info := Void;
		end;

	Size_limit: INTEGER is 20;

feature {NONE} -- External features

	fpos2 (f_desc: INTEGER): INTEGER is
		external
			"C"
		end;

	is_invariant_as (o: POINTER): BOOLEAN is
		external
			"C"
		end;

	is_feature_as (o: POINTER): BOOLEAN is
		external
			"C"
		end;

end
