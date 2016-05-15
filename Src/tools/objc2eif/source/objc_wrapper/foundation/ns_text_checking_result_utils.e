note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TEXT_CHECKING_RESULT_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSTextCheckingResultCreation

	orthography_checking_result_with_range__orthography_ (a_range: NS_RANGE; a_orthography: detachable NS_ORTHOGRAPHY): detachable NS_TEXT_CHECKING_RESULT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_orthography__item: POINTER
		do
			if attached a_orthography as a_orthography_attached then
				a_orthography__item := a_orthography_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_orthography_checking_result_with_range__orthography_ (l_objc_class.item, a_range.item, a_orthography__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like orthography_checking_result_with_range__orthography_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like orthography_checking_result_with_range__orthography_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	spell_checking_result_with_range_ (a_range: NS_RANGE): detachable NS_TEXT_CHECKING_RESULT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_spell_checking_result_with_range_ (l_objc_class.item, a_range.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like spell_checking_result_with_range_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like spell_checking_result_with_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	grammar_checking_result_with_range__details_ (a_range: NS_RANGE; a_details: detachable NS_ARRAY): detachable NS_TEXT_CHECKING_RESULT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_details__item: POINTER
		do
			if attached a_details as a_details_attached then
				a_details__item := a_details_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_grammar_checking_result_with_range__details_ (l_objc_class.item, a_range.item, a_details__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like grammar_checking_result_with_range__details_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like grammar_checking_result_with_range__details_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	date_checking_result_with_range__date_ (a_range: NS_RANGE; a_date: detachable NS_DATE): detachable NS_TEXT_CHECKING_RESULT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_date__item: POINTER
		do
			if attached a_date as a_date_attached then
				a_date__item := a_date_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_date_checking_result_with_range__date_ (l_objc_class.item, a_range.item, a_date__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like date_checking_result_with_range__date_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like date_checking_result_with_range__date_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	date_checking_result_with_range__date__time_zone__duration_ (a_range: NS_RANGE; a_date: detachable NS_DATE; a_time_zone: detachable NS_TIME_ZONE; a_duration: REAL_64): detachable NS_TEXT_CHECKING_RESULT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_date__item: POINTER
			a_time_zone__item: POINTER
		do
			if attached a_date as a_date_attached then
				a_date__item := a_date_attached.item
			end
			if attached a_time_zone as a_time_zone_attached then
				a_time_zone__item := a_time_zone_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_date_checking_result_with_range__date__time_zone__duration_ (l_objc_class.item, a_range.item, a_date__item, a_time_zone__item, a_duration)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like date_checking_result_with_range__date__time_zone__duration_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like date_checking_result_with_range__date__time_zone__duration_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	address_checking_result_with_range__components_ (a_range: NS_RANGE; a_components: detachable NS_DICTIONARY): detachable NS_TEXT_CHECKING_RESULT
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
			result_pointer := objc_address_checking_result_with_range__components_ (l_objc_class.item, a_range.item, a_components__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like address_checking_result_with_range__components_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like address_checking_result_with_range__components_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	link_checking_result_with_range__ur_l_ (a_range: NS_RANGE; a_url: detachable NS_URL): detachable NS_TEXT_CHECKING_RESULT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_link_checking_result_with_range__ur_l_ (l_objc_class.item, a_range.item, a_url__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like link_checking_result_with_range__ur_l_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like link_checking_result_with_range__ur_l_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	quote_checking_result_with_range__replacement_string_ (a_range: NS_RANGE; a_replacement_string: detachable NS_STRING): detachable NS_TEXT_CHECKING_RESULT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_replacement_string__item: POINTER
		do
			if attached a_replacement_string as a_replacement_string_attached then
				a_replacement_string__item := a_replacement_string_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_quote_checking_result_with_range__replacement_string_ (l_objc_class.item, a_range.item, a_replacement_string__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like quote_checking_result_with_range__replacement_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like quote_checking_result_with_range__replacement_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	dash_checking_result_with_range__replacement_string_ (a_range: NS_RANGE; a_replacement_string: detachable NS_STRING): detachable NS_TEXT_CHECKING_RESULT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_replacement_string__item: POINTER
		do
			if attached a_replacement_string as a_replacement_string_attached then
				a_replacement_string__item := a_replacement_string_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_dash_checking_result_with_range__replacement_string_ (l_objc_class.item, a_range.item, a_replacement_string__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dash_checking_result_with_range__replacement_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dash_checking_result_with_range__replacement_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	replacement_checking_result_with_range__replacement_string_ (a_range: NS_RANGE; a_replacement_string: detachable NS_STRING): detachable NS_TEXT_CHECKING_RESULT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_replacement_string__item: POINTER
		do
			if attached a_replacement_string as a_replacement_string_attached then
				a_replacement_string__item := a_replacement_string_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_replacement_checking_result_with_range__replacement_string_ (l_objc_class.item, a_range.item, a_replacement_string__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like replacement_checking_result_with_range__replacement_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like replacement_checking_result_with_range__replacement_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	correction_checking_result_with_range__replacement_string_ (a_range: NS_RANGE; a_replacement_string: detachable NS_STRING): detachable NS_TEXT_CHECKING_RESULT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_replacement_string__item: POINTER
		do
			if attached a_replacement_string as a_replacement_string_attached then
				a_replacement_string__item := a_replacement_string_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_correction_checking_result_with_range__replacement_string_ (l_objc_class.item, a_range.item, a_replacement_string__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like correction_checking_result_with_range__replacement_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like correction_checking_result_with_range__replacement_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSTextCheckingResultCreation Externals

	objc_orthography_checking_result_with_range__orthography_ (a_class_object: POINTER; a_range: POINTER; a_orthography: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object orthographyCheckingResultWithRange:*((NSRange *)$a_range) orthography:$a_orthography];
			 ]"
		end

	objc_spell_checking_result_with_range_ (a_class_object: POINTER; a_range: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object spellCheckingResultWithRange:*((NSRange *)$a_range)];
			 ]"
		end

	objc_grammar_checking_result_with_range__details_ (a_class_object: POINTER; a_range: POINTER; a_details: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object grammarCheckingResultWithRange:*((NSRange *)$a_range) details:$a_details];
			 ]"
		end

	objc_date_checking_result_with_range__date_ (a_class_object: POINTER; a_range: POINTER; a_date: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object dateCheckingResultWithRange:*((NSRange *)$a_range) date:$a_date];
			 ]"
		end

	objc_date_checking_result_with_range__date__time_zone__duration_ (a_class_object: POINTER; a_range: POINTER; a_date: POINTER; a_time_zone: POINTER; a_duration: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object dateCheckingResultWithRange:*((NSRange *)$a_range) date:$a_date timeZone:$a_time_zone duration:$a_duration];
			 ]"
		end

	objc_address_checking_result_with_range__components_ (a_class_object: POINTER; a_range: POINTER; a_components: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object addressCheckingResultWithRange:*((NSRange *)$a_range) components:$a_components];
			 ]"
		end

	objc_link_checking_result_with_range__ur_l_ (a_class_object: POINTER; a_range: POINTER; a_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object linkCheckingResultWithRange:*((NSRange *)$a_range) URL:$a_url];
			 ]"
		end

	objc_quote_checking_result_with_range__replacement_string_ (a_class_object: POINTER; a_range: POINTER; a_replacement_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object quoteCheckingResultWithRange:*((NSRange *)$a_range) replacementString:$a_replacement_string];
			 ]"
		end

	objc_dash_checking_result_with_range__replacement_string_ (a_class_object: POINTER; a_range: POINTER; a_replacement_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object dashCheckingResultWithRange:*((NSRange *)$a_range) replacementString:$a_replacement_string];
			 ]"
		end

	objc_replacement_checking_result_with_range__replacement_string_ (a_class_object: POINTER; a_range: POINTER; a_replacement_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object replacementCheckingResultWithRange:*((NSRange *)$a_range) replacementString:$a_replacement_string];
			 ]"
		end

	objc_correction_checking_result_with_range__replacement_string_ (a_class_object: POINTER; a_range: POINTER; a_replacement_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object correctionCheckingResultWithRange:*((NSRange *)$a_range) replacementString:$a_replacement_string];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTextCheckingResult"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
