indexing
	description: "Root class of ActiveX component"
	note: "Should not to be modified. Do not inherit from this class."
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"
 
class
	EOLE_ACTIVEX_SERVER

inherit
	EOLE_REGISTRATION

creation

	make

feature -- Initialization

	make is
			-- Do nothing
			-- This is statless object
		do
			
		end;

feature -- Access

	activex_component: EOLE_ACTIVEX is
			-- Implementation of ActiveX component
		once
			!!Result.make
		end
	
	DllGetClassObject (a_clsid: POINTER; a_riid: POINTER; ppv: POINTER): INTEGER is
			-- Retrieves the class object from a DLL object handler or object application,
			-- is called from within the `CoGetClassObject' function.
		local
			string: STRING
		do
			string := c_eole_guid_to_eiffel_string (a_clsid)
			string.to_upper
			clsid.to_upper
			if  clsid.is_equal(string) then
				string := c_eole_guid_to_eiffel_string (a_riid)
				string.to_upper
				if string.is_equal (Iid_class_factory) or
					string.is_equal (Iid_unknown) then	
					!!ole_call_dispatcher.make
				
					if activex_component.ole_interface_ptr = default_pointer then
						activex_component.create_ole_interface_ptr
					end	
					activex_component.add_ref			
					c_eole_dll_get_class_object (ppv, activex_component.ole_interface_ptr)
					Result := S_ok
				else
					c_eole_dll_get_class_object (ppv, Default_pointer)
					Result := E_nointerface
				end
			else
				c_eole_dll_get_class_object (ppv, Default_pointer)
				Result := Class_e_classnotavailable
			end
		end

feature -- Basic operations

	DllRegisterServer: INTEGER is
			-- Instructs an in-process server to create its registry entries 
			-- for all classes supported in this server module
		do
			Result := on_register_server ("InprocServer32")
		end

	DllUnregisterServer: INTEGER is
			-- Instructs an in-process server to remove only those 
			-- entries created through `DllRegisterServer'
		do
			Result := on_unregister_server ("InprocServer32")
		end

feature -- Status report

	DllCanUnloadNow: INTEGER is
			-- This function is used to determine whether
			-- the DLL is in use.
			-- COM calls it througha call to `CoFreeUnusedLibraries' function.
		do
			if activex_component.reference_counter = 0 and 
					activex_component.server_locks = 0 then
				Result := S_ok
			else
				Result := S_false
			end
		end

feature {NONE} -- Implementation

	ole_call_dispatcher: EOLE_CALL_DISPATCHER
			-- C - Eiffel dispatcher
			-- Should be initialized to allow clients to call back the server.


feature {NONE} -- Externals

	c_eole_dll_get_class_object (a_ppv: POINTER; a_pv: POINTER) is
		external
			"C [macro %"activex.h%"]"
		end

	c_eole_is_equal_clsid (a_clsid1, a_clsid2: POINTER): BOOLEAN is
		external
			"C [macro %"activex.h%"]"
		end

	c_eole_guid_to_eiffel_string (guid: POINTER): STRING is
		external
			"C"
		alias
			"GuidToEiffelString"
		end


end -- class EOLE_ACTIVEX_SERVER
