indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Activation.IActivator"

deferred external class
	SYSTEM_RUNTIME_REMOTING_ACTIVATION_IACTIVATOR

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_level: INTEGER is
		external
			"IL deferred signature (): enum System.Runtime.Remoting.Activation.ActivatorLevel use System.Runtime.Remoting.Activation.IActivator"
		alias
			"get_Level"
		ensure
			valid_activator_level: Result = 4 or Result = 8 or Result = 12 or Result = 16 or Result = 20
		end

	get_next_activator: SYSTEM_RUNTIME_REMOTING_ACTIVATION_IACTIVATOR is
		external
			"IL deferred signature (): System.Runtime.Remoting.Activation.IActivator use System.Runtime.Remoting.Activation.IActivator"
		alias
			"get_NextActivator"
		end

feature -- Element Change

	set_next_activator (value: SYSTEM_RUNTIME_REMOTING_ACTIVATION_IACTIVATOR) is
		external
			"IL deferred signature (System.Runtime.Remoting.Activation.IActivator): System.Void use System.Runtime.Remoting.Activation.IActivator"
		alias
			"set_NextActivator"
		end

feature -- Basic Operations

	activate (msg: SYSTEM_RUNTIME_REMOTING_ACTIVATION_ICONSTRUCTIONCALLMESSAGE): SYSTEM_RUNTIME_REMOTING_ACTIVATION_ICONSTRUCTIONRETURNMESSAGE is
		external
			"IL deferred signature (System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Runtime.Remoting.Activation.IConstructionReturnMessage use System.Runtime.Remoting.Activation.IActivator"
		alias
			"Activate"
		end

end -- class SYSTEM_RUNTIME_REMOTING_ACTIVATION_IACTIVATOR
