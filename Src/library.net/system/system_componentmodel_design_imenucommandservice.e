indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.IMenuCommandService"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_IMENUCOMMANDSERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_verbs: SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERVERBCOLLECTION is
		external
			"IL deferred signature (): System.ComponentModel.Design.DesignerVerbCollection use System.ComponentModel.Design.IMenuCommandService"
		alias
			"get_Verbs"
		end

feature -- Basic Operations

	add_verb (verb: SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERVERB) is
		external
			"IL deferred signature (System.ComponentModel.Design.DesignerVerb): System.Void use System.ComponentModel.Design.IMenuCommandService"
		alias
			"AddVerb"
		end

	remove_verb (verb: SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERVERB) is
		external
			"IL deferred signature (System.ComponentModel.Design.DesignerVerb): System.Void use System.ComponentModel.Design.IMenuCommandService"
		alias
			"RemoveVerb"
		end

	find_command (command_id: SYSTEM_COMPONENTMODEL_DESIGN_COMMANDID): SYSTEM_COMPONENTMODEL_DESIGN_MENUCOMMAND is
		external
			"IL deferred signature (System.ComponentModel.Design.CommandID): System.ComponentModel.Design.MenuCommand use System.ComponentModel.Design.IMenuCommandService"
		alias
			"FindCommand"
		end

	global_invoke (command_id: SYSTEM_COMPONENTMODEL_DESIGN_COMMANDID): BOOLEAN is
		external
			"IL deferred signature (System.ComponentModel.Design.CommandID): System.Boolean use System.ComponentModel.Design.IMenuCommandService"
		alias
			"GlobalInvoke"
		end

	show_context_menu (menu_id: SYSTEM_COMPONENTMODEL_DESIGN_COMMANDID; x: INTEGER; y: INTEGER) is
		external
			"IL deferred signature (System.ComponentModel.Design.CommandID, System.Int32, System.Int32): System.Void use System.ComponentModel.Design.IMenuCommandService"
		alias
			"ShowContextMenu"
		end

	remove_command (command: SYSTEM_COMPONENTMODEL_DESIGN_MENUCOMMAND) is
		external
			"IL deferred signature (System.ComponentModel.Design.MenuCommand): System.Void use System.ComponentModel.Design.IMenuCommandService"
		alias
			"RemoveCommand"
		end

	add_command (command: SYSTEM_COMPONENTMODEL_DESIGN_MENUCOMMAND) is
		external
			"IL deferred signature (System.ComponentModel.Design.MenuCommand): System.Void use System.ComponentModel.Design.IMenuCommandService"
		alias
			"AddCommand"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_IMENUCOMMANDSERVICE
