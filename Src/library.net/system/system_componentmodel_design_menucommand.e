indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.MenuCommand"

external class
	SYSTEM_COMPONENTMODEL_DESIGN_MENUCOMMAND

inherit
	ANY
		redefine
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make (handler: SYSTEM_EVENTHANDLER; command: SYSTEM_COMPONENTMODEL_DESIGN_COMMANDID) is
		external
			"IL creator signature (System.EventHandler, System.ComponentModel.Design.CommandID) use System.ComponentModel.Design.MenuCommand"
		end

feature -- Access

	get_checked: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.Design.MenuCommand"
		alias
			"get_Checked"
		end

	get_command_id: SYSTEM_COMPONENTMODEL_DESIGN_COMMANDID is
		external
			"IL signature (): System.ComponentModel.Design.CommandID use System.ComponentModel.Design.MenuCommand"
		alias
			"get_CommandID"
		end

	get_ole_status: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.Design.MenuCommand"
		alias
			"get_OleStatus"
		end

	get_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.Design.MenuCommand"
		alias
			"get_Enabled"
		end

	get_supported: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.Design.MenuCommand"
		alias
			"get_Supported"
		end

	get_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.Design.MenuCommand"
		alias
			"get_Visible"
		end

feature -- Element Change

	set_supported (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.ComponentModel.Design.MenuCommand"
		alias
			"set_Supported"
		end

	set_checked (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.ComponentModel.Design.MenuCommand"
		alias
			"set_Checked"
		end

	frozen add_command_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.ComponentModel.Design.MenuCommand"
		alias
			"add_CommandChanged"
		end

	set_visible (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.ComponentModel.Design.MenuCommand"
		alias
			"set_Visible"
		end

	set_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.ComponentModel.Design.MenuCommand"
		alias
			"set_Enabled"
		end

	frozen remove_command_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.ComponentModel.Design.MenuCommand"
		alias
			"remove_CommandChanged"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.MenuCommand"
		alias
			"ToString"
		end

	invoke is
		external
			"IL signature (): System.Void use System.ComponentModel.Design.MenuCommand"
		alias
			"Invoke"
		end

feature {NONE} -- Implementation

	on_command_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.ComponentModel.Design.MenuCommand"
		alias
			"OnCommandChanged"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_MENUCOMMAND
