indexing
	description: "Dispatch function helper."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_DISPATCH_FUNCTION_HELPER

inherit
	ECOM_FUNC_KIND
		export 
			{NONE} all
		end

	WIZARD_WRITER_DICTIONARY
		export 
			{NONE} all
		end

	ECOM_VAR_TYPE
		export 
			{NONE} all
		end

	ECOM_PARAM_FLAGS
		export 
			{NONE} all
		end

feature -- Basic operations

	does_routine_have_result (func_desc: WIZARD_FUNCTION_DESCRIPTOR): BOOLEAN is
			-- Does routine have result?
		local
			cursor: CURSOR
		do
			if func_desc.func_kind = func_dispatch then
				Result := not func_desc.return_type.name.is_equal (Void_c_keyword) and
						func_desc.return_type.type /= Vt_hresult
			else
				if func_desc.argument_count > 0 then
					cursor := func_desc.arguments.cursor
					func_desc.arguments.go_i_th (func_desc.argument_count)
					Result := is_paramflag_fretval (func_desc.arguments.item.flags)
					func_desc.arguments.go_to (cursor)
				end
			end
		end

end -- class WIZARD_DISPATCH_FUNCTION_HELPER

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
