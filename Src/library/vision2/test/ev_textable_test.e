indexing
	description: "Eiffel Vision dynamic list test."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXTABLE_TEST

inherit
	EV_TEST2

	EXCEPTIONS
		undefine
			default_create
		end

create
	make

feature {NONE} -- Initalization

	make (a_name: STRING; a_textable: EV_TEXTABLE; a_parent: EV_ANY) is
			-- Test `a_textable' with `a_parent'.
		require
			a_name_not_void: a_name /= Void
			a_textable_not_void: a_textable /= Void
			a_parent_not_void: a_parent /= Void
		do
			subject_name := a_name
			description := "Testing textable: " + a_name + ".%N"
			textable := a_textable
			parent := a_parent
		end

feature -- Basic operation

	execute is
		local
			il: EV_ITEM_LIST
			c: EV_CONTAINER
		do
			description.append ("Testing without parent...%N")
			perform_pass
			textable.set_text ("preserve")
			c ?= parent
			if c /= Void then
				c.extend (textable)
			else
				il ?= parent
				if il /= Void then
					il.extend (textable)
				end
			end
			if c = Void and il = Void then
				description.append ("(No valid parent given: could not perform any more tests)%N")
				test_result := False
			else
				if not textable.text.is_equal ("preserve") then
					description.append ("Text not preserved when parented.%N")
					test_result := False
				end
				description.append ("Testing with parent...%N")
				perform_pass
				textable.set_text ("preserve again")
				if c /= Void then
					c.prune_all (textable)
				end
				if il /= Void then
					il.prune_all (textable)
				end
				if not textable.text.is_equal ("preserve again") then
					description.append ("Text not preserved when unparented.%N")
					test_result := False
				end
			end
		end

	perform_pass is
			-- Perform testing.
		local
			test_string: STRING
			string_copy: STRING
		do
			create test_string.make (5)
			test_string.fill_character ("a")
			
			string_copy := clone (test_string)
			textable.set_text (test_string)
			test_string.put ('1', 1)
			if not string_copy.is_equal (test_string) then
				description.append ("set_text does not clone.%N")
				test_result := False
			end

			test_string := textable.text
			test_string.put ('2', 2)
			string_copy := clone (textable.text)
			if string_copy.is_equal (test_string) then
				description.append ("text does not return clone.%N")
				test_result := False
			end

			textable.remove_text
			if textable.text /= Void then
				description.append ("remove_text does not set text Void.%N")
				test_result := False
			end

			test_string.put ('&', 3)
			textable.set_text (test_string)
			if not test_string.is_equal (textable.text) then
				description.append ("Single ampersands not handled correctly.%N")
				test_result := False
			end

			test_string.put ('&', 4)
			textable.set_text (test_string)
			if not test_string.is_equal (textable.text) then
				description.append ("Double ampersands not handled correctly.%N")
				test_result := False
			end
		end

feature -- Access

	textable: EV_TEXTABLE
			-- Test subject.

	parent: EV_ANY
			-- Conforming to either EV_CONTAINER or EV_ITEM_LIST.

	description: STRING
			-- Description of the test, its results and other
			-- (ir)relevant information.

end -- class EV_TEXTABLE_TEST

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
--| Revision 1.1  2000/03/28 17:02:48  brendel
--| Initial version of thorough EV_TEXTABLE test.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------


