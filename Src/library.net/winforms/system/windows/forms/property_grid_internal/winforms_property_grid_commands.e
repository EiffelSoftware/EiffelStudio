indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.PropertyGridInternal.PropertyGridCommands"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_PROPERTY_GRID_COMMANDS

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Windows.Forms.PropertyGridInternal.PropertyGridCommands"
		end

feature -- Access

	frozen reset: SYSTEM_DLL_COMMAND_ID is
		external
			"IL static_field signature :System.ComponentModel.Design.CommandID use System.Windows.Forms.PropertyGridInternal.PropertyGridCommands"
		alias
			"Reset"
		end

	frozen hide: SYSTEM_DLL_COMMAND_ID is
		external
			"IL static_field signature :System.ComponentModel.Design.CommandID use System.Windows.Forms.PropertyGridInternal.PropertyGridCommands"
		alias
			"Hide"
		end

	frozen description: SYSTEM_DLL_COMMAND_ID is
		external
			"IL static_field signature :System.ComponentModel.Design.CommandID use System.Windows.Forms.PropertyGridInternal.PropertyGridCommands"
		alias
			"Description"
		end

	frozen commands: SYSTEM_DLL_COMMAND_ID is
		external
			"IL static_field signature :System.ComponentModel.Design.CommandID use System.Windows.Forms.PropertyGridInternal.PropertyGridCommands"
		alias
			"Commands"
		end

end -- class WINFORMS_PROPERTY_GRID_COMMANDS
