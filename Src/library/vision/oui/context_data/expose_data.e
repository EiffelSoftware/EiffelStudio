indexing

	description:
		"Information given by EiffelVision when a part of a window becomes %
		%visible. %
		%X event associated: `Expose'. Raised by `expose action' too";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	EXPOSE_DATA 

inherit

	CONTEXT_DATA
		rename
			make as context_data_make
		end

creation

	make

feature -- Initialization

	make (a_widget: WIDGET; a_clip: CLIP; expose_count: INTEGER) is
			-- Create a context_data for `Expose' event.
		do
			widget := a_widget;
			clip := a_clip;
			exposes_to_come := expose_count;
		end

feature -- Access

	clip: CLIP;
			-- Exposed region

	exposes_to_come: INTEGER
			-- Number of expose events to come

end -- class EXPOSE_DATA



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

