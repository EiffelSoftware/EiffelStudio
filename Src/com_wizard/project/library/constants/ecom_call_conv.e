indexing

	description: "Calling conventions constants"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_CALL_CONV

feature -- Access
	
	Cc_fastcall: INTEGER is
			-- Fastcall calling convention (arguments to 
			-- functions are to be passed in registers, when 
			-- possible) 
			-- Microsoft specific.
		external
			"C [macro <oaidl.h>]"
		alias
			"CC_FASTCALL"
		end

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
	
	Cc_macpascal: INTEGER is
			-- Mac Pascal calling convention 
		external
			"C [macro <oaidl.h>]"
		alias
			"CC_MACPASCAL"
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

	Cc_fpfastcall: INTEGER is
			-- Fpfastcall calling convention (
		external
			"C [macro <oaidl.h>]"
		alias
			"CC_FPFASTCALL"
		end

	Cc_syscall: INTEGER is
			-- Syscall calling convention
		external
			"C [macro <oaidl.h>]"
		alias
			"CC_SYSCALL"
		end

	Cc_mpwcdecl: INTEGER is
			-- Mpwcdecl calling convention 
		external
			"C [macro <oaidl.h>]"
		alias
			"CC_MPWCDECL"
		end

	Cc_mpwpascal: INTEGER is
			-- Mpwpascal calling convention 
		external
			"C [macro <oaidl.h>]"
		alias
			"CC_MPWPASCAL"
		end

	Cc_max: INTEGER is
			-- Max calling convention 
		external
			"C [macro <oaidl.h>]"
		alias
			"CC_MAX"
		end

feature -- Status report

	is_valid_callconv (cc: INTEGER): BOOLEAN is
			-- Is `cc' a valid calling convention?
		do
			Result := cc = Cc_fastcall or 
						cc = Cc_cdecl or
						cc = Cc_pascal or
						cc = Cc_macpascal or
						cc = Cc_stdcall or
						cc = Cc_fpfastcall or
						cc = Cc_syscall or
						cc = Cc_mpwcdecl or
						cc = Cc_mpwpascal or
						cc = Cc_max
		end
		
end -- class ECOM_CALL_CONV

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

