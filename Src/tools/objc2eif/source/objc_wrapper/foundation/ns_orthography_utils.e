note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ORTHOGRAPHY_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSOrthographyCreation

	orthography_with_dominant_script__language_map_ (a_script: detachable NS_STRING; a_map: detachable NS_DICTIONARY): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_script__item: POINTER
			a_map__item: POINTER
		do
			if attached a_script as a_script_attached then
				a_script__item := a_script_attached.item
			end
			if attached a_map as a_map_attached then
				a_map__item := a_map_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_orthography_with_dominant_script__language_map_ (l_objc_class.item, a_script__item, a_map__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like orthography_with_dominant_script__language_map_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like orthography_with_dominant_script__language_map_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSOrthographyCreation Externals

	objc_orthography_with_dominant_script__language_map_ (a_class_object: POINTER; a_script: POINTER; a_map: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object orthographyWithDominantScript:$a_script languageMap:$a_map];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSOrthography"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
