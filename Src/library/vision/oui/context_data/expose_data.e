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
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

