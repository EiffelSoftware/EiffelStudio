indexing

	description:
		"Unbounded queues, implemented by resizable arrays";

	status: "See notice at end of class";
	names: dispenser, array;
	representation: array;
	access: fixed, fifo, membership;
	size: fixed;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class ARRAYED_QUEUE [G] inherit

	QUEUE [G]
		undefine
			copy, is_equal,
			consistent, setup, prune_all
		redefine
			linear_representation, has, empty
		select
			count, empty, put
		end;

	ARRAY [G]
		rename
			count as array_count,
			force as force_i_th,
			item as i_th,
			make as array_make,
			put as put_i_th,
			grow as array_grow,
			empty as array_empty
		export
			{NONE}
				all;
		redefine
			wipe_out, extend, prunable,
			linear_representation,
			has, full, extendible
		end

creation

	make

feature -- Initialization

	make (n: INTEGER) is
			-- Create queue for at most `n' items.
		require
			non_negative_argument: n >= 0
		do
			array_make (1, n);
			in_index := 1;
			out_index := 1
				-- One entry is kept free
		ensure
			capacity_expected: capacity = n
		end;

feature -- Access

	item: G is
			-- Oldest item.
		do
			Result := i_th (out_index)
		end;

	has (v: like item): BOOLEAN is
			-- Does queue include `v'?
 			-- (Reference or object equality,
			-- based on `object_comparison'.)
		local
			i: INTEGER
		do
			if object_comparison then
				if v /= Void then
					from
						i := out_index
					until
						i = in_index or (i_th (i) /= Void and then v.is_equal (i_th (i)))
					loop
						i := i + 1;
						if i > capacity then
							i := 1
						end;
					end
				end
			else
				from
					i := out_index
				until
					i = in_index or v = i_th (i)
				loop
					i := i + 1;
					if i > capacity then
						i := 1
					end;
				end
			end;
			Result := (i /= in_index)
		end;

feature -- Measurement

	count: INTEGER is
			-- Number of items.
		do
			if capacity > 0 then
				Result := (in_index - out_index + capacity) \\ capacity
			end
		end;

feature -- Status report

	empty, off: BOOLEAN is
			-- Is the structure empty?
		do
			Result :=in_index = out_index
		end;

	full: BOOLEAN is
			-- Is structure filled to capacity?
			-- (Answer: no.)
		do
			Result := False
		end;

	extendible: BOOLEAN is
			-- May items be added? (Answer: yes.)
		do
			Result := true
		end;

	prunable: BOOLEAN is
			-- May items be removed? (Answer: yes.)
		do
			Result := true
		end;

feature -- Element change

	extend, put, force (v: G) is
			-- Add `v' as newest item.
		do
			if count + 1 >= array_count then grow end;
			put_i_th (v, in_index);
			in_index := (in_index + 1) \\ capacity;
			if in_index = 0 then in_index := capacity end;
		end;

	replace (v: like item) is
			-- Replace oldest item by `v'.
		do
			put_i_th (v, out_index)
		end;

feature -- Removal

	remove is
			-- Remove oldest item.
		local
			default_value: G;
		do
			put_i_th (default_value, out_index);
			out_index := (out_index + 1) \\ capacity;
			if out_index = 0 then out_index := capacity end;
		end;

	wipe_out is
			-- Remove all items.
		do
			clear_all;
			out_index := 1;
			in_index := 1;
		end;

feature -- Conversion

	linear_representation: ARRAYED_LIST [G] is
			-- Representation as a linear structure
			-- (in the original insertion order)
		local
			i: INTEGER;
		do
			!!Result.make (count);
			from
				i := out_index
			until
				i = in_index
			loop
				Result.extend (i_th (i));
				i := i + 1;
				if i > capacity then i := 1 end
			end;
			i := 1
		end;

feature {NONE} -- Inapplicable

	start is
			-- Move cursor to first position.
		do
		end;

	finish is
			-- Move cursor to last position.
		local
			size: INTEGER;
		do
		end;

	forth is
			-- Move cursor to next position.
		do
		end;

feature {ARRAYED_QUEUE} -- Implementation

	out_index: INTEGER;
			-- Position of oldest item

	in_index: INTEGER;
			-- Position for next insertion

	grow is
		local
			i,j: INTEGER;
			old_count: INTEGER;
			default_value: G
		do
			i := array_count;
			resize (1, capacity + additional_space);
			if out_index > 1 then
				from
					j := capacity
				until
					i < out_index
				loop
					put_i_th (i_th (i), j);
					put_i_th (default_value, i);
					i := i - 1;
					j := j - 1
				end;
				out_index := j + 1;
			end;
		end;

invariant

	not_full: not full;
	extendible: extendible;
	prunable: prunable;

end -- class ARRAYED_QUEUE


--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

