indexing
	description: 
		"EiffelVision box, deferred class, parent of vertical and%
		%horizontal boxes. Mswindows implementation."
	note: "We use `create with coordinates' to allow the notebook%
		% as containers. They are wel_windows and not%
		% wel_composite_windows."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_BOX_IMP

inherit
	EV_BOX_I
		redefine
			child_add_successful
		end

	EV_INVISIBLE_CONTAINER_IMP
		undefine
			parent_ask_resize
		redefine
			set_width,
			set_height,
			child_add_successful,
			on_first_display,
			client_width,
			client_height
		end

feature -- Access

	client_width: INTEGER is
			-- Width of the client area of container
		do
			Result := (client_rect.width - 2 * border_width).max (0)
		end
	
	client_height: INTEGER is
			-- Height of the client area of container
		do
			Result := (client_rect.height  - 2 * border_width).max (0)
		end

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
				-- Create the box with the default options.
		local
			par_imp: WEL_WINDOW
		do
			par_imp ?= par.implementation
			check
				parent_not_void: par_imp /= Void
			end
			make_with_coordinates (par_imp, "Box", 0, 0, 0, 0)
			initialize
			is_homogeneous := Default_homogeneous
			spacing := Default_spacing
		end

feature -- Access

	is_homogeneous: BOOLEAN
			-- Must the children have the same size ?

	spacing: INTEGER
			-- Space between the objects in the box

	border_width: INTEGER
			-- Border width around container

	total_spacing: INTEGER is
			-- Total space occupied by spacing. One spacing
			-- between two consecutives children.
		do
			Result := spacing * ( children.count - 1 )
		end

	already_displayed: BOOLEAN
			-- Tell if the box has already been displayed

feature -- Status setting (box specific)

	set_homogeneous (flag: BOOLEAN) is
			-- set `is_homogeneous' to `flag'.
			-- Need to be resized
		do
			is_homogeneous := flag
			if not ev_children.empty then
				initialize_display
			end
		end

	set_spacing (value: INTEGER) is
			-- Make `value' the new spacing of the box.
		do
			spacing := value
			if not ev_children.empty then
				initialize_display
			end
		end

	set_border_width (value: INTEGER) is
			-- Make `value' the new border width.
		do
			border_width := value
			-- Update view
		end

feature -- Resizing

	set_width (value: INTEGER) is
		do
			child_cell.set_width (value.max (minimum_width))
			set_local_width (child_cell.width)
		end

	set_height (value: INTEGER) is
		do
			child_cell.set_height (value.max (minimum_height))
			set_local_height (child_cell.height)
		end

feature {NONE} -- Basic operation

	set_local_width (new_width: INTEGER) is
		deferred
		end

	set_local_height (new_height: INTEGER) is
		deferred
		end

--	remove_child (child_imp: EV_WIDGET_IMP) is
			-- Remove a given child of the composite
--		do
--			children.go_i_th (children.index_of (child_imp,1))
--			children.remove
--			set_minimum (fonction a rajouter qui recherche le minimum des tailles des enfants)
--			parent_ask_resize (minimum_width, minimum_height)
--		end

	modulo (a, b: INTEGER): INTEGER is
				-- a modulo b
		require
			b_not_null: b /= 0
		do
			Result := a \\ b
			if Result <= 0 then
				Result := Result + b
			end
		ensure
			result_large_enough: Result >= 1
			result_small_enough: Result <= b
		end

	index: INTEGER
		-- Index of the last child which received a rest.

	rest (total_rest: INTEGER): INTEGER is
				-- Give the rest we must add to the current child of
				-- ev_children when the size of the parent is not a 
				-- multiple of the number of children.
		do
			if total_rest > 0 and then (modulo(ev_children.index - index, ev_children.count) < total_rest or index = ev_children.index) then
				Result := 1
			elseif total_rest < 0 and then index /= ev_children.index and then modulo(index - ev_children.index, ev_children.count) <= total_rest.abs then
				Result := - 1
			else
				Result := 0
			end
		end

	initialize_display is
			-- Reinitialize the box at the same size.
		deferred
		end

	initialize_length_at_minimum is
			-- Initialize the width of the window and of the children.
		deferred
		end

feature {EV_WIDGET_I} -- Implementation

	childvisible_nb: INTEGER
			-- Number of children which are visible

	childexpand_nb: INTEGER
			-- Number of children, which are expanded and visible

  	child_add_successful (new_child: EV_WIDGET_I): BOOLEAN is
  			-- Used in the postcondition of 'add_child'
   		local
   			child_imp: EV_WIDGET_IMP
   		do
 			child_imp ?= new_child
 			Result := ev_children.has (child_imp)
 		end

	on_first_display is
			-- Called by the top_level window.
		local
			i: INTEGER
		do
			if not ev_children.empty then
				from
					i := 1
				until
					i = ev_children.count + 1
				loop
					(ev_children @ i).on_first_display
					i := i + 1
				end
			end
			initialize_length_at_minimum
			child_cell.set_width (minimum_width)
			child_cell.set_height (minimum_height)
			already_displayed := True
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

