indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ICommandExecutor"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_ICOMMAND_EXECUTOR

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	execute is
		external
			"IL deferred signature (): System.Void use System.Windows.Forms.ICommandExecutor"
		alias
			"Execute"
		end

end -- class WINFORMS_ICOMMAND_EXECUTOR
