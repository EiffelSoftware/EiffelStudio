note
	description: "A square matrix."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	SQUARE_MATRIX

inherit
	ANY redefine is_equal end

create
	make_random, duplicate

feature {NONE} -- Initialization

	make_random (a_size: INTEGER)
			-- Initialize `Current' as a new random matrix.
		local
			rand: SIMPLE_RANDOM
			capacity: INTEGER
		do
			from
				size := a_size
				capacity := size*size
				create matrix.make_empty (capacity)
				create rand.make_time
			until
				capacity = 0
			loop
				matrix.extend (rand.new_double)
				capacity := capacity - 1
			end
		end

	duplicate (other: SQUARE_MATRIX)
			-- Initialize `Current' as a copy of 'other'.
		local
			capacity: INTEGER
		do
			size := other.size
			capacity := size*size
			create matrix.make_empty (capacity)

			across
				other.matrix as cursor
			loop
				matrix.extend (cursor.item)
			end
		ensure
			equal: Current ~ other
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := size = other.size and then across matrix as cursor all cursor.item = other.matrix.item (cursor.target_index)  end
		end

feature -- Access

	size: INTEGER

	item (x,y: INTEGER): DOUBLE
			-- Item at position [x,y], zero-indexed.
		require
			x_in_bounds: 0 <= x and x < size
			y_in_bounds: 0 <= y and y < size
		do
			Result := matrix [x*size + y]
		end

feature -- Element change

	put (x,y: INTEGER; val: DOUBLE)
			-- Set the value at position [x,y] to `val' (zero-indexed)
		require
			x_in_bounds: 0 <= x and x < size
			y_in_bounds: 0 <= y and y < size
		do
			matrix [x*size + y] := val
		end

feature {SQUARE_MATRIX} -- Implemetation

	matrix: SPECIAL [DOUBLE]

end
