note
	description: "Closed integer intervals."
	author: "Nadia Polikarpova"
	theory: "set.bpl"
	maps_to: "Interval"

class
	MML_INTERVAL

inherit
	MML_SET [INTEGER]

create
	from_range

feature {NONE} -- Initialization

	from_range (l, u: INTEGER)
			-- Create interval [l, u].
		do
		end

end
