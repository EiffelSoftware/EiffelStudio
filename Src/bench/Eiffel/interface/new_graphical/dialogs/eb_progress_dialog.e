indexing
	description:
		"Dialogs that display a progress bar and progress messages."
	appearance: "[
		+-------------------------------------------+
		| `degree'      `current_degree'    ------  |
		| `entity'      `current_entity'   |PIXMAP| |
		| `to_go_label' `to_go'             ------  |
		|                                           |
		| +----------------------------+ +--------+ |
		| | #####      25%             | | Cancel | |
		| +----------------------------+ +--------+ |
		+-------------------------------------------+
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROGRESS_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize,
			show
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_GRAPHICAL_DATA
		export 
			{NONE} all
		undefine
			default_create, copy
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_SHARED_MANAGERS
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
	EV_SHARED_APPLICATION
		export
			{NONE} all
		undefine
			default_create, copy
		end

feature {NONE} -- Initialization

	initialize is
			-- Build interface.
		local
			vbox, left_pane, right_pane: EV_VERTICAL_BOX
			space: EV_CELL
			text_box, progress_box: EV_HORIZONTAL_BOX
			frame: EV_FRAME
			fg_color: EV_COLOR
			bg_color: EV_COLOR
			i: INTEGER
			new_label: EV_LABEL
		do
			Precursor

			set_icon_pixmap (Pixmaps.Icon_progress_dialog)

				-- Create the progress pixmap.			
			create pixmap_cell
			pixmap_cell.set_minimum_width (34)

				-- Create the labels.
			create labels.make (1, 6)
			from
				i := labels.lower
			until
				i > labels.upper
			loop
				create new_label
				new_label.align_text_left
				labels.put (new_label, i)
				i := i + 1
			end
				
				-- put the labels in the left/right pane.
			create left_pane
			create space
			create right_pane
			left_pane.extend (labels @ degree_index)
			left_pane.extend (labels @ entity_index)
			left_pane.extend (labels @ to_go_label_index)
			right_pane.extend (labels @ current_degree_index)
			right_pane.extend (labels @ current_entity_index)
			right_pane.extend (labels @ to_go_index)
			(labels @ degree_index).set_minimum_width (100)
			(labels @ entity_index).set_minimum_width (100)
			(labels @ to_go_label_index).set_minimum_width (100)
			(labels @ current_degree_index).set_minimum_width (250)
			(labels @ current_entity_index).set_minimum_width (250)
			(labels @ to_go_index).set_minimum_width (250)
			space.set_minimum_width (20)

			create text_box
			text_box.set_border_width (7)
			text_box.set_padding (7)
			text_box.extend (left_pane)
			text_box.extend (space)
			text_box.extend (right_pane)
			text_box.extend (pixmap_cell)
			text_box.disable_item_expand (left_pane)
			text_box.disable_item_expand (space)
			text_box.disable_item_expand (pixmap_cell)

				-- Progress bar & button.
			create progress_box
			progress_box.set_border_width (7)
			progress_box.set_padding (7)
			create progress_bar
			create frame
			create cancel_button.make_with_text (Interface_names.b_Cancel)
			cancel_button.select_actions.extend (agent on_cancel)

			frame.extend (progress_bar)
			progress_box.extend (frame)
			progress_box.extend (cancel_button)
			progress_box.disable_item_expand (cancel_button)

				-- Set up dialog
			create vbox
			vbox.extend (text_box)
			vbox.extend (progress_box)
			vbox.disable_item_expand (progress_box)
			extend (vbox)

				-- Set Push & Cancel button.
			set_default_push_button (cancel_button)
			set_default_cancel_button (cancel_button)

				-- Set color of progress bar.
			fg_color := progress_bar_color
			if fg_color /= Void then
				progress_bar.set_foreground_color (fg_color)
				bg_color := progress_bar.background_color
				if (bg_color.lightness - fg_color.lightness).abs < 0.2 then
					bg_color.set_red (1.0 - fg_color.red)
					bg_color.set_green (1.0 - fg_color.green)
					bg_color.set_blue (1.0 - fg_color.blue)
				end
			end
		end

feature -- Access

	degree: STRING is
			-- Level of generation.
		do
			Result := labels.item (degree_index).text
		end

	current_degree: STRING is
			-- Current level of generation.
		do
			Result := labels.item (current_degree_index).text
		end

	entity: STRING is
			-- Type of items.
		do
			Result := labels.item (entity_index).text
		end

	current_entity: STRING is
			-- Current item.
		do
			Result := labels.item (current_entity_index).text
		end

	to_go_label: STRING is
			-- Category of items to go.
		do
			Result := labels.item (to_go_label_index).text
		end

	to_go: STRING is
			-- Number to be processed.
		do
			Result := labels.item (to_go_index).text
		end

feature -- Status setting

	enable_cancel is
			-- Enable `Cancel' button.
			-- An interrupt error is raised when pressed.
		do
			cancel_button.enable_sensitive
			if default_cancel_button = Void then
				set_default_cancel_button (cancel_button)
			end
		end

	disable_cancel is
			-- Disable `Cancel' button.
		do
			cancel_button.disable_sensitive
			if default_cancel_button /= Void then
				remove_default_cancel_button
			end
		end

feature -- Basic operation

	show is
			-- Show dialog if not shown yet it to front.
		local
			wparent: EB_WINDOW
		do
			if not is_show_requested then
--				wparent := Window_manager.last_focused_window
				if wparent /= Void then
					show_relative_to_window (wparent.window)
				else
					Precursor {EV_DIALOG}
				end
				restore
				raise
			end
		end

	start (nr_items: INTEGER) is
			-- Set to zero percent.
			-- Prepare to process `nr_items'.
		do
			progress_bar.reset_with_range (0 |..| nr_items)
			show
			graphical_update
		end

	set_value (a_value: INTEGER) is
			-- Set `processed_count' to `a_value'.
		do
			progress_bar.set_value (a_value)
			graphical_update
		end

feature -- Actions

	graphical_update is
			-- Process any pending events.
			-- Not needed after `start' or `set_value'.
		do
			ev_application.process_events
			if cancel_compilation_requested then
				cancel_compilation_requested := False
				Error_handler.insert_interrupt_error (True)
			end
		end

feature -- Element change

	set_degree (a_text: STRING) is
			-- Set level of generation to `a_text'.
			-- Example: "Degree:"
		require
			a_text_not_void: a_text /= Void
		do
			labels.item (degree_index).set_text (a_text)
		ensure
			assigned: degree.is_equal (a_text)
		end

	set_current_compilation_degree (a_compilation_degree: INTEGER) is
			-- Set current level of generation to `a_text', and set the
			-- pixmap corresponding to the degree `a_compilation_degree'.
			-- Example: "6"
		do
			set_current_degree (a_compilation_degree.out)
			set_pixmap_degree (a_compilation_degree)
		end

	set_current_degree (a_text: STRING) is
			-- Set current level of generation to `a_text'.
			-- Example: "Degree:"
		require
			a_text_not_void: a_text /= Void
		do
			labels.item (current_degree_index).set_text (a_text)
			remove_pixmap_degree
		ensure
			assigned: current_degree = Void and a_text.is_equal ("") 
						or else current_degree.is_equal (a_text)
		end

	set_entity (a_text: STRING) is
			-- Set current type of items to `a_text'.
			-- Example: "Class:", "Cluster:"
		require
			a_text_not_void: a_text /= Void
		do
			labels.item (entity_index).set_text (a_text)
		ensure
			assigned: equal (entity, a_text)
		end

	set_current_entity (a_text: STRING) is
			-- Set current item to `a_text'.
			-- Example: "CLASS_NAME"
		require
			a_text_not_void: a_text /= Void
		do
			labels.item (current_entity_index).set_text (a_text)
		ensure
			assigned: current_entity.is_equal (a_text)
		end

	set_to_go_label (a_text: STRING) is
			-- Set "to go" label to `a_text'.
		require
			a_text_not_void: a_text /= Void
		do
			labels.item (to_go_label_index).set_text (a_text)
		ensure
			assigned: to_go_label.is_equal (a_text)
		end

	set_to_go (a_text: STRING) is
			-- Set "to go" to `a_text'.
		require
			a_text_not_void: a_text /= Void
		do
			labels.item (to_go_index).set_text (a_text)
		ensure
			assigned: to_go.is_equal (a_text)
		end

	set_message (a_text: STRING) is
			-- Remove all other labels and display `a_text'.
		require
			a_text_not_void: a_text /= Void
		local
			i: INTEGER
		do
			from
				i := labels.lower
			until
				i > labels.upper
			loop
				if i /= current_degree_index then
					labels.item (i).remove_text
				end
				i := i + 1
			end
			labels.item (current_degree_index).set_text (a_text)
		ensure
			assigned: a_text.is_empty and then current_degree = Void
						or else current_degree.is_equal (a_text)
		end

feature {NONE} -- Constants

	degree_index: INTEGER is 1
	current_degree_index: INTEGER is 2
	entity_index: INTEGER is 3
	current_entity_index: INTEGER is 4
	to_go_label_index: INTEGER is 5
	to_go_index: INTEGER is 6
	
feature {NONE} -- Implementation

	pixmap_cell: EV_CELL

	set_pixmap_degree (a_degree: INTEGER) is
			-- Set `progress_pixmap' to the pixmap corresponding to
			-- `a_degree'.
		require
			valid_degree: a_degree <= 6 and a_degree >= -3
		local
			progress_pixmap: EV_PIXMAP
		do
			pixmap_cell.wipe_out
			create progress_pixmap
			progress_pixmap.copy (Pixmaps.Icons_progress_degree @ a_degree)
			pixmap_cell.extend (progress_pixmap)
		end 
	
	remove_pixmap_degree is
			-- Remove the `progress_pixmap'.
		do
			pixmap_cell.wipe_out
		end 

	labels: ARRAY [EV_LABEL]
			-- Labels for textual progress display.

	progress_bar: EB_PERCENT_PROGRESS_BAR
			-- Displaying percentage done.

	cancel_button: EV_BUTTON
			-- Button labeled "Cancel".

	on_cancel is
			-- User pressed Cancel.
		do
			disable_cancel
			cancel_compilation_requested := True
		end
		
	cancel_compilation_requested: BOOLEAN
			-- Has the user requested to cancel the compilation?

end -- class EB_PROGRESS_DIALOG
