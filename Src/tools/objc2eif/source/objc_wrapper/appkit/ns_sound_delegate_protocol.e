note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_SOUND_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	sound__did_finish_playing_ (a_sound: detachable NS_SOUND; a_bool: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		require
			has_sound__did_finish_playing_: has_sound__did_finish_playing_
		local
			a_sound__item: POINTER
		do
			if attached a_sound as a_sound_attached then
				a_sound__item := a_sound_attached.item
			end
			objc_sound__did_finish_playing_ (item, a_sound__item, a_bool)
		end

feature -- Status Report

	has_sound__did_finish_playing_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_sound__did_finish_playing_ (item)
		end

feature -- Status Report Externals

	objc_has_sound__did_finish_playing_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(sound:didFinishPlaying:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_sound__did_finish_playing_ (an_item: POINTER; a_sound: POINTER; a_bool: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSSoundDelegate>)$an_item sound:$a_sound didFinishPlaying:$a_bool];
			 ]"
		end

end
