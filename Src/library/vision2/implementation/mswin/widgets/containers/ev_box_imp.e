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
		end


feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
				-- Create the box
		local
			cont_imp: EV_CONTAINER_IMP
		do
			cont_imp ?= par.implementation
			check
				valid_container: cont_imp /= Void
			end
			!! wel_window.make_with_coordinates (cont_imp.wel_window, "", 0, 0, 0, 0)
			!! children.make

			is_homogeneous := Default_homogeneous
			spacing := Default_spacing
		end


feature {NONE} -- Implementation

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite at the level position.
		local
			box_child: EV_BOX_CHILD
		do
			child_imp.set_parent_imp (Current)
			!! box_child.make (child_imp, Current)
			children.extend (box_child)
			set_total_children_padding
			set_total_spacing
			if child_imp.width /= 0 or child_imp.height /= 0 then
				child_has_resized (child_imp.width, child_imp.height, child_imp)
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


feature -- Element change (box specific)

	set_homogeneous (homogeneous: BOOLEAN) is
			-- set `is_homogeneous' to `homogeneous'
			-- and tell the box that a child has resized to
			-- refresh the display of the container
		do
			is_homogeneous := homogeneous
			if not children.empty then
				child_has_resized (0, 0, children.first.widget)
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
				child_has_resized (0, 0, children.first.widget)
			end
		end


	set_total_spacing is
			-- set `total_spacing' to the proper value
		do
			total_spacing := spacing * (children.count - 1)
		end


	set_total_children_padding is
			-- set `total_children_padding' to the proper value
		local
			temp_result: INTEGER
		do
			if not children.empty then
				from
					children.start
				until
					children.after
				loop
					temp_result := temp_result + 2 * children.item.padding   -- left and right
					children.forth 
				end
			end
			total_children_padding := temp_result
		end


feature {EV_BOX_IMP} -- Access

	is_homogeneous: BOOLEAN
			-- Must the children have the same size ?

	spacing: INTEGER
			-- Space between the objects in the box

	total_spacing: INTEGER
			-- Total space occupied by spacing

	children: LINKED_LIST [EV_BOX_CHILD]
			-- List of the children of the box

	total_children_padding: INTEGER
			-- Total space occupied by the padding of the children

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
