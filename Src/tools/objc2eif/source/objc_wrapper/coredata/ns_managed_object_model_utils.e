note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MANAGED_OBJECT_MODEL_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSManagedObjectModel

	merged_model_from_bundles_ (a_bundles: detachable NS_ARRAY): detachable NS_MANAGED_OBJECT_MODEL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_bundles__item: POINTER
		do
			if attached a_bundles as a_bundles_attached then
				a_bundles__item := a_bundles_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_merged_model_from_bundles_ (l_objc_class.item, a_bundles__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like merged_model_from_bundles_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like merged_model_from_bundles_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	model_by_merging_models_ (a_models: detachable NS_ARRAY): detachable NS_MANAGED_OBJECT_MODEL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_models__item: POINTER
		do
			if attached a_models as a_models_attached then
				a_models__item := a_models_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_model_by_merging_models_ (l_objc_class.item, a_models__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like model_by_merging_models_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like model_by_merging_models_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	merged_model_from_bundles__for_store_metadata_ (a_bundles: detachable NS_ARRAY; a_metadata: detachable NS_DICTIONARY): detachable NS_MANAGED_OBJECT_MODEL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_bundles__item: POINTER
			a_metadata__item: POINTER
		do
			if attached a_bundles as a_bundles_attached then
				a_bundles__item := a_bundles_attached.item
			end
			if attached a_metadata as a_metadata_attached then
				a_metadata__item := a_metadata_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_merged_model_from_bundles__for_store_metadata_ (l_objc_class.item, a_bundles__item, a_metadata__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like merged_model_from_bundles__for_store_metadata_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like merged_model_from_bundles__for_store_metadata_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	model_by_merging_models__for_store_metadata_ (a_models: detachable NS_ARRAY; a_metadata: detachable NS_DICTIONARY): detachable NS_MANAGED_OBJECT_MODEL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_models__item: POINTER
			a_metadata__item: POINTER
		do
			if attached a_models as a_models_attached then
				a_models__item := a_models_attached.item
			end
			if attached a_metadata as a_metadata_attached then
				a_metadata__item := a_metadata_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_model_by_merging_models__for_store_metadata_ (l_objc_class.item, a_models__item, a_metadata__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like model_by_merging_models__for_store_metadata_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like model_by_merging_models__for_store_metadata_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSManagedObjectModel Externals

	objc_merged_model_from_bundles_ (a_class_object: POINTER; a_bundles: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object mergedModelFromBundles:$a_bundles];
			 ]"
		end

	objc_model_by_merging_models_ (a_class_object: POINTER; a_models: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object modelByMergingModels:$a_models];
			 ]"
		end

	objc_merged_model_from_bundles__for_store_metadata_ (a_class_object: POINTER; a_bundles: POINTER; a_metadata: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object mergedModelFromBundles:$a_bundles forStoreMetadata:$a_metadata];
			 ]"
		end

	objc_model_by_merging_models__for_store_metadata_ (a_class_object: POINTER; a_models: POINTER; a_metadata: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object modelByMergingModels:$a_models forStoreMetadata:$a_metadata];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSManagedObjectModel"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
