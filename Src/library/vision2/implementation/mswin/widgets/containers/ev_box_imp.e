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

	EV_INVISIBLE_CONTAINER_IMP
		undefine
			compute_minimum_width,
			compute_minimum_height,
			compute_minimum_size
		redefine
			make,
			client_width,
			client_height
		end

feature {NONE} -- Initialization

	make is
				-- Create the box with the default options.
		do
			{EV_INVISIBLE_CONTAINER_IMP} Precursor
			set_text ("EV_BOX")
			!! ev_children.make (2)
			is_homogeneous := Default_homogeneous
			spacing := Default_spacing
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

	spacing: INTEGER
			-- Space between the objects in the box

	border_width: INTEGER
			-- Border width around container

	total_spacing: INTEGER is
			-- Total space occupied by spacing. One spacing
			-- between two consecutives children.
		do
			Result := spacing * (childvisible_nb - 1)
		end

	childvisible_nb: INTEGER
			-- Number of children which are visible

	childexpand_nb: INTEGER is
			-- Number of children, which are expanded and visible
		do
			if children_expandable = Void then
				Result := childvisible_nb
			else
				Result := childvisible_nb - children_expandable.count
			end
		end

	children_expandable: ARRAYED_LIST [INTEGER]
			-- Position of the non expandable children in growing order.

feature -- Status report

	is_child_expandable (child: EV_WIDGET): BOOLEAN is
			-- Is the child corresponding to `index' expandable. ie: does it
			-- accept the parent to resize or move it.
		local
			child_imp: EV_WIDGET_IMP
		do
			if children_expandable = Void then
				Result := True
			else
				child_imp ?= child.implementation
				check
					valid_cast: child_imp /= Void
				end
				Result := not children_expandable.has (ev_children.index_of (child_imp, 1))
			end
		end

feature -- Status setting

	set_child_expandable (child: EV_WIDGET; flag: BOOLEAN) is
			-- Make the child corresponding to `index' expandable if `flag',
			-- not expandable otherwise.
		local
			list: ARRAYED_LIST [INTEGER]
			child_imp: EV_WIDGET_IMP
			value, index: INTEGER
			placed: BOOLEAN
		do
			-- First, we find the index of the child.
			child_imp ?= child.implementation
			check
				valid_cast: child_imp /= Void
			end
			index := ev_children.index_of (child_imp, 1)

			-- Then, we set the information
			if flag then
				if children_expandable /= Void then
					children_expandable.prune_all (index)
					if children_expandable.empty then
						children_expandable := Void
					end
				end
			else
				if children_expandable = Void then
					create children_expandable.make (1)
					children_expandable.extend (index)
				else
					from
						list := children_expandable
						placed := False
						list.start
					until
						placed
					loop
						if list.after then
							list.extend (index)
							placed := True
						else
							value := list.item
							if index < value then
								list.put_right (index)
								placed := True
							elseif index > value then
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
		do
			ev_children.prune_all (child_imp)
			if not ev_children.empty then
				notify_change (Nc_minsize)
			end
		end

feature -- Assertion

  	child_add_successful (new_child: EV_WIDGET_I): BOOLEAN is
  			-- Used in the postcondition of 'add_child'
   		local
   			child_imp: EV_WIDGET_IMP
   		do
 			child_imp ?= new_child
 			Result := ev_children.has (child_imp)
 		end

feature {NONE} -- Basic operation

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
