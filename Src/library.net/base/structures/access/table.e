indexing
	description: "Containers whose items are accessible through keys"
	class_type: Interface
	external_name: "ISE.Base.Table"

deferred class 
	TABLE [G, H]

feature -- Access

	item (k: H): G is
		indexing
			description: "Entry of key `k'."
		require
			valid_key: valid_key (k)
		deferred
		end

	infix "@" (k: H): G is
		indexing
			description: "Entry of key `k'."
		require
			valid_key: valid_key (k)
		deferred
		end
		
feature -- Status report

	valid_key (k: H): BOOLEAN is
		indexing
			description: "Is `k' a valid key?"
		deferred
		end

feature -- Element change

	put (v: G; k: H) is
		indexing
			description: "Associate value `v' with key `k'."
		require
			valid_key: valid_key (k)
		deferred
		end

end -- class TABLE



