indexing
	description: "EiffelVision fixed container. Allows several children that%
				  % must be place in one's hand. Mswindows implementation"
	note: "We use `create with coordinates' to allow the notebook%
		% as containers. They are wel_windows and not%
		% wel_composite_windows."
	author: "Leila"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIXED_IMP

inherit
	EV_FIXED_I

	EV_INVISIBLE_CONTAINER_IMP
		redefine
			make,
			child_minwidth_changed,
			child_minheight_changed
		end
		
creation
	make

feature {NONE} -- Initialization

	make is
			-- Create the fixed container in  ev_window.
		do
			{EV_INVISIBLE_CONTAINER_IMP} Precursor
			!! ev_children.make (2)
			set_text ("EV_FIXED")
		end

feature -- Element change

	add_child (child_imp: EV_WIDGET_IMP) is
		do
			ev_children.extend (child_imp)
		end

	remove_child (child_imp: EV_WIDGET_IMP) is
			-- Remove the given child from the children of
			-- the container.
		do
			ev_children.prune_all (child_imp)
		end

feature {NONE} -- Implementation

	child_minwidth_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the minimum width of the container because
			-- the child changed his own minimum width.
		do
			check
				Do_nothing_here: True
			end
		end

	child_minheight_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the minimum width of the container because
			-- the child changed his own minimum width.
		do
			check
				Do_nothing_here: True
			end
		end

	update_display is
			-- Update the display of the children in the container.
		do
			check
				Do_nothing_here: True
			end
		end

end -- class EV_FIXED_IMP

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
