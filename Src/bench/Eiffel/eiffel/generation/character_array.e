indexing
	description: "Array of character used for storing interpreted datas."
	date: "$Date$"
	revision: "$Revision$"

class CHARACTER_ARRAY 

inherit
	TO_SPECIAL [CHARACTER]
		export
			{CHARACTER_ARRAY} area
		end

creation
	make

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Allocate `n' characters
		require
			valid_n: n >= 0
		do
			make_area (n)
			size := n
		ensure
			size_set: size = n
		end

feature -- Access

	size: INTEGER
			-- Allocated size of the C character array `area'.

feature -- Store

	store (file: RAW_FILE) is
			-- Store C array in `file'.
		require
			good_argument: file /= Void
			is_open_write: file.is_open_write
		do
			ca_store ($area, size, file.file_pointer)
		end

feature -- Resizing

	resize (n: INTEGER) is
			-- Reallocation for `n' characters
		local
			old_area: like area
		do
			old_area := area
			make_area (n)
			ca_copy ($old_area, $area, size, 0)
			size := n
		ensure
			good_size: size = n
		end

feature -- Debug

	trace is
			-- Debug purpose
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i >= size
			loop
				io.error.putint (i)
				io.error.putstring (": ")
				io.error.putchar (item (i))
				io.error.new_line
				i := i + 1
			end
		end

feature {NONE} -- External features

	ca_store (ptr: POINTER; siz: INTEGER; fil: POINTER) is
		external
			"C"
		end

	ca_copy (fr, to: POINTER; nb_items, at: INTEGER) is
		external
			"C"
		end

invariant
	area_exists: area /= Void

end -- class CHARACTER_ARRAY
