indexing

	description:
		"Queues with a bounded physical size, implemented by arrays";

	status: "See notice at end of class";
	names: dispenser, array;
	representation: array;
	access: fixed, fifo, membership;
	size: fixed;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class BOUNDED_QUEUE [G] inherit

	QUEUE [G]
		redefine
			linear_representation, has
		end;

	BOUNDED [G]
		undefine
			copy, consistent, is_equal, setup
		end;

creation

	make

feature -- Initialization

	make (n: INTEGER) is
			-- Create queue for at most `n' items.
		require
			non_negative_argument: n >= 0
		do
			!!fl.make (0, n);
				-- One entry is kept free (the last one in the list)
		ensure
			capacity_expected: capacity = n
		end;

feature -- Access

	item: G is
			-- Oldest item.
		do
			Result := fl.item (out_index)
		end;

	has (v: like item): BOOLEAN is
			-- Does queue include `v'?
 			-- (Reference or object equality,
			-- based on `object_comparison'.)
		local
			i: INTEGER
		do
			if object_comparison then
				if  v /= Void then
					if out_index > in_index then
						from
							i := out_index
						until
							Result or i > fl.count
						loop
							Result := fl.item (i) /= Void and then v.is_equal (fl.item (i));
							i := i + 1
						end;
						from
							i := 0
						until
							Result or i >= in_index
						loop
							Result := fl.item (i) /= Void and then v.is_equal (fl.item (i));
							i := i + 1
						end
					else
						from
							i := out_index
						until
							Result or i >= in_index
						loop
							Result := fl.item (i) /= Void and then v.is_equal (fl.item (i));
							i := i + 1
						end
					end
				end
			else
				if out_index > in_index then
					from
						i := out_index
					until
						Result or i > fl.count
					loop
						Result := v = fl.item (i);
						i := i + 1
					end;
					from
						i := 0
					until
						Result or i >= in_index
					loop
						Result := v = fl.item (i);
						i := i + 1
					end
				else
					from
						i := out_index
					until
						Result or i >= in_index
					loop
						Result := v = fl.item (i);
						i := i + 1
					end
				end
			end
		end;


feature -- Measurement

	capacity: INTEGER is
			-- Number of items that may be kept.
		do
			Result := fl.capacity - 1
		end;

	count: INTEGER is
			-- Number of items.
		local
			size: INTEGER;
		do
			size := fl.capacity;
			Result := (in_index - out_index + size)\\  size
		end;

feature -- Status report

	off: BOOLEAN is
			-- Is there no current item?
		local
			size: INTEGER;
		do
			if index = in_index then
				Result := true
			else
				size := fl.capacity;
				Result := count <= ((index - out_index + size) \\ size)
				end
		end;

	prunable: BOOLEAN is true;

	resizable: BOOLEAN is true;

	extendible: BOOLEAN is
		do
			Result := not full
		end

feature -- Cursor movement

	start is
			-- Move cursor to first position.
		do
			index := out_index
		end;

	finish is
			-- Move cursor to last position.
		local
			size: INTEGER;
		do
			if empty then
				index := 0
			else
				size := fl.capacity;
				index := (in_index -1 + size) \\ size
			end
		end;

	forth is
			-- Move cursor to next position.
		do
			index := (index + 1) \\ fl.capacity
		end;

feature -- Element change

	extend, force, put (v: G) is
			-- Add `v' as newest element.
		do
			fl.put (v, in_index);
			in_index := (in_index + 1) \\ fl.capacity;
		end;

	replace (v: like item) is
			-- Replace oldest item by `v'.
		do
			fl.put (v, out_index)
		end;

feature -- Removal

	remove is
			-- Remove oldest item.
		do
			out_index := (out_index + 1) \\ fl.capacity;
		end;

	prune (v : like item) is
		do
		end

	wipe_out is
			-- Remove all items.
		do
			out_index := 0;
			in_index := 0;
		end;

feature -- Conversion

	linear_representation: ARRAYED_LIST [G] is
			-- Representation as a linear structure
			-- (in the original insertion order)
		local
			i: INTEGER
		do
			!!Result.make (count);
			if out_index > in_index then
				from
					i := out_index
				until
					i > fl.count
				loop
					Result.extend (fl.item (i));
					i := i + 1
				end;
				from
					i := 1
				until
					i >= in_index
				loop
					Result.extend (fl.item (i));
					i := i + 1
				end
			else
				from
					i := out_index
				until
					i >= in_index
				loop
					Result.extend (fl.item (i));
					i := i + 1
				end
			end
		end;


feature {BOUNDED_QUEUE} -- Implementation

	out_index: INTEGER;
			-- Position of oldest item

	in_index: INTEGER;
			-- Position for next insertion

	index: INTEGER;
			-- Current position

	fl: ARRAY[G]
			-- Storage

feature -- Measurement

	occurrences (v : G):INTEGER is
		do
			if object_comparison then
				fl.compare_objects
			else
				fl.compare_references
			end
			Result := fl.occurrences (v)
		end

invariant

	extendible_definition: extendible = not full

end -- class BOUNDED_QUEUE


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
