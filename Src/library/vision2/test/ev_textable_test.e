indexing
	description: "Eiffel Vision dynamic list test."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEST_TEXTABLE

inherit
	EV_TEST2

	EXCEPTIONS
		undefine
			default_create
		end

create
	make_with_item,
	make_with_widget

feature {NONE} -- Initalization

	make_with_item (a_name: STRING; a_textable: EV_TEXTABLE;
		a_item_parent: EV_ITEM_LIST [EV_ITEM]) is
			-- Test `a_textable' with `a_parent'.
		require
			a_name_not_void: a_name /= Void
			a_textable_not_void: a_textable /= Void
			a_item_parent_not_void: a_item_parent /= Void
		do
			description := "Testing textable: " + a_name + ".%N"
			textable := a_textable
			item_parent := a_item_parent
			test_successful := True
		end

	make_with_widget (a_name: STRING; a_textable: EV_TEXTABLE;
		a_widget_parent: EV_CONTAINER) is
			-- Test `a_textable' with `a_parent'.
		require
			a_name_not_void: a_name /= Void
			a_textable_not_void: a_textable /= Void
			a_widget_parent_not_void: a_widget_parent /= Void
		do
			description := "Testing textable: " + a_name + ".%N"
			textable := a_textable
			widget_parent := a_widget_parent
			test_successful := True
		end

feature -- Basic operation

	execute is
		local
			w: EV_WIDGET
			i: EV_ITEM
		do
			description.append ("Testing without parent...%N")
			perform_pass
			textable.set_text ("preserve")
			if widget_parent /= Void then
				w ?= textable
				widget_parent.extend (w)
			elseif item_parent /= Void then
				i ?= textable
				item_parent.extend (i)
			end
			if not textable.text.is_equal ("preserve") then
				description.append ("Text not preserved when parented.%N")
				test_successful := False
			end
			description.append ("Testing with parent...%N")
			perform_pass
			textable.set_text ("preserve again")
			if widget_parent /= Void then
				w ?= textable
				widget_parent.prune (w)
			elseif item_parent /= Void then
				i ?= textable
				item_parent.prune (i)
			end
			if not textable.text.is_equal ("preserve again") then
				description.append ("Text not preserved when unparented.%N")
				test_successful := False
			end
		end

	perform_pass is
			-- Perform testing.
		local
			test_string: STRING
		do
			create test_string.make (5)
			test_string.fill_character ('a')
			
			textable.set_text (test_string)
			test_string.put ('1', 1)
			if test_string.is_equal (textable.text) then
				description.append ("set_text does not clone.%N")
				test_successful := False
			end

			test_string := textable.text
			test_string.put ('2', 2)
			if test_string.is_equal (textable.text) then
				description.append ("text does not return clone.%N")
				test_successful := False
			end

			textable.remove_text
			if textable.text /= Void then
				description.append ("remove_text does not set text Void.%N")
				test_successful := False
			end

			test_string.put ('&', 3)
			textable.set_text (test_string)
			if not test_string.is_equal (textable.text) then
				description.append ("Single ampersands not handled correctly."
					+ "%N")
				test_successful := False
			end

			test_string.put ('&', 4)
			textable.set_text (test_string)
			if not test_string.is_equal (textable.text) then
				description.append ("Double ampersands not handled correctly."
					+ "%N")
				test_successful := False
			end
		end

feature -- Access

	textable: EV_TEXTABLE
			-- Test subject.

	widget_parent: EV_CONTAINER
	item_parent: EV_ITEM_LIST [EV_ITEM]

	description: STRING
			-- Description of the test, its results and other
			-- (ir)relevant information.

end -- class EV_TEST_TEXTABLE

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2001/06/07 23:08:57  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.4.2  2000/06/30 21:52:16  king
--| Set test_successful flag to true in both constructors
--|
--| Revision 1.3.4.1  2000/05/03 19:10:21  oconnor
--| mergred from HEAD
--|
--| Revision 1.3  2000/03/30 18:39:17  brendel
--| Renamed to EV_TEST_TEXTABLE.
--|
--| Revision 1.2  2000/03/29 20:15:06  brendel
--| Fixed some testcases.
--|
--| Revision 1.1  2000/03/28 17:02:48  brendel
--| Initial version of thorough EV_TEXTABLE test.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------


