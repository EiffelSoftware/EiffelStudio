note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_HELP_MANAGER_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSHelpManager

	shared_help_manager: detachable NS_HELP_MANAGER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_shared_help_manager (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like shared_help_manager} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like shared_help_manager} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_context_help_mode_active_ (a_active: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_context_help_mode_active_ (l_objc_class.item, a_active)
		end

	is_context_help_mode_active: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_is_context_help_mode_active (l_objc_class.item)
		end

feature {NONE} -- NSHelpManager Externals

	objc_shared_help_manager (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object sharedHelpManager];
			 ]"
		end

	objc_set_context_help_mode_active_ (a_class_object: POINTER; a_active: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object setContextHelpModeActive:$a_active];
			 ]"
		end

	objc_is_context_help_mode_active (a_class_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object isContextHelpModeActive];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSHelpManager"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
