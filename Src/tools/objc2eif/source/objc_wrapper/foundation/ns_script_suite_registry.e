note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCRIPT_SUITE_REGISTRY

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

feature -- NSScriptSuiteRegistry

	load_suites_from_bundle_ (a_bundle: detachable NS_BUNDLE)
			-- Auto generated Objective-C wrapper.
		local
			a_bundle__item: POINTER
		do
			if attached a_bundle as a_bundle_attached then
				a_bundle__item := a_bundle_attached.item
			end
			objc_load_suites_from_bundle_ (item, a_bundle__item)
		end

	load_suite_with_dictionary__from_bundle_ (a_suite_declaration: detachable NS_DICTIONARY; a_bundle: detachable NS_BUNDLE)
			-- Auto generated Objective-C wrapper.
		local
			a_suite_declaration__item: POINTER
			a_bundle__item: POINTER
		do
			if attached a_suite_declaration as a_suite_declaration_attached then
				a_suite_declaration__item := a_suite_declaration_attached.item
			end
			if attached a_bundle as a_bundle_attached then
				a_bundle__item := a_bundle_attached.item
			end
			objc_load_suite_with_dictionary__from_bundle_ (item, a_suite_declaration__item, a_bundle__item)
		end

	register_class_description_ (a_class_description: detachable NS_SCRIPT_CLASS_DESCRIPTION)
			-- Auto generated Objective-C wrapper.
		local
			a_class_description__item: POINTER
		do
			if attached a_class_description as a_class_description_attached then
				a_class_description__item := a_class_description_attached.item
			end
			objc_register_class_description_ (item, a_class_description__item)
		end

	register_command_description_ (a_command_description: detachable NS_SCRIPT_COMMAND_DESCRIPTION)
			-- Auto generated Objective-C wrapper.
		local
			a_command_description__item: POINTER
		do
			if attached a_command_description as a_command_description_attached then
				a_command_description__item := a_command_description_attached.item
			end
			objc_register_command_description_ (item, a_command_description__item)
		end

	suite_names: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_suite_names (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like suite_names} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like suite_names} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	apple_event_code_for_suite_ (a_suite_name: detachable NS_STRING): NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
			a_suite_name__item: POINTER
		do
			if attached a_suite_name as a_suite_name_attached then
				a_suite_name__item := a_suite_name_attached.item
			end
			Result := objc_apple_event_code_for_suite_ (item, a_suite_name__item)
		end

	bundle_for_suite_ (a_suite_name: detachable NS_STRING): detachable NS_BUNDLE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_suite_name__item: POINTER
		do
			if attached a_suite_name as a_suite_name_attached then
				a_suite_name__item := a_suite_name_attached.item
			end
			result_pointer := objc_bundle_for_suite_ (item, a_suite_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like bundle_for_suite_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like bundle_for_suite_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	class_descriptions_in_suite_ (a_suite_name: detachable NS_STRING): detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_suite_name__item: POINTER
		do
			if attached a_suite_name as a_suite_name_attached then
				a_suite_name__item := a_suite_name_attached.item
			end
			result_pointer := objc_class_descriptions_in_suite_ (item, a_suite_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like class_descriptions_in_suite_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like class_descriptions_in_suite_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	command_descriptions_in_suite_ (a_suite_name: detachable NS_STRING): detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_suite_name__item: POINTER
		do
			if attached a_suite_name as a_suite_name_attached then
				a_suite_name__item := a_suite_name_attached.item
			end
			result_pointer := objc_command_descriptions_in_suite_ (item, a_suite_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like command_descriptions_in_suite_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like command_descriptions_in_suite_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	suite_for_apple_event_code_ (a_apple_event_code: NATURAL_32): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_suite_for_apple_event_code_ (item, a_apple_event_code)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like suite_for_apple_event_code_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like suite_for_apple_event_code_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	class_description_with_apple_event_code_ (a_apple_event_code: NATURAL_32): detachable NS_SCRIPT_CLASS_DESCRIPTION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_class_description_with_apple_event_code_ (item, a_apple_event_code)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like class_description_with_apple_event_code_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like class_description_with_apple_event_code_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	command_description_with_apple_event_class__and_apple_event_code_ (a_apple_event_class_code: NATURAL_32; a_apple_event_id_code: NATURAL_32): detachable NS_SCRIPT_COMMAND_DESCRIPTION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_command_description_with_apple_event_class__and_apple_event_code_ (item, a_apple_event_class_code, a_apple_event_id_code)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like command_description_with_apple_event_class__and_apple_event_code_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like command_description_with_apple_event_class__and_apple_event_code_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	aete_resource_ (a_language_name: detachable NS_STRING): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_language_name__item: POINTER
		do
			if attached a_language_name as a_language_name_attached then
				a_language_name__item := a_language_name_attached.item
			end
			result_pointer := objc_aete_resource_ (item, a_language_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like aete_resource_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like aete_resource_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSScriptSuiteRegistry Externals

	objc_load_suites_from_bundle_ (an_item: POINTER; a_bundle: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptSuiteRegistry *)$an_item loadSuitesFromBundle:$a_bundle];
			 ]"
		end

	objc_load_suite_with_dictionary__from_bundle_ (an_item: POINTER; a_suite_declaration: POINTER; a_bundle: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptSuiteRegistry *)$an_item loadSuiteWithDictionary:$a_suite_declaration fromBundle:$a_bundle];
			 ]"
		end

	objc_register_class_description_ (an_item: POINTER; a_class_description: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptSuiteRegistry *)$an_item registerClassDescription:$a_class_description];
			 ]"
		end

	objc_register_command_description_ (an_item: POINTER; a_command_description: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScriptSuiteRegistry *)$an_item registerCommandDescription:$a_command_description];
			 ]"
		end

	objc_suite_names (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptSuiteRegistry *)$an_item suiteNames];
			 ]"
		end

	objc_apple_event_code_for_suite_ (an_item: POINTER; a_suite_name: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScriptSuiteRegistry *)$an_item appleEventCodeForSuite:$a_suite_name];
			 ]"
		end

	objc_bundle_for_suite_ (an_item: POINTER; a_suite_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptSuiteRegistry *)$an_item bundleForSuite:$a_suite_name];
			 ]"
		end

	objc_class_descriptions_in_suite_ (an_item: POINTER; a_suite_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptSuiteRegistry *)$an_item classDescriptionsInSuite:$a_suite_name];
			 ]"
		end

	objc_command_descriptions_in_suite_ (an_item: POINTER; a_suite_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptSuiteRegistry *)$an_item commandDescriptionsInSuite:$a_suite_name];
			 ]"
		end

	objc_suite_for_apple_event_code_ (an_item: POINTER; a_apple_event_code: NATURAL_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptSuiteRegistry *)$an_item suiteForAppleEventCode:$a_apple_event_code];
			 ]"
		end

	objc_class_description_with_apple_event_code_ (an_item: POINTER; a_apple_event_code: NATURAL_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptSuiteRegistry *)$an_item classDescriptionWithAppleEventCode:$a_apple_event_code];
			 ]"
		end

	objc_command_description_with_apple_event_class__and_apple_event_code_ (an_item: POINTER; a_apple_event_class_code: NATURAL_32; a_apple_event_id_code: NATURAL_32): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptSuiteRegistry *)$an_item commandDescriptionWithAppleEventClass:$a_apple_event_class_code andAppleEventCode:$a_apple_event_id_code];
			 ]"
		end

	objc_aete_resource_ (an_item: POINTER; a_language_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScriptSuiteRegistry *)$an_item aeteResource:$a_language_name];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSScriptSuiteRegistry"
		end

end
