indexing 
	description: "EiffelVision status bar."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STATUS_BAR

inherit
	EV_PRIMITIVE
		export
			{NONE} set_minimum_height, set_minimum_width, set_minimum_size
			{NONE} set_height, set_width, set_size
			{NONE} set_x, set_y, set_x_y
		redefine
			implementation,
			parent,
			set_parent
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_WINDOW) is
			-- Create a status bar with `par' as parent and only
			-- one part.
		do
			!EV_STATUS_BAR_IMP! implementation.make
			widget_make (par)
		end

feature -- Access

	parent: EV_WINDOW is
			-- The parent of the Current widget
			-- Can be Void
		do
			if implementation.parent_imp /= Void then
				Result ?= implementation.parent_imp.interface
			else
				Result := Void
			end
		end

feature -- Status report

	count: INTEGER is
			-- Current number of parts
		require
			exists: not destroyed
		do
			Result := implementation.count
		ensure
			positive_result: Result > 0
		end

feature -- Element change

	set_parent (par: EV_WINDOW) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		do
			implementation.set_parent (par)
		end

feature -- Implementation

	implementation: EV_STATUS_BAR_I

end -- class EV_STATUS_BAR

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
