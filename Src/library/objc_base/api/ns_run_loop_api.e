note
	description: "Low-level interface to NSRunLoop."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_RUN_LOOP_API

feature -- Accessing Run Loops and Modes

	frozen current_run_loop : POINTER
			-- + (NSRunLoop *)currentRunLoop
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSRunLoop currentRunLoop];"
		end

	frozen current_mode (a_ns_run_loop: POINTER): POINTER
			-- - (NSString *)currentMode
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSRunLoop*)$a_ns_run_loop currentMode];"
		end

	frozen limit_date_for_mode (a_ns_run_loop: POINTER; a_mode: POINTER): POINTER
			-- - (NSDate *)limitDateForMode: (NSString *) mode
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSRunLoop*)$a_ns_run_loop limitDateForMode: $a_mode];"
		end

	frozen main_run_loop : POINTER
			-- + (NSRunLoop *)mainRunLoop
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSRunLoop mainRunLoop];"
		end

feature -- Managing Timers

	frozen add_timer_for_mode (a_ns_run_loop: POINTER; a_timer: POINTER; a_mode: POINTER)
			-- - (void)addTimer: (NSTimer *) timer forMode: (NSString *) mode
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSRunLoop*)$a_ns_run_loop addTimer: $a_timer forMode: $a_mode];"
		end

feature -- Managing Ports

	frozen add_port_for_mode (a_ns_run_loop: POINTER; a_port: POINTER; a_mode: POINTER)
			-- - (void)addPort: (NSPort *) aPort forMode: (NSString *) mode
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSRunLoop*)$a_ns_run_loop addPort: $a_port forMode: $a_mode];"
		end

	frozen remove_port_for_mode (a_ns_run_loop: POINTER; a_port: POINTER; a_mode: POINTER)
			-- - (void)removePort: (NSPort *) aPort forMode: (NSString *) mode
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSRunLoop*)$a_ns_run_loop removePort: $a_port forMode: $a_mode];"
		end

feature -- Running a Loop

	frozen run (a_ns_run_loop: POINTER)
			-- - (void)run
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSRunLoop*)$a_ns_run_loop run];"
		end

	frozen run_mode_before_date (a_ns_run_loop: POINTER; a_mode: POINTER; a_limit_date: POINTER): BOOLEAN
			-- - (BOOL)runMode: (NSString *) mode beforeDate: (NSDate *) limitDate
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSRunLoop*)$a_ns_run_loop runMode: $a_mode beforeDate: $a_limit_date];"
		end

	frozen run_until_date (a_ns_run_loop: POINTER; a_limit_date: POINTER)
			-- - (void)runUntilDate: (NSDate *) limitDate
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSRunLoop*)$a_ns_run_loop runUntilDate: $a_limit_date];"
		end

	frozen accept_input_for_mode_before_date (a_ns_run_loop: POINTER; a_mode: POINTER; a_limit_date: POINTER)
			-- - (void)acceptInputForMode: (NSString *) mode beforeDate: (NSDate *) limitDate
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSRunLoop*)$a_ns_run_loop acceptInputForMode: $a_mode beforeDate: $a_limit_date];"
		end

feature -- Scheduling and Canceling Messages

	frozen perform_selector_target_argument_order_modes (a_ns_run_loop: POINTER; a_selector: POINTER; a_target: POINTER; a_arg: POINTER; a_order: NATURAL; a_modes: POINTER)
			-- - (void)performSelector: (SEL) aSelector target: (id) target argument: (id) arg order: (NSUInteger) order modes: (NSArray *) modes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSRunLoop*)$a_ns_run_loop performSelector: $a_selector target: $a_target argument: $a_arg order: $a_order modes: $a_modes];"
		end

	frozen cancel_perform_selector_target_argument (a_ns_run_loop: POINTER; a_selector: POINTER; a_target: POINTER; a_arg: POINTER)
			-- - (void)cancelPerformSelector: (SEL) aSelector target: (id) target argument: (id) arg
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSRunLoop*)$a_ns_run_loop cancelPerformSelector: $a_selector target: $a_target argument: $a_arg];"
		end

	frozen cancel_perform_selectors_with_target (a_ns_run_loop: POINTER; a_target: POINTER)
			-- - (void)cancelPerformSelectorsWithTarget: (id) target
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSRunLoop*)$a_ns_run_loop cancelPerformSelectorsWithTarget: $a_target];"
		end

end
