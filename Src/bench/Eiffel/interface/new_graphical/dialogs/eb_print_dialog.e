indexing
	description: "Dialog that displays the printer choices."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PRINT_DIALOG

inherit
	EB_GENERAL_DATA
		undefine
			default_create
		end
	EB_CONSTANTS
		undefine
			default_create
		end
	EV_DIALOG

	EIFFEL_ENV
		undefine
			default_create
		end

creation
	make

feature {NONE} -- Initialization

	make (an_agent: PROCEDURE [ANY, TUPLE[STRING, BOOLEAN, BOOLEAN]]) is
			-- Create the dialog with parent `par'.
		require
			an_agent_is_not_void: an_agent /= Void
		local	
			p_label: EV_LABEL
			hbox, hbox2: EV_HORIZONTAL_BOX
			vbox: EV_VERTICAL_BOX
			cell: EV_CELL
		do
			default_create
			call_back_agent := an_agent

			set_title (Interface_names.f_Print)

			close_actions.extend (~destroy)

			create vbox

			create hbox
			create p_label.make_with_text (Interface_names.t_Shell_command)
			hbox.extend (p_label)
			hbox.disable_item_expand (p_label)
			create shell_cmd_field
			shell_cmd_field.set_text (print_shell_command)
			hbox.extend (shell_cmd_field)
			vbox.extend (hbox)
			vbox.disable_item_expand (hbox)

--			create hbox			
--			create print_to_file_t.make_with_text (Interface_names.t_Print_to_file)
--			hbox.extend (print_to_file_t)
--			hbox.disable_item_expand (print_to_file_t)
--			create cell
--			hbox.extend (cell)
--			vbox.extend (hbox)
--			vbox.disable_item_expand (hbox)

			create hbox	
			create postscript_t.make_with_text (Interface_names.t_Postscript)
			hbox.extend (postscript_t)
			postscript_t.enable_select
			hbox.disable_item_expand (postscript_t)
			create cell
			hbox.extend (cell)
			vbox.extend (hbox)
			vbox.disable_item_expand (hbox)

			create cell
			vbox.extend (cell)

			create hbox
			create cell
			hbox.extend (cell)
			create hbox2
			hbox2.set_padding (10)
			create ok_button.make_with_text (Interface_names.b_Ok)
			ok_button.set_minimum_width (ok_button.minimum_width.max (75))
			hbox2.extend (ok_button)
			hbox2.disable_item_expand (ok_button)

			create cancel_button.make_with_text (Interface_names.b_Cancel)
			cancel_button.set_minimum_width (cancel_button.minimum_width.max (75))
			hbox2.extend (cancel_button)
			hbox2.disable_item_expand (cancel_button)
			hbox.extend (hbox2)
			hbox.disable_item_expand (hbox2)
			create cell
			hbox.extend (cell)

			vbox.extend (hbox)
			vbox.disable_item_expand (hbox)
			
			create cell
			vbox.extend (cell)

			extend (vbox)

			set_default_push_button (ok_button)

			set_default_cancel_button (cancel_button)

			ok_button.select_actions.extend (~execute)


			cancel_button.select_actions.extend (~cancel)

			shell_cmd_field.return_actions.extend (~execute)

		end

feature {NONE} -- Implementation

	shell_cmd_field: EV_TEXT_FIELD
			-- Shell command field

	print_to_file_t, postscript_t: EV_CHECK_BUTTON

	ok_button, cancel_button: EV_BUTTON
			-- Push buttons

	call_back_agent: PROCEDURE [ANY, TUPLE[STRING, BOOLEAN, BOOLEAN]]

feature {NONE} -- Execution

	execute is
			-- Launch print.
		do
			hide
			--call_back_agent.call ([shell_cmd_field.text, print_to_file_t.is_selected, postscript_t.is_selected])
			call_back_agent.call ([shell_cmd_field.text, False, postscript_t.is_selected])
		end

	cancel is
			-- close dialog window.
		do
			hide
		end

end -- class EB_PRINT_DIALOG
