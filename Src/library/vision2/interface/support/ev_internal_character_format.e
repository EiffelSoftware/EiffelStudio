indexing
	description:
		" EiffelVision internal character format. Internal class%
		% used by the EV_TEXT_FORMAT."		
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_INTERNAL_CHARACTER_FORMAT

creation
	make

feature {NONE} -- Initialization

	make (ft: EV_CHARACTER_FORMAT) is
			-- Create the internal character format with `ft'.
		do
			set_format (ft)
			!! regions.make (2)
		end

feature -- Access

	format: EV_CHARACTER_FORMAT
			-- the format associated to the object.

	regions: ARRAYED_LIST [INTEGER]
			-- The regions with `format'. Folloews the rule:
			-- <<start1, end1,..., startn, endn,...>>


feature -- Status report

	has_position (index: INTEGER): BOOLEAN is
			-- Does the format has the given index?
		do
		end

feature -- Status setting

	append_region (s,e: INTEGER) is
			-- Add the region defineds by its start `s' and its
			-- end `e' to the current regions.
		do
			regions.extend (s)
			regions.extend (s)
		end

feature -- Element change

	set_format (ft: EV_CHARACTER_FORMAT) is
			-- Make `ft' the new format.
		require
			valid_format: ft /= Void
		do
			format := ft
		end

	set_regions (values: ARRAY [INTEGER]) is
			-- Make `regions' the new regions of the format.
			-- `regions' is split between starts and ends.
		require
			valid_regions: values /= Void
			coherent_regions: (values.count \\ 2) = 0
		do
			regions ?= values.linear_representation
		end

feature -- Basic operation

	apply (text: EV_RICH_TEXT) is
			-- Apply the current format to the given `text'.
		local
			r: ARRAYED_LIST [INTEGER]
			i: INTEGER
		do
			r := regions
			from
				r.start
			until
				r.after
			loop
				i := r.item
				r.forth
				text.select_region (i, r.item)
				text.set_character_format (format)
				r.forth
			end
		end

invariant
	valid_regions: regions /= Void
	coherent_regions: (regions.count \\ 2) = 0

end -- class EV_INTERNAL_CHARACTER_FORMAT

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
