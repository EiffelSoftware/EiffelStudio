indexing
	description: "HASH_TABLE in configuration with different is_equal that checks the values."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_HASH_TABLE [G, H -> HASHABLE]

inherit
	HASH_TABLE [G, H]
		redefine
			is_equal
		end

create
	make

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Does table contain the same information as `other'?
		local
			a, b: like Current
		do
			a := Current
			b := other

			from
				Result := a.count = b.count
				a.start
			until
				not Result or a.after
			loop
				Result := equal (a.item_for_iteration, b.item (a.key_for_iteration))
				a.forth
			end
		end


end
