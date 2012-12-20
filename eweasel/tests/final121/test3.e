deferred class
	TEST3 [G, H]

feature -- Access

	item alias "[]" (k: H): G assign force
		deferred
		end

feature -- Element change

	put (v: G; k: H)
		deferred
		end

	force (v: G; k: H)
		deferred
		end

end
	
