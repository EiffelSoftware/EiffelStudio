note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_STRING_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSStringExtensionMethods

	default_c_string_encoding: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_default_c_string_encoding (l_objc_class.item)
		end

--	available_string_encodings: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--		do
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_available_string_encodings (l_objc_class.item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like available_string_encodings} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like available_string_encodings} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	localized_name_of_string_encoding_ (a_encoding: NATURAL_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_localized_name_of_string_encoding_ (l_objc_class.item, a_encoding)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_name_of_string_encoding_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_name_of_string_encoding_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	string: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_string (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	string_with_string_ (a_string: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_string_with_string_ (l_objc_class.item, a_string__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_with_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_with_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	string_with_characters__length_ (a_characters: UNSUPPORTED_TYPE; a_length: NATURAL_64): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_characters__item: POINTER
--		do
--			if attached a_characters as a_characters_attached then
--				a_characters__item := a_characters_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_string_with_characters__length_ (l_objc_class.item, a_characters__item, a_length)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like string_with_characters__length_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like string_with_characters__length_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	string_with_ut_f8_string_ (a_null_terminated_c_string: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--		do
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_string_with_ut_f8_string_ (l_objc_class.item, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like string_with_ut_f8_string_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like string_with_ut_f8_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	string_with_c_string__encoding_ (a_c_string: UNSUPPORTED_TYPE; a_enc: NATURAL_64): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--		do
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_string_with_c_string__encoding_ (l_objc_class.item, , a_enc)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like string_with_c_string__encoding_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like string_with_c_string__encoding_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	string_with_contents_of_ur_l__encoding__error_ (a_url: detachable NS_URL; a_enc: NATURAL_64; a_error: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_url__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_string_with_contents_of_ur_l__encoding__error_ (l_objc_class.item, a_url__item, a_enc, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like string_with_contents_of_ur_l__encoding__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like string_with_contents_of_ur_l__encoding__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	string_with_contents_of_file__encoding__error_ (a_path: detachable NS_STRING; a_enc: NATURAL_64; a_error: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_path__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_string_with_contents_of_file__encoding__error_ (l_objc_class.item, a_path__item, a_enc, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like string_with_contents_of_file__encoding__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like string_with_contents_of_file__encoding__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	string_with_contents_of_ur_l__used_encoding__error_ (a_url: detachable NS_URL; a_enc: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_url__item: POINTER
--			a_enc__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_enc as a_enc_attached then
--				a_enc__item := a_enc_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_string_with_contents_of_ur_l__used_encoding__error_ (l_objc_class.item, a_url__item, a_enc__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like string_with_contents_of_ur_l__used_encoding__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like string_with_contents_of_ur_l__used_encoding__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	string_with_contents_of_file__used_encoding__error_ (a_path: detachable NS_STRING; a_enc: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_path__item: POINTER
--			a_enc__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_path as a_path_attached then
--				a_path__item := a_path_attached.item
--			end
--			if attached a_enc as a_enc_attached then
--				a_enc__item := a_enc_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_string_with_contents_of_file__used_encoding__error_ (l_objc_class.item, a_path__item, a_enc__item, a_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like string_with_contents_of_file__used_encoding__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like string_with_contents_of_file__used_encoding__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSStringExtensionMethods Externals

	objc_default_c_string_encoding (a_class_object: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(Class)$a_class_object defaultCStringEncoding];
			 ]"
		end

	objc_available_string_encodings (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object availableStringEncodings];
			 ]"
		end

	objc_localized_name_of_string_encoding_ (a_class_object: POINTER; a_encoding: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object localizedNameOfStringEncoding:$a_encoding];
			 ]"
		end

	objc_string (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object string];
			 ]"
		end

	objc_string_with_string_ (a_class_object: POINTER; a_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object stringWithString:$a_string];
			 ]"
		end

--	objc_string_with_characters__length_ (a_class_object: POINTER; a_characters: UNSUPPORTED_TYPE; a_length: NATURAL_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object stringWithCharacters: length:$a_length];
--			 ]"
--		end

	objc_string_with_ut_f8_string_ (a_class_object: POINTER; a_null_terminated_c_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object stringWithUTF8String:$a_null_terminated_c_string];
			 ]"
		end

	objc_string_with_c_string__encoding_ (a_class_object: POINTER; a_c_string: POINTER; a_enc: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object stringWithCString:$a_c_string encoding:$a_enc];
			 ]"
		end

--	objc_string_with_contents_of_ur_l__encoding__error_ (a_class_object: POINTER; a_url: POINTER; a_enc: NATURAL_64; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object stringWithContentsOfURL:$a_url encoding:$a_enc error:];
--			 ]"
--		end

--	objc_string_with_contents_of_file__encoding__error_ (a_class_object: POINTER; a_path: POINTER; a_enc: NATURAL_64; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object stringWithContentsOfFile:$a_path encoding:$a_enc error:];
--			 ]"
--		end

--	objc_string_with_contents_of_ur_l__used_encoding__error_ (a_class_object: POINTER; a_url: POINTER; a_enc: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object stringWithContentsOfURL:$a_url usedEncoding: error:];
--			 ]"
--		end

--	objc_string_with_contents_of_file__used_encoding__error_ (a_class_object: POINTER; a_path: POINTER; a_enc: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object stringWithContentsOfFile:$a_path usedEncoding: error:];
--			 ]"
--		end

feature -- NSStringPathExtensions

	path_with_components_ (a_components: detachable NS_ARRAY): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_components__item: POINTER
		do
			if attached a_components as a_components_attached then
				a_components__item := a_components_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_path_with_components_ (l_objc_class.item, a_components__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like path_with_components_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like path_with_components_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSStringPathExtensions Externals

	objc_path_with_components_ (a_class_object: POINTER; a_components: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object pathWithComponents:$a_components];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSString"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
