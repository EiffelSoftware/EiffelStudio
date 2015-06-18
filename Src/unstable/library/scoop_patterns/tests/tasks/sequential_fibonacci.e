note
	description: "Summary description for {SEQUENTIAL_FIBONACCI}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SEQUENTIAL_FIBONACCI

inherit
	CP_COMPUTATION [INTEGER_64]

create
	make, make_from_separate

feature {NONE} -- Initialization

	make (a_input: INTEGER_64)
			-- Initialize `Current' with `a_input'.
		require
			positive: a_input > 0
		do
			input := a_input
		end

feature {CP_DYNAMIC_TYPE_IMPORTER} -- Initialization

	make_from_separate (other: separate like Current)
			-- <Precursor>
		do
			input := other.input
			promise := other.promise
		end

feature -- Access

	input: INTEGER_64

feature -- Basic operations

	computed: INTEGER_64
			-- <Precursor>
		local
			i, last, tmp: INTEGER_64
		do
			from
				i := 3
				last := 1
				Result := 1
			until
				i > input
			loop
				tmp := Result
				Result := Result + last
				last := tmp
				i := i + 1
			end
		end

end
