note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_OBJECT_PROTOCOL

inherit
	NS_COMMON

feature -- Required Methods

	is_equal_ (a_object: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_is_equal_ (item, a_object__item)
		end

	hash: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_hash (item)
		end

	superclass: detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_superclass (item)
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
		do
			result_pointer := objc_class_objc (item)
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

	self: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_self (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like self} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like self} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	zone: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_zone (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like zone} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like zone} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	perform_selector_ (a_selector: detachable OBJC_SELECTOR): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_selector__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			result_pointer := objc_perform_selector_ (item, a_selector__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like perform_selector_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like perform_selector_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	perform_selector__with_object_ (a_selector: detachable OBJC_SELECTOR; a_object: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_selector__item: POINTER
			a_object__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			result_pointer := objc_perform_selector__with_object_ (item, a_selector__item, a_object__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like perform_selector__with_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like perform_selector__with_object_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	perform_selector__with_object__with_object_ (a_selector: detachable OBJC_SELECTOR; a_object1: detachable NS_OBJECT; a_object2: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_selector__item: POINTER
			a_object1__item: POINTER
			a_object2__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached a_object1 as a_object1_attached then
				a_object1__item := a_object1_attached.item
			end
			if attached a_object2 as a_object2_attached then
				a_object2__item := a_object2_attached.item
			end
			result_pointer := objc_perform_selector__with_object__with_object_ (item, a_selector__item, a_object1__item, a_object2__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like perform_selector__with_object__with_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like perform_selector__with_object__with_object_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_proxy: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_proxy (item)
		end

	is_kind_of_class_ (a_class: detachable OBJC_CLASS): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_class__item: POINTER
		do
			if attached a_class as a_class_attached then
				a_class__item := a_class_attached.item
			end
			Result := objc_is_kind_of_class_ (item, a_class__item)
		end

	is_member_of_class_ (a_class: detachable OBJC_CLASS): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_class__item: POINTER
		do
			if attached a_class as a_class_attached then
				a_class__item := a_class_attached.item
			end
			Result := objc_is_member_of_class_ (item, a_class__item)
		end

--	conforms_to_protocol_ (a_protocol: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			Result := objc_conforms_to_protocol_ (item, )
--		end

	responds_to_selector_ (a_selector: detachable OBJC_SELECTOR): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_selector__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			Result := objc_responds_to_selector_ (item, a_selector__item)
		end

	retain_count: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_retain_count (item)
		end

	description: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_description (item)
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

feature {NONE} -- Required Methods Externals

	objc_is_equal_ (an_item: POINTER; a_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id <NSObject>)$an_item isEqual:$a_object];
			 ]"
		end

	objc_hash (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id <NSObject>)$an_item hash];
			 ]"
		end

	objc_superclass (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSObject>)$an_item superclass];
			 ]"
		end

	objc_class_objc (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSObject>)$an_item class];
			 ]"
		end

	objc_self (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSObject>)$an_item self];
			 ]"
		end

	objc_zone (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSObject>)$an_item zone];
			 ]"
		end

	objc_perform_selector_ (an_item: POINTER; a_selector: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSObject>)$an_item performSelector:$a_selector];
			 ]"
		end

	objc_perform_selector__with_object_ (an_item: POINTER; a_selector: POINTER; a_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSObject>)$an_item performSelector:$a_selector withObject:$a_object];
			 ]"
		end

	objc_perform_selector__with_object__with_object_ (an_item: POINTER; a_selector: POINTER; a_object1: POINTER; a_object2: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSObject>)$an_item performSelector:$a_selector withObject:$a_object1 withObject:$a_object2];
			 ]"
		end

	objc_is_proxy (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id <NSObject>)$an_item isProxy];
			 ]"
		end

	objc_is_kind_of_class_ (an_item: POINTER; a_class: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id <NSObject>)$an_item isKindOfClass:$a_class];
			 ]"
		end

	objc_is_member_of_class_ (an_item: POINTER; a_class: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id <NSObject>)$an_item isMemberOfClass:$a_class];
			 ]"
		end

	objc_conforms_to_protocol_ (an_item: POINTER; a_protocol: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id <NSObject>)$an_item conformsToProtocol:$a_protocol];
			 ]"
		end

	objc_responds_to_selector_ (an_item: POINTER; a_selector: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id <NSObject>)$an_item respondsToSelector:$a_selector];
			 ]"
		end

	objc_retain (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSObject>)$an_item retain];
			 ]"
		end

	objc_release (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSObject>)$an_item release];
			 ]"
		end

	objc_autorelease (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSObject>)$an_item autorelease];
			 ]"
		end

	objc_retain_count (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id <NSObject>)$an_item retainCount];
			 ]"
		end

	objc_description (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSObject>)$an_item description];
			 ]"
		end

end
