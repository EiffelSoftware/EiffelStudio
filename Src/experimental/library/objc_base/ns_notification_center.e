note
	description: "Wrapper for NSNotificationCenter."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_NOTIFICATION_CENTER

inherit
	NS_OBJECT

create {NS_ENVIRONEMENT}
	make_from_pointer,
	share_from_pointer

feature -- Managing Notification Observers

	add_observer (a_callback: PROCEDURE [ANY, TUPLE[NS_OBJECT]]; a_notification_name: detachable NS_STRING; a_notification_sender: detachable NS_OBJECT)
			-- Adds an entry to the receiver's dispatch table with an observer, a notification selector and optional criteria: notification name and sender.
			-- `a_notification_name' is the name of the notification for which to register the observer; that is, only notifications with this
			-- name are delivered to the observer. When `Void', the notification center doesn't use a notification's name
			-- to decide whether to deliver it to the observer.
		local
			l_callback_object: NS_NOTIFICATION_CALLBACK
			l_sender: POINTER
			l_notification_name: POINTER
		do
			if attached a_notification_sender then
				l_sender := a_notification_sender.item
			end
			if attached a_notification_name then
				l_notification_name := a_notification_name.item
			end
			create l_callback_object.make_with_agent (a_callback)
			observers.extend (l_callback_object)
			{NS_NOTIFICATION_CENTER_API}.add_observer_selector_name_object (item, l_callback_object.item,
					l_callback_object.selector,
					l_notification_name, l_sender)
		end

	remove_observers
			-- Removes all observers.
		do
			from
				observers.start
			until
				observers.after
			loop
				{NS_NOTIFICATION_CENTER_API}.remove_observer (item, observers.item.item)
				observers.forth
			end
			observers.wipe_out
		end

feature -- Posting Notifications

feature {NONE} -- Internal

	observers: ARRAYED_LIST [NS_NOTIFICATION_CALLBACK]
		once
			create Result.make (100)
		end

end
