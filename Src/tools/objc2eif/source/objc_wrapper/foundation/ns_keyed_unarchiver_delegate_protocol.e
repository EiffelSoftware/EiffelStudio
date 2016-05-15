note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_KEYED_UNARCHIVER_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	unarchiver__cannot_decode_object_of_class_name__original_classes_ (a_unarchiver: detachable NS_KEYED_UNARCHIVER; a_name: detachable NS_STRING; a_class_names: detachable NS_ARRAY): detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		require
			has_unarchiver__cannot_decode_object_of_class_name__original_classes_: has_unarchiver__cannot_decode_object_of_class_name__original_classes_
		local
			result_pointer: POINTER
			a_unarchiver__item: POINTER
			a_name__item: POINTER
			a_class_names__item: POINTER
		do
			if attached a_unarchiver as a_unarchiver_attached then
				a_unarchiver__item := a_unarchiver_attached.item
			end
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_class_names as a_class_names_attached then
				a_class_names__item := a_class_names_attached.item
			end
			result_pointer := objc_unarchiver__cannot_decode_object_of_class_name__original_classes_ (item, a_unarchiver__item, a_name__item, a_class_names__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like unarchiver__cannot_decode_object_of_class_name__original_classes_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like unarchiver__cannot_decode_object_of_class_name__original_classes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	unarchiver__did_decode_object_ (a_unarchiver: detachable NS_KEYED_UNARCHIVER; a_object: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		require
			has_unarchiver__did_decode_object_: has_unarchiver__did_decode_object_
		local
			result_pointer: POINTER
			a_unarchiver__item: POINTER
			a_object__item: POINTER
		do
			if attached a_unarchiver as a_unarchiver_attached then
				a_unarchiver__item := a_unarchiver_attached.item
			end
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			result_pointer := objc_unarchiver__did_decode_object_ (item, a_unarchiver__item, a_object__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like unarchiver__did_decode_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like unarchiver__did_decode_object_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	unarchiver__will_replace_object__with_object_ (a_unarchiver: detachable NS_KEYED_UNARCHIVER; a_object: detachable NS_OBJECT; a_new_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		require
			has_unarchiver__will_replace_object__with_object_: has_unarchiver__will_replace_object__with_object_
		local
			a_unarchiver__item: POINTER
			a_object__item: POINTER
			a_new_object__item: POINTER
		do
			if attached a_unarchiver as a_unarchiver_attached then
				a_unarchiver__item := a_unarchiver_attached.item
			end
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			if attached a_new_object as a_new_object_attached then
				a_new_object__item := a_new_object_attached.item
			end
			objc_unarchiver__will_replace_object__with_object_ (item, a_unarchiver__item, a_object__item, a_new_object__item)
		end

	unarchiver_will_finish_ (a_unarchiver: detachable NS_KEYED_UNARCHIVER)
			-- Auto generated Objective-C wrapper.
		require
			has_unarchiver_will_finish_: has_unarchiver_will_finish_
		local
			a_unarchiver__item: POINTER
		do
			if attached a_unarchiver as a_unarchiver_attached then
				a_unarchiver__item := a_unarchiver_attached.item
			end
			objc_unarchiver_will_finish_ (item, a_unarchiver__item)
		end

	unarchiver_did_finish_ (a_unarchiver: detachable NS_KEYED_UNARCHIVER)
			-- Auto generated Objective-C wrapper.
		require
			has_unarchiver_did_finish_: has_unarchiver_did_finish_
		local
			a_unarchiver__item: POINTER
		do
			if attached a_unarchiver as a_unarchiver_attached then
				a_unarchiver__item := a_unarchiver_attached.item
			end
			objc_unarchiver_did_finish_ (item, a_unarchiver__item)
		end

feature -- Status Report

	has_unarchiver__cannot_decode_object_of_class_name__original_classes_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_unarchiver__cannot_decode_object_of_class_name__original_classes_ (item)
		end

	has_unarchiver__did_decode_object_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_unarchiver__did_decode_object_ (item)
		end

	has_unarchiver__will_replace_object__with_object_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_unarchiver__will_replace_object__with_object_ (item)
		end

	has_unarchiver_will_finish_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_unarchiver_will_finish_ (item)
		end

	has_unarchiver_did_finish_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_unarchiver_did_finish_ (item)
		end

feature -- Status Report Externals

	objc_has_unarchiver__cannot_decode_object_of_class_name__original_classes_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(unarchiver:cannotDecodeObjectOfClassName:originalClasses:)];
			 ]"
		end

	objc_has_unarchiver__did_decode_object_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(unarchiver:didDecodeObject:)];
			 ]"
		end

	objc_has_unarchiver__will_replace_object__with_object_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(unarchiver:willReplaceObject:withObject:)];
			 ]"
		end

	objc_has_unarchiver_will_finish_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(unarchiverWillFinish:)];
			 ]"
		end

	objc_has_unarchiver_did_finish_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(unarchiverDidFinish:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_unarchiver__cannot_decode_object_of_class_name__original_classes_ (an_item: POINTER; a_unarchiver: POINTER; a_name: POINTER; a_class_names: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSKeyedUnarchiverDelegate>)$an_item unarchiver:$a_unarchiver cannotDecodeObjectOfClassName:$a_name originalClasses:$a_class_names];
			 ]"
		end

	objc_unarchiver__did_decode_object_ (an_item: POINTER; a_unarchiver: POINTER; a_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSKeyedUnarchiverDelegate>)$an_item unarchiver:$a_unarchiver didDecodeObject:$a_object];
			 ]"
		end

	objc_unarchiver__will_replace_object__with_object_ (an_item: POINTER; a_unarchiver: POINTER; a_object: POINTER; a_new_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSKeyedUnarchiverDelegate>)$an_item unarchiver:$a_unarchiver willReplaceObject:$a_object withObject:$a_new_object];
			 ]"
		end

	objc_unarchiver_will_finish_ (an_item: POINTER; a_unarchiver: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSKeyedUnarchiverDelegate>)$an_item unarchiverWillFinish:$a_unarchiver];
			 ]"
		end

	objc_unarchiver_did_finish_ (an_item: POINTER; a_unarchiver: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSKeyedUnarchiverDelegate>)$an_item unarchiverDidFinish:$a_unarchiver];
			 ]"
		end

end
