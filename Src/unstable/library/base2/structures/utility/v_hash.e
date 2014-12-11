note
	description: "[
		Internal hash code of a HASHABLE as a one argument function.
		Hash code of Void is taken to be 0.
		]"
	author: "Nadia Polikarpova"

class
	V_HASH [G -> detachable HASHABLE]

feature -- Basic operations

	hash_code (x: G): INTEGER
			-- Hash code of `x'.
		do
			if x /= Void then
				Result := x.hash_code
			end
		ensure
			definition_non_void: x /= Void implies Result = x.hash_code
			definition_void: x = Void implies Result = 0
		end
end
