note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MAPPING_MODEL_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSMappingModel

	mapping_model_from_bundles__for_source_model__destination_model_ (a_bundles: detachable NS_ARRAY; a_source_model: detachable NS_MANAGED_OBJECT_MODEL; a_destination_model: detachable NS_MANAGED_OBJECT_MODEL): detachable NS_MAPPING_MODEL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_bundles__item: POINTER
			a_source_model__item: POINTER
			a_destination_model__item: POINTER
		do
			if attached a_bundles as a_bundles_attached then
				a_bundles__item := a_bundles_attached.item
			end
			if attached a_source_model as a_source_model_attached then
				a_source_model__item := a_source_model_attached.item
			end
			if attached a_destination_model as a_destination_model_attached then
				a_destination_model__item := a_destination_model_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_mapping_model_from_bundles__for_source_model__destination_model_ (l_objc_class.item, a_bundles__item, a_source_model__item, a_destination_model__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like mapping_model_from_bundles__for_source_model__destination_model_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like mapping_model_from_bundles__for_source_model__destination_model_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	inferred_mapping_model_for_source_model__destination_model__error_ (a_source_model: detachable NS_MANAGED_OBJECT_MODEL; a_destination_model: detachable NS_MANAGED_OBJECT_MODEL; a_error: UNSUPPORTED_TYPE): detachable NS_MAPPING_MODEL
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_source_model__item: POINTER
--			a_destination_model__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_source_model as a_source_model_attached then
--				a_source_model__item := a_source_model_attached.item
--			end
--			if attached a_destination_model as a_destination_model_attached then
--				a_destination_model__item := a_destination_model_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_inferred_mapping_model_for_source_model__destination_model__error_ (l_objc_class.item, a_source_model__item, a_destination_model__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like inferred_mapping_model_for_source_model__destination_model__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like inferred_mapping_model_for_source_model__destination_model__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSMappingModel Externals

	objc_mapping_model_from_bundles__for_source_model__destination_model_ (a_class_object: POINTER; a_bundles: POINTER; a_source_model: POINTER; a_destination_model: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object mappingModelFromBundles:$a_bundles forSourceModel:$a_source_model destinationModel:$a_destination_model];
			 ]"
		end

--	objc_inferred_mapping_model_for_source_model__destination_model__error_ (a_class_object: POINTER; a_source_model: POINTER; a_destination_model: POINTER; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <CoreData/CoreData.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object inferredMappingModelForSourceModel:$a_source_model destinationModel:$a_destination_model error:];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMappingModel"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
