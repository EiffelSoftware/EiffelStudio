indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Emit.MethodRental"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	METHOD_RENTAL

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen jit_immediate: INTEGER is 0x1

	frozen jit_on_demand: INTEGER is 0x0

feature -- Basic Operations

	frozen swap_method_body (cls: TYPE; methodtoken: INTEGER; rg_il: POINTER; method_size: INTEGER; flags: INTEGER) is
		external
			"IL static signature (System.Type, System.Int32, System.IntPtr, System.Int32, System.Int32): System.Void use System.Reflection.Emit.MethodRental"
		alias
			"SwapMethodBody"
		end

end -- class METHOD_RENTAL
