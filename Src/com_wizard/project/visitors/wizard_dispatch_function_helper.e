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

