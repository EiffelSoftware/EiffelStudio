-- System level static type counter.

class TYPE_COUNTER

inherit

	COMPILER_COUNTER
		redefine
			next_id, current_subcounter
		end

creation

	make

feature -- Initialization

	new_subcounter (compilation_id: INTEGER): TYPE_SUBCOUNTER is
			-- New static type id counter associated with `compilation_id'
		do
			if Compilation_modes.is_precompiling then
				!P_TYPE_SUBCOUNTER! Result.make (compilation_id)
			else
				!TYPE_SUBCOUNTER! Result.make
			end
		end

feature -- Access

	next_id: TYPE_ID is
			-- Next static type id
		do
			Result := current_subcounter.next_id
		end

feature -- Generation

	generate_offsets (file: INDENT_FILE) is
			-- Generate `offset' declarations into `file'.
		require
			file_not_void: file /= Void;
			file_open_write: file.is_open_write
		local
			type_subcounter: TYPE_SUBCOUNTER
		do
			from start until after loop
				type_subcounter ?= item_for_iteration;
				type_subcounter.generate_offset (file);
				forth
			end
		end

	generate_extern_offsets (file: INDENT_FILE) is
			-- Generate `offset' extern declarations into `file'.
		 require
			file_not_void: file /= Void;
			file_open_write: file.is_open_write
		local
			type_subcounter: TYPE_SUBCOUNTER
		do
			from start until after loop
				type_subcounter ?= item_for_iteration;
				type_subcounter.generate_extern_offset (file);
				forth
			end
		end
				
feature {NONE} -- Implementation

	current_subcounter: TYPE_SUBCOUNTER;
			-- Current static type id subcounter

end -- class TYPE_COUNTER
