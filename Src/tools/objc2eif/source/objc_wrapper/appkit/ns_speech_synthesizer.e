note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SPEECH_SYNTHESIZER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_voice_,
	make

feature {NONE} -- Initialization

	make_with_voice_ (a_voice: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_voice__item: POINTER
		do
			if attached a_voice as a_voice_attached then
				a_voice__item := a_voice_attached.item
			end
			make_with_pointer (objc_init_with_voice_(allocate_object, a_voice__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSSpeechSynthesizer Externals

	objc_init_with_voice_ (an_item: POINTER; a_voice: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpeechSynthesizer *)$an_item initWithVoice:$a_voice];
			 ]"
		end

	objc_start_speaking_string_ (an_item: POINTER; a_string: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSpeechSynthesizer *)$an_item startSpeakingString:$a_string];
			 ]"
		end

	objc_start_speaking_string__to_ur_l_ (an_item: POINTER; a_string: POINTER; a_url: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSpeechSynthesizer *)$an_item startSpeakingString:$a_string toURL:$a_url];
			 ]"
		end

	objc_is_speaking (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSpeechSynthesizer *)$an_item isSpeaking];
			 ]"
		end

	objc_stop_speaking (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpeechSynthesizer *)$an_item stopSpeaking];
			 ]"
		end

	objc_stop_speaking_at_boundary_ (an_item: POINTER; a_boundary: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpeechSynthesizer *)$an_item stopSpeakingAtBoundary:$a_boundary];
			 ]"
		end

	objc_pause_speaking_at_boundary_ (an_item: POINTER; a_boundary: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpeechSynthesizer *)$an_item pauseSpeakingAtBoundary:$a_boundary];
			 ]"
		end

	objc_continue_speaking (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpeechSynthesizer *)$an_item continueSpeaking];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpeechSynthesizer *)$an_item delegate];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpeechSynthesizer *)$an_item setDelegate:$an_object];
			 ]"
		end

	objc_voice (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpeechSynthesizer *)$an_item voice];
			 ]"
		end

	objc_set_voice_ (an_item: POINTER; a_voice: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSpeechSynthesizer *)$an_item setVoice:$a_voice];
			 ]"
		end

	objc_rate (an_item: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSpeechSynthesizer *)$an_item rate];
			 ]"
		end

	objc_set_rate_ (an_item: POINTER; a_rate: REAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpeechSynthesizer *)$an_item setRate:$a_rate];
			 ]"
		end

	objc_volume (an_item: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSpeechSynthesizer *)$an_item volume];
			 ]"
		end

	objc_set_volume_ (an_item: POINTER; a_volume: REAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpeechSynthesizer *)$an_item setVolume:$a_volume];
			 ]"
		end

	objc_uses_feedback_window (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSpeechSynthesizer *)$an_item usesFeedbackWindow];
			 ]"
		end

	objc_set_uses_feedback_window_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpeechSynthesizer *)$an_item setUsesFeedbackWindow:$a_flag];
			 ]"
		end

	objc_add_speech_dictionary_ (an_item: POINTER; a_speech_dictionary: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpeechSynthesizer *)$an_item addSpeechDictionary:$a_speech_dictionary];
			 ]"
		end

	objc_phonemes_from_text_ (an_item: POINTER; a_text: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpeechSynthesizer *)$an_item phonemesFromText:$a_text];
			 ]"
		end

--	objc_object_for_property__error_ (an_item: POINTER; a_property: POINTER; a_out_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSSpeechSynthesizer *)$an_item objectForProperty:$a_property error:];
--			 ]"
--		end

--	objc_set_object__for_property__error_ (an_item: POINTER; a_object: POINTER; a_property: POINTER; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSSpeechSynthesizer *)$an_item setObject:$a_object forProperty:$a_property error:];
--			 ]"
--		end

feature -- NSSpeechSynthesizer

	start_speaking_string_ (a_string: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			Result := objc_start_speaking_string_ (item, a_string__item)
		end

	start_speaking_string__to_ur_l_ (a_string: detachable NS_STRING; a_url: detachable NS_URL): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
			a_url__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			Result := objc_start_speaking_string__to_ur_l_ (item, a_string__item, a_url__item)
		end

	is_speaking: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_speaking (item)
		end

	stop_speaking
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_stop_speaking (item)
		end

	stop_speaking_at_boundary_ (a_boundary: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_stop_speaking_at_boundary_ (item, a_boundary)
		end

	pause_speaking_at_boundary_ (a_boundary: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_pause_speaking_at_boundary_ (item, a_boundary)
		end

	continue_speaking
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_continue_speaking (item)
		end

	delegate: detachable NS_SPEECH_SYNTHESIZER_DELEGATE_PROTOCOL
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

	set_delegate_ (an_object: detachable NS_SPEECH_SYNTHESIZER_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_set_delegate_ (item, an_object__item)
		end

	voice: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_voice (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like voice} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like voice} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_voice_ (a_voice: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_voice__item: POINTER
		do
			if attached a_voice as a_voice_attached then
				a_voice__item := a_voice_attached.item
			end
			Result := objc_set_voice_ (item, a_voice__item)
		end

	rate: REAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_rate (item)
		end

	set_rate_ (a_rate: REAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_rate_ (item, a_rate)
		end

	volume: REAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_volume (item)
		end

	set_volume_ (a_volume: REAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_volume_ (item, a_volume)
		end

	uses_feedback_window: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_uses_feedback_window (item)
		end

	set_uses_feedback_window_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_uses_feedback_window_ (item, a_flag)
		end

	add_speech_dictionary_ (a_speech_dictionary: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_speech_dictionary__item: POINTER
		do
			if attached a_speech_dictionary as a_speech_dictionary_attached then
				a_speech_dictionary__item := a_speech_dictionary_attached.item
			end
			objc_add_speech_dictionary_ (item, a_speech_dictionary__item)
		end

	phonemes_from_text_ (a_text: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_text__item: POINTER
		do
			if attached a_text as a_text_attached then
				a_text__item := a_text_attached.item
			end
			result_pointer := objc_phonemes_from_text_ (item, a_text__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like phonemes_from_text_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like phonemes_from_text_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	object_for_property__error_ (a_property: detachable NS_STRING; a_out_error: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_property__item: POINTER
--			a_out_error__item: POINTER
--		do
--			if attached a_property as a_property_attached then
--				a_property__item := a_property_attached.item
--			end
--			if attached a_out_error as a_out_error_attached then
--				a_out_error__item := a_out_error_attached.item
--			end
--			result_pointer := objc_object_for_property__error_ (item, a_property__item, a_out_error__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like object_for_property__error_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like object_for_property__error_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	set_object__for_property__error_ (a_object: detachable NS_OBJECT; a_property: detachable NS_STRING; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_object__item: POINTER
--			a_property__item: POINTER
--			a_out_error__item: POINTER
--		do
--			if attached a_object as a_object_attached then
--				a_object__item := a_object_attached.item
--			end
--			if attached a_property as a_property_attached then
--				a_property__item := a_property_attached.item
--			end
--			if attached a_out_error as a_out_error_attached then
--				a_out_error__item := a_out_error_attached.item
--			end
--			Result := objc_set_object__for_property__error_ (item, a_object__item, a_property__item, a_out_error__item)
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSSpeechSynthesizer"
		end

end
