indexing
	description: "Variant constants, use `missing' as value for optional argument when %
				%no value should be specified"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_SHARED_VARIANT

inherit
	ECOM_VAR_TYPE
	ECOM_EXCEPTION_CODES
		export
			{NONE} all
		end

feature -- Access

	missing: ECOM_VARIANT is
			-- Value representing the default value of a COM optional argument.
			-- Equivalent to an omitted VB argument, or C++ vtMissing, or .NET System.Reflection.Missing.
		once
			create Result.make
			Result.set_error (create {ECOM_HRESULT}.make_from_integer (Disp_e_paramnotfound))
		ensure
			attached: Result /= Void
			definition: is_missing (Result)
		end

feature -- Status report

	is_missing (v: ECOM_VARIANT): BOOLEAN is
			-- Does `v' represent a COM optional argument?
		require
			attached: v /= Void
		do
			Result := is_error (v.variable_type) and then v.error.item = Disp_e_paramnotfound
		end

end -- class ECOM_SHARED_VARIANT

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2005 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

