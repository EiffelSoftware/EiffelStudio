note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_KEYED_ARCHIVER_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	archiver__will_encode_object_ (a_archiver: detachable NS_KEYED_ARCHIVER; a_object: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		require
			has_archiver__will_encode_object_: has_archiver__will_encode_object_
		local
			result_pointer: POINTER
			a_archiver__item: POINTER
			a_object__item: POINTER
		do
			if attached a_archiver as a_archiver_attached then
				a_archiver__item := a_archiver_attached.item
			end
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			result_pointer := objc_archiver__will_encode_object_ (item, a_archiver__item, a_object__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like archiver__will_encode_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like archiver__will_encode_object_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	archiver__did_encode_object_ (a_archiver: detachable NS_KEYED_ARCHIVER; a_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		require
			has_archiver__did_encode_object_: has_archiver__did_encode_object_
		local
			a_archiver__item: POINTER
			a_object__item: POINTER
		do
			if attached a_archiver as a_archiver_attached then
				a_archiver__item := a_archiver_attached.item
			end
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			objc_archiver__did_encode_object_ (item, a_archiver__item, a_object__item)
		end

	archiver__will_replace_object__with_object_ (a_archiver: detachable NS_KEYED_ARCHIVER; a_object: detachable NS_OBJECT; a_new_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		require
			has_archiver__will_replace_object__with_object_: has_archiver__will_replace_object__with_object_
		local
			a_archiver__item: POINTER
			a_object__item: POINTER
			a_new_object__item: POINTER
		do
			if attached a_archiver as a_archiver_attached then
				a_archiver__item := a_archiver_attached.item
			end
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			if attached a_new_object as a_new_object_attached then
				a_new_object__item := a_new_object_attached.item
			end
			objc_archiver__will_replace_object__with_object_ (item, a_archiver__item, a_object__item, a_new_object__item)
		end

	archiver_will_finish_ (a_archiver: detachable NS_KEYED_ARCHIVER)
			-- Auto generated Objective-C wrapper.
		require
			has_archiver_will_finish_: has_archiver_will_finish_
		local
			a_archiver__item: POINTER
		do
			if attached a_archiver as a_archiver_attached then
				a_archiver__item := a_archiver_attached.item
			end
			objc_archiver_will_finish_ (item, a_archiver__item)
		end

	archiver_did_finish_ (a_archiver: detachable NS_KEYED_ARCHIVER)
			-- Auto generated Objective-C wrapper.
		require
			has_archiver_did_finish_: has_archiver_did_finish_
		local
			a_archiver__item: POINTER
		do
			if attached a_archiver as a_archiver_attached then
				a_archiver__item := a_archiver_attached.item
			end
			objc_archiver_did_finish_ (item, a_archiver__item)
		end

feature -- Status Report

	has_archiver__will_encode_object_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_archiver__will_encode_object_ (item)
		end

	has_archiver__did_encode_object_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_archiver__did_encode_object_ (item)
		end

	has_archiver__will_replace_object__with_object_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_archiver__will_replace_object__with_object_ (item)
		end

	has_archiver_will_finish_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_archiver_will_finish_ (item)
		end

	has_archiver_did_finish_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_archiver_did_finish_ (item)
		end

feature -- Status Report Externals

	objc_has_archiver__will_encode_object_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(archiver:willEncodeObject:)];
			 ]"
		end

	objc_has_archiver__did_encode_object_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(archiver:didEncodeObject:)];
			 ]"
		end

	objc_has_archiver__will_replace_object__with_object_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(archiver:willReplaceObject:withObject:)];
			 ]"
		end

	objc_has_archiver_will_finish_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(archiverWillFinish:)];
			 ]"
		end

	objc_has_archiver_did_finish_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(archiverDidFinish:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_archiver__will_encode_object_ (an_item: POINTER; a_archiver: POINTER; a_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSKeyedArchiverDelegate>)$an_item archiver:$a_archiver willEncodeObject:$a_object];
			 ]"
		end

	objc_archiver__did_encode_object_ (an_item: POINTER; a_archiver: POINTER; a_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSKeyedArchiverDelegate>)$an_item archiver:$a_archiver didEncodeObject:$a_object];
			 ]"
		end

	objc_archiver__will_replace_object__with_object_ (an_item: POINTER; a_archiver: POINTER; a_object: POINTER; a_new_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSKeyedArchiverDelegate>)$an_item archiver:$a_archiver willReplaceObject:$a_object withObject:$a_new_object];
			 ]"
		end

	objc_archiver_will_finish_ (an_item: POINTER; a_archiver: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSKeyedArchiverDelegate>)$an_item archiverWillFinish:$a_archiver];
			 ]"
		end

	objc_archiver_did_finish_ (an_item: POINTER; a_archiver: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSKeyedArchiverDelegate>)$an_item archiverDidFinish:$a_archiver];
			 ]"
		end

end
