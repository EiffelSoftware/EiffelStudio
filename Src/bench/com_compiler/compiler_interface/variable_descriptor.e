indexing
	description: "Entry in completion list"
	date: "$Date$"
	revision: "$Revision$"

class
	VARIABLE_DESCRIPTOR

inherit
	COMPLETION_ENTRY

create
	make

feature {NONE} -- Initialization

	make (n, s: STRING) is
			-- Set `name' with `n'.
			-- Set `signature' with `s'.
		require
			non_void_name: n /= Void
			non_void_signature: s /= Void
		do
			name := n
			signature := s
		ensure
			name_set: n = name
			signature_set: signature = s
		end

feature -- Access

	is_feature (return_value: BOOLEAN_REF) is
			-- Is entry a feature? (could be a variable)
			-- Not a feature
		once
			return_value.set_item (False)
		end

	signature: STRING
			-- Signature

	name: STRING
			-- Name

end -- class VARIABLE_DESCRIPTOR
