indexing

	description: "COM IDispatch interface"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_DISPATCH

inherit
	EOLE_UNKNOWN
		redefine
			on_query_interface,
			create_ole_interface_ptr
		end

	EOLE_METHOD_FLAGS

creation
	make
		
feature -- Element change

	create_ole_interface_ptr is
			-- Create associated OLE pointer
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (Iid_dispatch)
			ole_interface_ptr := ole2_create_interface_pointer ($Current, wel_string.item)
		end

feature -- Message Transmission

	invoke (dispid, flags: INTEGER; params: EOLE_DISPPARAMS; 
			res: EOLE_VARIANT; exception: EOLE_EXCEPINFO) is
			-- Invoke method or property with dispatch identifier `dispid'
			-- and arguments `params' according to `flags'. Result is 
			-- stored in `res' and exception (if any) in `exception'.
			-- See class EOLE_METHODFLAGS for `flags' value.
			-- Not meant to be redefined; redefine `on_invoke' instead.
		require
			valid_interface: ole_interface_ptr /= default_pointer
			valid_method_flags: is_valid_method_flag (flags)
			valid_params: params /= Void and then params.ole_ptr /= default_pointer
			valid_exception: exception /= Void and then exception.ole_ptr /= default_pointer
		do
			if res = Void then
				ole2_dispatch_invoke (ole_interface_ptr, dispid,
							flags, params.ole_ptr, default_pointer, exception.ole_ptr)
			else
				ole2_dispatch_invoke (ole_interface_ptr, dispid,
							flags, params.ole_ptr, res.ole_ptr, exception.ole_ptr)
			end
		end

	get_ids_of_names (names: ARRAY [STRING]): ARRAY [INTEGER] is
			-- Maps `names' to their 'dispids'. First element
			-- in arrays correspond to member name, others
			-- to parameter names.
			-- Not meant to be redefined; redefine `on_get_ids_of_names' instead.
		require
			valid_interface: ole_interface_ptr /= default_pointer
			valid_names: names /= Void
		local
			i, count: INTEGER;
			wel_string: WEL_STRING
		do
			ole2_auto_erase_names
			from
				i := names.lower
			until
				i > names.upper
			loop
				!! wel_string.make (names.item (i))
				ole2_auto_add_name (wel_string.item)
				i := i + 1
			end
			ole2_dispatch_map_names (ole_interface_ptr)
			count := names.count
			!! Result.make (1, count)
			from
				i := 0
			until
				i >= count
			loop
				Result.put (ole2_auto_get_name_id (i), i + 1)
				i := i + 1
			end
		ensure
			good_mapping: names.count = Result.count
		end

	get_type_info: EOLE_TYPE_INFO is
			-- Type information
			-- Not meant to be redefined; redefine `on_get_type_info' instead.
		require
			valid_interface: ole_interface_ptr /= default_pointer
		do
			Result := ole2_dispatch_get_type_info (ole_interface_ptr)
		end

	get_type_info_count: INTEGER is
			-- Number of type interfaces supported
			-- May be only 0 or 1 - nothing else.
			-- Not meant to be redefined; redefine `on_get_type_info_count' instead.
		require
			valid_interface: ole_interface_ptr /= default_pointer
		do
			Result := ole2_dispatch_get_type_info_count (ole_interface_ptr)
		end
	
feature {EOLE_CALL_DISPATCHER} -- Callback

	on_query_interface (iid: STRING): POINTER is
			-- Query `iid' interface.
		do
			if iid.is_equal (Iid_dispatch) or iid.is_equal (Iid_unknown) then
				Current.add_ref
				Result := Current.ole_interface_ptr
				set_last_hresult (S_ok)
			else
				set_last_hresult (E_nointerface)
			end
		end

	on_invoke (dispid, flags: INTEGER; params: EOLE_DISPPARAMS; res: EOLE_VARIANT; exception: EOLE_EXCEPINFO) is
			-- Invoke method or property with `dispid' and arguments 
			-- `params' according to `flags'. Result is stored in 
			-- `res' and exception (if any) in `exception'.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_get_ids_of_names (names: ARRAY [STRING]): ARRAY [INTEGER] is
			-- Maps `names' to their 'dispids'. First element
			-- in arrays correspond to member name, others
			-- to parameter names.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_get_type_info: EOLE_TYPE_INFO is
			-- Type information
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_get_type_info_count: INTEGER is
			-- Number of type interfaces supported
			-- May be only 0 or 1 - nothing else.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end
	
feature {NONE} -- Externals

	ole2_dispatch_invoke (this: POINTER; dispid, flags: INTEGER; dispparams, variant_result, exception: POINTER) is
		external
			"C"
		alias
			"eole2_dispatch_invoke"
		end

	ole2_auto_erase_names is
		external
			"C"
		alias
			"eole2_auto_erase_names"
		end

	ole2_auto_add_name (str_ptr: POINTER) is
		external
			"C"
		alias
			"eole2_auto_add_name"
		end

	ole2_dispatch_map_names (this: POINTER) is
		external
			"C"
		alias
			"eole2_dispatch_map_names"
		end

	ole2_auto_get_name_id (pos: INTEGER): INTEGER is
		external
			"C"
		alias
			"eole2_auto_get_name_id"
		end

	ole2_dispatch_get_type_info (this: POINTER): EOLE_TYPE_INFO is
		external
			"C"
		alias
			"eole2_dispatch_get_type_info"
		end

	ole2_dispatch_get_type_info_count (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_dispatch_get_type_info_count"
		end
	
end -- class EOLE_DISPATCH

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
