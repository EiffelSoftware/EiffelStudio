-- Notion of id

deferred class COMPILER_ID

inherit

	SHARED_WORKBENCH;
	HASHABLE;
	ENCODER
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (val: like internal_id) is
			-- Create a new id.
		do
			internal_id := val
		end;

feature -- Access

	id: INTEGER is
			-- System-level unique value for the current id
		do
			Result := internal_id + counter.offset
		end;

	hash_code: INTEGER is
			-- Hash code
		do
			Result := internal_id
		end;

feature {NONE} -- Implementation

	internal_id: INTEGER;
			-- Internal precompilation-level id

	compilation_id: INTEGER is
			-- Compilation unit associated with the
			-- current id (-1 when not precompiled)
		do
			Result := -1
		end;

	prefix_string: STRING is
			-- Prefix for generated C function and table names
		do
			Result := counter.prefix_string
		end

	counter: COMPILER_SUBCOUNTER [COMPILER_ID] is
			-- Counter associated with the id
		deferred
		ensure
			counter_not_void: Result /= Void
		end;

end -- class COMPILER_ID
