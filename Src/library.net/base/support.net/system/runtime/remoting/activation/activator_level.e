indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Activation.ActivatorLevel"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	ACTIVATOR_LEVEL

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen construction: ACTIVATOR_LEVEL is
		external
			"IL enum signature :System.Runtime.Remoting.Activation.ActivatorLevel use System.Runtime.Remoting.Activation.ActivatorLevel"
		alias
			"4"
		end

	frozen context: ACTIVATOR_LEVEL is
		external
			"IL enum signature :System.Runtime.Remoting.Activation.ActivatorLevel use System.Runtime.Remoting.Activation.ActivatorLevel"
		alias
			"8"
		end

	frozen app_domain: ACTIVATOR_LEVEL is
		external
			"IL enum signature :System.Runtime.Remoting.Activation.ActivatorLevel use System.Runtime.Remoting.Activation.ActivatorLevel"
		alias
			"12"
		end

	frozen machine: ACTIVATOR_LEVEL is
		external
			"IL enum signature :System.Runtime.Remoting.Activation.ActivatorLevel use System.Runtime.Remoting.Activation.ActivatorLevel"
		alias
			"20"
		end

	frozen process: ACTIVATOR_LEVEL is
		external
			"IL enum signature :System.Runtime.Remoting.Activation.ActivatorLevel use System.Runtime.Remoting.Activation.ActivatorLevel"
		alias
			"16"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

	from_integer (a_value: INTEGER): like Current is
		do
			--Built-in
		end

	to_integer: INTEGER is
		do
			--Built-in
		end

end -- class ACTIVATOR_LEVEL
