note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PROCESS_INFO

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

feature -- NSProcessInfo

	environment: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_environment (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like environment} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like environment} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	arguments: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_arguments (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like arguments} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like arguments} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	host_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_host_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like host_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like host_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	process_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_process_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like process_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like process_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	process_identifier: INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_process_identifier (item)
		end

	set_process_name_ (a_new_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_new_name__item: POINTER
		do
			if attached a_new_name as a_new_name_attached then
				a_new_name__item := a_new_name_attached.item
			end
			objc_set_process_name_ (item, a_new_name__item)
		end

	globally_unique_string: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_globally_unique_string (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like globally_unique_string} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like globally_unique_string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	operating_system: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_operating_system (item)
		end

	operating_system_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_operating_system_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like operating_system_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like operating_system_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	operating_system_version_string: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_operating_system_version_string (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like operating_system_version_string} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like operating_system_version_string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	processor_count: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_processor_count (item)
		end

	active_processor_count: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_active_processor_count (item)
		end

	physical_memory: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_physical_memory (item)
		end

	system_uptime: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_system_uptime (item)
		end

	disable_sudden_termination
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_disable_sudden_termination (item)
		end

	enable_sudden_termination
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_enable_sudden_termination (item)
		end

feature {NONE} -- NSProcessInfo Externals

	objc_environment (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSProcessInfo *)$an_item environment];
			 ]"
		end

	objc_arguments (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSProcessInfo *)$an_item arguments];
			 ]"
		end

	objc_host_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSProcessInfo *)$an_item hostName];
			 ]"
		end

	objc_process_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSProcessInfo *)$an_item processName];
			 ]"
		end

	objc_process_identifier (an_item: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSProcessInfo *)$an_item processIdentifier];
			 ]"
		end

	objc_set_process_name_ (an_item: POINTER; a_new_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSProcessInfo *)$an_item setProcessName:$a_new_name];
			 ]"
		end

	objc_globally_unique_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSProcessInfo *)$an_item globallyUniqueString];
			 ]"
		end

	objc_operating_system (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSProcessInfo *)$an_item operatingSystem];
			 ]"
		end

	objc_operating_system_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSProcessInfo *)$an_item operatingSystemName];
			 ]"
		end

	objc_operating_system_version_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSProcessInfo *)$an_item operatingSystemVersionString];
			 ]"
		end

	objc_processor_count (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSProcessInfo *)$an_item processorCount];
			 ]"
		end

	objc_active_processor_count (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSProcessInfo *)$an_item activeProcessorCount];
			 ]"
		end

	objc_physical_memory (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSProcessInfo *)$an_item physicalMemory];
			 ]"
		end

	objc_system_uptime (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSProcessInfo *)$an_item systemUptime];
			 ]"
		end

	objc_disable_sudden_termination (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSProcessInfo *)$an_item disableSuddenTermination];
			 ]"
		end

	objc_enable_sudden_termination (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSProcessInfo *)$an_item enableSuddenTermination];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSProcessInfo"
		end

end
