note
	description: "Light COM object"
	date: "$Date$"
	revision: "$Revision$"

class
	COM_OBJECT

inherit
	COM_IDISPATCH_INVOKE_CONSTANTS

	DISPOSABLE

create
	make_by_pointer,
	make_with_program_id,
	make_active_object_with_program_id

feature {NONE} -- Initialization

	make_by_pointer (an_item: POINTER)
			-- Initialize Current with `an_item'.
		require
			an_item_not_null: an_item /= default_pointer
		do
			debug ("COM_OBJECT")
				io.put_string ("["+generating_type.name+"].make_by_pointer("+an_item.out+") called")
				io.put_new_line
			end
			item := an_item
		ensure
			item_set: item = an_item
		end

	make_with_program_id (a_name: READABLE_STRING_GENERAL)
			-- Initialization
			-- Example of program ID: "Word.Application"
			-- CLS context defaults to all.
		local
			l_uname: COM_BSTR_STRING
			l_clsid: like clsid
		do
			(create {COM_EXTERNALS}).initialize_com
			create l_clsid.make_empty
			clsid := l_clsid
			create l_uname.make_from_string (a_name)
			last_call_success := clsid_from_prog_id (l_uname.item, l_clsid.item)

			if is_successful then
				last_call_success := com_create_instance (l_clsid.item, default_pointer, clsctx_all, $item)
				if not is_successful then
					item := default_pointer
				end
			end
		end

	make_active_object_with_program_id (a_name: READABLE_STRING_GENERAL)
			-- Initialize with running object of `a_name'
			-- Example of program ID: "Word.Application"
		local
			l_uname: COM_BSTR_STRING
			l_clsid: like clsid
		do
			(create {COM_EXTERNALS}).initialize_com
			create l_clsid.make_empty
			clsid := l_clsid
			create l_uname.make_from_string (a_name)
			last_call_success := clsid_from_prog_id (l_uname.item, l_clsid.item)

			if is_successful then
				last_call_success := com_get_active_object (l_clsid.item, $item)
				if not is_successful then
					item := default_pointer
				end
			end
		end

feature -- Method	

	call_method (a_name: STRING; a_args: detachable TUPLE)
			-- Call OLE method
		require
			exists: exists
			a_args_valid: valid_arguments (a_args)
		do
			call (dispatch_method, a_name, a_args)
		end

	call_property_get (a_name: STRING; a_args: detachable TUPLE)
			-- Call OLE property get
		require
			exists: exists
			a_args_valid: valid_arguments (a_args)
		do
			call (dispatch_propertyget, a_name, a_args)
		end

	call_property_put (a_name: STRING; a_args: detachable TUPLE)
			-- Call OLE property put
		require
			exists: exists
			a_args_valid: valid_arguments (a_args)
		do
			call (dispatch_propertyput, a_name, a_args)
		end

	call_property_put_ref (a_name: STRING; a_args: detachable TUPLE)
			-- Call OLE property put ref
		require
			exists: exists
			a_args_valid: valid_arguments (a_args)
		do
			call (dispatch_propertyputref, a_name, a_args)
		end

feature -- Access

	last_object: detachable COM_OBJECT
			-- Last object from call result
		do
			if attached last_variant_result as l_variant and then l_variant.idispatch /= default_pointer then
				create Result.make_by_pointer (l_variant.idispatch)
			end
		end

	last_string: detachable STRING_32
			-- Last string from call result
		do
			if attached last_variant_result as l_variant then
				Result := l_variant.string
			end
		end

feature -- Status report

	exists: BOOLEAN
			-- Is Current properly associated to a COM object?
		do
			Result := item /= default_pointer
		end

	is_successful: BOOLEAN
			-- Was last call to a COM routine of `Current' successful?
		do
			Result := last_call_success = 0
		end

	valid_arguments (a_args: detachable TUPLE): BOOLEAN
			-- Is `a_args' valid as arguments of OLE method call?
		local
			i: INTEGER
			l_item: detachable separate ANY
		do
			if attached a_args as l_args then
				from
					i := 1
					Result := True
				until
					i > l_args.count or else not Result
				loop
					l_item := l_args.item (i)
					Result := attached {COM_VARIANT} l_item or else
						attached {READABLE_STRING_GENERAL} l_item or else
						attached {INTEGER_32} l_item or else
						attached {BOOLEAN} l_item or else
						l_item = Void
							-- Can be extended later, if needed
					i := i + 1
				end
			else
				Result := True
			end
		end

feature {NONE} -- Access

	item: POINTER
			-- Access to underlying COM object.

	last_call_success: INTEGER
			-- Result of last COM calls. When successful it should be `0'.

feature {NONE} -- Access

	clsid: detachable WEL_GUID
			-- CLSID related to current

	last_variant_result: detachable COM_VARIANT
			-- Last variant result

feature {NONE} -- Call

	call (a_ntype: INTEGER; a_name: STRING; a_args: detachable TUPLE)
			-- Call OLE method on current object by `a_name'.
		require
			exists: exists
			args_valid: valid_arguments (a_args)
			valid_ntype: valid_type (a_ntype)
		local
			l_bstr: COM_BSTR_STRING
			l_args_pointer: POINTER
			l_v: COM_VARIANT
			l_args_count: INTEGER
			l_managed_pointer: MANAGED_POINTER
			i: INTEGER
			l_arrayed_list: ARRAYED_LIST [COM_VARIANT]
			l_error: INTEGER
		do
			create l_bstr.make_from_string (a_name)
			if attached a_args as l_args and then l_args.count > 0 then
				l_args_count := l_args.count
					-- Put pointers of VARIANT into memory pointed by managed pointer.
				create l_managed_pointer.make ({PLATFORM}.pointer_bytes * l_args_count)
				create l_arrayed_list.make (l_args_count)
				from
					i := 1
				until
					i > l_args_count
				loop
					if attached variant_from_tuple (l_args, i) as l_variant then
						l_managed_pointer.put_pointer (l_variant.item, (i - 1) * {PLATFORM}.pointer_bytes)
							-- Keep the reference, in case it is garbage collected.
						l_arrayed_list.extend (l_variant)
					else
						l_managed_pointer.put_pointer (default_pointer, (i - 1) * {PLATFORM}.pointer_bytes)
					end
					i := i + 1
				end
				l_args_pointer := l_managed_pointer.item
			end
			create l_v.make
			last_call_success := cpp_ole_method (a_ntype, l_v.item, item, l_bstr.item, l_args_count, l_args_pointer, $l_error)

			if last_call_success = {COM_EXTERNALS}.com_s_ok then
				last_variant_result := l_v
			else
				last_variant_result := Void
			end
		end

	variant_from_tuple (a_tuple: TUPLE; a_index: INTEGER): detachable COM_VARIANT
			-- Variant from item of `a_index' from `a_tuple'
		require
			args_valid: valid_arguments (a_tuple)
			a_index_valid: a_tuple.valid_index (a_index)
		do
			if attached {COM_VARIANT} a_tuple.item (a_index) as l_v then
				Result := l_v
			elseif attached {READABLE_STRING_GENERAL} a_tuple.item (a_index) as l_string then
				create Result.make_from_string (l_string)
			elseif a_tuple.is_integer_32_item (a_index) then
				create Result.make_from_integer_32 (a_tuple.integer_32_item (a_index))
			elseif a_tuple.is_boolean_item (a_index) then
				create Result.make_from_boolean (a_tuple.boolean_item (a_index))
			else
				-- Can be extended later, if needed
			end
		end

feature {NONE} -- Disposal

	dispose
			-- Free `item'.
		local
			l_nb_ref: INTEGER
		do
			if item /= Default_pointer then
				debug ("COM_OBJECT")
					dispose_debug_output (1, item, $Current, 0)
				end
				l_nb_ref := {COM_EXTERNALS}.release (item)
				item := default_pointer
				debug ("COM_OBJECT")
					dispose_debug_output (2, item, $Current, l_nb_ref)
				end
			end
		ensure then
			item_null: item = default_pointer
		end

	dispose_debug_output (type: INTEGER; a_ptr: POINTER; an_obj: POINTER; a_nb_ref: INTEGER)
			-- Safe display while disposing. If `type' is `1' then
			-- we are entering `dispose', else we are leaving it.
			-- `a_ptr' is the item being freed in current object `an_obj'.
		external
			"C inline use <stdio.h>, %"eif_gen_conf.h%""
		alias
			"[
#ifndef EIF_IL_DLL
				if ($type == 1) {
					printf ("\nEntering dispose of %s with item value 0x%" EIF_POINTER_DISPLAY "\n", eif_typename_id(Dftype($an_obj)), (rt_uint_ptr) $a_ptr);
				} else {
					printf ("Quitting dispose with item value 0x%" EIF_POINTER_DISPLAY " nb_ref[%d]\n", (rt_uint_ptr) $a_ptr, $a_nb_ref);
				}
#endif
			]"
		end

feature {NONE} -- Externals

	clsctx_local_server: INTEGER_32
		external
			"C [macro <Objbase.h>] : EIF_INTEGER"
		alias
			"CLSCTX_LOCAL_SERVER"
		ensure
			is_class: class
		end

	clsctx_inproc_server: INTEGER_32
		external
			"C [macro <Objbase.h>] : EIF_INTEGER"
		alias
			"CLSCTX_INPROC_SERVER"
		ensure
			is_class: class
		end

	clsctx_remote_server: INTEGER_32
		external
			"C [macro <Objbase.h>] : EIF_INTEGER"
		alias
			"CLSCTX_REMOTE_SERVER"
		ensure
			is_class: class
		end

	clsctx_inproc_handler: INTEGER_32
		external
			"C [macro <Objbase.h>] : EIF_INTEGER"
		alias
			"CLSCTX_INPROC_HANDLER"
		ensure
			is_class: class
		end

	clsctx_all: INTEGER_32
		external
			"C [macro <Objbase.h>] : EIF_INTEGER"
		alias
			"CLSCTX_ALL"
		ensure
			is_class: class
		end

	clsid_from_prog_id (a_str: POINTER; a_clsid: POINTER): INTEGER_32
		external
			"C inline use <Objbase.h>"
		alias
			"CLSIDFromProgID ((LPCOLESTR)$a_str, (LPCLSID)$a_clsid)"
		ensure
			is_class: class
		end

	com_create_instance (a_rclsid: POINTER; a_unknown: POINTER; a_dwclscontext: INTEGER; a_app_pointer: TYPED_POINTER [POINTER]): INTEGER_32
		external
			"C++ inline use <Objbase.h>"
		alias
			"CoCreateInstance ((REFCLSID)(*(CLSID *)$a_rclsid), (LPUNKNOWN)$a_unknown, (DWORD)$a_dwclscontext, IID_IDispatch, (LPVOID *)$a_app_pointer)"
		ensure
			is_class: class
		end

	com_get_active_object (a_rclsid: POINTER; a_app_pointer: TYPED_POINTER [POINTER]): INTEGER_32
		external
			"C++ inline use <Objbase.h>"
		alias
			"[
				IUnknown *pUnk = NULL;
				HRESULT hr = GetActiveObject ((REFCLSID)(*(CLSID *)$a_rclsid), NULL, (IUnknown **)&pUnk);
				if(!FAILED(hr)) {
					hr = pUnk->QueryInterface(IID_IDispatch, (LPVOID *)$a_app_pointer);
				}
				return hr;
			]"
		ensure
			is_class: class
		end

	cpp_ole_method (a_ntype: INTEGER; a_variant_result: POINTER; a_dispatch: POINTER; a_c_str_name: POINTER; arg_count: INTEGER; a_args: POINTER; a_err: TYPED_POINTER [INTEGER]): INTEGER
			-- `a_err' returns index within rgvarg of the first parameter that has an error,
			-- when the resulting return value of `Invoke' is DISP_E_TYPEMISMATCH or DISP_E_PARAMNOTFOUND.
		require
			a_dispatch_set: a_dispatch /= default_pointer
			a_variant_result_set: a_variant_result /= default_pointer
			a_args_exists: arg_count > 0 implies a_args /= default_pointer
		external
			"C++ inline use <OleAuto.h>"
		alias
			"[
				DISPPARAMS dp = { NULL, NULL, 0, 0 };
				DISPID dispidNamed = DISPID_PROPERTYPUT;
				DISPID dispID;

				// Get DISPID for name passed.
				HRESULT hr = ((IDispatch *)$a_dispatch)->GetIDsOfNames(IID_NULL, (LPOLESTR *)&$a_c_str_name, 1, LOCALE_USER_DEFAULT, &dispID);
				if(!FAILED(hr)) {
					// Allocate memory for arguments.
					VARIANT *pArgs = new VARIANT[$arg_count+1];

					// Fetch arguments from Eiffel pointers.
					for(int i=0; i<$arg_count; i++) {
						/* pArgs should be in reverse order */
						/* ref: http://msdn.microsoft.com/en-us/library/aa912367.aspx */
						pArgs[$arg_count - i - 1] = *(VARIANT *)(*(((EIF_POINTER *)$a_args) + i));
					}

					// Build DISPPARAMS
					dp.cArgs = $arg_count;
					dp.rgvarg = pArgs;

					// Handle special-case for property-puts!
					if($a_ntype & DISPATCH_PROPERTYPUT) {
						dp.cNamedArgs = 1;
						dp.rgdispidNamedArgs = &dispidNamed;
					}

					// Make the call!
					hr = ((IDispatch *)$a_dispatch)->Invoke(dispID, IID_NULL, LOCALE_SYSTEM_DEFAULT, $a_ntype, &dp, (VARIANT *)$a_variant_result, NULL, (UINT *)$a_err);

					delete [] pArgs;
				}
				return hr;
			]"
		ensure
			is_class: class
		end

feature {NONE} -- COM Ref management

	cpp_addref (a_pointer: POINTER): INTEGER
			-- AddRef COM objects
		external
			"C++ IUnknown use %"unknwn.h%""
		alias
			"AddRef"
		ensure
			is_class: class
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
