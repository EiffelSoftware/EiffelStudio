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
		undefine
			add_child
		redefine
			parent_ask_resize,
			set_width,
			set_height
		end


feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
				-- Create the box with the default options.
		local
			cont_imp: EV_CONTAINER_IMP
		do
			cont_imp ?= par.implementation
			check
				valid_container: cont_imp /= Void
			end
			!! wel_window.make (cont_imp.wel_window, "")
			!! children.make
			is_homogeneous := True -- Default_homogeneous
			spacing := 0 -- Default spacing
		end


feature {EV_BOX_IMP} -- Access

	is_homogeneous: BOOLEAN
			-- Must the children have the same size ?

	spacing: INTEGER
			-- Space between the objects in the box

	total_spacing: INTEGER
			-- Total space occupied by spacing

	children: LINKED_LIST [EV_WIDGET_IMP]
			-- List of the children of the box


feature -- Status setting (box specific)

	set_homogeneous (homogeneous: BOOLEAN) is
			-- set `is_homogeneous' to `homogeneous'
			-- and tell the box that a child has resized to
			-- refresh the display of the container
		do
			is_homogeneous := homogeneous
			if not children.empty then
				child_has_resized (0, 0, children.first)
			end
		end

	set_spacing (new_spacing: INTEGER) is
			-- set `spacing' to `new_spacing'
			-- and tell the box that a child has resized to
			-- refresh the display of the container
		do
			spacing := new_spacing
			set_total_spacing
			if not children.empty then
				child_has_resized (0, 0, children.first)
			end
		end

	set_total_spacing is
			-- set `total_spacing' to the proper value
		do
			total_spacing := spacing * (children.count - 1)
		end


feature {NONE} -- Basic operation

	set_local_width (new_width: INTEGER) is
		deferred
		end

	set_local_height (new_height: INTEGER) is
		deferred
		end


feature {NONE} -- Implementation

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite at the level position.
		do
			child_imp.set_parent_imp (Current)
			children.extend (child_imp)
			set_total_spacing
			if child_imp.width /= 0 or child_imp.height /= 0 then
				child_has_resized (child_imp.width, child_imp.height, child_imp)
				child_minwidth_changed (child_imp.minimum_width)
				child_minheight_changed (child_imp.minimum_height)
			end
		end

--	remove_child (child_imp: EV_WIDGET_IMP) is
			-- Remove a given child of the composite
--		do
--			children.go_i_th (children.index_of (child_imp,1))
--			children.remove
--			set_minimum (fonction a rajouter qui recherche le minimum des tailles des enfants)
--			parent_ask_resize (minimum_width, minimum_height)
--		end


	parent_ask_resize (new_box_width:INTEGER; new_box_height: INTEGER) is
			-- Resize the box and all the children inside
		do
			if new_box_width /= width then
				set_local_width (new_box_width)
			end
			if new_box_height /= height then
				set_local_height (new_box_height)
			end
		end

	set_width (new_width: INTEGER) is
		do
			set_local_width (new_width)
			if parent_imp /= Void then
				parent_imp.child_has_resized (width, height, Current)
			end
		end

	set_height (new_height: INTEGER) is
		do
			set_local_height (new_height)
			if parent_imp /= Void then
				parent_imp.child_has_resized (width, height, Current)
			end
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
