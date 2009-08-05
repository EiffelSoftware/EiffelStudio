note
	description: "Wrapper for NSTimer."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TIMER

inherit
	NS_OBJECT

create
--	scheduled_timer_with_time_interval_invocation_repeats,
	scheduled_timer
--	timer_with_time_interval_invocation_repeats,
--	timer_with_time_interval_target_selector_user_info_repeats
create {NS_OBJECT}
	make_from_pointer,
	share_from_pointer

feature {NONE} -- Creating a Timer

--	scheduled_timer_with_time_interval_invocation_repeats (a_ti: REAL_64; a_invocation: NS_INVOCATION; a_yes_or_no: BOOLEAN)
--			-- Returns a new `NSTimer' object, scheduled with the current `NSRunLoop' object in the default mode.
--		do
--			make_from_pointer ({NS_TIMER_API}.scheduled_timer_with_time_interval_invocation_repeats (a_ti, a_invocation.item, a_yes_or_no))
--		end

	scheduled_timer (a_ti: REAL_64; a_callback: PROCEDURE [ANY, TUPLE]; a_user_info: detachable NS_OBJECT; a_yes_or_no: BOOLEAN)
			-- Returns a new `NSTimer' object, scheduled the current `NSRunLoop' object in the default mode.
		local
			l_user_info: POINTER
		do
			if attached a_user_info then
				l_user_info := a_user_info.item
			end
			callback := a_callback
			callback_item := callbacks_class.create_instance.item
--			callback_marshal.register_object (current)
			--a_target: NS_OBJECT; a_selector: OBJC_SELECTOR
			make_from_pointer ({NS_TIMER_API}.scheduled_timer_with_time_interval_target_selector_user_info_repeats (a_ti, callback_item, selector, l_user_info, a_yes_or_no))
		end

--	timer_with_time_interval_invocation_repeats (a_ti: REAL_64; a_invocation: NS_INVOCATION; a_yes_or_no: BOOLEAN)
--			-- Returns a new `NSTimer' that, when added to a run loop, will fire after a given number of seconds.
--		do
--			make_from_pointer ({NS_TIMER_API}.timer_with_time_interval_invocation_repeats (a_ti, a_invocation.item, a_yes_or_no))
--		end

--	timer_with_time_interval_target_selector_user_info_repeats (a_ti: REAL_64; a_callback: PROCEDURE [ANY, TUPLE]; a_user_info: NS_OBJECT; a_yes_or_no: BOOLEAN)
--			-- Returns a new `NSTimer' that, when added to a run loop, will fire after a specified number of seconds.
--		do
--			callback := a_callback
--			make_from_pointer ({NS_TIMER_API}.timer_with_time_interval_target_selector_user_info_repeats (a_ti, a_target.item, a_selector.item, a_user_info.item, a_yes_or_no))
--		end

	init_with_fire_date_interval_target_selector_user_info_repeats (a_date: NS_DATE; a_ti: REAL_64; a_t: NS_OBJECT; a_s: OBJC_SELECTOR; a_ui: NS_OBJECT; a_rep: BOOLEAN)
			-- Initializes a new <code>NSTimer</code> that, when added to a run loop, will fire at a given date.
		do
			item := {NS_TIMER_API}.init_with_fire_date_interval_target_selector_user_info_repeats (item, a_date.item, a_ti, a_t.item, a_s.item, a_ui.item, a_rep)
		end

feature -- Firing a Timer

	fire
			-- Causes the receiver`s message to be sent to its target.
		do
			{NS_TIMER_API}.fire (item)
		end

feature -- Stopping a Timer

	invalidate
			-- Stops the receiver from ever firing again and requests its removal from its `NSRunLoop' object.
		do
			{NS_TIMER_API}.invalidate (item)
		end

feature -- Information About a Timer

	is_valid: BOOLEAN
			-- Returns a Boolean value that indicates whether the receiver is currently valid.
		do
			Result := {NS_TIMER_API}.is_valid (item)
		end

	fire_date: NS_DATE
			-- Returns the date at which the receiver will fire.
		do
			create Result.share_from_pointer ({NS_TIMER_API}.fire_date (item))
		end

	set_fire_date (a_date: NS_DATE)
			-- Resets the receiver to fire next at a given date.
		do
			{NS_TIMER_API}.set_fire_date (item, a_date.item)
		end

	time_interval: REAL_64
			-- Returns the receiver`s time interval.
		do
			Result := {NS_TIMER_API}.time_interval (item)
		end

	user_info: NS_OBJECT
			-- Returns the receiver's <em>userInfo</em> object.
		do
			create Result.share_from_pointer ({NS_TIMER_API}.user_info (item))
		end

feature {NONE} -- Implementation

	callbacks_class: OBJC_CLASS
			-- Create a new Objective-C object with one method and use this as a callback.
		once
			create Result.make_with_name ("EiffelWrapperTimerCallback")
			Result.set_superclass (create {OBJC_CLASS}.make_with_name ("NSObject"))
			Result.add_method ("callbackMethod:", agent call_observer)
			Result.register
		end

	selector: POINTER
		do
			Result := {NS_OBJC_RUNTIME}.sel_register_name ((create {C_STRING}.make ("callbackMethod:")).item)
		end

	call_observer (a_ptr: POINTER)
		do
			check
				callback_correct: a_ptr = item
			end
			if attached callback as c then
				c.call ([])
			end
		end

	callback: detachable PROCEDURE [ANY, TUPLE[]]

	callback_item: POINTER

end
