indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.Emit.MethodRental"

frozen external class
	SYSTEM_REFLECTION_EMIT_METHODRENTAL

create {NONE}

feature -- Access

	frozen jit_immediate: INTEGER is 0x1

	frozen jit_on_demand: INTEGER is 0x0

feature -- Basic Operations

	frozen swap_method_body (cls: SYSTEM_TYPE; methodtoken: INTEGER; rg_il: POINTER; method_size: INTEGER; flags: INTEGER) is
		external
			"IL static signature (System.Type, System.Int32, System.IntPtr, System.Int32, System.Int32): System.Void use System.Reflection.Emit.MethodRental"
		alias
			"SwapMethodBody"
		end

end -- class SYSTEM_REFLECTION_EMIT_METHODRENTAL
