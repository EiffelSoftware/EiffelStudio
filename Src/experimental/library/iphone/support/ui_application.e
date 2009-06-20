note
	description: "[
		Represent the current application object responsible of event handling. To get an instance, you need
		to use {SHARED_UI_APPLICATION}.application.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	UI_APPLICATION

inherit
	NS_OBJECT
		redefine
			default_create
		end

	UI_ENVIRONMENT
		export
			{NONE} all
		undefine
			copy
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
			-- Initialize Current by setting up UI_ENVIRONMENT and callbacks.
		do
			c_set_dispatcher (Current, $dispatcher)
			application_cell.put (Current)
		end

feature -- Basic operations

	launch
			-- Start the event loop for current.
		local
			l_res: INTEGER
		do
			l_res := c_run
		end

feature -- Access

	accelerometer: UI_ACCELEROMETER
			-- Shared object to access accelerometer data
		require
			exists: exists
		once
			create Result.make (c_delegate (item))
			Result.set_update_interval (2)
		end

feature -- Action sequences

	post_launch_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions executed when application starts
		do
			if attached post_launch_actions_internal as l_actions then
				Result := l_actions
			else
				create Result
				post_launch_actions_internal := Result
			end
		end

	shake_began_actions: ACTION_SEQUENCE [TUPLE [UI_EVENT]]
			-- Actions executed when shake starts
		do
			if attached shake_began_actions_internal as l_actions then
				Result := l_actions
			else
				create Result
				shake_began_actions_internal := Result
			end
		end

	shake_cancelled_actions: ACTION_SEQUENCE [TUPLE [UI_EVENT]]
			-- Actions executed when shake is cancelled
		do
			if attached shake_cancelled_actions_internal as l_actions then
				Result := l_actions
			else
				create Result
				shake_cancelled_actions_internal := Result
			end
		end

	shake_ended_actions: ACTION_SEQUENCE [TUPLE [UI_EVENT]]
			-- Actions executed when shake finishes
		do
			if attached shake_ended_actions_internal as l_actions then
				Result := l_actions
			else
				create Result
				shake_ended_actions_internal := Result
			end
		end

feature {NONE} -- Implementation

	post_launch_actions_internal: detachable like post_launch_actions note option: stable attribute end
			-- Storage for `launch_actions'

	shake_began_actions_internal: detachable like shake_began_actions note option: stable attribute end
			-- Storage for `shake_began_actions'

	shake_cancelled_actions_internal: detachable like shake_cancelled_actions note option: stable attribute end
			-- Storage for `shake_cancelled_actions'

	shake_ended_actions_internal: detachable like shake_ended_actions note option: stable attribute end
			-- Storage for `shake_ended_actions'

feature {NONE} -- Dispatching

	dispatcher (a_msg: NATURAL; a_data: POINTER)
		local
			l_obj: POINTER
			l_event: UI_EVENT
		do
			inspect a_msg
			when {UI_DISPATCHER_CONST}.ui_application_did_finish_launching then
				share_from_pointer (a_data)
				post_launch_actions.call (Void)

			when {UI_DISPATCHER_CONST}.ui_responder_touches_began then
				l_obj := c_touch_obj (a_data)
				check l_obj_not_null: l_obj /= default_pointer end
				if attached mapping.eiffel_object_from_c (l_obj) as l_view then
					create l_event.share_from_pointer (c_touch_event_data (a_data))
					l_view.touches_began_actions.call ([l_event]);
				end

			when {UI_DISPATCHER_CONST}.ui_responder_touches_moved then
				l_obj := c_touch_obj (a_data)
				check l_obj_not_null: l_obj /= default_pointer end
				if attached mapping.eiffel_object_from_c (l_obj) as l_view then
					create l_event.share_from_pointer (c_touch_event_data (a_data))
					l_view.touches_moved_actions.call ([l_event]);
				end

			when {UI_DISPATCHER_CONST}.ui_responder_touches_cancelled then
				l_obj := c_touch_obj (a_data)
				check l_obj_not_null: l_obj /= default_pointer end
				if attached mapping.eiffel_object_from_c (l_obj) as l_view then
					create l_event.share_from_pointer (c_touch_event_data (a_data))
					l_view.touches_cancelled_actions.call ([l_event]);
				end

			when {UI_DISPATCHER_CONST}.ui_responder_touches_ended then
				l_obj := c_touch_obj (a_data)
				check l_obj_not_null: l_obj /= default_pointer end
				if attached mapping.eiffel_object_from_c (l_obj) as l_view then
					create l_event.share_from_pointer (c_touch_event_data (a_data))
					l_view.touches_ended_actions.call ([l_event]);
				end

			when {UI_DISPATCHER_CONST}.ui_responder_motion_began then
				if c_is_motion_shake (a_data) then
					create l_event.share_from_pointer (c_touch_event_data (a_data))
					shake_began_actions.call ([l_event]);
				end

			when {UI_DISPATCHER_CONST}.ui_responder_motion_cancelled then
				if c_is_motion_shake (a_data) then
					create l_event.share_from_pointer (c_touch_event_data (a_data))
					shake_cancelled_actions.call ([l_event]);
				end

			when {UI_DISPATCHER_CONST}.ui_responder_motion_ended then
				if c_is_motion_shake (a_data) then
					create l_event.share_from_pointer (c_touch_event_data (a_data))
					shake_ended_actions.call ([l_event]);
				end

			when {UI_DISPATCHER_CONST}.ui_accelerometer_msg then
				accelerometer.acceleration_actions.call ([create {UI_ACCELERATION}.share_from_pointer (a_data)])

			else
			end
		end

	mapping: UI_ROUTINES
			-- Mapping between objective C object and Eiffel UI_VIEWs
		once
			create Result
		end

feature {NONE} -- Externals

	c_set_dispatcher (a_disp: ANY; a_proc: POINTER)
		require
			a_proc_not_null: a_proc /= default_pointer
			a_proc_valid: True
		external
			"C inline use %"eiffel_iphone.h%""
		alias
			"eiffel_iphone_set_dispatcher($a_disp, (EIF_NOTIFY_PROC) $a_proc);"
		end

	c_run: INTEGER
		external
			"C inline use <UIKit/UIKit.h>, %"eif_argv.h%""
		alias
			"[
				int retVal;
			    NSAutoreleasePool *pool;
			    
			    pool = [[NSAutoreleasePool alloc] init];
    			retVal = UIApplicationMain(eif_argc, eif_argv, @"EiffelUIApplication", @"EiffeliPhoneDelegate");
    			[pool release];
    			
    			return retVal;
			]"
		end

	c_delegate (a_item_ptr: POINTER): POINTER
			-- Delegate of Current UIApplication object
		require
			a_item_ptr_not_null: a_item_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((UIApplication *) $a_item_ptr).delegate;"
		end

	c_touch_obj (a_data: POINTER): POINTER
		require
			a_data_not_null: a_data /= default_pointer
		external
			"C inline use %"eiffel_iphone.h%""
		alias
			"return ((eif_touches_event_t *) $a_data)->obj;"
		end

	c_touch_event_data (a_data: POINTER): POINTER
		require
			a_data_not_null: a_data /= default_pointer
		external
			"C inline use %"eiffel_iphone.h%""
		alias
			"return ((eif_touches_event_t *) $a_data)->event;"
		end

	c_motion_event_data (a_data: POINTER): POINTER
		require
			a_data_not_null: a_data /= default_pointer
		external
			"C inline use %"eiffel_iphone.h%""
		alias
			"return ((eif_motion_event_t *) $a_data)->event;"
		end

	c_is_motion_shake (a_data: POINTER): BOOLEAN
		require
			a_data_not_null: a_data /= default_pointer
		external
			"C inline use %"eiffel_iphone.h%""
		alias
			"return EIF_TEST(((eif_motion_event_t *) $a_data)->motion == UIEventSubtypeMotionShake);"
		end

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
