indexing
	description: "Page representing the behavior properties."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class BEHAVIOR_FORM

inherit
	EDITOR_FORM
		redefine
			initialize, show
		end

	WINDOWS

creation
	make

feature {NONE} -- Initialization

	initialize (par: EV_CONTAINER) is
		do
			Precursor (par)
			create event_catalog.make (Current)
			create behavior_editor.make (Current)
		end

feature -- Access

	clear_editor is
			-- Reset the edited_function of Current. 
		do
			behavior_editor.clear
		end

	reset_editor is
		local
			behavior: BEHAVIOR
			previous_behavior: BEHAVIOR
			current_state: BUILD_STATE
		do
			current_state := behavior_editor.current_state
			if (current_state = Void) then
				current_state := app_editor.initial_state_circle.data
			end
			current_state.find_input (context)
			if not current_state.after then
				behavior := current_state.output.data
			else
				create behavior.make
				behavior.set_internal_name ("")
				behavior.set_context (context)
				current_state.add (context, behavior)
			end
			behavior_editor.set_edited_function (behavior)
			behavior_editor.set_context_editor (editor)
			behavior_editor.set_current_state (current_state)
		end

	update_state_name (state: BUILD_STATE) is
			-- Update the state name if current_state
			-- is `state'.
		do
			if behavior_editor.current_state = state then
				behavior_editor.set_current_state (state)
			end
		end

feature {NONE} -- Implementation

	event_catalog: EVENT_CATALOG

	behavior_editor: BEHAVIOR_EDITOR

	reset is
		do
			event_catalog.update_pages (context)
			reset_editor
		end

	show is
		do
			Precursor
			behavior_editor.hide_stones
		end

	apply is 
		do 
			-- Do nothing
		end

end -- class BEHAVIOR_FORM

