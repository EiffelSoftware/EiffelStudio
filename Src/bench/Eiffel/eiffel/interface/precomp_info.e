class PRECOMP_INFO

inherit

	HASH_TABLE [INTEGER, STRING]
		rename
			make as ht_make
		end;
	STORABLE
		undefine
			copy, is_equal
		end;
	SHARED_WORKBENCH
		undefine
			copy, is_equal
		end;
	SYSTEM_CONSTANTS
		undefine
			copy, is_equal
		end

creation

	make

feature {NONE} -- Initialization

	make (precomp_dirs: HASH_TABLE [REMOTE_PROJECT_DIRECTORY, INTEGER]) is
			-- Create a new structure containing precompilation info.
		require
			precomp_dirs_not_void: precomp_dirs /= Void
		do
			ht_make (precomp_dirs.count);
			from precomp_dirs.start until precomp_dirs.after loop
				force (precomp_dirs.key_for_iteration,
					precomp_dirs.item_for_iteration.dollar_name);
				precomp_dirs.forth
			end
			compiler_version := Version_number;
			compilation_id := System.compilation_id
		end

feature -- Access

	compilation_id: INTEGER
			-- Precompilation identifier

	compiler_version: STRING
			-- Compiler version

end -- class PRECOMP_INFO
