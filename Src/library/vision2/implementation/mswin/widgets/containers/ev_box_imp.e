--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
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
			interface
		end

	EV_WIDGET_LIST_IMP
		undefine
			set_default_minimum_size,
			enable_sensitive,
			disable_sensitive,
			client_width,
			client_height
		redefine
			interface
		select
			interface
		end
	
	EV_INVISIBLE_CONTAINER_IMP
		rename
			move as move_to,
			interface as ev_invisible_container_imp_interface
		undefine
			compute_minimum_width,
			compute_minimum_height,
			compute_minimum_size,
			client_width,
			client_height
		redefine
			make,
			set_focus,
			has_focus
		end

feature {NONE} -- Initialization

	make (an_interface: like interface)is
				-- Create the box with the default options.
		do
			--{EV_INVISIBLE_CONTAINER_IMP} Precursor
			base_make (an_interface)
			ev_wel_control_container_make
			!! ev_children.make (2)
			is_homogeneous := Default_homogeneous
			padding := Default_spacing
			border_width := Default_border_width
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

	is_homogeneous: BOOLEAN
			-- Must the children have the same size ?

	padding: INTEGER
			-- Space between the objects in the box

	border_width: INTEGER
			-- Border width around container

	total_spacing: INTEGER is
			-- Total space occupied by spacing. One spacing
			-- between two consecutives children.
		do
			Result := padding * (childvisible_nb - 1)
		end

	childvisible_nb: INTEGER
			-- Number of children which are visible
 
	childexpand_nb: INTEGER is
			-- Number of children, which are expanded and visible
		do
			if non_expandable_children = Void then
				Result := childvisible_nb
			else
				Result := childvisible_nb - non_expandable_children.count
			end
		end

	non_expandable_children: ARRAYED_LIST [INTEGER]
			-- Position of the non expandable children in growing order.

feature -- Status report

	is_child_expanded (child: EV_WIDGET): BOOLEAN is
			-- Is the child corresponding to `index' expandable. ie: does it
			-- accept the parent to resize or move it.
		local
			child_imp: EV_WIDGET_IMP
		do
			if non_expandable_children = Void then
				Result := True
			else
				child_imp ?= child.implementation
				check
					valid_cast: child_imp /= Void
				end
				Result := not non_expandable_children.has (ev_children.index_of (child_imp, 1))
			end
		end

	has_focus: BOOLEAN is
			-- Does box have focus?
		do
			Result := True
		end

feature -- Status setting

	set_focus is
			-- When current widget recieves focus, pass
			-- focus to the first child.
		do
			if not ev_children.empty then
				ev_children.first.set_focus
			end
		end

	set_child_expandable (child: EV_WIDGET; flag: BOOLEAN) is
			-- Make the child corresponding to `index' expandable if `flag',
			-- not expandable otherwise.
		local
			list: ARRAYED_LIST [INTEGER]
			child_imp: EV_WIDGET_IMP
			value, an_index: INTEGER
			placed: BOOLEAN
		do
			-- First, we find the index of the child.
			child_imp ?= child.implementation
			check
				valid_cast: child_imp /= Void
			end
			an_index := ev_children.index_of (child_imp, 1)

			-- Then, we set the information
			if flag then
				if non_expandable_children /= Void then
					non_expandable_children.prune_all (an_index)
					if non_expandable_children.empty then
						non_expandable_children := Void
					end
				end
			else
				if non_expandable_children = Void then
					create non_expandable_children.make (1)
					non_expandable_children.extend (an_index)
				else
					from
						list := non_expandable_children
						placed := False
						list.start
					until
						placed
					loop
						if list.after then
							list.extend (an_index)
							placed := True
						else
							value := list.item
							if an_index < value then
								list.put_left (an_index)
								placed := True
							elseif an_index > value then
								list.forth
							else
								placed := True
							end
						end
					end
				end
			end

			-- Need to be redefine
			-- Notify the changes here
		end



feature -- Element change

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add a child to the box.
		do
			ev_children.extend (child_imp)
			notify_change (Nc_minsize)
		end

	remove_child (child_imp: EV_WIDGET_IMP) is
			-- Remove the given child from the children of
			-- the container.
			local
				child: EV_WIDGET
				an_index: INTEGER
		do
			child ?= child_imp.interface
			an_index := ev_children.index_of (child_imp, 1)
			if non_expandable_children /= Void then
				non_expandable_children.prune_all (an_index)
					if non_expandable_children.empty then
						non_expandable_children := Void
					else
						update_non_expandable_children (an_index)
					end
				end
			child_imp.set_parent (Void)
			ev_children.prune_all (child_imp)
			if not ev_children.empty then
				notify_change (Nc_minsize)
			end
		end

feature -- Contract support

  	child_add_successful (new_child: EV_WIDGET_I): BOOLEAN is
  			-- Used in the postcondition of 'add_child'
   		local
   			child_imp: EV_WIDGET_IMP
   		do
 			child_imp ?= new_child
 			Result := ev_children.has (child_imp)
 		end

feature {NONE} -- Basic operation
 
	update_non_expandable_children (index_value: INTEGER) is
		local 
			value: INTEGER
			i: INTEGER
		do
		if index_value <= non_expandable_children.count then
			from
				non_expandable_children.go_i_th (index_value)
			until
				non_expandable_children.off
			loop
				value := non_expandable_children.item
				non_expandable_children.remove
				non_expandable_children.put_left (value - 1)
			end
		end
		end

	rest (total_rest: INTEGER): INTEGER is
				-- Give the rest we must add to the current child of
				-- ev_children when the size of the parent is not a 
				-- multiple of the number of children.
		do
			if total_rest > 0 then
				Result := 1
			elseif total_rest < 0 then
				Result := -1
			else
				Result := 0
			end
		end

feature {EV_ANY_I} -- Interface

	interface: EV_BOX

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.28  2000/02/14 11:40:42  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.26.2.1.2.6  2000/01/31 17:27:46  brendel
--| Removed set_default_minimum_size from inh. clause.
--|
--| Revision 1.26.2.1.2.5  2000/01/27 19:30:19  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.26.2.1.2.4  2000/01/18 00:45:21  rogers
--| Removed commented parts from ineritance structure. See diff.
--|
--| Revision 1.26.2.1.2.2  1999/12/17 00:55:13  rogers
--| Altered to fit in with the review branch. Redefinitions required. Now inherits from EV_WIDGET_LIST_IMP, make takes an interface.
--|
--| Revision 1.26.2.1.2.1  1999/11/24 17:30:25  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.25.2.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
