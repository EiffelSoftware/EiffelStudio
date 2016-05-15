note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CA_ACTION_PROTOCOL

inherit
	NS_COMMON

feature -- Required Methods

	run_action_for_key__object__arguments_ (a_event: detachable NS_STRING; an_object: detachable NS_OBJECT; a_dict: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_event__item: POINTER
			an_object__item: POINTER
			a_dict__item: POINTER
		do
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			if attached a_dict as a_dict_attached then
				a_dict__item := a_dict_attached.item
			end
			objc_run_action_for_key__object__arguments_ (item, a_event__item, an_object__item, a_dict__item)
		end

feature {NONE} -- Required Methods Externals

	objc_run_action_for_key__object__arguments_ (an_item: POINTER; a_event: POINTER; a_an_object: POINTER; a_dict: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <QuartzCore/QuartzCore.h>"
		alias
			"[
				[(id <CAAction>)$an_item runActionForKey:$a_event object:$a_an_object arguments:$a_dict];
			 ]"
		end

end
