indexing

	description: "COM IUnknown interface"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	EOLE_UNKNOWN
	
inherit
	EOLE_ERROR_CODE
		export
			{NONE} all
		end
	
	EOLE_INTERFACE_IDENT
		export
			{NONE} all;
			{ANY} default_pointer
		end

creation
	make
	
feature -- Initialization

	make is
			-- Initialize `status'
		do
			!! status
		end
		
feature -- Element change
		
	create_ole_interface_ptr is
			-- Create associated OLE pointer.
			-- Automatically update `ole_interface_ptr'.
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (Iid_unknown)
			ole_interface_ptr := ole2_create_interface_pointer ($Current, wel_string.item)
		end

	frozen attach_ole_interface_ptr (ptr: POINTER) is
			-- Attach `p' to this object.
			-- If `ole_interface_ptr' has not been
			-- created with `create_ole_interface_ptr'
			-- then `ole2_update_interface' will raise
			-- an exception. This exception will be caught.
		require
			valid_pointer: ptr /= default_pointer
		local
			second_time: BOOLEAN
		do
			if not second_time then
				ole_interface_ptr := ptr
				ole2_update_interface ($Current, ptr)
			end
		rescue
			second_time := True
			retry
		end
		
	frozen detach_ole_interface_ptr is
			-- Destroy current Ole interface pointer.
		do
			cpp_delete (ole_interface_ptr)
			ole_interface_ptr := default_pointer
		end

	frozen set_delegate (unk: EOLE_UNKNOWN) is
			-- Set `delegate' with `unk'.
		do
			delegate := unk
		end
		
	frozen set_last_hresult (hresult: INTEGER) is
			-- Set last result with `code'.
			-- Shortcut for `status.set_last_hresult'.
		do
			status.set_last_hresult (hresult)
		end

feature -- Access

	status: EOLE_RESULT
			-- OLE result handler
		
	is_valid_interface: BOOLEAN is
			-- Was `interface' initialized?
		do
			Result := ole_interface_ptr /= default_pointer
		end

	reference_counter: INTEGER
			-- Current count of references

	frozen ole_interface_ptr: POINTER
			-- Pointer to "Native Ole interface"

	frozen delegate: EOLE_UNKNOWN
			-- Delegate of this object (aggregation support)

feature -- Message Transmission

	query_interface (interface_ident: STRING): POINTER is
			-- Query `iid' interface.
			-- Return Void if fails.
		require
			valid_interface_identifier: interface_ident /= Void
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (interface_ident)
			Result := ole2_unknown_query_interface (ole_interface_ptr, wel_string.item)
		end

	add_ref is
			-- Increment reference counter and update 
			-- current reference counter value.
			-- Not meant to be redefined; redefine `on_add_ref' instead.
		require
			valid_interface: ole_interface_ptr /= default_pointer
		do
			reference_counter := ole2_unknown_add_ref (ole_interface_ptr)
		end

	release is
			-- Decrement reference counter and update
			-- current reference counter value.
			-- Not meant to be redefined; redefine `on_release' instead.
		require
			valid_interface: ole_interface_ptr /= default_pointer
		do
			reference_counter := ole2_unknown_release (ole_interface_ptr)
		end
		
feature {EOLE_CALL_DISPATCHER} -- Callback

	on_query_interface (iid: STRING): POINTER is
			-- Query `iid' interface.
			-- Return Void if interface is not supported.
		do
			if iid.is_equal (Iid_unknown) then
				add_ref
				Result := ole_interface_ptr
				set_last_hresult (S_ok)
			else
				set_last_hresult (E_nointerface)
			end
		end

	on_add_ref: INTEGER is
			-- By default: increment counter.
			-- Redefine in descendant if needed.
		do
			reference_counter := reference_counter + 1
			Result := reference_counter
		end

	on_release: INTEGER is
			-- By default: Decrement counter.
			-- Destroy associated C++ interface
			-- if reference counter = 0.
			-- Redefine in descendant if needed.
		require
			reference_counter_greater_than_0: reference_counter > 0
		do
			reference_counter := reference_counter - 1
			if reference_counter = 0 then
				detach_ole_interface_ptr
			end
			Result := reference_counter
		end

feature {NONE} -- Externals

	cpp_delete (ptr: POINTER) is
		external
			"C++"
		end

	ole2_update_interface (this,p :POINTER) is
		external
			"C"
		alias
			"eole2_update_interface"
		end
		
	ole2_create_interface_pointer (eo: POINTER; iid_string: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_create_interface_pointer"
		end

	ole2_unknown_query_interface (p: POINTER; iid_string: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_unknown_query_interface"
		end

	ole2_unknown_add_ref (p: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_unknown_add_ref"
		end

	ole2_unknown_release (p: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_unknown_release"
		end
	
end -- class EOLE_UNKNOWN

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

