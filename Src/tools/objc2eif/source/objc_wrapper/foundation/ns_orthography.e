note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ORTHOGRAPHY

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_dominant_script__language_map_,
	make

feature -- Properties

	dominant_script: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_dominant_script (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dominant_script} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dominant_script} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	language_map: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_language_map (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like language_map} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like language_map} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	dominant_language: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_dominant_language (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dominant_language} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dominant_language} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	all_scripts: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_all_scripts (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like all_scripts} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like all_scripts} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	all_languages: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_all_languages (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like all_languages} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like all_languages} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Properties Externals

	objc_dominant_script (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOrthography *)$an_item dominantScript];
			 ]"
		end

	objc_language_map (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOrthography *)$an_item languageMap];
			 ]"
		end

	objc_dominant_language (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOrthography *)$an_item dominantLanguage];
			 ]"
		end

	objc_all_scripts (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOrthography *)$an_item allScripts];
			 ]"
		end

	objc_all_languages (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOrthography *)$an_item allLanguages];
			 ]"
		end

feature -- NSOrthographyExtended

	languages_for_script_ (a_script: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_script__item: POINTER
		do
			if attached a_script as a_script_attached then
				a_script__item := a_script_attached.item
			end
			result_pointer := objc_languages_for_script_ (item, a_script__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like languages_for_script_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like languages_for_script_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	dominant_language_for_script_ (a_script: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_script__item: POINTER
		do
			if attached a_script as a_script_attached then
				a_script__item := a_script_attached.item
			end
			result_pointer := objc_dominant_language_for_script_ (item, a_script__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dominant_language_for_script_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dominant_language_for_script_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSOrthographyExtended Externals

	objc_languages_for_script_ (an_item: POINTER; a_script: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOrthography *)$an_item languagesForScript:$a_script];
			 ]"
		end

	objc_dominant_language_for_script_ (an_item: POINTER; a_script: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOrthography *)$an_item dominantLanguageForScript:$a_script];
			 ]"
		end

feature {NONE} -- Initialization

	make_with_dominant_script__language_map_ (a_script: detachable NS_STRING; a_map: detachable NS_DICTIONARY)
			-- Initialize `Current'.
		local
			a_script__item: POINTER
			a_map__item: POINTER
		do
			if attached a_script as a_script_attached then
				a_script__item := a_script_attached.item
			end
			if attached a_map as a_map_attached then
				a_map__item := a_map_attached.item
			end
			make_with_pointer (objc_init_with_dominant_script__language_map_(allocate_object, a_script__item, a_map__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSOrthographyCreation Externals

	objc_init_with_dominant_script__language_map_ (an_item: POINTER; a_script: POINTER; a_map: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSOrthography *)$an_item initWithDominantScript:$a_script languageMap:$a_map];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSOrthography"
		end

end
