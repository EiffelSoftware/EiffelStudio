indexing

	description: 
		"EiffelVision box, deferred class, parent of vertical and%
		 %horizontal boxes. Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_BOX_IMP

inherit

	EV_BOX_I

	EV_INVISIBLE_CONTAINER_IMP
		redefine
			parent_ask_resize,
			set_width,
			set_height,
			set_move_and_size
		end

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
				-- Create the box with the default options.
		local
			par_imp: EV_CONTAINER_IMP
		do
			par_imp ?= par.implementation
			check
				parent_not_void: par_imp /= Void
			end
			wel_make (par_imp, "Box")
			initialize
			is_homogeneous := True --Default_homogeneous
			spacing := 0 --Default spacing
		end


feature {EV_BOX_IMP} -- Access

	is_homogeneous: BOOLEAN
			-- Must the children have the same size ?

	spacing: INTEGER
			-- Space between the objects in the box

	total_spacing: INTEGER is
			-- Total space occupied by spacing.
			-- There is (spacing//2) on the left and on on the
			-- right of the box.
		do
			Result := spacing * children.count
		end

	
feature -- Status setting (box specific)

	set_homogeneous (flag: BOOLEAN) is
			-- set `is_homogeneous' to `flag'.
			-- Need to be resized
		do
			is_homogeneous := flag
--			if not children.empty then
--				child_has_resized (0,0, children.first)
--			end
--			set_minimum_size
		end

	set_spacing (value: INTEGER) is
			-- Make `value' the new spacing of the box.
		do
			spacing := value
		end

feature -- Resizing

	set_width (new_width: INTEGER) is
		do
			set_local_width (new_width)
			parent_imp.child_width_changed (width, Current)
		end

	set_height (new_height: INTEGER) is
		do
			set_local_height (new_height)
			parent_imp.child_height_changed (height, Current)
		end

feature {NONE} -- Basic operation

	set_local_width (new_width: INTEGER) is
		deferred
		end

	set_local_height (new_height: INTEGER) is
		deferred
		end

feature {NONE} -- Implementation

--	remove_child (child_imp: EV_WIDGET_IMP) is
			-- Remove a given child of the composite
--		do
--			children.go_i_th (children.index_of (child_imp,1))
--			children.remove
--			set_minimum (fonction a rajouter qui recherche le minimum des tailles des enfants)
--			parent_ask_resize (minimum_width, minimum_height)
--		end

	parent_ask_resize (new_box_width, new_box_height: INTEGER) is
			-- Resize the box and all the children inside
		do
			if new_box_width /= width then
				set_local_width (new_box_width)
			end
			if new_box_height /= height then
				set_local_height (new_box_height)
			end
		end

	set_move_and_size (a_x, a_y, a_width, a_height: INTEGER) is
			-- Move and resize the componant in the same time.
			-- Don't notice the parent of the change.
		do
			parent_ask_resize (a_width, a_height)
			set_x_y (a_x, a_y)
		end

end -- class EV_BOX_IMP

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

