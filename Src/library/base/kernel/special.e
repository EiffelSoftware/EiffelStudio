--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------


-- Redefining  'ANY' conformance features

indexing

	date: "$Date$";
	revision: "$Revision$"

class SPECIAL [T]

inherit

	ANY
		redefine
			conforms_to,
			c_standard_clone, c_standard_is_equal, c_standard_copy
		end

feature -- Access

	item (i: INTEGER): T is
			-- Item at `i' th position
			-- Index begins at 0
		require
			index_big_enough: i >= 0;
			index_small_enough: i < count
		do
			-- Built-in
		end;

	conforms_to (other: SPECIAL [T]): BOOLEAN is
			-- Does other special object conform to `other' ?
		do
			Result := other.count = count
		end;


feature -- Measurement

	count: INTEGER is
			-- Count of the special area
		do
			Result := sp_count ($Current);
		end;



feature -- Modification & Insertion

	put (v: T; i: INTEGER) is
			-- Put item `v' at position `i'.
		require
			index_big_enough: i >= 0;
			index_small_enough: i < count
		do
			-- Built-in
		end;

feature  {NONE} -- External, Measurement

	sp_count (sp_obj: SPECIAL [T]): INTEGER is
			-- Count of the special object
		external
			"C"
		end;



feature  {NONE} -- External, Comparison

	c_standard_is_equal (source, target: SPECIAL [T]): BOOLEAN is
			-- Is `source' equal to `target' ?
			-- Returns True if `source' and `target' have the same count
			-- and the same entries.
		external
			"C"
		alias
			"spequal"
		end;

feature  {NONE} -- External, Duplication

	c_standard_copy (source, target: SPECIAL [T]) is
			-- Copy entries of `target' into `source'.
		external
			"C"
		alias
			"spcopy"
		end;



	c_standard_clone (other: SPECIAL [T]): SPECIAL [T] is
            -- New special object of size `count'
        external
            "C"
        alias
            "spclone"
        end




end -- class SPECIAL
