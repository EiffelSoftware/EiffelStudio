indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.Emit.MethodRental"

frozen external class
	SYSTEM_REFLECTION_EMIT_METHODRENTAL

create {NONE}

feature -- Access

	frozen jit_immediate: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Reflection.Emit.MethodRental"
		alias
			"JitImmediate"
		end

	frozen jit_on_demand: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Reflection.Emit.MethodRental"
		alias
			"JitOnDemand"
		end

feature -- Basic Operations

	frozen swap_method_body (cls: SYSTEM_TYPE; methodtoken: INTEGER; rgIL: POINTER; methodSize: INTEGER; flags: INTEGER) is
		external
			"IL static signature (System.Type, System.Int32, System.IntPtr, System.Int32, System.Int32): System.Void use System.Reflection.Emit.MethodRental"
		alias
			"SwapMethodBody"
		end

end -- class SYSTEM_REFLECTION_EMIT_METHODRENTAL
