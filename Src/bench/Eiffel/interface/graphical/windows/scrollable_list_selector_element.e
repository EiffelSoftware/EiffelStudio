indexing
	
	description: "This class can be used as a%
		%scrollable_element in scrollable_list."
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	SCROLLABLE_LIST_SELECTOR_ELEMENT

inherit

	SCROLLABLE_LIST_ELEMENT

creation
	make


feature -- Initialization

	make (c_w:CLASS_W) is
		do
			tool:= c_w
			!! tag.make(0)
		end

feature {SELECTOR_W} -- Attribute

	tool: CLASS_W

	tag: STRING

feature -- Access

	set_read_only is
		do
			tag := "-"
		end

	value: STRING is
			-- String to appear in scrollable list box
		do
			Result := tool.class_text_field.text
		end

end -- class SCROLLABLE_LIST_SELECTOR


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


