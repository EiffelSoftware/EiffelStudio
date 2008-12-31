note
	description: "Custom implementation of IDispatch interface. Meant to be implemented by user."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	COMPONENT_DISPATCH

inherit
	EOLE_ACTIVEX_DISPINTERFACE
		redefine
			on_invoke,
			on_get_ids_of_names
		end

	COMPONENT_DISPID

create
	make

feature {EOLE_CALL_DISPATCHER} -- Callback

	on_invoke (dispid, flags: INTEGER; params: EOLE_DISPPARAMS; a_res: EOLE_VARIANT; exception: EOLE_EXCEPINFO)
			-- Invoke method or property with `dispid' and arguments 
			-- `params' according to `flags'. See EOLE_METHOD_FLAGS for 
			-- possible `flags' values. Result is stored in 
			-- `res' and exception (if any) in `exception'.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Should be implemented by user
		local
			arg1, arg2, res: INTEGER
		do
			if is_dispatch_method (flags) then
				inspect
					dispid
				when Dispid_sum then
					arg1 := params.argument (0).integer4
					arg2 := params.argument (1).integer4
					res := arg1 + arg2
					a_res.set_integer4 (res)
				else
					exception.set_ole_error_code (Disp_e_membernotfound)
				end
			end
		end

	on_get_ids_of_names (names: ARRAY [STRING]): ARRAY [INTEGER]
			-- Maps `names' to their 'dispids'. First element
			-- in arrays correspond to member name, others
			-- to parameter names.
		do
			if names.item(names.lower).is_equal("sum") then
				create Result.make (names.lower, names.lower)
				Result.force(Dispid_sum, names.lower)
				set_last_hresult (Noerror)
			else
				set_last_hresult (Disp_e_unknownname)
			end
		end

invariant
	
note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class COMPONENT_DIPATCH
