indexing
	description: "Server abstract synax tree on temporary file for AST. This server is%
				%used during the compilation. The goal is to merge the file Tmp_ast_file%
				%and Ast_file if the compilation is successful. Indexed by class id."
	date: "$Date$"
	revision: "$Revision$"

class TMP_AST_SERVER 

inherit
	COMPILER_SERVER [CLASS_AS]
		redefine
			put, make_index, need_index, make
		end

	INTERNAL
		undefine
			copy, is_equal
		end

creation
	make
	
feature 

	index: EXTEND_TABLE [READ_INFO, INTEGER]
			-- Offsets of objects tracked by the store append: offsets in
			-- file Tmp_ast_file of instances of FEATURE_AS are put
			-- in the hash table with keys the object ids of the
			-- instances

	invariant_info: READ_INFO
			-- Information about invariant clause

	last_offset: INTEGER
			-- Offset of the last introduced class

	last_id: INTEGER
			-- Id of the current inserted class

	make is
			-- Initialization
		do
			{COMPILER_SERVER} Precursor
			!!index.make (100)
		end

	cache: AST_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end
		
	id (t: CLASS_AS): INTEGER is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

	put (t: CLASS_AS) is
			-- Append object `t' in file ".TMP_AST".
		do
			index.clear_all
			last_id := t.class_id
				-- Write data structure in file `file'
			{COMPILER_SERVER} Precursor (t)
		end

	make_index (obj: ANY; file_position, object_count: INTEGER) is
			-- Store object `obj' and track the instances
			-- of FEATURE_AS and INVARIANT_AS
		local
			read_info: READ_INFO
			feat: FEATURE_AS
		do
				-- Put `obj' in the index.
			create read_info
			read_info.set_position (file_position)
			read_info.set_class_id (last_id)
			read_info.set_object_count (object_count)
			if is_feature_as (obj) then
				feat ?= obj
				index.force (read_info, feat.id)
			else
				invariant_info := read_info
			end
		end

	need_index (obj: ANY): BOOLEAN is
			-- Is an index needed for `obj'?
		do
			Result := is_feature_as (obj) or else is_invariant_as (obj)
		end

	clear_index is
			-- Clear `index'.
		do
			index.clear_all;
			invariant_info := Void;
		end

	Size_limit: INTEGER is 400
			-- Size of the TMP_AST_SERVER file (400 Ko)

	Chunk: INTEGER is 500
			-- Size of a HASH_TABLE block

feature {NONE} -- Implementation of dynamic type checking

	is_invariant_as (obj: ANY): BOOLEAN is
			-- Is `obj' of type INVARIANT_AS?
		do
			Result := invariant_as_type = dynamic_type (obj)
		end

	is_feature_as (obj: ANY): BOOLEAN is
			-- Is `obj' of type FEATURE_AS?
		do
			Result := feature_as_type = dynamic_type (obj)
		end

	invariant_as_type: INTEGER is
			-- Dynamic type of objects of type INVARIANT_AS.
		once
			Result := dynamic_type (create {INVARIANT_AS})
		end

	feature_as_type: INTEGER is
			-- Dynamic type of objects of type INVARIANT_AS.
		once
			Result := dynamic_type (create {FEATURE_AS})
		end

end
