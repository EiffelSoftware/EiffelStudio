note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCRIPT_SUITE_REGISTRY_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSScriptSuiteRegistry

	shared_script_suite_registry: detachable NS_SCRIPT_SUITE_REGISTRY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_shared_script_suite_registry (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like shared_script_suite_registry} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like shared_script_suite_registry} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_shared_script_suite_registry_ (a_registry: detachable NS_SCRIPT_SUITE_REGISTRY)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_registry__item: POINTER
		do
			if attached a_registry as a_registry_attached then
				a_registry__item := a_registry_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_shared_script_suite_registry_ (l_objc_class.item, a_registry__item)
		end

feature {NONE} -- NSScriptSuiteRegistry Externals

	objc_shared_script_suite_registry (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object sharedScriptSuiteRegistry];
			 ]"
		end

	objc_set_shared_script_suite_registry_ (a_class_object: POINTER; a_registry: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object setSharedScriptSuiteRegistry:$a_registry];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSScriptSuiteRegistry"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
