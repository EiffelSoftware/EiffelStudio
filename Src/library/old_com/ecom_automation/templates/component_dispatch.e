indexing
	description: "Custom implementation of IDispatch interface"
	note: "Meant to be implemanted by user"
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	COMPONENT_DISPATCH

inherit
	EOLE_ACTIVEX_DISPINTERFACE
		redefine
			on_invoke
		end

	COMPONENT_DISPID

creation
	make

feature {EOLE_CALL_DISPATCHER} -- Callback

	on_invoke (dispid, flags: INTEGER; params: EOLE_DISPPARAMS; a_res: EOLE_VARIANT; exception: EOLE_EXCEPINFO) is
			-- Invoke method or property with `dispid' and arguments 
			-- `params' according to `flags'. Result is stored in 
			-- `res' and exception (if any) in `exception'.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Should be implemented by user
		do
		
		end

invariant
	
end -- class COMPONENT_DIPATCH
