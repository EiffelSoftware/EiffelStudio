indexing
	description: "Dialog displaying extended information concerning an object."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PRETTY_PRINT_DIALOG

inherit
	EB_CONSTANTS

	SHARED_APPLICATION_EXECUTION

create {EB_PRETTY_PRINT_CMD}
	make

feature {NONE} -- Initialization

	make (cmd: EB_PRETTY_PRINT_CMD) is
			-- Initialize `Current'.
		local
			hb: EV_HORIZONTAL_BOX
			exit_button: EV_BUTTON
			vb: EV_VERTICAL_BOX
			f: EV_FRAME
		do
			parent := cmd
			
				-- Create `slice_cmd'.
			create slice_cmd.make_for_pretty_print (Current)
			
				-- Building the dialog.
			create dialog
			dialog.set_title (Interface_names.t_Enhanced_display)
			dialog.set_icon_pixmap (Pixmaps.Icon_pretty_print)
				--| FIXME XR: Implement the save to file.
			create exit_button.make_with_text (Interface_names.b_Close)
			exit_button.select_actions.extend (dialog~destroy)
			create slice_button.make_with_text (Interface_names.b_Slice)
			slice_button.select_actions.extend (slice_cmd~execute)
			
				-- Setting up the editor.
			create editor.make
			
			create f
			create vb
			create hb
			f.set_minimum_size (200, 150)
			f.extend (editor.widget)
			vb.extend (f)
			vb.set_padding (Layout_constants.Small_padding_size)
			vb.set_border_width (Layout_constants.Small_border_size)
			hb.set_padding (Layout_constants.Small_padding_size)
			Layout_constants.set_default_size_for_button (exit_button)
			Layout_constants.set_default_size_for_button (slice_button)
			hb.extend (create {EV_CELL})
			hb.extend (slice_button)
			hb.disable_item_expand (slice_button)
			hb.extend (exit_button)
			hb.disable_item_expand (exit_button)
			hb.extend (create {EV_CELL})
			vb.extend (hb)
			vb.disable_item_expand (hb)
			dialog.extend (vb)
			dialog.set_default_cancel_button (exit_button)
			dialog.set_default_push_button (slice_button)
			editor.drop_actions.extend (~on_stone_dropped)
		end

feature -- Access

feature -- Measurement

feature -- Status report

	is_destroyed: BOOLEAN is
			-- Is `dialog' destroyed?
		do
			Result := dialog = Void
		end

	current_object: OBJECT_STONE
			-- Object `Current' is displaying.

	dialog: EV_DIALOG
			-- Dialog where `editor' is displayed.

feature -- Status setting

	raise is
			-- Display `dialog' and put it in front.
		do
			dialog.show_relative_to_window (parent.associated_window)
		end

	set_stone (st: OBJECT_STONE) is
			-- Give a new object to `Current' and refresh the display.
		do
			current_object := st
			if slice_cmd.is_resizable (st) then
				slice_cmd.enable_sensitive
			else
				slice_cmd.disable_sensitive
			end
			refresh
		end

	refresh is
			-- Recompute the displayed text.
		local
			dmp: DUMP_VALUE
		do
			if Application.status.is_stopped then
				create dmp.make_object (current_object.object_address, current_object.dynamic_class)
				if dmp.is_void then
					editor.load_basic_text ("Void")
				elseif dmp.has_formatted_output then
					editor.load_basic_text (dmp.string_representation (slice_cmd.slice_min, slice_cmd.slice_max))
				else
						-- XR: This shouldn't happen, because the command should filter out
						-- objects that have no formatted output.
					editor.load_basic_text ("[" + current_object.object_address + "]")
				end
			else
				editor.clear_window
			end
		end

	destroy is
			-- Destroy the actual dialog and forget about `Current'.
		require
			not is_destroyed
		do
			dialog.destroy
			dialog := Void
			parent.remove_dialog (Current)
		ensure
			destroyed: is_destroyed
		end

	--| FIXME XR: Maybe we should add advanced positioning methods (set_position, set_size,...).
	--| FIXME XR: Anyway they wouldn't be used at the moment.

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	editor: SELECTABLE_TEXT_PANEL
			-- Editor where the object value is displayed.

	text: STRUCTURED_TEXT
			-- Text that is displayed in the editor.

	slice_cmd: EB_SET_SLICE_SIZE_CMD
			-- Command that is supposed to resize special objects.

	parent: EB_PRETTY_PRINT_CMD
			-- Command that created `Current' and knows about it.

	slice_button: EV_BUTTON
			-- Button launching the slice command.

feature {NONE} -- Event handling

	on_stone_dropped (st: OBJECT_STONE) is
			-- A stone was dropped in the editor. Handle it.
		do
			set_stone (st)
		end

end -- class EB_PRETTY_PRINT_DIALOG
