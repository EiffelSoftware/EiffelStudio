note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_KEY_VALUE_BINDING_CREATION_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSKeyValueBindingCreation

	exposed_bindings (a_ns_object: NS_OBJECT): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_exposed_bindings (a_ns_object.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like exposed_bindings} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like exposed_bindings} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	value_class_for_binding_ (a_ns_object: NS_OBJECT; a_binding: detachable NS_STRING): detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_binding__item: POINTER
		do
			if attached a_binding as a_binding_attached then
				a_binding__item := a_binding_attached.item
			end
			result_pointer := objc_value_class_for_binding_ (a_ns_object.item, a_binding__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value_class_for_binding_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value_class_for_binding_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	bind__to_object__with_key_path__options_ (a_ns_object: NS_OBJECT; a_binding: detachable NS_STRING; a_observable: detachable NS_OBJECT; a_key_path: detachable NS_STRING; a_options: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_binding__item: POINTER
			a_observable__item: POINTER
			a_key_path__item: POINTER
			a_options__item: POINTER
		do
			if attached a_binding as a_binding_attached then
				a_binding__item := a_binding_attached.item
			end
			if attached a_observable as a_observable_attached then
				a_observable__item := a_observable_attached.item
			end
			if attached a_key_path as a_key_path_attached then
				a_key_path__item := a_key_path_attached.item
			end
			if attached a_options as a_options_attached then
				a_options__item := a_options_attached.item
			end
			objc_bind__to_object__with_key_path__options_ (a_ns_object.item, a_binding__item, a_observable__item, a_key_path__item, a_options__item)
		end

	unbind_ (a_ns_object: NS_OBJECT; a_binding: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_binding__item: POINTER
		do
			if attached a_binding as a_binding_attached then
				a_binding__item := a_binding_attached.item
			end
			objc_unbind_ (a_ns_object.item, a_binding__item)
		end

	info_for_binding_ (a_ns_object: NS_OBJECT; a_binding: detachable NS_STRING): detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_binding__item: POINTER
		do
			if attached a_binding as a_binding_attached then
				a_binding__item := a_binding_attached.item
			end
			result_pointer := objc_info_for_binding_ (a_ns_object.item, a_binding__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like info_for_binding_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like info_for_binding_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	option_descriptions_for_binding_ (a_ns_object: NS_OBJECT; a_binding: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_binding__item: POINTER
		do
			if attached a_binding as a_binding_attached then
				a_binding__item := a_binding_attached.item
			end
			result_pointer := objc_option_descriptions_for_binding_ (a_ns_object.item, a_binding__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like option_descriptions_for_binding_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like option_descriptions_for_binding_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSKeyValueBindingCreation Externals

	objc_exposed_bindings (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item exposedBindings];
			 ]"
		end

	objc_value_class_for_binding_ (an_item: POINTER; a_binding: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item valueClassForBinding:$a_binding];
			 ]"
		end

	objc_bind__to_object__with_key_path__options_ (an_item: POINTER; a_binding: POINTER; a_observable: POINTER; a_key_path: POINTER; a_options: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item bind:$a_binding toObject:$a_observable withKeyPath:$a_key_path options:$a_options];
			 ]"
		end

	objc_unbind_ (an_item: POINTER; a_binding: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item unbind:$a_binding];
			 ]"
		end

	objc_info_for_binding_ (an_item: POINTER; a_binding: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item infoForBinding:$a_binding];
			 ]"
		end

	objc_option_descriptions_for_binding_ (an_item: POINTER; a_binding: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item optionDescriptionsForBinding:$a_binding];
			 ]"
		end

end
