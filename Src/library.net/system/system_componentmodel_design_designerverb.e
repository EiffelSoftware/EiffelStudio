indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.DesignerVerb"

external class
	SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERVERB

inherit
	SYSTEM_COMPONENTMODEL_DESIGN_MENUCOMMAND
		redefine
			to_string
		end

create
	make_designerverb_1,
	make_designerverb

feature {NONE} -- Initialization

	frozen make_designerverb_1 (text: STRING; handler: SYSTEM_EVENTHANDLER; start_command_id: SYSTEM_COMPONENTMODEL_DESIGN_COMMANDID) is
		external
			"IL creator signature (System.String, System.EventHandler, System.ComponentModel.Design.CommandID) use System.ComponentModel.Design.DesignerVerb"
		end

	frozen make_designerverb (text: STRING; handler: SYSTEM_EVENTHANDLER) is
		external
			"IL creator signature (System.String, System.EventHandler) use System.ComponentModel.Design.DesignerVerb"
		end

feature -- Access

	frozen get_text: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.DesignerVerb"
		alias
			"get_Text"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.DesignerVerb"
		alias
			"ToString"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERVERB
