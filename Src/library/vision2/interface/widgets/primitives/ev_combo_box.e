class EV_COMBO_BOX

inherit

	EV_TEXT_FIELD
		redefine
			implementation
		end

creation

	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a combo-box with `par' as parent.
		do
			!EV_COMBO_BOX_IMP!implementation.make (par)
			widget_make (par)
		end

feature -- Access

	read_element (index: INTEGER): STRING is
			-- Text at the zero-based `index'
		require
			exists: not destroyed
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			implementation.read_element (index)
		end

feature -- Element change

	add_element (a_string: STRING) is
			-- Add an element with the text `a_string' 
			-- to the combo-box.
			-- If string is `Void', it add an element with 
			-- an empty string "".
		require
			exists: not destroyed
		do
			implementation.add_element (a_string)
		end

	insert_element (a_string: STRING; index: INTEGER) is
			-- Insert an element with the text `a_string'
			-- at the zero-based `index' position of the 
			-- combo box.
			-- If string is `Void', it add an element with 
			-- an empty string "".
		require
			exists: not destroyed
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			implementation.insert_element (a_string, index)
		end				

	remove_element (index: INTEGER) is
			-- Remove the element at the zero-based
			-- `index' position of the combo-box.
		require
			exists: not destroyed
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			implementation.remove_element (index)
		end

	remove_all_elements is
			-- Remove all the elements of the combo-box.
		require
			exists: not destroyed
		do
			implementation.remove_all_elements
		end

feature -- Implementation

	implementation: EV_COMBO_BOX_I

end -- class EV_COMBO_BOX

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
