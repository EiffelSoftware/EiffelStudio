indexing

	description:
		"Once per process control. This class provides %
		%some features that manipulates once per process%
		%functions and procedures in multithreaded mode. %
		%The standard once features are once per thread";
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class 
	ONCE_CONTROL

feature	-- Externals

	global_once_procedure (Currt: ANY; once_proc: POINTER) is
			-- Evaluates once per process the procedure
			-- pointed by `once_proc'. Put `Current' as 
			-- the first argument.
		external
			"C [macro %"eif_once.h%"]"
		alias
			"eif_global_procedure"	
		end

	global_once_function (Currt: ANY; once_func: POINTER): ANY is
			-- returns the result of the once feature
			-- pointed by 'once_func' which will be
			-- evaluated once per process. Put `Current' as 
			-- the first argument.
		external
			"C [macro %"eif_once.h%"]"
		alias
			"eif_global_function"
		end


 

end -- class ONCE_CONTROL

--|----------------------------------------------------------------
--| EiffelThread: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
