indexing

	description: "Calling conventions constants used in EOLE_METHODDATA"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EOLE_CALL_CONV

feature -- Access
	
	Cc_cdecl: INTEGER is
			-- C calling convention (caller pushes
			-- parameters on stack, in reverse order,
			-- caller cleans up stack)
		external
			"C [macro <oaidl.h>]"
		alias
			"CC_CDECL"
		end

	Cc_pascal: INTEGER is
			-- Pascal calling convention (caller pushes
			-- parameters on stack, in reverse order,
			-- caller cleans up stack)
		external
			"C [macro <oaidl.h>]"
		alias
			"CC_PASCAL"
		end
		
	Cc_stdcall: INTEGER is
			-- Stdcall calling convention (callee pushes
			-- parameters on stack, in reverse order,
			-- callee cleans up stack).
		external
			"C [macro <oaidl.h>]"
		alias
			"CC_STDCALL"
		end

	Cc_syscall: INTEGER is
			-- Stdcall calling convention (callee pushes
			-- parameters on stack, in reverse order,
			-- callee cleans up stack).
		external
			"C [macro <oaidl.h>]"
		alias
			"CC_SYSCALL"
		end
		
	is_valid_callconv (cc: INTEGER): BOOLEAN is
			-- Is `cc' a valid calling convention?
		do
			Result := cc = Cc_cdecl or
						cc = Cc_pascal or
						cc = Cc_stdcall or
						cc = Cc_syscall
		end
		
end -- class EOLE_CALLCONV

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1998.
--| Modifications and extensions: copyright (C) ISE, 1998.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

