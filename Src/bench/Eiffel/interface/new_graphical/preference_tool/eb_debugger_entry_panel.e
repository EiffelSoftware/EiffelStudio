indexing
	description: "Data panel used for capturing class parameters."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUGGER_ENTRY_PANEL

inherit
	NEW_EB_CONSTANTS
		rename
			Debugger_resources as parameters
		export
			{NONE} all
		end
	EB_ENTRY_PANEL
		redefine
			make
		end

creation
	make

feature -- Initialization

	make (par: EV_CONTAINER; a_tool: like tool) is
		do
			Precursor (par, a_tool)

			Create debugger_feature_height.make_with_resource (Current, parameters.debugger_feature_height)
			Create debugger_object_height.make_with_resource (Current, parameters.debugger_object_height)
			Create debugger_show_all_callers.make_with_resource (
				Current, parameters.debugger_show_all_callers)
			Create debugger_do_flat_in_breakpoints.make_with_resource (
				Current, parameters.debugger_do_flat_in_breakpoints)
			Create interrupt_every_n_instructions.make_with_resource 
					(Current, parameters.interrupt_every_n_instructions)

			resources.extend (debugger_feature_height)
			resources.extend (debugger_object_height)
			resources.extend (debugger_show_all_callers)
			resources.extend (debugger_do_flat_in_breakpoints)
			resources.extend (interrupt_every_n_instructions)
		end

feature -- Access

	name: STRING is "Debugger preferences"
			-- Current's name

	symbol: PIXMAP is
		once
			Result := Pixmaps.bm_Preference_project
		end

feature {NONE} -- Implementation

	debugger_feature_height, debugger_object_height,
	interrupt_every_n_instructions: EB_INTEGER_RESOURCE_DISPLAY
	debugger_show_all_callers: EB_BOOLEAN_RESOURCE_DISPLAY
	debugger_do_flat_in_breakpoints: EB_BOOLEAN_RESOURCE_DISPLAY

end -- class EB_DEBUGGER_ENTRY_PANEL
