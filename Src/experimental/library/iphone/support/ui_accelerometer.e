note
	description: "Wrapper around the UIAccelerator."
	date: "$Date$"
	revision: "$Revision$"

class
	UI_ACCELEROMETER

inherit
	NS_OBJECT

create {UI_APPLICATION}
	make

feature {NONE} -- Initialization

	make (a_delegate_ptr: POINTER)
			-- Create instance of UI_ACCELEROMETER using `a_delegate_ptr' to handle the callbacks.
		require
			a_delegate_ptr_not_null: a_delegate_ptr /= default_pointer
		do
			share_from_pointer (c_shared_accelerometer)
			delegate := a_delegate_ptr
		ensure
			delegate_set: delegate = a_delegate_ptr
		end

feature -- Action sequences

	acceleration_actions: ACTION_SEQUENCE [TUPLE [UI_ACCELERATION]]
			-- Actions executed when acceleration data is received
		do
			if attached acceleration_actions_internal as l_actions then
				Result := l_actions
			else
				create Result
				Result.empty_actions.extend (agent c_set_delegate (item, default_pointer))
				Result.not_empty_actions.extend (agent c_set_delegate (item, delegate))
				acceleration_actions_internal := Result
			end
		end

feature -- Update

	update_interval: like ns_time_interval
			-- Interval in seconds where acceleromter data is sent to `accelerometer_actions'
		do
			Result := c_update_interval (item)
		ensure
			update_interval_non_negative: Result >= 0.0
		end

feature -- Setting

	set_update_interval (a_time_interval: like ns_time_interval)
			-- Set `update_interval' with `a_time_interval'.
		require
			a_time_interval_positive: a_time_interval >= 0.0
		do
			c_set_update_interval (item, a_time_interval)
		ensure
			update_interval_set: update_interval = a_time_interval
		end

feature {NONE} -- Implementation

	delegate: POINTER
			-- Associated objective C delegate responding to the accelerometer actions

	acceleration_actions_internal: detachable like acceleration_actions note option: stable attribute end
			-- Storage for `acceleration_actions'

feature {NONE} -- Externals

	c_shared_accelerometer: POINTER
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return [UIAccelerometer sharedAccelerometer];"
		end

	c_update_interval (a_item_ptr: POINTER): like ns_time_interval
		require
			a_item_ptr_not_null: a_item_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((UIAccelerometer *) $a_item_ptr).updateInterval;"
		end

	c_set_update_interval (a_item_ptr: POINTER; a_time_interval: like ns_time_interval)
		require
			a_item_ptr_not_null: a_item_ptr /= default_pointer
			a_time_interval_non_negative: a_time_interval >= 0
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((UIAccelerometer *) $a_item_ptr).updateInterval = $a_time_interval;"
		end

	c_set_delegate (a_item_ptr, a_delegate_ptr: POINTER)
		require
			a_item_ptr_not_null: a_item_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((UIAccelerometer *) $a_item_ptr).delegate = (id<UIAccelerometerDelegate>) $a_delegate_ptr;"
		end

invariant
	delegate_not_null: delegate /= default_pointer

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
