indexing
	description: "Object that stores formatted Eiffel code"

deferred class
	ROUNDTRIP_CONTEXT

feature	-- Operation

	add_string (s: STRING) is
			-- Add `s' into this context.
		require
			s_not_void: s /= Void
		deferred
		ensure
			count_set: count = old count + s.count
		end

	clear is
		-- Clear this context.
		deferred
		ensure
			count_set: count = 0
			string_representation_is_empty: string_representation.is_empty
		end

	string_representation: STRING is
			-- String representation of this context
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	count: INTEGER is
			-- Number of characters in current context.
		deferred
		end

end
