note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_SPEECH_SYNTHESIZER_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	speech_synthesizer__did_finish_speaking_ (a_sender: detachable NS_SPEECH_SYNTHESIZER; a_finished_speaking: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		require
			has_speech_synthesizer__did_finish_speaking_: has_speech_synthesizer__did_finish_speaking_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_speech_synthesizer__did_finish_speaking_ (item, a_sender__item, a_finished_speaking)
		end

	speech_synthesizer__will_speak_word__of_string_ (a_sender: detachable NS_SPEECH_SYNTHESIZER; a_character_range: NS_RANGE; a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		require
			has_speech_synthesizer__will_speak_word__of_string_: has_speech_synthesizer__will_speak_word__of_string_
		local
			a_sender__item: POINTER
			a_string__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_speech_synthesizer__will_speak_word__of_string_ (item, a_sender__item, a_character_range.item, a_string__item)
		end

	speech_synthesizer__will_speak_phoneme_ (a_sender: detachable NS_SPEECH_SYNTHESIZER; a_phoneme_opcode: INTEGER_16)
			-- Auto generated Objective-C wrapper.
		require
			has_speech_synthesizer__will_speak_phoneme_: has_speech_synthesizer__will_speak_phoneme_
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_speech_synthesizer__will_speak_phoneme_ (item, a_sender__item, a_phoneme_opcode)
		end

	speech_synthesizer__did_encounter_error_at_index__of_string__message_ (a_sender: detachable NS_SPEECH_SYNTHESIZER; a_character_index: NATURAL_64; a_string: detachable NS_STRING; a_message: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		require
			has_speech_synthesizer__did_encounter_error_at_index__of_string__message_: has_speech_synthesizer__did_encounter_error_at_index__of_string__message_
		local
			a_sender__item: POINTER
			a_string__item: POINTER
			a_message__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			if attached a_message as a_message_attached then
				a_message__item := a_message_attached.item
			end
			objc_speech_synthesizer__did_encounter_error_at_index__of_string__message_ (item, a_sender__item, a_character_index, a_string__item, a_message__item)
		end

	speech_synthesizer__did_encounter_sync_message_ (a_sender: detachable NS_SPEECH_SYNTHESIZER; a_message: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		require
			has_speech_synthesizer__did_encounter_sync_message_: has_speech_synthesizer__did_encounter_sync_message_
		local
			a_sender__item: POINTER
			a_message__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_message as a_message_attached then
				a_message__item := a_message_attached.item
			end
			objc_speech_synthesizer__did_encounter_sync_message_ (item, a_sender__item, a_message__item)
		end

feature -- Status Report

	has_speech_synthesizer__did_finish_speaking_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_speech_synthesizer__did_finish_speaking_ (item)
		end

	has_speech_synthesizer__will_speak_word__of_string_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_speech_synthesizer__will_speak_word__of_string_ (item)
		end

	has_speech_synthesizer__will_speak_phoneme_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_speech_synthesizer__will_speak_phoneme_ (item)
		end

	has_speech_synthesizer__did_encounter_error_at_index__of_string__message_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_speech_synthesizer__did_encounter_error_at_index__of_string__message_ (item)
		end

	has_speech_synthesizer__did_encounter_sync_message_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_speech_synthesizer__did_encounter_sync_message_ (item)
		end

feature -- Status Report Externals

	objc_has_speech_synthesizer__did_finish_speaking_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(speechSynthesizer:didFinishSpeaking:)];
			 ]"
		end

	objc_has_speech_synthesizer__will_speak_word__of_string_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(speechSynthesizer:willSpeakWord:ofString:)];
			 ]"
		end

	objc_has_speech_synthesizer__will_speak_phoneme_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(speechSynthesizer:willSpeakPhoneme:)];
			 ]"
		end

	objc_has_speech_synthesizer__did_encounter_error_at_index__of_string__message_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(speechSynthesizer:didEncounterErrorAtIndex:ofString:message:)];
			 ]"
		end

	objc_has_speech_synthesizer__did_encounter_sync_message_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(speechSynthesizer:didEncounterSyncMessage:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_speech_synthesizer__did_finish_speaking_ (an_item: POINTER; a_sender: POINTER; a_finished_speaking: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSSpeechSynthesizerDelegate>)$an_item speechSynthesizer:$a_sender didFinishSpeaking:$a_finished_speaking];
			 ]"
		end

	objc_speech_synthesizer__will_speak_word__of_string_ (an_item: POINTER; a_sender: POINTER; a_character_range: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSSpeechSynthesizerDelegate>)$an_item speechSynthesizer:$a_sender willSpeakWord:*((NSRange *)$a_character_range) ofString:$a_string];
			 ]"
		end

	objc_speech_synthesizer__will_speak_phoneme_ (an_item: POINTER; a_sender: POINTER; a_phoneme_opcode: INTEGER_16)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSSpeechSynthesizerDelegate>)$an_item speechSynthesizer:$a_sender willSpeakPhoneme:$a_phoneme_opcode];
			 ]"
		end

	objc_speech_synthesizer__did_encounter_error_at_index__of_string__message_ (an_item: POINTER; a_sender: POINTER; a_character_index: NATURAL_64; a_string: POINTER; a_message: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSSpeechSynthesizerDelegate>)$an_item speechSynthesizer:$a_sender didEncounterErrorAtIndex:$a_character_index ofString:$a_string message:$a_message];
			 ]"
		end

	objc_speech_synthesizer__did_encounter_sync_message_ (an_item: POINTER; a_sender: POINTER; a_message: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSSpeechSynthesizerDelegate>)$an_item speechSynthesizer:$a_sender didEncounterSyncMessage:$a_message];
			 ]"
		end

end
