indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.DesignerVerb"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_DESIGNER_VERB

inherit
	SYSTEM_DLL_MENU_COMMAND
		redefine
			to_string
		end

create
	make_system_dll_designer_verb,
	make_system_dll_designer_verb_1

feature {NONE} -- Initialization

	frozen make_system_dll_designer_verb (text: SYSTEM_STRING; handler: EVENT_HANDLER) is
		external
			"IL creator signature (System.String, System.EventHandler) use System.ComponentModel.Design.DesignerVerb"
		end

	frozen make_system_dll_designer_verb_1 (text: SYSTEM_STRING; handler: EVENT_HANDLER; start_command_id: SYSTEM_DLL_COMMAND_ID) is
		external
			"IL creator signature (System.String, System.EventHandler, System.ComponentModel.Design.CommandID) use System.ComponentModel.Design.DesignerVerb"
		end

feature -- Access

	frozen get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.DesignerVerb"
		alias
			"get_Text"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.DesignerVerb"
		alias
			"ToString"
		end

end -- class SYSTEM_DLL_DESIGNER_VERB
