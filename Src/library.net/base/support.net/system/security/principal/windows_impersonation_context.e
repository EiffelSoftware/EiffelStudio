indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Principal.WindowsImpersonationContext"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINDOWS_IMPERSONATION_CONTEXT

inherit
	SYSTEM_OBJECT
		redefine
			finalize
		end

create {NONE}

feature -- Basic Operations

	frozen undo is
		external
			"IL signature (): System.Void use System.Security.Principal.WindowsImpersonationContext"
		alias
			"Undo"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.Principal.WindowsImpersonationContext"
		alias
			"Finalize"
		end

end -- class WINDOWS_IMPERSONATION_CONTEXT
