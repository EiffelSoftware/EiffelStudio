note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_SPEECH_RECOGNIZER_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	speech_recognizer__did_recognize_command_ (a_sender: detachable NS_SPEECH_RECOGNIZER; a_command: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		require
			has_speech_recognizer__did_recognize_command_: has_speech_recognizer__did_recognize_command_
		local
			a_sender__item: POINTER
			a_command__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			if attached a_command as a_command_attached then
				a_command__item := a_command_attached.item
			end
			objc_speech_recognizer__did_recognize_command_ (item, a_sender__item, a_command__item)
		end

feature -- Status Report

	has_speech_recognizer__did_recognize_command_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_speech_recognizer__did_recognize_command_ (item)
		end

feature -- Status Report Externals

	objc_has_speech_recognizer__did_recognize_command_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(speechRecognizer:didRecognizeCommand:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_speech_recognizer__did_recognize_command_ (an_item: POINTER; a_sender: POINTER; a_command: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSSpeechRecognizerDelegate>)$an_item speechRecognizer:$a_sender didRecognizeCommand:$a_command];
			 ]"
		end

end
