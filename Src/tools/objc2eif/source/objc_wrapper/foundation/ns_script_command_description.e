note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCRIPT_COMMAND_DESCRIPTION

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
	make_with_suite_name__command_name__dictionary_,
	make

feature {NONE} -- Initialization

	make_with_suite_name__command_name__dictionary_ (a_suite_name: detachable NS_STRING; a_command_name: detachable NS_STRING; a_command_declaration: detachable NS_DICTIONARY)
			-- Initialize `Current'.
		local
			a_suite_name__item: POINTER
			a_command_name__item: POINTER
			a_command_declaration__item: POINTER
		do
			if attached a_suite_name as a_suite_name_attached then
				a_suite_name__item := a_suite_name_attached.item
			end
			if attached a_command_name as a_command_name_attached then
				a_command_name__item := a_command_name_attached.item
			end
			if attached a_command_declaration as a_command_declaration_attached then
				a_command_declaration__item := a_command_declaration_attached.item
			end
			make_with_pointer (objc_init_with_suite_name__command_name__dictionary_(allocate_object, a_suite_name__item, a_command_name__item, a_command_declaration__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSScriptCommandDescription Externals

	objc_init_with_suite_name__command_name__dictionary_ (an_item: POINTER; a_suite_name: POINTER; a_command_name: POINTER; a_command_declaration: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptCommandDescription *)$an_item initWithSuiteName:$a_suite_name commandName:$a_command_name dictionary:$a_command_declaration];
			 ]"
		end

	objc_suite_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptCommandDescription *)$an_item suiteName];
			 ]"
		end

	objc_command_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptCommandDescription *)$an_item commandName];
			 ]"
		end

	objc_apple_event_class_code (an_item: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScriptCommandDescription *)$an_item appleEventClassCode];
			 ]"
		end

	objc_apple_event_code (an_item: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScriptCommandDescription *)$an_item appleEventCode];
			 ]"
		end

	objc_command_class_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptCommandDescription *)$an_item commandClassName];
			 ]"
		end

	objc_return_type (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptCommandDescription *)$an_item returnType];
			 ]"
		end

	objc_apple_event_code_for_return_type (an_item: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScriptCommandDescription *)$an_item appleEventCodeForReturnType];
			 ]"
		end

	objc_argument_names (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptCommandDescription *)$an_item argumentNames];
			 ]"
		end

	objc_type_for_argument_with_name_ (an_item: POINTER; a_argument_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptCommandDescription *)$an_item typeForArgumentWithName:$a_argument_name];
			 ]"
		end

	objc_apple_event_code_for_argument_with_name_ (an_item: POINTER; a_argument_name: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScriptCommandDescription *)$an_item appleEventCodeForArgumentWithName:$a_argument_name];
			 ]"
		end

	objc_is_optional_argument_with_name_ (an_item: POINTER; a_argument_name: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScriptCommandDescription *)$an_item isOptionalArgumentWithName:$a_argument_name];
			 ]"
		end

	objc_create_command_instance (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptCommandDescription *)$an_item createCommandInstance];
			 ]"
		end

--	objc_create_command_instance_with_zone_ (an_item: POINTER; a_zone: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSScriptCommandDescription *)$an_item createCommandInstanceWithZone:];
--			 ]"
--		end

feature -- NSScriptCommandDescription

	suite_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_suite_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like suite_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like suite_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	command_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_command_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like command_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like command_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	apple_event_class_code: NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_apple_event_class_code (item)
		end

	apple_event_code: NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_apple_event_code (item)
		end

	command_class_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_command_class_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like command_class_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like command_class_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	return_type: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_return_type (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like return_type} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like return_type} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	apple_event_code_for_return_type: NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_apple_event_code_for_return_type (item)
		end

	argument_names: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_argument_names (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like argument_names} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like argument_names} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	type_for_argument_with_name_ (a_argument_name: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_argument_name__item: POINTER
		do
			if attached a_argument_name as a_argument_name_attached then
				a_argument_name__item := a_argument_name_attached.item
			end
			result_pointer := objc_type_for_argument_with_name_ (item, a_argument_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like type_for_argument_with_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like type_for_argument_with_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	apple_event_code_for_argument_with_name_ (a_argument_name: detachable NS_STRING): NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
			a_argument_name__item: POINTER
		do
			if attached a_argument_name as a_argument_name_attached then
				a_argument_name__item := a_argument_name_attached.item
			end
			Result := objc_apple_event_code_for_argument_with_name_ (item, a_argument_name__item)
		end

	is_optional_argument_with_name_ (a_argument_name: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_argument_name__item: POINTER
		do
			if attached a_argument_name as a_argument_name_attached then
				a_argument_name__item := a_argument_name_attached.item
			end
			Result := objc_is_optional_argument_with_name_ (item, a_argument_name__item)
		end

	create_command_instance: detachable NS_SCRIPT_COMMAND
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_create_command_instance (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like create_command_instance} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like create_command_instance} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	create_command_instance_with_zone_ (a_zone: UNSUPPORTED_TYPE): detachable NS_SCRIPT_COMMAND
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_zone__item: POINTER
--		do
--			if attached a_zone as a_zone_attached then
--				a_zone__item := a_zone_attached.item
--			end
--			result_pointer := objc_create_command_instance_with_zone_ (item, a_zone__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like create_command_instance_with_zone_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like create_command_instance_with_zone_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSScriptCommandDescription"
		end

end
