indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Activation.IActivator"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IACTIVATOR

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_next_activator: IACTIVATOR is
		external
			"IL deferred signature (): System.Runtime.Remoting.Activation.IActivator use System.Runtime.Remoting.Activation.IActivator"
		alias
			"get_NextActivator"
		end

	get_level: ACTIVATOR_LEVEL is
		external
			"IL deferred signature (): System.Runtime.Remoting.Activation.ActivatorLevel use System.Runtime.Remoting.Activation.IActivator"
		alias
			"get_Level"
		end

feature -- Element Change

	set_next_activator (value: IACTIVATOR) is
		external
			"IL deferred signature (System.Runtime.Remoting.Activation.IActivator): System.Void use System.Runtime.Remoting.Activation.IActivator"
		alias
			"set_NextActivator"
		end

feature -- Basic Operations

	activate (msg: ICONSTRUCTION_CALL_MESSAGE): ICONSTRUCTION_RETURN_MESSAGE is
		external
			"IL deferred signature (System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Runtime.Remoting.Activation.IConstructionReturnMessage use System.Runtime.Remoting.Activation.IActivator"
		alias
			"Activate"
		end

end -- class IACTIVATOR
