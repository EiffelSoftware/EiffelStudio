indexing

	description:
		"Widget: Bulletin dialog.%
		%Area for free-form placement on any of its children.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class EB_BULLETIN_D 

inherit

	BULLETIN_D
		redefine
			make, set_size, set_height, set_width
		end

	COMMAND

	SCALABLE

creation

	make

feature 

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			{BULLETIN_D} Precursor (a_name, a_parent)
			forbid_recompute_size
			!!widget_coordinates.make
				-- Callback
			set_parent_action ("<Configure>", Current, Current)
		end

feature 

	set_width (new_width: INTEGER) is
			-- Set width to `new_width'.
		do	
			{BULLETIN_D} Precursor (new_width)
			if old_width = 0 then
				old_width := width
			end
		end

	set_height (new_height: INTEGER) is
			-- Set height to `new_height'.
		do	
			{BULLETIN_D} Precursor (new_height)
			if old_height = 0 then
				old_height := height
			end
		end

	set_size (new_width, new_height: INTEGER) is
			-- Set width and height to `new_width'
			-- and `new_height'.
		do	
			{BULLETIN_D} Precursor (new_width, new_height)
			if old_width = 0 then
				old_width := width
			end
			if old_height = 0 then
				old_height := height
			end
		end

end

--|----------------------------------------------------------------
--| EiffelBuild library.
--| Copyright (C) 1995 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
