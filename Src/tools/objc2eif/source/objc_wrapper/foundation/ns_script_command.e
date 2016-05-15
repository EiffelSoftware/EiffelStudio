note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCRIPT_COMMAND

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_command_description_,
	make

feature {NONE} -- Initialization

	make_with_command_description_ (a_command_def: detachable NS_SCRIPT_COMMAND_DESCRIPTION)
			-- Initialize `Current'.
		local
			a_command_def__item: POINTER
		do
			if attached a_command_def as a_command_def_attached then
				a_command_def__item := a_command_def_attached.item
			end
			make_with_pointer (objc_init_with_command_description_(allocate_object, a_command_def__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSScriptCommand Externals

	objc_init_with_command_description_ (an_item: POINTER; a_command_def: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptCommand *)$an_item initWithCommandDescription:$a_command_def];
			 ]"
		end

	objc_command_description (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptCommand *)$an_item commandDescription];
			 ]"
		end

	objc_set_direct_parameter_ (an_item: POINTER; a_direct_parameter: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptCommand *)$an_item setDirectParameter:$a_direct_parameter];
			 ]"
		end

	objc_direct_parameter (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptCommand *)$an_item directParameter];
			 ]"
		end

	objc_set_receivers_specifier_ (an_item: POINTER; a_receivers_ref: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptCommand *)$an_item setReceiversSpecifier:$a_receivers_ref];
			 ]"
		end

	objc_receivers_specifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptCommand *)$an_item receiversSpecifier];
			 ]"
		end

	objc_evaluated_receivers (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptCommand *)$an_item evaluatedReceivers];
			 ]"
		end

	objc_set_arguments_ (an_item: POINTER; a_args: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptCommand *)$an_item setArguments:$a_args];
			 ]"
		end

	objc_arguments (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptCommand *)$an_item arguments];
			 ]"
		end

	objc_evaluated_arguments (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptCommand *)$an_item evaluatedArguments];
			 ]"
		end

	objc_is_well_formed (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScriptCommand *)$an_item isWellFormed];
			 ]"
		end

	objc_perform_default_implementation (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptCommand *)$an_item performDefaultImplementation];
			 ]"
		end

	objc_execute_command (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptCommand *)$an_item executeCommand];
			 ]"
		end

	objc_set_script_error_number_ (an_item: POINTER; a_error_number: INTEGER_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptCommand *)$an_item setScriptErrorNumber:$a_error_number];
			 ]"
		end

	objc_set_script_error_offending_object_descriptor_ (an_item: POINTER; a_error_offending_object_descriptor: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptCommand *)$an_item setScriptErrorOffendingObjectDescriptor:$a_error_offending_object_descriptor];
			 ]"
		end

	objc_set_script_error_expected_type_descriptor_ (an_item: POINTER; a_error_expected_type_descriptor: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptCommand *)$an_item setScriptErrorExpectedTypeDescriptor:$a_error_expected_type_descriptor];
			 ]"
		end

	objc_set_script_error_string_ (an_item: POINTER; a_error_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptCommand *)$an_item setScriptErrorString:$a_error_string];
			 ]"
		end

	objc_script_error_number (an_item: POINTER): INTEGER_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScriptCommand *)$an_item scriptErrorNumber];
			 ]"
		end

	objc_script_error_offending_object_descriptor (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptCommand *)$an_item scriptErrorOffendingObjectDescriptor];
			 ]"
		end

	objc_script_error_expected_type_descriptor (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptCommand *)$an_item scriptErrorExpectedTypeDescriptor];
			 ]"
		end

	objc_script_error_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptCommand *)$an_item scriptErrorString];
			 ]"
		end

	objc_apple_event (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptCommand *)$an_item appleEvent];
			 ]"
		end

	objc_suspend_execution (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptCommand *)$an_item suspendExecution];
			 ]"
		end

	objc_resume_execution_with_result_ (an_item: POINTER; a_result: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptCommand *)$an_item resumeExecutionWithResult:$a_result];
			 ]"
		end

feature -- NSScriptCommand

	command_description: detachable NS_SCRIPT_COMMAND_DESCRIPTION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_command_description (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like command_description} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like command_description} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_direct_parameter_ (a_direct_parameter: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_direct_parameter__item: POINTER
		do
			if attached a_direct_parameter as a_direct_parameter_attached then
				a_direct_parameter__item := a_direct_parameter_attached.item
			end
			objc_set_direct_parameter_ (item, a_direct_parameter__item)
		end

	direct_parameter: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_direct_parameter (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like direct_parameter} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like direct_parameter} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_receivers_specifier_ (a_receivers_ref: detachable NS_SCRIPT_OBJECT_SPECIFIER)
			-- Auto generated Objective-C wrapper.
		local
			a_receivers_ref__item: POINTER
		do
			if attached a_receivers_ref as a_receivers_ref_attached then
				a_receivers_ref__item := a_receivers_ref_attached.item
			end
			objc_set_receivers_specifier_ (item, a_receivers_ref__item)
		end

	receivers_specifier: detachable NS_SCRIPT_OBJECT_SPECIFIER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_receivers_specifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like receivers_specifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like receivers_specifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	evaluated_receivers: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_evaluated_receivers (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like evaluated_receivers} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like evaluated_receivers} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_arguments_ (a_args: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_args__item: POINTER
		do
			if attached a_args as a_args_attached then
				a_args__item := a_args_attached.item
			end
			objc_set_arguments_ (item, a_args__item)
		end

	arguments: detachable NS_DICTIONARY
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

	evaluated_arguments: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_evaluated_arguments (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like evaluated_arguments} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like evaluated_arguments} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_well_formed: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_well_formed (item)
		end

	perform_default_implementation: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_perform_default_implementation (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like perform_default_implementation} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like perform_default_implementation} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	execute_command: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_execute_command (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like execute_command} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like execute_command} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_script_error_number_ (a_error_number: INTEGER_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_script_error_number_ (item, a_error_number)
		end

	set_script_error_offending_object_descriptor_ (a_error_offending_object_descriptor: detachable NS_APPLE_EVENT_DESCRIPTOR)
			-- Auto generated Objective-C wrapper.
		local
			a_error_offending_object_descriptor__item: POINTER
		do
			if attached a_error_offending_object_descriptor as a_error_offending_object_descriptor_attached then
				a_error_offending_object_descriptor__item := a_error_offending_object_descriptor_attached.item
			end
			objc_set_script_error_offending_object_descriptor_ (item, a_error_offending_object_descriptor__item)
		end

	set_script_error_expected_type_descriptor_ (a_error_expected_type_descriptor: detachable NS_APPLE_EVENT_DESCRIPTOR)
			-- Auto generated Objective-C wrapper.
		local
			a_error_expected_type_descriptor__item: POINTER
		do
			if attached a_error_expected_type_descriptor as a_error_expected_type_descriptor_attached then
				a_error_expected_type_descriptor__item := a_error_expected_type_descriptor_attached.item
			end
			objc_set_script_error_expected_type_descriptor_ (item, a_error_expected_type_descriptor__item)
		end

	set_script_error_string_ (a_error_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_error_string__item: POINTER
		do
			if attached a_error_string as a_error_string_attached then
				a_error_string__item := a_error_string_attached.item
			end
			objc_set_script_error_string_ (item, a_error_string__item)
		end

	script_error_number: INTEGER_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_script_error_number (item)
		end

	script_error_offending_object_descriptor: detachable NS_APPLE_EVENT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_script_error_offending_object_descriptor (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like script_error_offending_object_descriptor} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like script_error_offending_object_descriptor} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	script_error_expected_type_descriptor: detachable NS_APPLE_EVENT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_script_error_expected_type_descriptor (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like script_error_expected_type_descriptor} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like script_error_expected_type_descriptor} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	script_error_string: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_script_error_string (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like script_error_string} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like script_error_string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	apple_event: detachable NS_APPLE_EVENT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_apple_event (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like apple_event} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like apple_event} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	suspend_execution
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_suspend_execution (item)
		end

	resume_execution_with_result_ (a_result: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_result__item: POINTER
		do
			if attached a_result as a_result_attached then
				a_result__item := a_result_attached.item
			end
			objc_resume_execution_with_result_ (item, a_result__item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSScriptCommand"
		end

end
