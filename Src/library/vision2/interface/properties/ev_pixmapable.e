indexing

	description: 
		"EiffelVision pixmap container. Pixmap container is used internally in EiffelVision (by EV_BUTTON and EV_MENU_ITEM to allow a EV_PIXMAP to be put inside it)."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 

	EV_PIXMAP_CONTAINER

inherit

--	EV_CONTAINER
--		redefine
--			implementation
--		end
	
--creation	

--	make_from_primitive

feature {NONE} -- Initialization
	
--	make (par: EV_CONTAINER) is
--		do
--			check
--				do_not_call: False
--			end
--		end

--	make_from_primitive (primitive: EV_BUTTON) is
--			-- Create pixmap container inside of 'primitive'
--		do
--			!EV_PIXMAP_CONTAINER_IMP!implementation.make_from_primitive (primitive)
--		end

--feature {EV_PIXMAP} -- Implementation

--	add_pixmap (pixmap: EV_PIXMAP) is
			-- Add a pixmap in the container.
--		deferred
--		end
	
feature -- Implementation
	
	implementation: EV_PIXMAP_CONTAINER_I
			
end -- class EV_PIXMAP_CONTAINER

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
