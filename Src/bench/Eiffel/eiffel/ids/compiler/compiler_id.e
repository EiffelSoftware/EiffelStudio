-- Notion of id

deferred class COMPILER_ID

inherit

	SHARED_ID;
	SHARED_WORKBENCH;
	HASHABLE
		rename
			hash_code as internal_id
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

feature -- Status report

	is_precompiled: BOOLEAN is
			-- Is the entity identified by `Current' precompiled?
		do
		end

	is_dynamic: BOOLEAN is
			-- Is the entity identified by `Current' part of a DC-set?
		do
		end

feature {NONE} -- Implementation

	internal_id: INTEGER;
			-- Internal compilation-level id

	compilation_id: INTEGER is
			-- Compilation unit associated with the current id
		do
			Result := Normal_compilation
		end;

	counter: COMPILER_SUBCOUNTER is
			-- Counter associated with the id
		deferred
		ensure
			counter_not_void: Result /= Void
		end;

end -- class COMPILER_ID
