indexing

	description: "Miscellaneous OLE functions including OLE%
					%initialization and uninitialization."
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"
	
class
	EOLE_COM
	
inherit
	EOLE_CLSCTX

	EOLE_GUID
	
	EOLE_REGISTER_FLAGS

creation
	make
	
feature -- Initialization

	make is
			-- Create `status'
		do
			!! status
		end
		
feature -- Access

	co_build_version_major: INTEGER is
			-- Major build number of the OLE libraries.
		do
			Result := ole2_co_build_version_major
		end

	co_build_version_minor: INTEGER is
			-- Minor build number of the OLE libraries.
		do
			Result := ole2_co_build_version_minor
		end

	status: EOLE_RESULT
			-- OLE function result manager
			
feature -- Element change

	co_initialize: INTEGER is
			-- Initialize COM. Should be
			-- called before any other OLE function.
			-- Result is S_ok if successful,
			-- S_false if not.
		do
			Result := ole2_co_initialize
		end

	ole_initialize: INTEGER is
			-- Initialize COM. Should be
			-- called before any other OLE function.
			-- Result is S_ok if successful.
			-- Internally call co_initialize.
		do
			Result := ole2_ole_initialize
		end
		
	co_uninitialize is
			-- Finish COM use. Should be
			-- called after any other OLE function.
			-- Internally call co_uninitialize.
		do
			ole2_co_uninitialize
		end

	ole_uninitialize is
			-- Finish COM use. Should be
			-- called after any other OLE function.
		do
			ole2_ole_uninitialize
		end
		
	co_create_instance (clsid: STRING; punk_outer: POINTER; context: INTEGER; iid: STRING): POINTER is
			-- Create single uninitialized object of class associated with 
			-- `clsid' according to `context'. `punk_outer' is a pointer to
			-- aggregate object’s IUnknown interface. (Void if not created
			-- as part of an aggregate). `iid' is the required interface.
			-- See EOLE_CLSCTX for `context' value.
		require
			valid_clsid: is_valid_guid (clsid)
			valid_context: is_valid_clsctx (context)
			valid_iid: is_valid_guid (iid)
		local
			wel_string1, wel_string2: WEL_STRING
		do
			!! wel_string1.make (clsid)
			!! wel_string2.make (iid)
			Result := ole2_co_create_instance (wel_string1.item, punk_outer, context, wel_string2.item)
		end
	
	co_get_class_object (clsid: STRING; context: INTEGER; iid: STRING): POINTER is
			-- Provide pointer to C++ interface `iid' on class object 
			-- associated with CLSID `clsid' according to `context'. 
		require
			valid_clsid: is_valid_guid (clsid)
			valid_context: is_valid_clsctx (context)
			valid_iid: is_valid_guid (iid)
		local
			wel_string1, wel_string2: WEL_STRING
		do
			!! wel_string1.make (clsid)
			!! wel_string2.make (iid)
			Result := ole2_co_get_class_object (wel_string1.item, context, wel_string2.item)
		end			
	
	co_register_class_object (clsid: STRING; class_factory: EOLE_CLASS_FACTORY; context, flags: INTEGER): INTEGER is
			-- Register class factory `class_factory' with class identifier `clsid'
			-- according to `context'. `flags' specify whether class factory can
			-- be used by more than one consumer at a time.
			-- See class EOLE_CLSCTX for `context' value.
			-- See class EOLE_REGISTER_FLAGS for `flags' value.
		require
			valid_clsid: is_valid_guid (clsid)
			valid_class_factory: class_factory /= Void and then 
									class_factory.ole_interface_ptr /= default_pointer
			valid_context: is_valid_clsctx (context)
			valid_flags: is_valid_register_flag (flags)
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (clsid)
			Result := ole2_co_register_class_object (wel_string.item, class_factory.ole_interface_ptr, context, flags)
		end
		
	co_revoke_class_object (token: INTEGER) is
			-- Inform OLE that class object previously registered with 
			-- `co_register_class_object' is no longer available for use.
		do
			ole2_co_revoke_class_object (token)
		end
		
feature {NONE} -- Externals

	ole2_co_initialize: INTEGER is
		external
			"C"
		alias
			"eole2_co_initialize"
		end
		
	ole2_ole_initialize: INTEGER is
		external
			"C"
		alias
			"eole2_ole_initialize"
		end
		
	ole2_co_uninitialize is
		external
			"C"
		alias
			"eole2_co_uninitialize"
		end

	ole2_ole_uninitialize is
		external
			"C"
		alias
			"eole2_ole_uninitialize"
		end
		
	ole2_co_build_version_major: INTEGER is
		external
			"C"
		alias
			"eole2_co_build_version_major"
		end

	ole2_co_build_version_minor: INTEGER is
		external
			"C"
		alias
			"eole2_co_build_version_minor"
		end

	ole2_co_create_instance (clsid, punk_outer: POINTER; context: INTEGER; iid: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_co_create_instance"
		end

	ole2_co_get_class_object (clsid: POINTER; context: INTEGER; iid: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_co_get_class_object"
		end
		
	ole2_co_register_class_object (clsid, class_factory: POINTER; context, flags: INTEGER): INTEGER is
		external
			"C"
		alias
			"eole2_co_register_class_object"
		end

	ole2_co_revoke_class_object (token: INTEGER) is
		external
			"C"
		alias
			"eole2_co_revoke_class_object"
		end
		
end -- class EOLE_COM

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

