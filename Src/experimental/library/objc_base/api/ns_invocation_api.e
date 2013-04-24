note
	description: "Summary description for {NS_INVOCATION_API}."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_INVOCATION_API

feature -- Creating NSInvocation Objects

	frozen invocation_with_method_signature (a_sig: POINTER): POINTER
			-- + (NSInvocation *)invocationWithMethodSignature: (NSMethodSignature *) sig
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSInvocation invocationWithMethodSignature: $a_sig];"
		end

feature -- Configuring an Invocation Object

	frozen set_selector (a_ns_invocation: POINTER; a_selector: POINTER)
			-- - (void)setSelector: (SEL) selector
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSInvocation*)$a_ns_invocation setSelector: $a_selector];"
		end

	frozen selector (a_ns_invocation: POINTER): POINTER
			-- - (SEL)selector
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSInvocation*)$a_ns_invocation selector];"
		end

	frozen set_target (a_ns_invocation: POINTER; a_target: POINTER)
			-- - (void)setTarget: (id) target
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSInvocation*)$a_ns_invocation setTarget: $a_target];"
		end

	frozen target (a_ns_invocation: POINTER): POINTER
			-- - (id)target
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSInvocation*)$a_ns_invocation target];"
		end

	frozen set_argument_at_index (a_ns_invocation: POINTER; a_buffer: POINTER; a_idx: INTEGER)
			-- - (void)setArgument: (void *) a_buffer atIndex: (NSInteger) idx
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSInvocation*)$a_ns_invocation setArgument: $a_buffer atIndex: $a_idx];"
		end

	frozen get_argument_at_index (a_ns_invocation: POINTER; a_argument_location: POINTER; a_idx: INTEGER)
			-- - (void)getArgument: (void *) argumentLocation atIndex: (NSInteger) idx
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSInvocation*)$a_ns_invocation getArgument: $a_argument_location atIndex: $a_idx];"
		end

	frozen arguments_retained (a_ns_invocation: POINTER): BOOLEAN
			-- - (BOOL)argumentsRetained
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSInvocation*)$a_ns_invocation argumentsRetained];"
		end

	frozen retain_arguments (a_ns_invocation: POINTER)
			-- - (void)retainArguments
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSInvocation*)$a_ns_invocation retainArguments];"
		end

	frozen set_return_value (a_ns_invocation: POINTER; a_ret_loc: POINTER)
			-- - (void)setReturnValue: (void *) retLoc
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSInvocation*)$a_ns_invocation setReturnValue: $a_ret_loc];"
		end

	frozen get_return_value (a_ns_invocation: POINTER; a_ret_loc: POINTER)
			-- - (void)getReturnValue: (void *) retLoc
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSInvocation*)$a_ns_invocation getReturnValue: $a_ret_loc];"
		end

feature -- Dispatching an Invocation

	frozen invoke (a_ns_invocation: POINTER)
			-- - (void)invoke
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSInvocation*)$a_ns_invocation invoke];"
		end

	frozen invoke_with_target (a_ns_invocation: POINTER; a_target: POINTER)
			-- - (void)invokeWithTarget: (id) target
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSInvocation*)$a_ns_invocation invokeWithTarget: $a_target];"
		end

feature -- Getting the Method Signature

	frozen method_signature (a_ns_invocation: POINTER): POINTER
			-- - (NSMethodSignature *)methodSignature
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSInvocation*)$a_ns_invocation methodSignature];"
		end

end
