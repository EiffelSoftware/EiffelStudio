deferred class MT_ROUTINE 

inherit

	INTERNAL
		export {NONE} all
		end

feature -- Access

	arguments: ARRAY [ANY] -- Arguments of routine body

feature -- Status Report

	name: STRING is
		-- Routine name used to communicate with C
		once
			Result := class_name (Current)
		ensure
			Result.is_equal (class_name (Current))
		end -- name

feature -- Status Setting

	set_arguments (parameter_list: ARRAY [ANY]) is
		-- Set `arguments'.
		require
			parameter_list /= void
		do
			arguments := parameter_list
		ensure
			arguments = parameter_list
		end -- set_arguments

feature -- Action

	execute is
		-- To be implemented in descendant class.
		deferred
		end -- execute

end -- class MT_ROUTINE

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
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

