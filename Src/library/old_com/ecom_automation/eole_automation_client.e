indexing

	description: "COM Automation client"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EOLE_AUTOMATION_CLIENT

inherit
	EOLE_COM
	
	EOLE_INTERFACE_IDENT
		export
			{NONE} all
		end

	EOLE_ERROR_CODE
		export
			{NONE} all
		end
	
feature -- Access

	class_id: STRING is
			-- CLSID of server object
			-- Must be redefined in descendant.
		deferred
		end

	is_valid: BOOLEAN is
			-- Is dispatcher valid?
		do
			Result := (dispatch /= Void and then dispatch.ole_interface_ptr /= default_pointer)
		end
		
feature -- Element change

	create is
			-- Initialize Automation by creating new dispatcher.
		local
			exception: EXCEPTIONS
			dispatch_ptr, class_factory_ptr: POINTER
			class_factory: EOLE_CLASS_FACTORY
			msg_box: WEL_MSG_BOX
		do
			make
			!! class_factory.make
			if co_initialize = S_false then
				!! msg_box.make
				msg_box.warning_message_box (Void, "CoInitialize returned S_FALSE", "COM Initialization")
			end
			class_factory_ptr := co_get_class_object (class_id, 
					Clsctx_local_server, Iid_class_factory)
			if status.succeeded then
				class_factory.attach_ole_interface_ptr (class_factory_ptr)
				dispatch_ptr := class_factory.create_instance (default_pointer, Iid_dispatch)
				if class_factory.status.succeeded then
					!! dispatch.make
					dispatch.attach_ole_interface_ptr (dispatch_ptr)
				else
					!! exception
					exception.raise ("Could not retrieve IDispatch")
				end
			elseif status.last_hresult = Regdb_e_classnotreg then
				!! exception
				exception.raise ("Server not registered")
			elseif status.last_hresult = Co_e_server_exec_failure then
				!! exception
				exception.raise ("Server execution failed")
			else
				!! exception
				exception.raise ("Could not initialize server")
			end
		end

	attach (dispsrc: EOLE_DISPATCH) is
			-- Initialize Automation by retrieving existing dispatcher `dispsrc'.
		require
			valid_dispatch: dispsrc /= void and then dispsrc.is_valid_interface
		do
			dispatch := dispsrc
		end

	terminate is
			-- End Automation.
		local
			ref_counter: INTEGER
		do
			dispatch.release
			function_result.destroy
			function_exception.destroy
			dispparams.destroy
			co_uninitialize
		end
	
feature {NONE} -- Implementation

	function_result: EOLE_VARIANT is
			-- Result of last `dispatch.invoke'
		once
			!! Result
		end

	function_exception: EOLE_EXCEPINFO is
			-- Last exception that occured during `dispatch.invoke'
		once
			!! Result
		end

	dispparams: EOLE_DISPPARAMS is
			-- `dispatch.invoke' arguments
		once
			!! Result
		end
			
	dispatch: EOLE_DISPATCH
			-- IDispatch interface
	
end -- class EOLE_AUTOMATION_CLIENT

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
