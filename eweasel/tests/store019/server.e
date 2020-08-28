class
	SERVER [H -> HASHABLE, G -> HASHABLE]

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
			-- <precursor>
			-- Create entries.
		do
			create entries.make (5)
		end

	entries: attached HASH_TABLE [ARRAYED_LIST [H], G]

end
