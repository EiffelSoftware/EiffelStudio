indexing
	description: 
		"Eiffel Vision aggregate widget. WEL implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_AGGREGATE_WIDGET_IMP
	
inherit
	EV_AGGREGATE_WIDGET_I
		redefine
			interface
		select
			interface
		end

	EV_WIDGET_IMP
		undefine
			internal_set_minimum_height,
			internal_set_minimum_width,
			internal_set_minimum_size,
			minimum_height,
			minimum_width,
			disable_sensitive,
			enable_sensitive,
			integrate_changes
		redefine
			interface
		end

	--EV_WIDGET_LIST_IMP
	--	rename
	--		interface as ev_widget_list_interface
	--	undefine
	--		set_default_minimum_size,
	--		enable_sensitive,
	--		disable_sensitive,
	--		client_width,
	--		client_height
	--	end
	
	EV_INVISIBLE_CONTAINER_IMP
		rename
			move as move_to,
			interface as ev_invisible_container_imp_interface
		redefine
			make--,
			--set_focus,
			--has_focus
		end

create
	make

feature -- initialization

	make (an_interface: like interface) is
			-- Connect interface and initialize `c_object'.
		do
			base_make (an_interface)
			create {EV_AGGREGATE_BOX} box
			--| FIXME need to arrange for `box' to appear in current.
			check
				not_implemented: false
			end
		end

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite
		do
			check tbi: false end
		end

	remove_child (child_imp: EV_WIDGET_IMP) is
			-- Remove the given child from the children of
			-- the container.
		do
			check tbi: false end
		end

	item: EV_WIDGET is
		do
			check tbi: false end
		end

feature -- Implementation

	interface: EV_WIDGET
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_AGGREGATE_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2000/02/14 12:05:10  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.3  2000/02/08 07:21:03  brendel
--| Minor changes to run through compiler.
--| Still needs major revision.
--|
--| Revision 1.1.2.2  2000/01/28 19:00:34  oconnor
--| changed to use EV_AGGREGATE_BOX
--|
--| Revision 1.1.2.1  2000/01/28 16:40:35  oconnor
--| initial
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
