indexing
	description: "EiffelVision pixmap container. %
				% Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PIXMAP_CONTAINER_IMP

inherit
	EV_PIXMAP_CONTAINER_I

feature -- Access

	pixmap_imp: EV_PIXMAP_IMP
			-- Implementation of the pixmap contained 

feature -- Status setting

	add_pixmap (pixmap: EV_PIXMAP) is
			-- Add a pixmap in the container
		do
			pixmap_imp ?= pixmap.implementation
			check
				pixmap_set: pixmap_imp /= Void
			end
		ensure then
			pixmap_set: pixmap_imp /= Void
		end

--creation

--	make_from_primitive

--feature {NONE} -- Initialization
	
--	make_from_primitive (primitive: EV_BUTTON) is
--			-- Create pixmap container inside of 'primitive'
--		local
--			primitive_imp: EV_BUTTON_IMP
--		do
--			primitive_imp ?= primitive.implementation
--			check	
--				good_primitive: primitive_imp /= Void
--			end
--			wel_make (primitive_imp)
--		end

feature -- Status setting

--	add_pixmap (pixmap: EV_PIXMAP) is
			-- Add a pixmap in the container.
--		do
--		end

end -- class EV_PIXMAP_CONTAINER_IMP

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
