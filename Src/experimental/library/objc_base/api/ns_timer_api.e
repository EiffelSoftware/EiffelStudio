note
	description: "Summary description for {NS_TIMER_API}."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TIMER_API

feature -- Creating a Timer

	frozen scheduled_timer_with_time_interval_invocation_repeats (a_ti: REAL_64; a_invocation: POINTER; a_yes_or_no: BOOLEAN): POINTER
			-- + (NSTimer *)scheduledTimerWithTimeInterval: (NSTimeInterval) ti invocation: (NSInvocation *) invocation repeats: (BOOL) yesOrNo
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSTimer scheduledTimerWithTimeInterval: $a_ti invocation: $a_invocation repeats: $a_yes_or_no];"
		end

	frozen scheduled_timer_with_time_interval_target_selector_user_info_repeats (a_ti: REAL_64; a_target: POINTER; a_selector: POINTER; a_user_info: POINTER; a_yes_or_no: BOOLEAN): POINTER
			-- + (NSTimer *)scheduledTimerWithTimeInterval: (NSTimeInterval) ti target: (id) aTarget selector: (SEL) aSelector userInfo: (id) userInfo repeats: (BOOL) yesOrNo
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSTimer scheduledTimerWithTimeInterval: $a_ti target: $a_target selector: (SEL)$a_selector userInfo: $a_user_info repeats: $a_yes_or_no];"
		end

	frozen timer_with_time_interval_invocation_repeats (a_ti: REAL_64; a_invocation: POINTER; a_yes_or_no: BOOLEAN): POINTER
			-- + (NSTimer *)timerWithTimeInterval: (NSTimeInterval) ti invocation: (NSInvocation *) invocation repeats: (BOOL) yesOrNo
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSTimer timerWithTimeInterval: $a_ti invocation: $a_invocation repeats: $a_yes_or_no];"
		end

	frozen timer_with_time_interval_target_selector_user_info_repeats (a_ti: REAL_64; a_target: POINTER; a_selector: POINTER; a_user_info: POINTER; a_yes_or_no: BOOLEAN): POINTER
			-- + (NSTimer *)timerWithTimeInterval: (NSTimeInterval) ti target: (id) aTarget selector: (SEL) aSelector userInfo: (id) userInfo repeats: (BOOL) yesOrNo
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSTimer timerWithTimeInterval: $a_ti target: $a_target selector: (SEL)$a_selector userInfo: $a_user_info repeats: $a_yes_or_no];"
		end

	frozen init_with_fire_date_interval_target_selector_user_info_repeats (a_ns_timer: POINTER; a_date: POINTER; a_ti: REAL_64; a_t: POINTER; a_s: POINTER; a_ui: POINTER; a_rep: BOOLEAN): POINTER
			-- - (id)initWithFireDate: (NSDate *) date interval: (NSTimeInterval) ti target: (id) t selector: (SEL) s userInfo: (id) ui repeats: (BOOL) rep
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTimer*)$a_ns_timer initWithFireDate: $a_date interval: $a_ti target: $a_t selector: (SEL)$a_s userInfo: $a_ui repeats: $a_rep];"
		end

feature -- Firing a Timer

	frozen fire (a_ns_timer: POINTER)
			-- - (void)fire
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTimer*)$a_ns_timer fire];"
		end

feature -- Stopping a Timer

	frozen invalidate (a_ns_timer: POINTER)
			-- - (void)invalidate
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTimer*)$a_ns_timer invalidate];"
		end

feature -- Information About a Timer

	frozen is_valid (a_ns_timer: POINTER): BOOLEAN
			-- - (BOOL)isValid
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTimer*)$a_ns_timer isValid];"
		end

	frozen fire_date (a_ns_timer: POINTER): POINTER
			-- - (NSDate *)fireDate
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTimer*)$a_ns_timer fireDate];"
		end

	frozen set_fire_date (a_ns_timer: POINTER; a_date: POINTER)
			-- - (void)setFireDate: (NSDate *) date
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTimer*)$a_ns_timer setFireDate: $a_date];"
		end

	frozen time_interval (a_ns_timer: POINTER): REAL_64
			-- - (NSTimeInterval)timeInterval
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTimer*)$a_ns_timer timeInterval];"
		end

	frozen user_info (a_ns_timer: POINTER): POINTER
			-- - (id)userInfo
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTimer*)$a_ns_timer userInfo];"
		end

end
