indexing
	description: "EiffelVision vertical split. Mswindows implementation."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	
	EV_VERTICAL_SPLIT_IMP
	
inherit
	
	EV_VERTICAL_SPLIT_I
		
	EV_SPLIT_IMP
		redefine
			child_minheight_changed,
			wel_window
		end
	
creation
	
	make

feature -- Initilization

	make (par: EV_CONTAINER) is
			-- Create a fixed widget. 
		local
			par_imp: EV_CONTAINER_IMP			
		do
			par_imp ?= par.implementation
			check
				par_imp_not_void: par_imp /= Void
			end 
			!! wel_window.make (par_imp.wel_window, Current)
		end

feature {EV_WEL_SPLIT_WINDOW} -- Access

	minimum_level: INTEGER is
			-- Minimum level that the splitter is allowed to go
			-- Depends of the first child minimum size
		do
			if child1 = Void then
				Result := 0
			else
				Result := child1.minimum_height
			end
		end	

	maximum_level: INTEGER is
			-- Maximum level that the splitter is allowed to go
			-- Depends of the second child minimum size
		do
			if child2 = Void then
				Result := height
			else
				Result := height - child2.minimum_height - wel_window.size
			end
		end

feature -- Implementation

	child_minheight_changed (child_new_minimum: INTEGER) is
			-- Change the current minimum_width because the child did.
		local
			local_height: INTEGER
		do
			if child1 /= Void then
				local_height := local_height + child1.width
			end
			if child2 /= Void then
				local_height := local_height + child2.width
			end
			set_minimum_height (local_height + wel_window.size)
		end

feature {EV_WEL_SPLIT_WINDOW} -- Implementation

	resize_children (level: INTEGER) is
			-- Resize the two children according to the new level of the 
			-- splitter
		do
			if child1 /= Void then
				child1.parent_ask_resize (width, wel_window.level)
			end
			if child2 /= Void then
				child2.set_move_and_size (0, wel_window.level + wel_window.size, 
							width, height - wel_window.level - wel_window.size)
			end
		end

feature {NONE} -- Implementation

	wel_window: EV_WEL_VERTICAL_SPLIT_WINDOW

end -- EV_VERTICAL_SPLIT_IMP

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
