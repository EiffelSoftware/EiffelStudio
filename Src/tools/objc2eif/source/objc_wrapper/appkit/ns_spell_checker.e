note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SPELL_CHECKER

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

feature -- NSSpellChecker

--	check_spelling_of_string__starting_at__language__wrap__in_spell_document_with_tag__word_count_ (a_string_to_check: detachable NS_STRING; a_starting_offset: INTEGER_64; a_language: detachable NS_STRING; a_wrap_flag: BOOLEAN; a_tag: INTEGER_64; a_word_count: UNSUPPORTED_TYPE): NS_RANGE
--			-- Auto generated Objective-C wrapper.
--		local
--			a_string_to_check__item: POINTER
--			a_language__item: POINTER
--			a_word_count__item: POINTER
--		do
--			if attached a_string_to_check as a_string_to_check_attached then
--				a_string_to_check__item := a_string_to_check_attached.item
--			end
--			if attached a_language as a_language_attached then
--				a_language__item := a_language_attached.item
--			end
--			if attached a_word_count as a_word_count_attached then
--				a_word_count__item := a_word_count_attached.item
--			end
--			create Result.make
--			objc_check_spelling_of_string__starting_at__language__wrap__in_spell_document_with_tag__word_count_ (item, Result.item, a_string_to_check__item, a_starting_offset, a_language__item, a_wrap_flag, a_tag, a_word_count__item)
--		end

	check_spelling_of_string__starting_at_ (a_string_to_check: detachable NS_STRING; a_starting_offset: INTEGER_64): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
			a_string_to_check__item: POINTER
		do
			if attached a_string_to_check as a_string_to_check_attached then
				a_string_to_check__item := a_string_to_check_attached.item
			end
			create Result.make
			objc_check_spelling_of_string__starting_at_ (item, Result.item, a_string_to_check__item, a_starting_offset)
		end

	count_words_in_string__language_ (a_string_to_count: detachable NS_STRING; a_language: detachable NS_STRING): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_string_to_count__item: POINTER
			a_language__item: POINTER
		do
			if attached a_string_to_count as a_string_to_count_attached then
				a_string_to_count__item := a_string_to_count_attached.item
			end
			if attached a_language as a_language_attached then
				a_language__item := a_language_attached.item
			end
			Result := objc_count_words_in_string__language_ (item, a_string_to_count__item, a_language__item)
		end

--	check_grammar_of_string__starting_at__language__wrap__in_spell_document_with_tag__details_ (a_string_to_check: detachable NS_STRING; a_starting_offset: INTEGER_64; a_language: detachable NS_STRING; a_wrap_flag: BOOLEAN; a_tag: INTEGER_64; a_details: UNSUPPORTED_TYPE): NS_RANGE
--			-- Auto generated Objective-C wrapper.
--		local
--			a_string_to_check__item: POINTER
--			a_language__item: POINTER
--			a_details__item: POINTER
--		do
--			if attached a_string_to_check as a_string_to_check_attached then
--				a_string_to_check__item := a_string_to_check_attached.item
--			end
--			if attached a_language as a_language_attached then
--				a_language__item := a_language_attached.item
--			end
--			if attached a_details as a_details_attached then
--				a_details__item := a_details_attached.item
--			end
--			create Result.make
--			objc_check_grammar_of_string__starting_at__language__wrap__in_spell_document_with_tag__details_ (item, Result.item, a_string_to_check__item, a_starting_offset, a_language__item, a_wrap_flag, a_tag, a_details__item)
--		end

--	check_string__range__types__options__in_spell_document_with_tag__orthography__word_count_ (a_string_to_check: detachable NS_STRING; a_range: NS_RANGE; a_checking_types: NATURAL_64; a_options: detachable NS_DICTIONARY; a_tag: INTEGER_64; a_orthography: UNSUPPORTED_TYPE; a_word_count: UNSUPPORTED_TYPE): detachable NS_ARRAY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_string_to_check__item: POINTER
--			a_options__item: POINTER
--			a_orthography__item: POINTER
--			a_word_count__item: POINTER
--		do
--			if attached a_string_to_check as a_string_to_check_attached then
--				a_string_to_check__item := a_string_to_check_attached.item
--			end
--			if attached a_options as a_options_attached then
--				a_options__item := a_options_attached.item
--			end
--			if attached a_orthography as a_orthography_attached then
--				a_orthography__item := a_orthography_attached.item
--			end
--			if attached a_word_count as a_word_count_attached then
--				a_word_count__item := a_word_count_attached.item
--			end
--			result_pointer := objc_check_string__range__types__options__in_spell_document_with_tag__orthography__word_count_ (item, a_string_to_check__item, a_range.item, a_checking_types, a_options__item, a_tag, a_orthography__item, a_word_count__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like check_string__range__types__options__in_spell_document_with_tag__orthography__word_count_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like check_string__range__types__options__in_spell_document_with_tag__orthography__word_count_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	request_checking_of_string__range__types__options__in_spell_document_with_tag__completion_handler_ (a_string_to_check: detachable NS_STRING; a_range: NS_RANGE; a_checking_types: NATURAL_64; a_options: detachable NS_DICTIONARY; a_tag: INTEGER_64; a_completion_handler: UNSUPPORTED_TYPE): INTEGER_64
--			-- Auto generated Objective-C wrapper.
--		local
--			a_string_to_check__item: POINTER
--			a_options__item: POINTER
--		do
--			if attached a_string_to_check as a_string_to_check_attached then
--				a_string_to_check__item := a_string_to_check_attached.item
--			end
--			if attached a_options as a_options_attached then
--				a_options__item := a_options_attached.item
--			end
--			Result := objc_request_checking_of_string__range__types__options__in_spell_document_with_tag__completion_handler_ (item, a_string_to_check__item, a_range.item, a_checking_types, a_options__item, a_tag, )
--		end

	menu_for_result__string__options__at_location__in_view_ (a_result: detachable NS_TEXT_CHECKING_RESULT; a_checked_string: detachable NS_STRING; a_options: detachable NS_DICTIONARY; a_location: NS_POINT; a_view: detachable NS_VIEW): detachable NS_MENU
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_result__item: POINTER
			a_checked_string__item: POINTER
			a_options__item: POINTER
			a_view__item: POINTER
		do
			if attached a_result as a_result_attached then
				a_result__item := a_result_attached.item
			end
			if attached a_checked_string as a_checked_string_attached then
				a_checked_string__item := a_checked_string_attached.item
			end
			if attached a_options as a_options_attached then
				a_options__item := a_options_attached.item
			end
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			result_pointer := objc_menu_for_result__string__options__at_location__in_view_ (item, a_result__item, a_checked_string__item, a_options__item, a_location.item, a_view__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like menu_for_result__string__options__at_location__in_view_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like menu_for_result__string__options__at_location__in_view_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	user_quotes_array_for_language_ (a_language: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_language__item: POINTER
		do
			if attached a_language as a_language_attached then
				a_language__item := a_language_attached.item
			end
			result_pointer := objc_user_quotes_array_for_language_ (item, a_language__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like user_quotes_array_for_language_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like user_quotes_array_for_language_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	user_replacements_dictionary: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_user_replacements_dictionary (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like user_replacements_dictionary} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like user_replacements_dictionary} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	update_spelling_panel_with_misspelled_word_ (a_word: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_word__item: POINTER
		do
			if attached a_word as a_word_attached then
				a_word__item := a_word_attached.item
			end
			objc_update_spelling_panel_with_misspelled_word_ (item, a_word__item)
		end

	update_spelling_panel_with_grammar_string__detail_ (a_string: detachable NS_STRING; a_detail: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
			a_detail__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			if attached a_detail as a_detail_attached then
				a_detail__item := a_detail_attached.item
			end
			objc_update_spelling_panel_with_grammar_string__detail_ (item, a_string__item, a_detail__item)
		end

	spelling_panel: detachable NS_PANEL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_spelling_panel (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like spelling_panel} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like spelling_panel} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	accessory_view: detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_accessory_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like accessory_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like accessory_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_accessory_view_ (a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_set_accessory_view_ (item, a_view__item)
		end

	substitutions_panel: detachable NS_PANEL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_substitutions_panel (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like substitutions_panel} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like substitutions_panel} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	substitutions_panel_accessory_view_controller: detachable NS_VIEW_CONTROLLER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_substitutions_panel_accessory_view_controller (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like substitutions_panel_accessory_view_controller} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like substitutions_panel_accessory_view_controller} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_substitutions_panel_accessory_view_controller_ (a_accessory_controller: detachable NS_VIEW_CONTROLLER)
			-- Auto generated Objective-C wrapper.
		local
			a_accessory_controller__item: POINTER
		do
			if attached a_accessory_controller as a_accessory_controller_attached then
				a_accessory_controller__item := a_accessory_controller_attached.item
			end
			objc_set_substitutions_panel_accessory_view_controller_ (item, a_accessory_controller__item)
		end

	update_panels
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_update_panels (item)
		end

	ignore_word__in_spell_document_with_tag_ (a_word_to_ignore: detachable NS_STRING; a_tag: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_word_to_ignore__item: POINTER
		do
			if attached a_word_to_ignore as a_word_to_ignore_attached then
				a_word_to_ignore__item := a_word_to_ignore_attached.item
			end
			objc_ignore_word__in_spell_document_with_tag_ (item, a_word_to_ignore__item, a_tag)
		end

	ignored_words_in_spell_document_with_tag_ (a_tag: INTEGER_64): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_ignored_words_in_spell_document_with_tag_ (item, a_tag)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like ignored_words_in_spell_document_with_tag_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like ignored_words_in_spell_document_with_tag_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_ignored_words__in_spell_document_with_tag_ (a_words: detachable NS_ARRAY; a_tag: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_words__item: POINTER
		do
			if attached a_words as a_words_attached then
				a_words__item := a_words_attached.item
			end
			objc_set_ignored_words__in_spell_document_with_tag_ (item, a_words__item, a_tag)
		end

	guesses_for_word_range__in_string__language__in_spell_document_with_tag_ (a_range: NS_RANGE; a_string: detachable NS_STRING; a_language: detachable NS_STRING; a_tag: INTEGER_64): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_string__item: POINTER
			a_language__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			if attached a_language as a_language_attached then
				a_language__item := a_language_attached.item
			end
			result_pointer := objc_guesses_for_word_range__in_string__language__in_spell_document_with_tag_ (item, a_range.item, a_string__item, a_language__item, a_tag)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like guesses_for_word_range__in_string__language__in_spell_document_with_tag_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like guesses_for_word_range__in_string__language__in_spell_document_with_tag_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	completions_for_partial_word_range__in_string__language__in_spell_document_with_tag_ (a_range: NS_RANGE; a_string: detachable NS_STRING; a_language: detachable NS_STRING; a_tag: INTEGER_64): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_string__item: POINTER
			a_language__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			if attached a_language as a_language_attached then
				a_language__item := a_language_attached.item
			end
			result_pointer := objc_completions_for_partial_word_range__in_string__language__in_spell_document_with_tag_ (item, a_range.item, a_string__item, a_language__item, a_tag)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like completions_for_partial_word_range__in_string__language__in_spell_document_with_tag_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like completions_for_partial_word_range__in_string__language__in_spell_document_with_tag_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	close_spell_document_with_tag_ (a_tag: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_close_spell_document_with_tag_ (item, a_tag)
		end

	available_languages: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_available_languages (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like available_languages} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like available_languages} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	user_preferred_languages: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_user_preferred_languages (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like user_preferred_languages} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like user_preferred_languages} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	automatically_identifies_languages: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_automatically_identifies_languages (item)
		end

	set_automatically_identifies_languages_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_automatically_identifies_languages_ (item, a_flag)
		end

	language: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_language (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like language} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like language} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_language_ (a_language: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_language__item: POINTER
		do
			if attached a_language as a_language_attached then
				a_language__item := a_language_attached.item
			end
			Result := objc_set_language_ (item, a_language__item)
		end

	set_word_field_string_value_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_word_field_string_value_ (item, a_string__item)
		end

	learn_word_ (a_word: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_word__item: POINTER
		do
			if attached a_word as a_word_attached then
				a_word__item := a_word_attached.item
			end
			objc_learn_word_ (item, a_word__item)
		end

	has_learned_word_ (a_word: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_word__item: POINTER
		do
			if attached a_word as a_word_attached then
				a_word__item := a_word_attached.item
			end
			Result := objc_has_learned_word_ (item, a_word__item)
		end

	unlearn_word_ (a_word: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_word__item: POINTER
		do
			if attached a_word as a_word_attached then
				a_word__item := a_word_attached.item
			end
			objc_unlearn_word_ (item, a_word__item)
		end

feature {NONE} -- NSSpellChecker Externals

--	objc_check_spelling_of_string__starting_at__language__wrap__in_spell_document_with_tag__word_count_ (an_item: POINTER; result_pointer: POINTER; a_string_to_check: POINTER; a_starting_offset: INTEGER_64; a_language: POINTER; a_wrap_flag: BOOLEAN; a_tag: INTEGER_64; a_word_count: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				*(NSRange *)$result_pointer = [(NSSpellChecker *)$an_item checkSpellingOfString:$a_string_to_check startingAt:$a_starting_offset language:$a_language wrap:$a_wrap_flag inSpellDocumentWithTag:$a_tag wordCount:];
--			 ]"
--		end

	objc_check_spelling_of_string__starting_at_ (an_item: POINTER; result_pointer: POINTER; a_string_to_check: POINTER; a_starting_offset: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSSpellChecker *)$an_item checkSpellingOfString:$a_string_to_check startingAt:$a_starting_offset];
			 ]"
		end

	objc_count_words_in_string__language_ (an_item: POINTER; a_string_to_count: POINTER; a_language: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSpellChecker *)$an_item countWordsInString:$a_string_to_count language:$a_language];
			 ]"
		end

--	objc_check_grammar_of_string__starting_at__language__wrap__in_spell_document_with_tag__details_ (an_item: POINTER; result_pointer: POINTER; a_string_to_check: POINTER; a_starting_offset: INTEGER_64; a_language: POINTER; a_wrap_flag: BOOLEAN; a_tag: INTEGER_64; a_details: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				*(NSRange *)$result_pointer = [(NSSpellChecker *)$an_item checkGrammarOfString:$a_string_to_check startingAt:$a_starting_offset language:$a_language wrap:$a_wrap_flag inSpellDocumentWithTag:$a_tag details:];
--			 ]"
--		end

--	objc_check_string__range__types__options__in_spell_document_with_tag__orthography__word_count_ (an_item: POINTER; a_string_to_check: POINTER; a_range: POINTER; a_checking_types: NATURAL_64; a_options: POINTER; a_tag: INTEGER_64; a_orthography: UNSUPPORTED_TYPE; a_word_count: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSSpellChecker *)$an_item checkString:$a_string_to_check range:*((NSRange *)$a_range) types:$a_checking_types options:$a_options inSpellDocumentWithTag:$a_tag orthography: wordCount:];
--			 ]"
--		end

--	objc_request_checking_of_string__range__types__options__in_spell_document_with_tag__completion_handler_ (an_item: POINTER; a_string_to_check: POINTER; a_range: POINTER; a_checking_types: NATURAL_64; a_options: POINTER; a_tag: INTEGER_64; a_completion_handler: UNSUPPORTED_TYPE): INTEGER_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSSpellChecker *)$an_item requestCheckingOfString:$a_string_to_check range:*((NSRange *)$a_range) types:$a_checking_types options:$a_options inSpellDocumentWithTag:$a_tag completionHandler:];
--			 ]"
--		end

	objc_menu_for_result__string__options__at_location__in_view_ (an_item: POINTER; a_result: POINTER; a_checked_string: POINTER; a_options: POINTER; a_location: POINTER; a_view: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpellChecker *)$an_item menuForResult:$a_result string:$a_checked_string options:$a_options atLocation:*((NSPoint *)$a_location) inView:$a_view];
			 ]"
		end

	objc_user_quotes_array_for_language_ (an_item: POINTER; a_language: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpellChecker *)$an_item userQuotesArrayForLanguage:$a_language];
			 ]"
		end

	objc_user_replacements_dictionary (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpellChecker *)$an_item userReplacementsDictionary];
			 ]"
		end

	objc_update_spelling_panel_with_misspelled_word_ (an_item: POINTER; a_word: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpellChecker *)$an_item updateSpellingPanelWithMisspelledWord:$a_word];
			 ]"
		end

	objc_update_spelling_panel_with_grammar_string__detail_ (an_item: POINTER; a_string: POINTER; a_detail: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpellChecker *)$an_item updateSpellingPanelWithGrammarString:$a_string detail:$a_detail];
			 ]"
		end

	objc_spelling_panel (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpellChecker *)$an_item spellingPanel];
			 ]"
		end

	objc_accessory_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpellChecker *)$an_item accessoryView];
			 ]"
		end

	objc_set_accessory_view_ (an_item: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpellChecker *)$an_item setAccessoryView:$a_view];
			 ]"
		end

	objc_substitutions_panel (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpellChecker *)$an_item substitutionsPanel];
			 ]"
		end

	objc_substitutions_panel_accessory_view_controller (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpellChecker *)$an_item substitutionsPanelAccessoryViewController];
			 ]"
		end

	objc_set_substitutions_panel_accessory_view_controller_ (an_item: POINTER; a_accessory_controller: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpellChecker *)$an_item setSubstitutionsPanelAccessoryViewController:$a_accessory_controller];
			 ]"
		end

	objc_update_panels (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpellChecker *)$an_item updatePanels];
			 ]"
		end

	objc_ignore_word__in_spell_document_with_tag_ (an_item: POINTER; a_word_to_ignore: POINTER; a_tag: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpellChecker *)$an_item ignoreWord:$a_word_to_ignore inSpellDocumentWithTag:$a_tag];
			 ]"
		end

	objc_ignored_words_in_spell_document_with_tag_ (an_item: POINTER; a_tag: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpellChecker *)$an_item ignoredWordsInSpellDocumentWithTag:$a_tag];
			 ]"
		end

	objc_set_ignored_words__in_spell_document_with_tag_ (an_item: POINTER; a_words: POINTER; a_tag: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpellChecker *)$an_item setIgnoredWords:$a_words inSpellDocumentWithTag:$a_tag];
			 ]"
		end

	objc_guesses_for_word_range__in_string__language__in_spell_document_with_tag_ (an_item: POINTER; a_range: POINTER; a_string: POINTER; a_language: POINTER; a_tag: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpellChecker *)$an_item guessesForWordRange:*((NSRange *)$a_range) inString:$a_string language:$a_language inSpellDocumentWithTag:$a_tag];
			 ]"
		end

	objc_completions_for_partial_word_range__in_string__language__in_spell_document_with_tag_ (an_item: POINTER; a_range: POINTER; a_string: POINTER; a_language: POINTER; a_tag: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpellChecker *)$an_item completionsForPartialWordRange:*((NSRange *)$a_range) inString:$a_string language:$a_language inSpellDocumentWithTag:$a_tag];
			 ]"
		end

	objc_close_spell_document_with_tag_ (an_item: POINTER; a_tag: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpellChecker *)$an_item closeSpellDocumentWithTag:$a_tag];
			 ]"
		end

	objc_available_languages (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpellChecker *)$an_item availableLanguages];
			 ]"
		end

	objc_user_preferred_languages (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpellChecker *)$an_item userPreferredLanguages];
			 ]"
		end

	objc_automatically_identifies_languages (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSpellChecker *)$an_item automaticallyIdentifiesLanguages];
			 ]"
		end

	objc_set_automatically_identifies_languages_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpellChecker *)$an_item setAutomaticallyIdentifiesLanguages:$a_flag];
			 ]"
		end

	objc_language (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpellChecker *)$an_item language];
			 ]"
		end

	objc_set_language_ (an_item: POINTER; a_language: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSpellChecker *)$an_item setLanguage:$a_language];
			 ]"
		end

	objc_set_word_field_string_value_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpellChecker *)$an_item setWordFieldStringValue:$a_string];
			 ]"
		end

	objc_learn_word_ (an_item: POINTER; a_word: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpellChecker *)$an_item learnWord:$a_word];
			 ]"
		end

	objc_has_learned_word_ (an_item: POINTER; a_word: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSpellChecker *)$an_item hasLearnedWord:$a_word];
			 ]"
		end

	objc_unlearn_word_ (an_item: POINTER; a_word: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpellChecker *)$an_item unlearnWord:$a_word];
			 ]"
		end

feature -- NSDeprecated

	guesses_for_word_ (a_word: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_word__item: POINTER
		do
			if attached a_word as a_word_attached then
				a_word__item := a_word_attached.item
			end
			result_pointer := objc_guesses_for_word_ (item, a_word__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like guesses_for_word_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like guesses_for_word_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSDeprecated Externals

	objc_guesses_for_word_ (an_item: POINTER; a_word: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpellChecker *)$an_item guessesForWord:$a_word];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSSpellChecker"
		end

end
