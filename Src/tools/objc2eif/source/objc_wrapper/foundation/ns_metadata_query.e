note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_METADATA_QUERY

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

feature -- NSMetadataQuery

	delegate: detachable NS_METADATA_QUERY_DELEGATE_PROTOCOL
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

	set_delegate_ (a_delegate: detachable NS_METADATA_QUERY_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_delegate__item: POINTER
		do
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			objc_set_delegate_ (item, a_delegate__item)
		end

	predicate: detachable NS_PREDICATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_predicate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like predicate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like predicate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_predicate_ (a_predicate: detachable NS_PREDICATE)
			-- Auto generated Objective-C wrapper.
		local
			a_predicate__item: POINTER
		do
			if attached a_predicate as a_predicate_attached then
				a_predicate__item := a_predicate_attached.item
			end
			objc_set_predicate_ (item, a_predicate__item)
		end

	sort_descriptors: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_sort_descriptors (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like sort_descriptors} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like sort_descriptors} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_sort_descriptors_ (a_descriptors: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_descriptors__item: POINTER
		do
			if attached a_descriptors as a_descriptors_attached then
				a_descriptors__item := a_descriptors_attached.item
			end
			objc_set_sort_descriptors_ (item, a_descriptors__item)
		end

	value_list_attributes: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_value_list_attributes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value_list_attributes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value_list_attributes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_value_list_attributes_ (a_attrs: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_attrs__item: POINTER
		do
			if attached a_attrs as a_attrs_attached then
				a_attrs__item := a_attrs_attached.item
			end
			objc_set_value_list_attributes_ (item, a_attrs__item)
		end

	grouping_attributes: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_grouping_attributes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like grouping_attributes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like grouping_attributes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_grouping_attributes_ (a_attrs: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_attrs__item: POINTER
		do
			if attached a_attrs as a_attrs_attached then
				a_attrs__item := a_attrs_attached.item
			end
			objc_set_grouping_attributes_ (item, a_attrs__item)
		end

	notification_batching_interval: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_notification_batching_interval (item)
		end

	set_notification_batching_interval_ (a_ti: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_notification_batching_interval_ (item, a_ti)
		end

	search_scopes: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_search_scopes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like search_scopes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like search_scopes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_search_scopes_ (a_scopes: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_scopes__item: POINTER
		do
			if attached a_scopes as a_scopes_attached then
				a_scopes__item := a_scopes_attached.item
			end
			objc_set_search_scopes_ (item, a_scopes__item)
		end

	start_query: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_start_query (item)
		end

	stop_query
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_stop_query (item)
		end

	is_started: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_started (item)
		end

	is_gathering: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_gathering (item)
		end

	is_stopped: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_stopped (item)
		end

	disable_updates
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_disable_updates (item)
		end

	enable_updates
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_enable_updates (item)
		end

	result_count: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_result_count (item)
		end

	result_at_index_ (a_idx: NATURAL_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_result_at_index_ (item, a_idx)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like result_at_index_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like result_at_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	results: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_results (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like results} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like results} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	index_of_result_ (a_result: detachable NS_OBJECT): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_result__item: POINTER
		do
			if attached a_result as a_result_attached then
				a_result__item := a_result_attached.item
			end
			Result := objc_index_of_result_ (item, a_result__item)
		end

	value_lists: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_value_lists (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value_lists} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value_lists} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	grouped_results: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_grouped_results (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like grouped_results} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like grouped_results} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	value_of_attribute__for_result_at_index_ (a_attr_name: detachable NS_STRING; a_idx: NATURAL_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_attr_name__item: POINTER
		do
			if attached a_attr_name as a_attr_name_attached then
				a_attr_name__item := a_attr_name_attached.item
			end
			result_pointer := objc_value_of_attribute__for_result_at_index_ (item, a_attr_name__item, a_idx)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value_of_attribute__for_result_at_index_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value_of_attribute__for_result_at_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSMetadataQuery Externals

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMetadataQuery *)$an_item delegate];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; a_delegate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMetadataQuery *)$an_item setDelegate:$a_delegate];
			 ]"
		end

	objc_predicate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMetadataQuery *)$an_item predicate];
			 ]"
		end

	objc_set_predicate_ (an_item: POINTER; a_predicate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMetadataQuery *)$an_item setPredicate:$a_predicate];
			 ]"
		end

	objc_sort_descriptors (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMetadataQuery *)$an_item sortDescriptors];
			 ]"
		end

	objc_set_sort_descriptors_ (an_item: POINTER; a_descriptors: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMetadataQuery *)$an_item setSortDescriptors:$a_descriptors];
			 ]"
		end

	objc_value_list_attributes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMetadataQuery *)$an_item valueListAttributes];
			 ]"
		end

	objc_set_value_list_attributes_ (an_item: POINTER; a_attrs: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMetadataQuery *)$an_item setValueListAttributes:$a_attrs];
			 ]"
		end

	objc_grouping_attributes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMetadataQuery *)$an_item groupingAttributes];
			 ]"
		end

	objc_set_grouping_attributes_ (an_item: POINTER; a_attrs: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMetadataQuery *)$an_item setGroupingAttributes:$a_attrs];
			 ]"
		end

	objc_notification_batching_interval (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSMetadataQuery *)$an_item notificationBatchingInterval];
			 ]"
		end

	objc_set_notification_batching_interval_ (an_item: POINTER; a_ti: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMetadataQuery *)$an_item setNotificationBatchingInterval:$a_ti];
			 ]"
		end

	objc_search_scopes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMetadataQuery *)$an_item searchScopes];
			 ]"
		end

	objc_set_search_scopes_ (an_item: POINTER; a_scopes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMetadataQuery *)$an_item setSearchScopes:$a_scopes];
			 ]"
		end

	objc_start_query (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSMetadataQuery *)$an_item startQuery];
			 ]"
		end

	objc_stop_query (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMetadataQuery *)$an_item stopQuery];
			 ]"
		end

	objc_is_started (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSMetadataQuery *)$an_item isStarted];
			 ]"
		end

	objc_is_gathering (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSMetadataQuery *)$an_item isGathering];
			 ]"
		end

	objc_is_stopped (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSMetadataQuery *)$an_item isStopped];
			 ]"
		end

	objc_disable_updates (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMetadataQuery *)$an_item disableUpdates];
			 ]"
		end

	objc_enable_updates (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSMetadataQuery *)$an_item enableUpdates];
			 ]"
		end

	objc_result_count (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSMetadataQuery *)$an_item resultCount];
			 ]"
		end

	objc_result_at_index_ (an_item: POINTER; a_idx: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMetadataQuery *)$an_item resultAtIndex:$a_idx];
			 ]"
		end

	objc_results (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMetadataQuery *)$an_item results];
			 ]"
		end

	objc_index_of_result_ (an_item: POINTER; a_result: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSMetadataQuery *)$an_item indexOfResult:$a_result];
			 ]"
		end

	objc_value_lists (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMetadataQuery *)$an_item valueLists];
			 ]"
		end

	objc_grouped_results (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMetadataQuery *)$an_item groupedResults];
			 ]"
		end

	objc_value_of_attribute__for_result_at_index_ (an_item: POINTER; a_attr_name: POINTER; a_idx: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMetadataQuery *)$an_item valueOfAttribute:$a_attr_name forResultAtIndex:$a_idx];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMetadataQuery"
		end

end
