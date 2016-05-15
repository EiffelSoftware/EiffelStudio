note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ATOMIC_STORE_CACHE_NODE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_object_i_d_,
	make

feature {NONE} -- Initialization

	make_with_object_i_d_ (a_moid: detachable NS_MANAGED_OBJECT_ID)
			-- Initialize `Current'.
		local
			a_moid__item: POINTER
		do
			if attached a_moid as a_moid_attached then
				a_moid__item := a_moid_attached.item
			end
			make_with_pointer (objc_init_with_object_i_d_(allocate_object, a_moid__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSAtomicStoreCacheNode Externals

	objc_init_with_object_i_d_ (an_item: POINTER; a_moid: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAtomicStoreCacheNode *)$an_item initWithObjectID:$a_moid];
			 ]"
		end

	objc_object_id (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAtomicStoreCacheNode *)$an_item objectID];
			 ]"
		end

	objc_property_cache (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAtomicStoreCacheNode *)$an_item propertyCache];
			 ]"
		end

	objc_set_property_cache_ (an_item: POINTER; a_property_cache: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSAtomicStoreCacheNode *)$an_item setPropertyCache:$a_property_cache];
			 ]"
		end

feature -- NSAtomicStoreCacheNode

	object_id: detachable NS_MANAGED_OBJECT_ID
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_object_id (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_id} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_id} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	property_cache: detachable NS_MUTABLE_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_property_cache (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like property_cache} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like property_cache} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_property_cache_ (a_property_cache: detachable NS_MUTABLE_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_property_cache__item: POINTER
		do
			if attached a_property_cache as a_property_cache_attached then
				a_property_cache__item := a_property_cache_attached.item
			end
			objc_set_property_cache_ (item, a_property_cache__item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSAtomicStoreCacheNode"
		end

end
