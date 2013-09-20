note
	description: "Summary description for {CHAIN_TAIL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CHAIN_TAIL

create
	make

feature {NONE} -- Initialization

	make (lvl: INTEGER)
			-- Initialization for `Current'.
		do
			level := lvl
		end

feature

	level: INTEGER

	next: CHAIN_TAIL
		require
			not last
		do
			check attached internal_next as res then
				Result := res
			end
		end

	last: BOOLEAN
		do
			Result := internal_next = Void
		end

	set_tail (t: CHAIN_TAIL)
		do
			internal_next := t
		end

	increment
		do
			level := level + 1
		end

feature {NONE}

	internal_next: detachable CHAIN_TAIL

end
