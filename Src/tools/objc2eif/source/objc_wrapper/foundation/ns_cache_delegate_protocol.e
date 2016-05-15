note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_CACHE_DELEGATE_PROTOCOL

inherit
	NS_COMMON

feature -- Optional Methods

	cache__will_evict_object_ (a_cache: detachable NS_CACHE; a_obj: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		require
			has_cache__will_evict_object_: has_cache__will_evict_object_
		local
			a_cache__item: POINTER
			a_obj__item: POINTER
		do
			if attached a_cache as a_cache_attached then
				a_cache__item := a_cache_attached.item
			end
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			objc_cache__will_evict_object_ (item, a_cache__item, a_obj__item)
		end

feature -- Status Report

	has_cache__will_evict_object_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_cache__will_evict_object_ (item)
		end

feature -- Status Report Externals

	objc_has_cache__will_evict_object_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(cache:willEvictObject:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_cache__will_evict_object_ (an_item: POINTER; a_cache: POINTER; a_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSCacheDelegate>)$an_item cache:$a_cache willEvictObject:$a_obj];
			 ]"
		end

end
