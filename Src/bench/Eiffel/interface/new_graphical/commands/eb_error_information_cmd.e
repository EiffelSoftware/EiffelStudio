indexing
	description: "Dialog used to display extended help concerning a compilation error."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ERROR_INFORMATION_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_toolbar_item
		end

	EB_SHARED_WINDOW_MANAGER

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
		end

feature -- Status setting

	execute is
			-- Launch `Current'.
			-- Pop up an error wizard relative to the last focused development window.
		do
			execute_with_text (Interface_names.e_Drop_an_error_stone)
		end

	execute_with_stone (st: ERROR_STONE) is
			-- Pop up a new dialog and display the help text of `st' inside it.
		do
			execute_with_text (st.help_text)
		end
		
feature -- Status report

	description: STRING is
			-- Explanatory text for this command.
		do
			Result := Interface_names.e_Display_error_help
		end

	tooltip: STRING is
			-- Tooltip for `Current's toolbar buttons.
		do
			Result := Interface_names.e_Display_error_help
		end

	name: STRING is "Open_help_tool"
			-- Internal textual representation.

	pixmap: ARRAY [EV_PIXMAP] is
			-- Images used for `Current's toolbar buttons.
		do
			Result := Pixmaps.Icon_help_tool
		end

	menu_name: STRING is
			-- Text used for menu items for `Current'.
		do
			Result := Interface_names.m_Display_error_help
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			--
			-- Call `recycle' on the result when you don't need it anymore otherwise
			-- it will never be garbage collected.
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} (display_text, use_gray_icons)
			Result.drop_actions.extend (agent execute_with_stone)
		end

feature {NONE} -- Implementation

	current_dialog: EV_DIALOG
			-- Dialog used to display the error explanations.

	current_editor: EB_CLICKABLE_EDITOR
			-- Editor in which the explanation texts are put.

	execute_with_text (a_text: STRING) is
			-- Pop up a new dialog and display `a_text' inside it.
		do
			create_new_dialog
			current_editor.load_basic_text (a_text)
			current_dialog.show_relative_to_window (Window_manager.last_focused_development_window.window)
			current_dialog := Void
		end

	create_new_dialog is
			-- Fill `current_dialog' with a newly created dialog.
		local
			but: EV_BUTTON
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			f: EV_FRAME
			scr: EV_SCREEN
			fs: INTEGER
			ft: EV_FONT
		do
				-- Build the layout.
			create vb
			vb.set_padding (Layout_constants.small_padding_size)
			vb.set_border_width (Layout_constants.small_border_size)
			create hb
			create f
			create current_dialog
			current_dialog.set_title (Interface_names.t_Extended_explanation)
			
			create but.make_with_text (Interface_names.b_Close)
			Layout_constants.set_default_size_for_button (but)
			create current_editor.make (Void)
			current_editor.set_reference_window (current_dialog)
			current_editor.widget.set_minimum_size (150, 100)
			
			hb.extend (create {EV_CELL})
			hb.extend (but)
			hb.disable_item_expand (but)
			hb.extend (create {EV_CELL})
			f.extend (current_editor.widget)
			vb.extend (f)
			vb.extend (hb)
			vb.disable_item_expand (hb)
			
			current_dialog.extend (vb)
			
				-- Set up the event handlers.
			current_dialog.set_default_cancel_button (but)
			but.select_actions.extend (agent current_dialog.destroy)
			current_editor.drop_actions.extend (agent set_stone (current_editor, ?))
			current_editor.disable_editable
			create scr
				--| + 1 to make sure there is enough room.
			ft := (create {EB_SHARED_EDITOR_FONT}).font
			fs := (ft.maximum_width + ft.width) // 2
				--| 60 is the number of characters in the error texts,
				--| 56 is the overhead brought by the editor (margins),
				--| 20 is an approximation of the overhead due to the window border.
			current_dialog.set_size (Layout_constants.dialog_unit_to_pixels (60 * fs + 56 + 20).min (scr.width),
									 Layout_constants.dialog_unit_to_pixels (300).min (scr.height))
		ensure
			valid_dialog: current_dialog /= Void and then not current_dialog.is_destroyed
			valid_editor: current_editor /= Void
		end

	set_stone (editor: EB_EDITOR; st: ERROR_STONE) is
			-- Display the help text associated with `st' in `editor'.
		require
			valid_stone: st /= Void
			valid_editor: editor /= Void
		do
			editor.load_basic_text (st.help_text)
		end

end -- class EB_ERROR_INFORMATION_DIALOG
