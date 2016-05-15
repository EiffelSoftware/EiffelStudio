note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OBJECT_UTILS

inherit
	NS_NAMED_CLASS
		redefine
			is_subclass_instance
		end


feature -- NSObject

	load
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_load (l_objc_class.item)
		end

	initialize
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_initialize (l_objc_class.item)
		end

	new: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_new (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like new} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like new} new_eiffel_object (result_pointer, False) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	copy_with_zone_ (a_zone: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_zone__item: POINTER
--		do
--			if attached a_zone as a_zone_attached then
--				a_zone__item := a_zone_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_copy_with_zone_ (l_objc_class.item, a_zone__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like copy_with_zone_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like copy_with_zone_} new_eiffel_object (result_pointer, False) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	mutable_copy_with_zone_ (a_zone: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_zone__item: POINTER
--		do
--			if attached a_zone as a_zone_attached then
--				a_zone__item := a_zone_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_mutable_copy_with_zone_ (l_objc_class.item, a_zone__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like mutable_copy_with_zone_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like mutable_copy_with_zone_} new_eiffel_object (result_pointer, False) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	superclass: detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_superclass (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like superclass} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like superclass} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	class_objc: detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_class_objc (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like class_objc} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like class_objc} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	instances_respond_to_selector_ (a_selector: detachable OBJC_SELECTOR): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_selector__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_instances_respond_to_selector_ (l_objc_class.item, a_selector__item)
		end

--	conforms_to_protocol_ (a_protocol: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			l_objc_class: OBJC_CLASS
--		do
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			Result := objc_conforms_to_protocol_ (l_objc_class.item, )
--		end

--	instance_method_for_selector_ (a_selector: detachable OBJC_SELECTOR): UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_selector__item: POINTER
--		do
--			if attached a_selector as a_selector_attached then
--				a_selector__item := a_selector_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_instance_method_for_selector_ (l_objc_class.item, a_selector__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like instance_method_for_selector_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like instance_method_for_selector_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	instance_method_signature_for_selector_ (a_selector: detachable OBJC_SELECTOR): detachable NS_METHOD_SIGNATURE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_selector__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_instance_method_signature_for_selector_ (l_objc_class.item, a_selector__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like instance_method_signature_for_selector_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like instance_method_signature_for_selector_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	description: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_description (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like description} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like description} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_subclass_of_class_ (a_class: detachable OBJC_CLASS): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_class__item: POINTER
		do
			if attached a_class as a_class_attached then
				a_class__item := a_class_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_is_subclass_of_class_ (l_objc_class.item, a_class__item)
		end

	resolve_class_method_ (a_sel: detachable OBJC_SELECTOR): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_sel__item: POINTER
		do
			if attached a_sel as a_sel_attached then
				a_sel__item := a_sel_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_resolve_class_method_ (l_objc_class.item, a_sel__item)
		end

	resolve_instance_method_ (a_sel: detachable OBJC_SELECTOR): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_sel__item: POINTER
		do
			if attached a_sel as a_sel_attached then
				a_sel__item := a_sel_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_resolve_instance_method_ (l_objc_class.item, a_sel__item)
		end

feature {NONE} -- NSObject Externals

	objc_load (a_class_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object load];
			 ]"
		end

	objc_initialize (a_class_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object initialize];
			 ]"
		end

	objc_new (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object new];
			 ]"
		end

--	objc_copy_with_zone_ (a_class_object: POINTER; a_zone: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object copyWithZone:];
--			 ]"
--		end

--	objc_mutable_copy_with_zone_ (a_class_object: POINTER; a_zone: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object mutableCopyWithZone:];
--			 ]"
--		end

	objc_superclass (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object superclass];
			 ]"
		end

	objc_class_objc (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object class];
			 ]"
		end

	objc_instances_respond_to_selector_ (a_class_object: POINTER; a_selector: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(Class)$a_class_object instancesRespondToSelector:$a_selector];
			 ]"
		end

	objc_conforms_to_protocol_ (a_class_object: POINTER; a_protocol: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(Class)$a_class_object conformsToProtocol:$a_protocol];
			 ]"
		end

	objc_instance_method_for_selector_ (a_class_object: POINTER; a_selector: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object instanceMethodForSelector:$a_selector];
			 ]"
		end

	objc_instance_method_signature_for_selector_ (a_class_object: POINTER; a_selector: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object instanceMethodSignatureForSelector:$a_selector];
			 ]"
		end

	objc_description (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object description];
			 ]"
		end

	objc_is_subclass_of_class_ (a_class_object: POINTER; a_class: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(Class)$a_class_object isSubclassOfClass:$a_class];
			 ]"
		end

	objc_resolve_class_method_ (a_class_object: POINTER; a_sel: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(Class)$a_class_object resolveClassMethod:$a_sel];
			 ]"
		end

	objc_resolve_instance_method_ (a_class_object: POINTER; a_sel: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(Class)$a_class_object resolveInstanceMethod:$a_sel];
			 ]"
		end

feature -- NSCoderMethods

	version: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_version (l_objc_class.item)
		end

	set_version_ (a_version: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_version_ (l_objc_class.item, a_version)
		end

feature {NONE} -- NSCoderMethods Externals

	objc_version (a_class_object: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(Class)$a_class_object version];
			 ]"
		end

	objc_set_version_ (a_class_object: POINTER; a_version: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object setVersion:$a_version];
			 ]"
		end

feature -- NSKeyValueCoding

	access_instance_variables_directly: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_access_instance_variables_directly (l_objc_class.item)
		end

feature {NONE} -- NSKeyValueCoding Externals

	objc_access_instance_variables_directly (a_class_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(Class)$a_class_object accessInstanceVariablesDirectly];
			 ]"
		end

feature -- NSKeyValueObservingCustomization

	key_paths_for_values_affecting_value_for_key_ (a_key: detachable NS_STRING): detachable NS_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_key_paths_for_values_affecting_value_for_key_ (l_objc_class.item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like key_paths_for_values_affecting_value_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like key_paths_for_values_affecting_value_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	automatically_notifies_observers_for_key_ (a_key: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_automatically_notifies_observers_for_key_ (l_objc_class.item, a_key__item)
		end

feature {NONE} -- NSKeyValueObservingCustomization Externals

	objc_key_paths_for_values_affecting_value_for_key_ (a_class_object: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object keyPathsForValuesAffectingValueForKey:$a_key];
			 ]"
		end

	objc_automatically_notifies_observers_for_key_ (a_class_object: POINTER; a_key: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(Class)$a_class_object automaticallyNotifiesObserversForKey:$a_key];
			 ]"
		end

feature -- NSKeyedArchiverObjectSubstitution

	class_fallbacks_for_keyed_archiver: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_class_fallbacks_for_keyed_archiver (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like class_fallbacks_for_keyed_archiver} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like class_fallbacks_for_keyed_archiver} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSKeyedArchiverObjectSubstitution Externals

	objc_class_fallbacks_for_keyed_archiver (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object classFallbacksForKeyedArchiver];
			 ]"
		end

feature -- NSKeyedUnarchiverObjectSubstitution

	class_for_keyed_unarchiver: detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_class_for_keyed_unarchiver (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like class_for_keyed_unarchiver} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like class_for_keyed_unarchiver} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSKeyedUnarchiverObjectSubstitution Externals

	objc_class_for_keyed_unarchiver (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object classForKeyedUnarchiver];
			 ]"
		end

feature -- NSDelayedPerforming

	cancel_previous_perform_requests_with_target__selector__object_ (a_target: detachable NS_OBJECT; a_selector: detachable OBJC_SELECTOR; an_argument: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_target__item: POINTER
			a_selector__item: POINTER
			an_argument__item: POINTER
		do
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached an_argument as an_argument_attached then
				an_argument__item := an_argument_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_cancel_previous_perform_requests_with_target__selector__object_ (l_objc_class.item, a_target__item, a_selector__item, an_argument__item)
		end

	cancel_previous_perform_requests_with_target_ (a_target: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_target__item: POINTER
		do
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_cancel_previous_perform_requests_with_target_ (l_objc_class.item, a_target__item)
		end

feature {NONE} -- NSDelayedPerforming Externals

	objc_cancel_previous_perform_requests_with_target__selector__object_ (a_class_object: POINTER; a_target: POINTER; a_selector: POINTER; a_an_argument: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object cancelPreviousPerformRequestsWithTarget:$a_target selector:$a_selector object:$a_an_argument];
			 ]"
		end

	objc_cancel_previous_perform_requests_with_target_ (a_class_object: POINTER; a_target: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object cancelPreviousPerformRequestsWithTarget:$a_target];
			 ]"
		end

feature -- NSKeyValueBindingCreation

	expose_binding_ (a_binding: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_binding__item: POINTER
		do
			if attached a_binding as a_binding_attached then
				a_binding__item := a_binding_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_expose_binding_ (l_objc_class.item, a_binding__item)
		end

feature {NONE} -- NSKeyValueBindingCreation Externals

	objc_expose_binding_ (a_class_object: POINTER; a_binding: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object exposeBinding:$a_binding];
			 ]"
		end

feature -- NSPlaceholders

	set_default_placeholder__for_marker__with_binding_ (a_placeholder: detachable NS_OBJECT; a_marker: detachable NS_OBJECT; a_binding: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_placeholder__item: POINTER
			a_marker__item: POINTER
			a_binding__item: POINTER
		do
			if attached a_placeholder as a_placeholder_attached then
				a_placeholder__item := a_placeholder_attached.item
			end
			if attached a_marker as a_marker_attached then
				a_marker__item := a_marker_attached.item
			end
			if attached a_binding as a_binding_attached then
				a_binding__item := a_binding_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_default_placeholder__for_marker__with_binding_ (l_objc_class.item, a_placeholder__item, a_marker__item, a_binding__item)
		end

	default_placeholder_for_marker__with_binding_ (a_marker: detachable NS_OBJECT; a_binding: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_marker__item: POINTER
			a_binding__item: POINTER
		do
			if attached a_marker as a_marker_attached then
				a_marker__item := a_marker_attached.item
			end
			if attached a_binding as a_binding_attached then
				a_binding__item := a_binding_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_default_placeholder_for_marker__with_binding_ (l_objc_class.item, a_marker__item, a_binding__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like default_placeholder_for_marker__with_binding_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like default_placeholder_for_marker__with_binding_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSPlaceholders Externals

	objc_set_default_placeholder__for_marker__with_binding_ (a_class_object: POINTER; a_placeholder: POINTER; a_marker: POINTER; a_binding: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object setDefaultPlaceholder:$a_placeholder forMarker:$a_marker withBinding:$a_binding];
			 ]"
		end

	objc_default_placeholder_for_marker__with_binding_ (a_class_object: POINTER; a_marker: POINTER; a_binding: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object defaultPlaceholderForMarker:$a_marker withBinding:$a_binding];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSObject"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
