indexing

	description: "COM IClassFactory interface"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EOLE_AUTOMATION_SERVER_CLASS_FACTORY

inherit
	EOLE_CLASS_FACTORY
		rename
			make as cf_make
		redefine
			on_create_instance
		end

feature -- Initialization

	make is
			-- Initialize OLE interface
		do
			cf_make
			create_ole_interface_ptr
		end
		
feature -- Access

	dispatch_interface: EOLE_DISPATCH is
			-- Server dispatch interface
		deferred
		ensure
			valid_dispatch_interface: Result /= Void and then 
						(Result.ole_interface_ptr /= default_pointer and Result.reference_counter > 0)
		end
			
feature {EOLE_CALL_DISPATCHER} -- Callback

	on_create_instance (controller_interface: POINTER; interface_id: STRING): POINTER is
			-- Create an instance of an object with `interface_id'
			-- interface, which may optionally be controlled by
			-- `controller_interface'. Returns Void if fails.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			if interface_id.is_equal (Iid_dispatch) or interface_id.is_equal (Iid_unknown) then
				Result := dispatch_interface.ole_interface_ptr
				set_last_hresult (S_ok)
			else
				set_last_hresult (E_nointerface)
			end
		end

end -- class EOLE_AUTOMATION_SERVER_CLASS_FACTORY

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

