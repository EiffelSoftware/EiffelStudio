note
	description: "Objects that are hashed based on their identity (reference)."
	author: "Nadia Polikarpova"

class
	V_REFERENCE_HASHABLE

inherit
	HASHABLE

feature -- Access

	hash_code: INTEGER
			-- Hash code value.
		do
			if not is_hash_stored then
				stored_hash := ($Current).hash_code
				is_hash_stored := True
			end
			Result := stored_hash
		end

feature {NONE} -- Implementation

	stored_hash: INTEGER
			-- Hash code stored in an attribute.

	is_hash_stored: BOOLEAN
			-- Has `stored_hash' already been computed?

end
