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

	make (t_w:TOOL_W) is
		do
			tool:= t_w
			!! tag.make(0)
		end

feature {SELECTOR_W} -- Attribute

	tool: TOOL_W

	tag: STRING

feature -- Access

	set_read_only is
		local
			c_w : CLASS_W
		do
			tag := " [READ-ONLY]"
			c_w ?= tool
			if c_w /= Void then
				c_w.set_read_only (True)
			end
		end

	value: STRING is
			-- String to appear in scrollable list box
		local
			t: STRING
			c_w:CLASS_W
			r_w:ROUTINE_W
			o_w:OBJECT_W
		do
			c_w ?= tool
			r_w ?= tool
			o_w ?= tool

			if c_w /= Void then
				if c_w.class_text_field.text.is_empty then
					t:= clone (tool.title)
				else
					t := clone (tool.eb_shell.icon_name)
				end
			elseif r_w /= Void then
				t := clone (tool.title)
				if not t.is_empty then
					t.replace_substring_all ("Feature: ","+ ")
					t.replace_substring_all ("Class:","from:")
				end
			elseif o_w /= Void then
				t := clone (tool.title)
			else
				t := clone ("? Unknown Tool")
			end

			if t.is_empty then
--				t.append ("<<>> EL WHAT ??")
			else
				t.append (tag)
			end

			Result := t
		end

end -- class SCROLLABLE_LIST_SELECTOR_ELEMENT


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


