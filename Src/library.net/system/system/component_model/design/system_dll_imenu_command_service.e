indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.IMenuCommandService"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IMENU_COMMAND_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_verbs: SYSTEM_DLL_DESIGNER_VERB_COLLECTION is
		external
			"IL deferred signature (): System.ComponentModel.Design.DesignerVerbCollection use System.ComponentModel.Design.IMenuCommandService"
		alias
			"get_Verbs"
		end

feature -- Basic Operations

	add_verb (verb: SYSTEM_DLL_DESIGNER_VERB) is
		external
			"IL deferred signature (System.ComponentModel.Design.DesignerVerb): System.Void use System.ComponentModel.Design.IMenuCommandService"
		alias
			"AddVerb"
		end

	remove_verb (verb: SYSTEM_DLL_DESIGNER_VERB) is
		external
			"IL deferred signature (System.ComponentModel.Design.DesignerVerb): System.Void use System.ComponentModel.Design.IMenuCommandService"
		alias
			"RemoveVerb"
		end

	find_command (command_id: SYSTEM_DLL_COMMAND_ID): SYSTEM_DLL_MENU_COMMAND is
		external
			"IL deferred signature (System.ComponentModel.Design.CommandID): System.ComponentModel.Design.MenuCommand use System.ComponentModel.Design.IMenuCommandService"
		alias
			"FindCommand"
		end

	global_invoke (command_id: SYSTEM_DLL_COMMAND_ID): BOOLEAN is
		external
			"IL deferred signature (System.ComponentModel.Design.CommandID): System.Boolean use System.ComponentModel.Design.IMenuCommandService"
		alias
			"GlobalInvoke"
		end

	show_context_menu (menu_id: SYSTEM_DLL_COMMAND_ID; x: INTEGER; y: INTEGER) is
		external
			"IL deferred signature (System.ComponentModel.Design.CommandID, System.Int32, System.Int32): System.Void use System.ComponentModel.Design.IMenuCommandService"
		alias
			"ShowContextMenu"
		end

	remove_command (command: SYSTEM_DLL_MENU_COMMAND) is
		external
			"IL deferred signature (System.ComponentModel.Design.MenuCommand): System.Void use System.ComponentModel.Design.IMenuCommandService"
		alias
			"RemoveCommand"
		end

	add_command (command: SYSTEM_DLL_MENU_COMMAND) is
		external
			"IL deferred signature (System.ComponentModel.Design.MenuCommand): System.Void use System.ComponentModel.Design.IMenuCommandService"
		alias
			"AddCommand"
		end

end -- class SYSTEM_DLL_IMENU_COMMAND_SERVICE
