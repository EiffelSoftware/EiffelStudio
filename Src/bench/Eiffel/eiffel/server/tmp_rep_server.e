-- Server abstract synax tree on temporary file for AST. This server is
-- used during the compilation. The goal is to merge the file Tmp_ast_file
-- and Ast_file if the compilation is successfull.

class TMP_REP_SERVER 

inherit

	SERVER [REP_FEATURES]
		rename
			make as basic_make,
			put as old_put
		redefine
			make_index, init_file
		end;

	SERVER [REP_FEATURES]
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

	Cache: REP_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	put (t: REP_FEATURES) is
			-- Append object `t' in file ".TMP_AST".
		local
			server_file: SERVER_FILE;
		do
			server_file := Server_controler.file_of_id (current_id);
			if not server_file.is_open then
				Server_controler.open_file (server_file);
			end;
			index.clear_all;
			last_id := t.class_id;
				-- Write data structure in file `file'
			old_put (t);
		end;

	init_file (server_file: SERVER_FILE) is
			-- Initialize server file `server_file' before writing in
			-- it.
		local
			ptr: POINTER;
		do
			ptr := server_file.file_pointer;
			c_sv_init (ptr);
			last_offset := fpos2 ( ptr);
		end;

	make_index (obj: ANY; file_position, object_count: INTEGER) is
			-- Store object `obj' and track the instances
			-- of FEATURE_AS and INVARIANT_AS
		local
			read_info: READ_INFO;
			is_feature, is_invariant: BOOLEAN;
			feat: FEATURE_AS;
		do
				-- Put `obj' in the index.
			!!read_info;
			read_info.set_offset (file_position - last_offset);
			read_info.set_class_id (last_id);
			read_info.set_object_count (object_count);
			feat ?= obj;
			if feat /= Void then
				index.force (read_info, feat.id);
			end;
		end;

	clear_index is
		do
			index.clear_all
		end;

	Size_limit: INTEGER is 1000000;

feature {NONE} -- External features

	fpos2 (fil: POINTER): INTEGER is
		external
			"C"
		end;

end
