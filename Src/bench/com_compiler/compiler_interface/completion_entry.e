indexing
	description: "Entry in completion list"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMPLETION_ENTRY

inherit
	IEIFFEL_COMPLETION_ENTRY_IMPL_STUB
		undefine
			name,
			signature,
			is_feature,
			is_equal
		end

	COMPARABLE

feature -- Access

	name: STRING is
			-- Completion entry name
		deferred
		end

	signature: STRING is
			-- Completion entry description
		deferred
		end

	is_feature (return_value: BOOLEAN_REF) is
			-- Is entry a feature? (could be a variable)
		deferred
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Compare names
		do
			Result := name < other.name
		end

end -- class COMPLETION_ENTRY
