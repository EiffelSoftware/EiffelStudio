note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SPEECH_RECOGNIZER

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

feature -- NSSpeechRecognizer

	start_listening
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_start_listening (item)
		end

	stop_listening
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_stop_listening (item)
		end

	delegate: detachable NS_SPEECH_RECOGNIZER_DELEGATE_PROTOCOL
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

	set_delegate_ (an_object: detachable NS_SPEECH_RECOGNIZER_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_set_delegate_ (item, an_object__item)
		end

	commands: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_commands (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like commands} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like commands} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_commands_ (a_commands: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_commands__item: POINTER
		do
			if attached a_commands as a_commands_attached then
				a_commands__item := a_commands_attached.item
			end
			objc_set_commands_ (item, a_commands__item)
		end

	displayed_commands_title: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_displayed_commands_title (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like displayed_commands_title} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like displayed_commands_title} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_displayed_commands_title_ (a_title: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_title__item: POINTER
		do
			if attached a_title as a_title_attached then
				a_title__item := a_title_attached.item
			end
			objc_set_displayed_commands_title_ (item, a_title__item)
		end

	listens_in_foreground_only: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_listens_in_foreground_only (item)
		end

	set_listens_in_foreground_only_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_listens_in_foreground_only_ (item, a_flag)
		end

	blocks_other_recognizers: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_blocks_other_recognizers (item)
		end

	set_blocks_other_recognizers_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_blocks_other_recognizers_ (item, a_flag)
		end

feature {NONE} -- NSSpeechRecognizer Externals

	objc_start_listening (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpeechRecognizer *)$an_item startListening];
			 ]"
		end

	objc_stop_listening (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpeechRecognizer *)$an_item stopListening];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpeechRecognizer *)$an_item delegate];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpeechRecognizer *)$an_item setDelegate:$an_object];
			 ]"
		end

	objc_commands (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpeechRecognizer *)$an_item commands];
			 ]"
		end

	objc_set_commands_ (an_item: POINTER; a_commands: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpeechRecognizer *)$an_item setCommands:$a_commands];
			 ]"
		end

	objc_displayed_commands_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpeechRecognizer *)$an_item displayedCommandsTitle];
			 ]"
		end

	objc_set_displayed_commands_title_ (an_item: POINTER; a_title: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpeechRecognizer *)$an_item setDisplayedCommandsTitle:$a_title];
			 ]"
		end

	objc_listens_in_foreground_only (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSpeechRecognizer *)$an_item listensInForegroundOnly];
			 ]"
		end

	objc_set_listens_in_foreground_only_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpeechRecognizer *)$an_item setListensInForegroundOnly:$a_flag];
			 ]"
		end

	objc_blocks_other_recognizers (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSpeechRecognizer *)$an_item blocksOtherRecognizers];
			 ]"
		end

	objc_set_blocks_other_recognizers_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSpeechRecognizer *)$an_item setBlocksOtherRecognizers:$a_flag];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSSpeechRecognizer"
		end

end
