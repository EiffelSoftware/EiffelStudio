-- System level class counter.

class CLASS_COUNTER

inherit

	COMPILER_COUNTER
		redefine
			next_id, current_subcounter
		end

creation

	make

feature -- Initialization

	new_subcounter (compilation_id: INTEGER): CLASS_SUBCOUNTER is
			-- New class id counter associated with `compilation_id'
		do
			if Compilation_modes.is_precompiling then
				!P_CLASS_SUBCOUNTER! Result.make (compilation_id)
			else
				!CLASS_SUBCOUNTER! Result.make
			end
		end

feature -- Access

	next_id: CLASS_ID is
			-- Next class id
		do
			Result := current_subcounter.next_id
		end

	next_protected_id: CLASS_ID is
			-- Next protected class id
		do
			Result := current_subcounter.next_protected_id
		ensure
			id_not_void: Result /= Void;
			protected: Result.protected
		end

feature -- Generation

	generate_offsets (file: INDENT_FILE) is
			-- Generate `offset' declarations into `file'.
		require
			file_not_void: file /= Void;
			file_open_write: file.is_open_write
		local
			class_subcounter: CLASS_SUBCOUNTER
		do
			from start until after loop
				class_subcounter ?= item_for_iteration;
				class_subcounter.generate_offset (file);	
				forth
			end
		end

	generate_extern_offsets (file: INDENT_FILE) is
			-- Generate `offset' extern declarations into `file'.
		require
			file_not_void: file /= Void;
			file_open_write: file.is_open_write
		local
			class_subcounter: CLASS_SUBCOUNTER
		do
			from start until after loop
				class_subcounter ?= item_for_iteration;
				class_subcounter.generate_extern_offset (file);	
				forth
			end
		end

feature {NONE} -- Implementation

	current_subcounter: CLASS_SUBCOUNTER;
			-- Current class id subcounter

end -- class CLASS_COUNTER
