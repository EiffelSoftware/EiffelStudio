-- Notion of id

deferred class COMPILER_ID

inherit

	SHARED_ID;
	SHARED_WORKBENCH;
	HASHABLE;
	COMPARABLE
		undefine
			is_equal
		end;
	COMPILER_EXPORTER

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
		end

feature -- Status report

	is_precompiled: BOOLEAN is
			-- Is the entity identified by `Current' precompiled?
		do
		end

	is_dynamic: BOOLEAN is
			-- Is the entity identified by `Current' part of a DC-set?
		do
		end

	infix "<" (other: COMPILER_ID): BOOLEAN is
			-- Is current object less than `other'?
		do
			Result := id < other.id
		end

feature {COMPILER_SUBCOUNTER} -- Implementation

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

feature -- Trace

	dump: STRING is
			--  Dump string
		do
			!! Result.make (10);
			Result.extend ('[');
			Result.append_integer (compilation_id);
			Result.append (", ");
			Result.append_integer (internal_id);
			Result.extend (']')
		ensure
			dump_not_void: Result /= Void
		end

	trace is
			-- Dump string on standard error.
		do
			io.error.put_character ('[');
			io.error.put_integer (compilation_id);
			io.error.put_string (", ");
			io.error.put_integer (internal_id);
			io.error.put_character (']')
		end

end -- class COMPILER_ID
