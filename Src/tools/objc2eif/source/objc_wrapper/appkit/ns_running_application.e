note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_RUNNING_APPLICATION

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSRunningApplication

	hide: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_hide (item)
		end

	unhide: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_unhide (item)
		end

	activate_with_options_ (a_options: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_activate_with_options_ (item, a_options)
		end

	terminate: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_terminate (item)
		end

	force_terminate: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_force_terminate (item)
		end

feature {NONE} -- NSRunningApplication Externals

	objc_hide (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRunningApplication *)$an_item hide];
			 ]"
		end

	objc_unhide (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRunningApplication *)$an_item unhide];
			 ]"
		end

	objc_activate_with_options_ (an_item: POINTER; a_options: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRunningApplication *)$an_item activateWithOptions:$a_options];
			 ]"
		end

	objc_terminate (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRunningApplication *)$an_item terminate];
			 ]"
		end

	objc_force_terminate (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRunningApplication *)$an_item forceTerminate];
			 ]"
		end

feature -- Properties

	is_terminated: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_is_terminated (item)
		end

	is_finished_launching: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_is_finished_launching (item)
		end

	is_hidden: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_is_hidden (item)
		end

	is_active: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_is_active (item)
		end

	activation_policy: INTEGER_64
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_activation_policy (item)
		end

	localized_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_localized_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	bundle_identifier: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_bundle_identifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like bundle_identifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like bundle_identifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	bundle_url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_bundle_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like bundle_url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like bundle_url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	executable_url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_executable_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like executable_url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like executable_url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	process_identifier: INTEGER_32
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_process_identifier (item)
		end

	launch_date: detachable NS_DATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_launch_date (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like launch_date} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like launch_date} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	icon: detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_icon (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like icon} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like icon} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	executable_architecture: INTEGER_64
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_executable_architecture (item)
		end

feature {NONE} -- Properties Externals

	objc_is_terminated (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRunningApplication *)$an_item isTerminated];
			 ]"
		end

	objc_is_finished_launching (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRunningApplication *)$an_item isFinishedLaunching];
			 ]"
		end

	objc_is_hidden (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRunningApplication *)$an_item isHidden];
			 ]"
		end

	objc_is_active (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRunningApplication *)$an_item isActive];
			 ]"
		end

	objc_activation_policy (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRunningApplication *)$an_item activationPolicy];
			 ]"
		end

	objc_localized_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRunningApplication *)$an_item localizedName];
			 ]"
		end

	objc_bundle_identifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRunningApplication *)$an_item bundleIdentifier];
			 ]"
		end

	objc_bundle_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRunningApplication *)$an_item bundleURL];
			 ]"
		end

	objc_executable_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRunningApplication *)$an_item executableURL];
			 ]"
		end

	objc_process_identifier (an_item: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRunningApplication *)$an_item processIdentifier];
			 ]"
		end

	objc_launch_date (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRunningApplication *)$an_item launchDate];
			 ]"
		end

	objc_icon (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRunningApplication *)$an_item icon];
			 ]"
		end

	objc_executable_architecture (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRunningApplication *)$an_item executableArchitecture];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSRunningApplication"
		end

end
