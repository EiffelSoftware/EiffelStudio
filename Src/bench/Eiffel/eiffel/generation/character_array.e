-- Array of character used for storing interpreted datas

class CHARACTER_ARRAY 

inherit

	TO_SPECIAL [CHARACTER]
		export
			{CHARACTER_ARRAY} area
		end;

creation

	make
	
feature 

	size: INTEGER;
			-- Allocated size of the C character array `area'.

	set_size (i: INTEGER) is
			-- Assign `i' to `size'.
		do
			size := i;
		end;

	make (n: INTEGER) is
			-- Allocate `n' characters
		do
			make_area (n);
			size := n;
		ensure
			good_size: size = n;
		end;

	resize (n: INTEGER) is
			-- Reallocation for `n' characters
		local
			old_area: like area;
		do
			old_area := area;
			make_area (n);
			ca_copy ($old_area, $area, size, 0);
			size := n;
		ensure
			good_size: size = n;
		end;

	put (c: CHARACTER; i: INTEGER) is
			-- Put `c' at position `i'.
		require
			index_small_enough: i <= size;
			index_large_enough: i > 0;
		do
			ca_put ($area, c, i - 1);
		ensure
			good_item: item (i) = c
		end;

	item (i: INTEGER): CHARACTER is
			-- Character at position `i'.
		require
            index_small_enough: i <= size;
            index_large_enough: i > 0;
		do
			Result := ca_item ($area, i - 1);
		end;
		
	store (file: RAW_FILE) is
			-- Store C array in `file'.
		require
			good_argument: file /= Void;
			is_open_write: file.is_open_write;
		do
			ca_store ($area, size, file.file_pointer);
		end; -- store

	trace is
			-- Debug purpose
		local
			i: INTEGER;
		do
			from
				i := 1
			until
				i > size
			loop
				io.error.putint (i - 1);
				io.error.putstring (": ");
				io.error.putchar (item (i));
				io.error.new_line;
				i := i + 1
			end;
		end;

feature {NONE} -- External features

	ca_store (ptr: ANY; siz: INTEGER; fil: POINTER) is
		external
			"C"
		end;

	ca_item (ptr: like area; i: INTEGER): CHARACTER is
		external
			"C"
		end;

	ca_put (ptr: like area; val: CHARACTER; i: INTEGER) is
		external
			"C"
		end;

	ca_copy (fr, to: like area; nb_items, at: INTEGER) is
		external
			"C"
		end;

invariant

	area_exists: area /= Void

end
