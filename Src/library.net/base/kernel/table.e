indexing
	external_name: "ISE.Base.Table"

deferred class TABLE [G, H] inherit

feature -- Access

	item, infix "@" (k: H): G is
			-- Entry of key `k'.
		require
			valid_key: valid_key (k)
		deferred
		end;

feature -- Status report

	valid_key (k: H): BOOLEAN is
			-- Is `k' a valid key?
		deferred
		end

feature -- Element change

	put (v: G; k: H) is
			-- Associate value `v' with key `k'.
		require
			valid_key: valid_key (k)
		deferred
		end

end -- class TABLE



