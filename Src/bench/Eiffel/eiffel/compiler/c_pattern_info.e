indexing
	description: "Information about C patterns"
	date: "$Date$"
	revision: "$Revision$"

class
	C_PATTERN_INFO 

inherit
	HASHABLE
		redefine
			is_equal
		end

	SHARED_CODE_FILES
		export
			{NONE} all
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (p: like pattern) is
		require
			p_not_void: p /= Void
		do
			pattern := p
		ensure
			pattern_set: pattern = p
		end

feature -- Access

	pattern: C_PATTERN
			-- Pattern

	c_pattern_id: INTEGER
			-- Pattern id

	hash_code: INTEGER is
			-- Hash code
		do
			Result := pattern.hash_code
		end

feature -- Settings

	set_c_pattern_id (i: INTEGER) is
			-- Assign `i' to `c_pattern_id'.
		do
			c_pattern_id := i
		ensure
			c_pattern_id_set: c_pattern_id = i
		end

	set_pattern (p: C_PATTERN) is
		require
			p_not_void: p /= Void
		do
			pattern := p
		ensure
			pattern_set: pattern = p
		end

feature -- Comparison

	is_equal (other: C_PATTERN_INFO): BOOLEAN is
            -- Is `other' equal to Current ?
        do
            Result := pattern.is_equal (other.pattern)
        end

feature -- Code generation

	generate_pattern (buffer: GENERATION_BUFFER) is
			-- Generate pattern for interface between C generated code
			-- and the interpreter
		require
			buffer_not_void: buffer /= Void
		do
			pattern.generate_pattern (c_pattern_id, buffer)
		end

feature -- Concurrent Eiffel

	generate_separate_pattern (buffer: GENERATION_BUFFER) is
			-- Generate pattern for separate calls
		require
			buffer_not_void: buffer /= Void
		do
			pattern.generate_separate_pattern (c_pattern_id, buffer)
		end

	generate_only_separate_pattern (buffer: GENERATION_BUFFER) is
			-- Generate pattern for separate calls in FINALIZED mode
		require
			buffer_not_void: buffer /= Void
		do
			pattern.generate_separate_pattern (c_pattern_id, buffer)
		end

feature -- Debug

	trace is
		do
			io.error.putint (c_pattern_id)
			io.error.new_line
			pattern.trace
		end

invariant
	pattern_exists: pattern /= Void

end
