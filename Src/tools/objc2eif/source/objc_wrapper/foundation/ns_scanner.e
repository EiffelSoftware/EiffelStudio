note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCANNER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_string_,
	make

feature -- NSScanner

	string: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_string (item)
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

	scan_location: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_scan_location (item)
		end

	set_scan_location_ (a_pos: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_scan_location_ (item, a_pos)
		end

	set_characters_to_be_skipped_ (a_set: detachable NS_CHARACTER_SET)
			-- Auto generated Objective-C wrapper.
		local
			a_set__item: POINTER
		do
			if attached a_set as a_set_attached then
				a_set__item := a_set_attached.item
			end
			objc_set_characters_to_be_skipped_ (item, a_set__item)
		end

	set_case_sensitive_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_case_sensitive_ (item, a_flag)
		end

	set_locale_ (a_locale: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_locale__item: POINTER
		do
			if attached a_locale as a_locale_attached then
				a_locale__item := a_locale_attached.item
			end
			objc_set_locale_ (item, a_locale__item)
		end

feature {NONE} -- NSScanner Externals

	objc_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScanner *)$an_item string];
			 ]"
		end

	objc_scan_location (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScanner *)$an_item scanLocation];
			 ]"
		end

	objc_set_scan_location_ (an_item: POINTER; a_pos: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScanner *)$an_item setScanLocation:$a_pos];
			 ]"
		end

	objc_set_characters_to_be_skipped_ (an_item: POINTER; a_set: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScanner *)$an_item setCharactersToBeSkipped:$a_set];
			 ]"
		end

	objc_set_case_sensitive_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScanner *)$an_item setCaseSensitive:$a_flag];
			 ]"
		end

	objc_set_locale_ (an_item: POINTER; a_locale: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSScanner *)$an_item setLocale:$a_locale];
			 ]"
		end

feature -- NSExtendedScanner

	characters_to_be_skipped: detachable NS_CHARACTER_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_characters_to_be_skipped (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like characters_to_be_skipped} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like characters_to_be_skipped} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	case_sensitive: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_case_sensitive (item)
		end

	locale: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_locale (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like locale} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like locale} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	scan_int_ (a_value: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_value__item: POINTER
--		do
--			if attached a_value as a_value_attached then
--				a_value__item := a_value_attached.item
--			end
--			Result := objc_scan_int_ (item, a_value__item)
--		end

--	scan_integer_ (a_value: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_value__item: POINTER
--		do
--			if attached a_value as a_value_attached then
--				a_value__item := a_value_attached.item
--			end
--			Result := objc_scan_integer_ (item, a_value__item)
--		end

--	scan_hex_long_long_ (a_result: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_result__item: POINTER
--		do
--			if attached a_result as a_result_attached then
--				a_result__item := a_result_attached.item
--			end
--			Result := objc_scan_hex_long_long_ (item, a_result__item)
--		end

--	scan_hex_float_ (a_result: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_result__item: POINTER
--		do
--			if attached a_result as a_result_attached then
--				a_result__item := a_result_attached.item
--			end
--			Result := objc_scan_hex_float_ (item, a_result__item)
--		end

--	scan_hex_double_ (a_result: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_result__item: POINTER
--		do
--			if attached a_result as a_result_attached then
--				a_result__item := a_result_attached.item
--			end
--			Result := objc_scan_hex_double_ (item, a_result__item)
--		end

--	scan_hex_int_ (a_value: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_value__item: POINTER
--		do
--			if attached a_value as a_value_attached then
--				a_value__item := a_value_attached.item
--			end
--			Result := objc_scan_hex_int_ (item, a_value__item)
--		end

--	scan_long_long_ (a_value: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_value__item: POINTER
--		do
--			if attached a_value as a_value_attached then
--				a_value__item := a_value_attached.item
--			end
--			Result := objc_scan_long_long_ (item, a_value__item)
--		end

--	scan_float_ (a_value: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_value__item: POINTER
--		do
--			if attached a_value as a_value_attached then
--				a_value__item := a_value_attached.item
--			end
--			Result := objc_scan_float_ (item, a_value__item)
--		end

--	scan_double_ (a_value: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_value__item: POINTER
--		do
--			if attached a_value as a_value_attached then
--				a_value__item := a_value_attached.item
--			end
--			Result := objc_scan_double_ (item, a_value__item)
--		end

--	scan_string__into_string_ (a_string: detachable NS_STRING; a_value: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_string__item: POINTER
--			a_value__item: POINTER
--		do
--			if attached a_string as a_string_attached then
--				a_string__item := a_string_attached.item
--			end
--			if attached a_value as a_value_attached then
--				a_value__item := a_value_attached.item
--			end
--			Result := objc_scan_string__into_string_ (item, a_string__item, a_value__item)
--		end

--	scan_characters_from_set__into_string_ (a_set: detachable NS_CHARACTER_SET; a_value: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_set__item: POINTER
--			a_value__item: POINTER
--		do
--			if attached a_set as a_set_attached then
--				a_set__item := a_set_attached.item
--			end
--			if attached a_value as a_value_attached then
--				a_value__item := a_value_attached.item
--			end
--			Result := objc_scan_characters_from_set__into_string_ (item, a_set__item, a_value__item)
--		end

--	scan_up_to_string__into_string_ (a_string: detachable NS_STRING; a_value: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_string__item: POINTER
--			a_value__item: POINTER
--		do
--			if attached a_string as a_string_attached then
--				a_string__item := a_string_attached.item
--			end
--			if attached a_value as a_value_attached then
--				a_value__item := a_value_attached.item
--			end
--			Result := objc_scan_up_to_string__into_string_ (item, a_string__item, a_value__item)
--		end

--	scan_up_to_characters_from_set__into_string_ (a_set: detachable NS_CHARACTER_SET; a_value: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_set__item: POINTER
--			a_value__item: POINTER
--		do
--			if attached a_set as a_set_attached then
--				a_set__item := a_set_attached.item
--			end
--			if attached a_value as a_value_attached then
--				a_value__item := a_value_attached.item
--			end
--			Result := objc_scan_up_to_characters_from_set__into_string_ (item, a_set__item, a_value__item)
--		end

	is_at_end: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_at_end (item)
		end

feature {NONE} -- NSExtendedScanner Externals

	objc_characters_to_be_skipped (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScanner *)$an_item charactersToBeSkipped];
			 ]"
		end

	objc_case_sensitive (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScanner *)$an_item caseSensitive];
			 ]"
		end

	objc_locale (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScanner *)$an_item locale];
			 ]"
		end

--	objc_scan_int_ (an_item: POINTER; a_value: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSScanner *)$an_item scanInt:];
--			 ]"
--		end

--	objc_scan_integer_ (an_item: POINTER; a_value: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSScanner *)$an_item scanInteger:];
--			 ]"
--		end

--	objc_scan_hex_long_long_ (an_item: POINTER; a_result: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSScanner *)$an_item scanHexLongLong:];
--			 ]"
--		end

--	objc_scan_hex_float_ (an_item: POINTER; a_result: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSScanner *)$an_item scanHexFloat:];
--			 ]"
--		end

--	objc_scan_hex_double_ (an_item: POINTER; a_result: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSScanner *)$an_item scanHexDouble:];
--			 ]"
--		end

--	objc_scan_hex_int_ (an_item: POINTER; a_value: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSScanner *)$an_item scanHexInt:];
--			 ]"
--		end

--	objc_scan_long_long_ (an_item: POINTER; a_value: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSScanner *)$an_item scanLongLong:];
--			 ]"
--		end

--	objc_scan_float_ (an_item: POINTER; a_value: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSScanner *)$an_item scanFloat:];
--			 ]"
--		end

--	objc_scan_double_ (an_item: POINTER; a_value: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSScanner *)$an_item scanDouble:];
--			 ]"
--		end

--	objc_scan_string__into_string_ (an_item: POINTER; a_string: POINTER; a_value: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSScanner *)$an_item scanString:$a_string intoString:];
--			 ]"
--		end

--	objc_scan_characters_from_set__into_string_ (an_item: POINTER; a_set: POINTER; a_value: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSScanner *)$an_item scanCharactersFromSet:$a_set intoString:];
--			 ]"
--		end

--	objc_scan_up_to_string__into_string_ (an_item: POINTER; a_string: POINTER; a_value: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSScanner *)$an_item scanUpToString:$a_string intoString:];
--			 ]"
--		end

--	objc_scan_up_to_characters_from_set__into_string_ (an_item: POINTER; a_set: POINTER; a_value: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSScanner *)$an_item scanUpToCharactersFromSet:$a_set intoString:];
--			 ]"
--		end

	objc_is_at_end (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSScanner *)$an_item isAtEnd];
			 ]"
		end

	objc_init_with_string_ (an_item: POINTER; a_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSScanner *)$an_item initWithString:$a_string];
			 ]"
		end

feature {NONE} -- Initialization

	make_with_string_ (a_string: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			make_with_pointer (objc_init_with_string_(allocate_object, a_string__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature -- NSDecimalNumberScanning

--	scan_decimal_ (a_dcm: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_dcm__item: POINTER
--		do
--			if attached a_dcm as a_dcm_attached then
--				a_dcm__item := a_dcm_attached.item
--			end
--			Result := objc_scan_decimal_ (item, a_dcm__item)
--		end

feature {NONE} -- NSDecimalNumberScanning Externals

--	objc_scan_decimal_ (an_item: POINTER; a_dcm: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSScanner *)$an_item scanDecimal:];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSScanner"
		end

end
