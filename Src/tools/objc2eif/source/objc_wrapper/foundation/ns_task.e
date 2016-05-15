note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TASK

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

feature -- NSTask

	set_launch_path_ (a_path: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			objc_set_launch_path_ (item, a_path__item)
		end

	set_arguments_ (a_arguments: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_arguments__item: POINTER
		do
			if attached a_arguments as a_arguments_attached then
				a_arguments__item := a_arguments_attached.item
			end
			objc_set_arguments_ (item, a_arguments__item)
		end

	set_environment_ (a_dict: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_dict__item: POINTER
		do
			if attached a_dict as a_dict_attached then
				a_dict__item := a_dict_attached.item
			end
			objc_set_environment_ (item, a_dict__item)
		end

	set_current_directory_path_ (a_path: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			objc_set_current_directory_path_ (item, a_path__item)
		end

	set_standard_input_ (a_input: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_input__item: POINTER
		do
			if attached a_input as a_input_attached then
				a_input__item := a_input_attached.item
			end
			objc_set_standard_input_ (item, a_input__item)
		end

	set_standard_output_ (a_output: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_output__item: POINTER
		do
			if attached a_output as a_output_attached then
				a_output__item := a_output_attached.item
			end
			objc_set_standard_output_ (item, a_output__item)
		end

	set_standard_error_ (a_error: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_error__item: POINTER
		do
			if attached a_error as a_error_attached then
				a_error__item := a_error_attached.item
			end
			objc_set_standard_error_ (item, a_error__item)
		end

	launch_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_launch_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like launch_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like launch_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
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

	current_directory_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_current_directory_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like current_directory_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like current_directory_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	standard_input: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_standard_input (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like standard_input} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like standard_input} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	standard_output: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_standard_output (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like standard_output} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like standard_output} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	standard_error: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_standard_error (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like standard_error} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like standard_error} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	launch
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_launch (item)
		end

	interrupt
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_interrupt (item)
		end

	terminate
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_terminate (item)
		end

	suspend: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_suspend (item)
		end

	resume: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_resume (item)
		end

	process_identifier: INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_process_identifier (item)
		end

	is_running: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_running (item)
		end

	termination_status: INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_termination_status (item)
		end

	termination_reason: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_termination_reason (item)
		end

feature {NONE} -- NSTask Externals

	objc_set_launch_path_ (an_item: POINTER; a_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSTask *)$an_item setLaunchPath:$a_path];
			 ]"
		end

	objc_set_arguments_ (an_item: POINTER; a_arguments: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSTask *)$an_item setArguments:$a_arguments];
			 ]"
		end

	objc_set_environment_ (an_item: POINTER; a_dict: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSTask *)$an_item setEnvironment:$a_dict];
			 ]"
		end

	objc_set_current_directory_path_ (an_item: POINTER; a_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSTask *)$an_item setCurrentDirectoryPath:$a_path];
			 ]"
		end

	objc_set_standard_input_ (an_item: POINTER; a_input: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSTask *)$an_item setStandardInput:$a_input];
			 ]"
		end

	objc_set_standard_output_ (an_item: POINTER; a_output: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSTask *)$an_item setStandardOutput:$a_output];
			 ]"
		end

	objc_set_standard_error_ (an_item: POINTER; a_error: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSTask *)$an_item setStandardError:$a_error];
			 ]"
		end

	objc_launch_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTask *)$an_item launchPath];
			 ]"
		end

	objc_arguments (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTask *)$an_item arguments];
			 ]"
		end

	objc_environment (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTask *)$an_item environment];
			 ]"
		end

	objc_current_directory_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTask *)$an_item currentDirectoryPath];
			 ]"
		end

	objc_standard_input (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTask *)$an_item standardInput];
			 ]"
		end

	objc_standard_output (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTask *)$an_item standardOutput];
			 ]"
		end

	objc_standard_error (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTask *)$an_item standardError];
			 ]"
		end

	objc_launch (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSTask *)$an_item launch];
			 ]"
		end

	objc_interrupt (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSTask *)$an_item interrupt];
			 ]"
		end

	objc_terminate (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSTask *)$an_item terminate];
			 ]"
		end

	objc_suspend (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSTask *)$an_item suspend];
			 ]"
		end

	objc_resume (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSTask *)$an_item resume];
			 ]"
		end

	objc_process_identifier (an_item: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSTask *)$an_item processIdentifier];
			 ]"
		end

	objc_is_running (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSTask *)$an_item isRunning];
			 ]"
		end

	objc_termination_status (an_item: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSTask *)$an_item terminationStatus];
			 ]"
		end

	objc_termination_reason (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSTask *)$an_item terminationReason];
			 ]"
		end

feature -- NSTaskConveniences

	wait_until_exit
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_wait_until_exit (item)
		end

feature {NONE} -- NSTaskConveniences Externals

	objc_wait_until_exit (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSTask *)$an_item waitUntilExit];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTask"
		end

end
