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
			count := n
		ensure
			size_set: count = n
		end

feature -- Access

	count: INTEGER
			-- Allocated count of the C character array `area'.

feature -- Store

	store (file: RAW_FILE) is
			-- Store C array in `file'.
		require
			good_argument: file /= Void
			is_open_write: file.is_open_write
		do
			internal_store (area, count, file)
		end

feature -- Resizing

	resize (n: INTEGER) is
			-- Reallocation for `n' characters
		require
			valid_n: n >= 0 and n > count
		local
			old_area: like area
		do
			old_area := area
			make_area (n)
			internal_copy (old_area, area, count, 0)
			count := n
		ensure
			good_size: count = n
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
				i >= count
			loop
				io.error.putint (i)
				io.error.putstring (": ")
				io.error.putchar (item (i))
				io.error.new_line
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	internal_store (an_area: like area; nb_items: INTEGER; a_file: FILE) is
			-- Store first `nb_items' of `an_area' into `a_file'.
		require
			an_area_not_void: an_area /= Void
			valid_nb_items: nb_items >= 0
			size_compatible_with_area: an_area.count >= nb_items
			good_argument: a_file /= Void
			is_open_write: a_file.is_open_write
		do
			ca_store ($an_area, nb_items, a_file.file_pointer)
		end

	internal_copy (a_source, a_target: like area; nb_items, pos: INTEGER) is
			-- Copy first `nb_items' of `a_source' area into `a_target'
			-- area starting at index `pos'.
		require
			a_source_not_void: a_source /= Void
			a_target_not_void: a_target /= Void
			valid_nb_items: nb_items >= 0
			valid_pos: pos >= 0
			nb_items_compatible_with_source: a_source.count >= nb_items
			nb_items_compatible_with_target: a_target.count >= nb_items + pos
		do
			($a_target + pos).memory_copy ($a_source, nb_items)
		end

feature {NONE} -- External features

	ca_store (ptr: POINTER; siz: INTEGER; fil: POINTER) is
		external
			"C"
		end

invariant
	area_exists: area /= Void

end -- class CHARACTER_ARRAY
