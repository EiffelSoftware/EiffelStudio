indexing
	description: "ActiveX Class Factory"
	note: "Do not inherit from this class, implement it instead"
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	EOLE_ACTIVEX

inherit
	EOLE_AUTOMATION_SERVER_CLASS_FACTORY
		redefine
			on_create_instance
		end

	EOLE_GUID

	EOLE_SERVER_CONFIGURATION

creation
	make

feature -- Access

	dispatch_interface: COMPONENT_DISPATCH
			-- Component's dispatch interface

feature {EOLE_CALL_DISPATCHER} -- Callback

	on_create_instance (controller_interface: POINTER; a_interface_id: STRING): POINTER is
			-- Create an instance of an object with `interface_id'
			-- interface, which may optionally be controlled by
			-- `controller_interface'. Returns Void if fails.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			a_interface_id.to_upper
			if a_interface_id.is_equal (Iid_dispatch) or 
					a_interface_id.is_equal (Iid_unknown) or 
					a_interface_id.is_equal (dispinterface_id) 
			then
				!!dispatch_interface.make
				dispatch_interface.set_class_factory (Current)
				dispatch_interface.add_ref
				Result := dispatch_interface.ole_interface_ptr
				set_last_hresult (S_ok)
			else
				set_last_hresult (E_nointerface)
			end
		end


invariant
	valid_clsid: is_valid_guid (clsid)
	valid_typelib_id: is_valid_guid (typelib_id)
	valid_dispinterface_id: is_valid_guid (dispinterface_id)

end -- class EOLE_ACTIVEX
