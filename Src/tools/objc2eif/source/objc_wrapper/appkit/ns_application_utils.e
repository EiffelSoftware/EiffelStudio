note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_APPLICATION_UTILS

inherit
	NS_RESPONDER_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSApplication

	shared_application: detachable NS_APPLICATION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_shared_application (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like shared_application} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like shared_application} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	detach_drawing_thread__to_target__with_object_ (a_selector: detachable OBJC_SELECTOR; a_target: detachable NS_OBJECT; a_argument: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_selector__item: POINTER
			a_target__item: POINTER
			a_argument__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			if attached a_argument as a_argument_attached then
				a_argument__item := a_argument_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_detach_drawing_thread__to_target__with_object_ (l_objc_class.item, a_selector__item, a_target__item, a_argument__item)
		end

feature {NONE} -- NSApplication Externals

	objc_shared_application (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object sharedApplication];
			 ]"
		end

	objc_detach_drawing_thread__to_target__with_object_ (a_class_object: POINTER; a_selector: POINTER; a_target: POINTER; a_argument: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object detachDrawingThread:$a_selector toTarget:$a_target withObject:$a_argument];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSApplication"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
