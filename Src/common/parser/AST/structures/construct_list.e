indexing
	description: "List used in abstract syntax trees."
	date: "$Date$"
	revision: "$Revision$"

class CONSTRUCT_LIST [T]

inherit
	ARRAYED_LIST [T]
		export
			{ANY} all_default
		end

create
	make

create {CONSTRUCT_LIST}
	make_filled

feature -- Special insertion

	reverse_extend (v: T) is
			-- Add `v' to `Current'
		require
			extendible: extendible
		do
			area.put (v, capacity - count - 1)
			set_count (count + 1)
		end

end
