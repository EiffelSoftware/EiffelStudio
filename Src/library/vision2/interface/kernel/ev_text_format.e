indexing
	description:
		" EiffelVision text format. Contains information about%
		% the formatting of a text in a EV_RICH_TEXT."
	note: " For now, the text format only use the%
		% EV_CHARACTER_FORMAT, but as soon as the gtk library%
		% offers more possibilities on the formating of paragraph,%
		% the same functions than the one present here should be%
		% added for the paragraph formating with EV_PARAGRAPH_FORMAT."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT_FORMAT

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create a text format object.
		do
			!! character_format_list.make (2)
		end

feature -- Access

	character_formats: LINKED_LIST [EV_CHARACTER_FORMAT] is
			-- Character formats present in the text
		local
			list: ARRAYED_LIST [EV_INTERNAL_CHARACTER_FORMAT]
		do
			from
				Result.make
				list := character_format_list
				list.start
			until
				list.after
			loop
				Result.extend (list.item.format)
				list.forth
			end
		end
		
feature -- Status setting

	set_regions_for_character_format (ft: EV_CHARACTER_FORMAT;
					regions: ARRAY [INTEGER]) is
			-- Make the given regions the only ones of the text
			-- where `format' is used.
			-- regions follow the rules :
			-- <<start1, end1,..., startn, endn,...>>
		require
			valid_format: ft /= Void
			has_character_format: has_character_format (ft)
			valid_regions: regions /= Void
			coherent_regions: (regions.count \\ 2) = 0
		local
			internal: EV_INTERNAL_CHARACTER_FORMAT
		do
			internal := find_character_format (ft)
			internal.set_regions (regions)			
		end

	add_region_for_character_format (ft: EV_CHARACTER_FORMAT;
					start, finish: INTEGER) is
			-- Add the given region to the list of region where
			-- `format' is used.
		require
			valid_format: ft /= Void
			has_character_format: has_character_format (ft)
		local
			internal: EV_INTERNAL_CHARACTER_FORMAT
		do
			internal := find_character_format (ft)
			internal.append_region (start, finish)
		end

feature -- Element change

	add_character_format (ft: EV_CHARACTER_FORMAT) is
			-- Add `ft' to the list of format present in the text.
		require
			valid_format: ft /= Void
		local
			internal: EV_INTERNAL_CHARACTER_FORMAT
		do
			!! internal.make (ft)
			character_format_list.extend (internal)
		end

	add_character_format_with_regions (ft: EV_CHARACTER_FORMAT;
				regions: ARRAY [INTEGER]) is
			-- Add `ft' to the list of format and make `regions'
			-- the new regions of this format.
		require
			valid_format: ft /= Void
			valid_regions: regions /= Void
			coherent_regions: (regions.count \\ 2) = 0
		local
			internal: EV_INTERNAL_CHARACTER_FORMAT
		do
			!! internal.make (ft)
			internal.set_regions (regions)
			character_format_list.extend (internal)
		end

feature -- Assertion feature

	has_character_format (ft: EV_CHARACTER_FORMAT): BOOLEAN is
			-- Does `ft' belongs to the current format.
		do
			Result := find_character_format (ft) /= Void
		end

feature {EV_RICH_TEXT_IMP} -- Basic_operation

	apply (text: EV_RICH_TEXT) is
			-- Apply the current format to the given `text'.
		local
			list: ARRAYED_LIST [EV_INTERNAL_CHARACTER_FORMAT]
		do
			from
				list := character_format_list
				list.start
			until
				list.after
			loop
				list.item.apply (text)
				list.forth
			end
			text.deselect_all
		end

feature {NONE} -- Implementation

	character_format_list: ARRAYED_LIST [EV_INTERNAL_CHARACTER_FORMAT]
			-- A list for the different character formats of
			-- the text.

	find_character_format (ft: EV_CHARACTER_FORMAT): EV_INTERNAL_CHARACTER_FORMAT is
			-- Find `ft' in the list and send back the index.
		local
			list: ARRAYED_LIST [EV_INTERNAL_CHARACTER_FORMAT]
		do
			from
				list := character_format_list
				list.start
			until
				Result /= Void or else list.after
			loop
				if list.item.format = ft then
					Result := list.item
				end
				list.forth
			end
		end

invariant
	valid_character_list: character_format_list /= Void

end -- class EV_TEXT_FORMAT

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
