note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_SPELL_SERVER_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

--	spell_server__find_misspelled_word_in_string__language__word_count__count_only_ (a_sender: detachable NS_SPELL_SERVER; a_string_to_check: detachable NS_STRING; a_language: detachable NS_STRING; a_word_count: UNSUPPORTED_TYPE; a_count_only: BOOLEAN): NS_RANGE
--			-- Auto generated Objective-C wrapper.
--		require
--			has_spell_server__find_misspelled_word_in_string__language__word_count__count_only_: has_spell_server__find_misspelled_word_in_string__language__word_count__count_only_
--		local
--			a_sender__item: POINTER
--			a_string_to_check__item: POINTER
--			a_language__item: POINTER
--			a_word_count__item: POINTER
--		do
--			if attached a_sender as a_sender_attached then
--				a_sender__item := a_sender_attached.item
--			end
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
--			objc_spell_server__find_misspelled_word_in_string__language__word_count__count_only_ (item, Result.item, a_sender__item, a_string_to_check__item, a_language__item, a_word_count__item, a_count_only)
--		end

	spell_server__suggest_guesses_for_word__in_language_ (a_sender: detachable NS_SPELL_SERVER; a_word: detachable NS_STRING; a_language: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		require
			has_spell_server__suggest_guesses_for_word__in_language_: has_spell_server__suggest_guesses_for_word__in_language_
		local
			result_pointer: POINTER
			a_sender__item: POINTER
			a_word__item: POINTER
			a_language__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_word as a_word_attached then
				a_word__item := a_word_attached.item
			end
			if attached a_language as a_language_attached then
				a_language__item := a_language_attached.item
			end
			result_pointer := objc_spell_server__suggest_guesses_for_word__in_language_ (item, a_sender__item, a_word__item, a_language__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like spell_server__suggest_guesses_for_word__in_language_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like spell_server__suggest_guesses_for_word__in_language_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	spell_server__did_learn_word__in_language_ (a_sender: detachable NS_SPELL_SERVER; a_word: detachable NS_STRING; a_language: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		require
			has_spell_server__did_learn_word__in_language_: has_spell_server__did_learn_word__in_language_
		local
			a_sender__item: POINTER
			a_word__item: POINTER
			a_language__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_word as a_word_attached then
				a_word__item := a_word_attached.item
			end
			if attached a_language as a_language_attached then
				a_language__item := a_language_attached.item
			end
			objc_spell_server__did_learn_word__in_language_ (item, a_sender__item, a_word__item, a_language__item)
		end

	spell_server__did_forget_word__in_language_ (a_sender: detachable NS_SPELL_SERVER; a_word: detachable NS_STRING; a_language: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		require
			has_spell_server__did_forget_word__in_language_: has_spell_server__did_forget_word__in_language_
		local
			a_sender__item: POINTER
			a_word__item: POINTER
			a_language__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_word as a_word_attached then
				a_word__item := a_word_attached.item
			end
			if attached a_language as a_language_attached then
				a_language__item := a_language_attached.item
			end
			objc_spell_server__did_forget_word__in_language_ (item, a_sender__item, a_word__item, a_language__item)
		end

	spell_server__suggest_completions_for_partial_word_range__in_string__language_ (a_sender: detachable NS_SPELL_SERVER; a_range: NS_RANGE; a_string: detachable NS_STRING; a_language: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		require
			has_spell_server__suggest_completions_for_partial_word_range__in_string__language_: has_spell_server__suggest_completions_for_partial_word_range__in_string__language_
		local
			result_pointer: POINTER
			a_sender__item: POINTER
			a_string__item: POINTER
			a_language__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			if attached a_language as a_language_attached then
				a_language__item := a_language_attached.item
			end
			result_pointer := objc_spell_server__suggest_completions_for_partial_word_range__in_string__language_ (item, a_sender__item, a_range.item, a_string__item, a_language__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like spell_server__suggest_completions_for_partial_word_range__in_string__language_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like spell_server__suggest_completions_for_partial_word_range__in_string__language_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	spell_server__check_grammar_in_string__language__details_ (a_sender: detachable NS_SPELL_SERVER; a_string_to_check: detachable NS_STRING; a_language: detachable NS_STRING; a_details: UNSUPPORTED_TYPE): NS_RANGE
--			-- Auto generated Objective-C wrapper.
--		require
--			has_spell_server__check_grammar_in_string__language__details_: has_spell_server__check_grammar_in_string__language__details_
--		local
--			a_sender__item: POINTER
--			a_string_to_check__item: POINTER
--			a_language__item: POINTER
--			a_details__item: POINTER
--		do
--			if attached a_sender as a_sender_attached then
--				a_sender__item := a_sender_attached.item
--			end
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
--			objc_spell_server__check_grammar_in_string__language__details_ (item, Result.item, a_sender__item, a_string_to_check__item, a_language__item, a_details__item)
--		end

--	spell_server__check_string__offset__types__options__orthography__word_count_ (a_sender: detachable NS_SPELL_SERVER; a_string_to_check: detachable NS_STRING; a_offset: NATURAL_64; a_checking_types: NATURAL_64; a_options: detachable NS_DICTIONARY; a_orthography: detachable NS_ORTHOGRAPHY; a_word_count: UNSUPPORTED_TYPE): detachable NS_ARRAY
--			-- Auto generated Objective-C wrapper.
--		require
--			has_spell_server__check_string__offset__types__options__orthography__word_count_: has_spell_server__check_string__offset__types__options__orthography__word_count_
--		local
--			result_pointer: POINTER
--			a_sender__item: POINTER
--			a_string_to_check__item: POINTER
--			a_options__item: POINTER
--			a_orthography__item: POINTER
--			a_word_count__item: POINTER
--		do
--			if attached a_sender as a_sender_attached then
--				a_sender__item := a_sender_attached.item
--			end
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
--			result_pointer := objc_spell_server__check_string__offset__types__options__orthography__word_count_ (item, a_sender__item, a_string_to_check__item, a_offset, a_checking_types, a_options__item, a_orthography__item, a_word_count__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like spell_server__check_string__offset__types__options__orthography__word_count_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like spell_server__check_string__offset__types__options__orthography__word_count_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature -- Status Report

--	has_spell_server__find_misspelled_word_in_string__language__word_count__count_only_: BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		do
--			Result := objc_has_spell_server__find_misspelled_word_in_string__language__word_count__count_only_ (item)
--		end

	has_spell_server__suggest_guesses_for_word__in_language_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_spell_server__suggest_guesses_for_word__in_language_ (item)
		end

	has_spell_server__did_learn_word__in_language_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_spell_server__did_learn_word__in_language_ (item)
		end

	has_spell_server__did_forget_word__in_language_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_spell_server__did_forget_word__in_language_ (item)
		end

	has_spell_server__suggest_completions_for_partial_word_range__in_string__language_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_spell_server__suggest_completions_for_partial_word_range__in_string__language_ (item)
		end

--	has_spell_server__check_grammar_in_string__language__details_: BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		do
--			Result := objc_has_spell_server__check_grammar_in_string__language__details_ (item)
--		end

--	has_spell_server__check_string__offset__types__options__orthography__word_count_: BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		do
--			Result := objc_has_spell_server__check_string__offset__types__options__orthography__word_count_ (item)
--		end

feature -- Status Report Externals

--	objc_has_spell_server__find_misspelled_word_in_string__language__word_count__count_only_ (an_item: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(id)$an_item respondsToSelector:@selector(spellServer:findMisspelledWordInString:language:wordCount:countOnly:)];
--			 ]"
--		end

	objc_has_spell_server__suggest_guesses_for_word__in_language_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(spellServer:suggestGuessesForWord:inLanguage:)];
			 ]"
		end

	objc_has_spell_server__did_learn_word__in_language_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(spellServer:didLearnWord:inLanguage:)];
			 ]"
		end

	objc_has_spell_server__did_forget_word__in_language_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(spellServer:didForgetWord:inLanguage:)];
			 ]"
		end

	objc_has_spell_server__suggest_completions_for_partial_word_range__in_string__language_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(spellServer:suggestCompletionsForPartialWordRange:inString:language:)];
			 ]"
		end

--	objc_has_spell_server__check_grammar_in_string__language__details_ (an_item: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(id)$an_item respondsToSelector:@selector(spellServer:checkGrammarInString:language:details:)];
--			 ]"
--		end

--	objc_has_spell_server__check_string__offset__types__options__orthography__word_count_ (an_item: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(id)$an_item respondsToSelector:@selector(spellServer:checkString:offset:types:options:orthography:wordCount:)];
--			 ]"
--		end

feature {NONE} -- Optional Methods Externals

--	objc_spell_server__find_misspelled_word_in_string__language__word_count__count_only_ (an_item: POINTER; result_pointer: POINTER; a_sender: POINTER; a_string_to_check: POINTER; a_language: POINTER; a_word_count: UNSUPPORTED_TYPE; a_count_only: BOOLEAN)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				*(NSRange *)$result_pointer = [(id <NSSpellServerDelegate>)$an_item spellServer:$a_sender findMisspelledWordInString:$a_string_to_check language:$a_language wordCount: countOnly:$a_count_only];
--			 ]"
--		end

	objc_spell_server__suggest_guesses_for_word__in_language_ (an_item: POINTER; a_sender: POINTER; a_word: POINTER; a_language: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSSpellServerDelegate>)$an_item spellServer:$a_sender suggestGuessesForWord:$a_word inLanguage:$a_language];
			 ]"
		end

	objc_spell_server__did_learn_word__in_language_ (an_item: POINTER; a_sender: POINTER; a_word: POINTER; a_language: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSSpellServerDelegate>)$an_item spellServer:$a_sender didLearnWord:$a_word inLanguage:$a_language];
			 ]"
		end

	objc_spell_server__did_forget_word__in_language_ (an_item: POINTER; a_sender: POINTER; a_word: POINTER; a_language: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSSpellServerDelegate>)$an_item spellServer:$a_sender didForgetWord:$a_word inLanguage:$a_language];
			 ]"
		end

	objc_spell_server__suggest_completions_for_partial_word_range__in_string__language_ (an_item: POINTER; a_sender: POINTER; a_range: POINTER; a_string: POINTER; a_language: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSSpellServerDelegate>)$an_item spellServer:$a_sender suggestCompletionsForPartialWordRange:*((NSRange *)$a_range) inString:$a_string language:$a_language];
			 ]"
		end

--	objc_spell_server__check_grammar_in_string__language__details_ (an_item: POINTER; result_pointer: POINTER; a_sender: POINTER; a_string_to_check: POINTER; a_language: POINTER; a_details: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				*(NSRange *)$result_pointer = [(id <NSSpellServerDelegate>)$an_item spellServer:$a_sender checkGrammarInString:$a_string_to_check language:$a_language details:];
--			 ]"
--		end

--	objc_spell_server__check_string__offset__types__options__orthography__word_count_ (an_item: POINTER; a_sender: POINTER; a_string_to_check: POINTER; a_offset: NATURAL_64; a_checking_types: NATURAL_64; a_options: POINTER; a_orthography: POINTER; a_word_count: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(id <NSSpellServerDelegate>)$an_item spellServer:$a_sender checkString:$a_string_to_check offset:$a_offset types:$a_checking_types options:$a_options orthography:$a_orthography wordCount:];
--			 ]"
--		end

end
