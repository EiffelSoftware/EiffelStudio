note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_RUNNING_APPLICATION_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSRunningApplication

	running_applications_with_bundle_identifier_ (a_bundle_identifier: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_bundle_identifier__item: POINTER
		do
			if attached a_bundle_identifier as a_bundle_identifier_attached then
				a_bundle_identifier__item := a_bundle_identifier_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_running_applications_with_bundle_identifier_ (l_objc_class.item, a_bundle_identifier__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like running_applications_with_bundle_identifier_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like running_applications_with_bundle_identifier_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	running_application_with_process_identifier_ (a_pid: INTEGER_32): detachable NS_RUNNING_APPLICATION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_running_application_with_process_identifier_ (l_objc_class.item, a_pid)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like running_application_with_process_identifier_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like running_application_with_process_identifier_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	current_application: detachable NS_RUNNING_APPLICATION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_current_application (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like current_application} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like current_application} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSRunningApplication Externals

	objc_running_applications_with_bundle_identifier_ (a_class_object: POINTER; a_bundle_identifier: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object runningApplicationsWithBundleIdentifier:$a_bundle_identifier];
			 ]"
		end

	objc_running_application_with_process_identifier_ (a_class_object: POINTER; a_pid: INTEGER_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object runningApplicationWithProcessIdentifier:$a_pid];
			 ]"
		end

	objc_current_application (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object currentApplication];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSRunningApplication"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
