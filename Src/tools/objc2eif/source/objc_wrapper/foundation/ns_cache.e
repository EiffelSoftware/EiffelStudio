note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CACHE

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

feature -- NSCache

	set_name_ (a_n: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_n__item: POINTER
		do
			if attached a_n as a_n_attached then
				a_n__item := a_n_attached.item
			end
			objc_set_name_ (item, a_n__item)
		end

	name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_delegate_ (a_d: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_d__item: POINTER
		do
			if attached a_d as a_d_attached then
				a_d__item := a_d_attached.item
			end
			objc_set_delegate_ (item, a_d__item)
		end

	delegate: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_delegate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like delegate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like delegate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	object_for_key_ (a_key: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			result_pointer := objc_object_for_key_ (item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_object__for_key_ (a_obj: detachable NS_OBJECT; a_key: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_obj__item: POINTER
			a_key__item: POINTER
		do
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_set_object__for_key_ (item, a_obj__item, a_key__item)
		end

	set_object__for_key__cost_ (a_obj: detachable NS_OBJECT; a_key: detachable NS_OBJECT; a_g: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_obj__item: POINTER
			a_key__item: POINTER
		do
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_set_object__for_key__cost_ (item, a_obj__item, a_key__item, a_g)
		end

	remove_object_for_key_ (a_key: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_remove_object_for_key_ (item, a_key__item)
		end

	remove_all_objects
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_all_objects (item)
		end

	set_total_cost_limit_ (a_lim: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_total_cost_limit_ (item, a_lim)
		end

	total_cost_limit: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_total_cost_limit (item)
		end

	set_count_limit_ (a_lim: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_count_limit_ (item, a_lim)
		end

	count_limit: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_count_limit (item)
		end

	evicts_objects_with_discarded_content: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_evicts_objects_with_discarded_content (item)
		end

	set_evicts_objects_with_discarded_content_ (a_b: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_evicts_objects_with_discarded_content_ (item, a_b)
		end

feature {NONE} -- NSCache Externals

	objc_set_name_ (an_item: POINTER; a_n: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCache *)$an_item setName:$a_n];
			 ]"
		end

	objc_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCache *)$an_item name];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; a_d: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCache *)$an_item setDelegate:$a_d];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCache *)$an_item delegate];
			 ]"
		end

	objc_object_for_key_ (an_item: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCache *)$an_item objectForKey:$a_key];
			 ]"
		end

	objc_set_object__for_key_ (an_item: POINTER; a_obj: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCache *)$an_item setObject:$a_obj forKey:$a_key];
			 ]"
		end

	objc_set_object__for_key__cost_ (an_item: POINTER; a_obj: POINTER; a_key: POINTER; a_g: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCache *)$an_item setObject:$a_obj forKey:$a_key cost:$a_g];
			 ]"
		end

	objc_remove_object_for_key_ (an_item: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCache *)$an_item removeObjectForKey:$a_key];
			 ]"
		end

	objc_remove_all_objects (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCache *)$an_item removeAllObjects];
			 ]"
		end

	objc_set_total_cost_limit_ (an_item: POINTER; a_lim: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCache *)$an_item setTotalCostLimit:$a_lim];
			 ]"
		end

	objc_total_cost_limit (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCache *)$an_item totalCostLimit];
			 ]"
		end

	objc_set_count_limit_ (an_item: POINTER; a_lim: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCache *)$an_item setCountLimit:$a_lim];
			 ]"
		end

	objc_count_limit (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCache *)$an_item countLimit];
			 ]"
		end

	objc_evicts_objects_with_discarded_content (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCache *)$an_item evictsObjectsWithDiscardedContent];
			 ]"
		end

	objc_set_evicts_objects_with_discarded_content_ (an_item: POINTER; a_b: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSCache *)$an_item setEvictsObjectsWithDiscardedContent:$a_b];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSCache"
		end

end
