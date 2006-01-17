indexing
	description: "Server abstract synax tree on temporary file for AST. This server is%
				%used during the compilation. The goal is to merge the file Tmp_ast_file%
				%and Ast_file if the compilation is successful. Indexed by class id."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make
	
feature 

	index: HASH_TABLE [READ_INFO, INTEGER]
			-- Offsets of objects tracked by the store append: offsets in
			-- file Tmp_ast_file of instances of FEATURE_AS are put
			-- in the hash table with keys the object ids of the
			-- instances

	invariant_info: READ_INFO
			-- Information about invariant clause

	last_offset: INTEGER
			-- Offset of the last introduced class

	make is
			-- Initialization
		do
			Precursor {COMPILER_SERVER}
			create index.make (100)
		end

	cache: AST_CACHE is
			-- Cache for routine tables
		once
			create Result.make
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
				-- Write data structure in file `file'
			Precursor {COMPILER_SERVER} (t)
		end

	make_index (obj: ANY; file_position, object_count: INTEGER) is
			-- Store object `obj' and track the instances
			-- of FEATURE_AS and INVARIANT_AS
		local
			read_info: READ_INFO
			feat: FEATURE_AS
		do
				-- Put `obj' in the index.
			create read_info.make (file_position, current_file_id)
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
			Result := dynamic_type_from_string ("INVARIANT_AS")
		end

	feature_as_type: INTEGER is
			-- Dynamic type of objects of type INVARIANT_AS.
		once
			Result := dynamic_type_from_string ("FEATURE_AS")
		end

invariant
	cache_not_void: cache /= Void

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
