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

create

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
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

