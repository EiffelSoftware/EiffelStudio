indexing
	description	: "Dialog for confirming a save action"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CONFIRM_SAVE_DIALOG

inherit
	EV_QUESTION_DIALOG

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch (a_target: like target; a_caller: EB_CONFIRM_SAVE_CALLBACK) is
			-- Initialize and popup the dialog
		local
			clsi_stone: CLASSI_STONE
			cls_name: STRING
		do
			target := a_target
			caller := a_caller
			clsi_stone ?= target.stone
			if clsi_stone /= Void then
				cls_name := clsi_stone.class_name
			end
			make_with_text (Warning_messages.w_File_changed (cls_name))
			button ("Yes").select_actions.extend (~save_text)
			button ("No").select_actions.extend (~dont_save_text)
		--	button ("Cancel").select_actions.extend (~destroy)
			--| IEK Message dialogs by default destroy themselves on button press.
			
			show_modal_to_window (window_manager.last_focused_development_window.window)
		end

feature -- Access

	caller: EB_CONFIRM_SAVE_CALLBACK
		-- object whose `process' feature will be executed on success

	target: EB_FILEABLE
			-- Target for the command.

feature -- Execution

	save_text is
			-- Save text and quit.
		do
			target.save_text
			dont_save_text
		end

	dont_save_text is
			-- Directly quit.
		do
			caller.process
		end

end -- class EB_CONFIRM_SAVE_DIALOG
