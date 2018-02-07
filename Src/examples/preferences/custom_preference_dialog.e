note
	description: "[
			Customized dialog for showing preferences.  This dialog show preferences on the left side as a pixmap and
			then the child prefences to the right in separate frames for a nicer look.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CUSTOM_PREFERENCE_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize,
			create_interface_objects,
			is_in_default_state
		end

	PREFERENCE_VIEW
		undefine
			copy, default_create
		end

create
	make_with_parent

feature {NONE} -- Initialization

	create_interface_objects
		do
			create parent_pixmap_box
			create parent_title_container
			create parent_title_label
			create main_preference_box
			create restore_button
			create ok_button
			create cancel_button
			create grid
			Precursor
		end

	make_with_parent (a_preferences: like preferences; a_parent_window: like parent_window)
				-- Initialize
		do
			make (a_preferences)
			parent_window := a_parent_window
			default_create
			fill_list
			close_request_actions.extend (agent on_cancel)
			cancel_button.select_actions.extend (agent on_cancel)
			ok_button.select_actions.extend (agent on_close)
			restore_button.select_actions.extend (agent on_restore)
			main_preference_box.extend (grid)
			show
		end

	user_initialization
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			but_export, but_import: EV_BUTTON
		do
			create but_export.make_with_text_and_action ("Export", agent export_preferences)
			create but_import.make_with_text_and_action ("Import", agent import_preferences)
			if attached {EV_BOX} restore_button.parent as p then
				p.put_front (but_export)
				p.put_front (but_import)
				p.disable_item_expand (but_export)
				p.disable_item_expand (but_import)
			end
		end

	export_preferences
		local
			dlg: EV_FILE_SAVE_DIALOG
			s: STRING_32
			stor: PREFERENCES_STORAGE_XML
		do
			create dlg.make_with_title ("Export preferences to file")
			dlg.show_modal_to_window (Current)
			s := dlg.file_name
			if s /= Void and then not s.is_empty then
				create stor.make_with_location (s)
				preferences.export_to_storage (stor, False)
			end
		end

	import_preferences
		local
			dlg: EV_FILE_OPEN_DIALOG
			s: STRING_32
			stor: PREFERENCES_STORAGE_XML
		do
			create dlg.make_with_title ("Import preferences from file")
			dlg.show_modal_to_window (Current)
			s := dlg.file_name
			if s /= Void and then not s.is_empty then
				create stor.make_with_location (s)
				preferences.import_from_storage (stor)
				if attached selected_preference_name as pn then
					fill_container (pn)
				end
			end
		end

	initialize
			-- Initialize `Current'.
		local
			l_ev_vertical_box_1, l_ev_vertical_box_2: EV_VERTICAL_BOX
			l_ev_frame_1: EV_FRAME
			l_ev_horizontal_split_area_1: EV_HORIZONTAL_SPLIT_AREA
			l_ev_horizontal_box_1: EV_HORIZONTAL_BOX
			l_ev_cell_1: EV_CELL
			internal_font: EV_FONT
		do
			Precursor {EV_DIALOG}

				-- Create all widgets.
			create l_ev_vertical_box_1
			create l_ev_frame_1
			create l_ev_horizontal_split_area_1
			create l_ev_vertical_box_2
			create l_ev_horizontal_box_1
			create l_ev_cell_1

				-- Build_widget_structure.
			extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_frame_1)
			l_ev_frame_1.extend (l_ev_horizontal_split_area_1)
			l_ev_horizontal_split_area_1.extend (parent_pixmap_box)
			l_ev_horizontal_split_area_1.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (parent_title_container)
			parent_title_container.extend (parent_title_label)
			l_ev_vertical_box_2.extend (main_preference_box)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (restore_button)
			l_ev_horizontal_box_1.extend (l_ev_cell_1)
			l_ev_horizontal_box_1.extend (ok_button)
			l_ev_horizontal_box_1.extend (cancel_button)

			set_minimum_width (640)
			set_minimum_height (480)
			set_title ("Preferences")
			l_ev_vertical_box_1.set_padding_width (5)
			l_ev_vertical_box_1.set_border_width (5)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_1)
			parent_pixmap_box.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			parent_pixmap_box.set_minimum_width (150)
			parent_pixmap_box.set_padding_width (5)
			parent_pixmap_box.set_border_width (5)
			l_ev_vertical_box_2.set_padding_width (5)
			l_ev_vertical_box_2.set_border_width (5)
			l_ev_vertical_box_2.disable_item_expand (parent_title_container)
			parent_title_container.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 160))
			parent_title_container.set_padding_width (5)
			parent_title_container.set_border_width (5)
			parent_title_label.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 160))
			parent_title_label.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			create internal_font
			internal_font.set_family (3)
			internal_font.set_weight (7)
			internal_font.set_shape (10)
			internal_font.set_height_in_points (12)
			internal_font.preferred_families.extend ("Verdana")
			parent_title_label.set_font (internal_font)
			parent_title_label.align_text_left
			main_preference_box.set_padding_width (5)
			main_preference_box.set_border_width (5)
			l_ev_horizontal_box_1.set_padding_width (5)
			l_ev_horizontal_box_1.set_border_width (5)
			l_ev_horizontal_box_1.disable_item_expand (restore_button)
			l_ev_horizontal_box_1.disable_item_expand (ok_button)
			l_ev_horizontal_box_1.disable_item_expand (cancel_button)
			restore_button.set_text ("Restore defaults")
			ok_button.set_text ("OK")
			ok_button.set_minimum_width (80)
			cancel_button.set_text ("Cancel")
			cancel_button.set_minimum_width (80)

				--Connect events.
				-- Close the application when an interface close
				-- request is received on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	parent_pixmap_box, main_preference_box: EV_VERTICAL_BOX
	parent_title_container: EV_HORIZONTAL_BOX
	parent_title_label: EV_LABEL
	restore_button, ok_button, cancel_button: EV_BUTTON

	parent_window: EV_WINDOW

feature -- Change

	set_parent_window (p: like parent_window)
			-- Set `parent_window'
		do
			parent_window := p
		end

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end

	grid: EV_GRID

	fill_list
			-- Fill Left pixmaps list.
		local
			l_pref_hash: STRING_TABLE [EV_PIXMAP]
			l_known_pref_hash: STRING_TABLE [PREFERENCE]
			l_pref_name,
			l_pref_parent_short_name: READABLE_STRING_GENERAL
			l_split_string: LIST [READABLE_STRING_GENERAL]
			l_root_pixmap: EV_PIXMAP
			l_hbox: EV_HORIZONTAL_BOX
			l_row_index: INTEGER
			l_exec: EXECUTION_ENVIRONMENT
			l_filename: PATH
		do
				-- Retrieve known preferences
			l_known_pref_hash := preferences.preferences

			if not l_known_pref_hash.is_empty then
				create l_pref_hash.make (l_known_pref_hash.count)

				from
					l_known_pref_hash.start
					l_row_index := 1
					create l_exec
				until
					l_known_pref_hash.after
				loop
					l_pref_name := l_known_pref_hash.key_for_iteration
					if l_pref_name.has ('.') then
						l_split_string := l_pref_name.split ('.')
						l_pref_parent_short_name := l_split_string.i_th (1)
						if not l_pref_hash.has (l_pref_parent_short_name) then
							create l_root_pixmap
							create l_hbox
							l_filename := l_exec.current_working_path.extended (l_pref_parent_short_name.to_string_32 + {STRING_32} ".png")
							l_root_pixmap.set_with_named_path (l_filename)
							l_root_pixmap.pointer_button_press_actions.extend
								(agent (a_pre: attached like selected_preference_name; x, y, b: INTEGER_32; x_tilt, y_tilt, pressure: REAL_64; s_x, s_y: INTEGER_32)
										require
											a_pre_attached: a_pre /= Void
										do
											selected_preference_name := a_pre;
											fill_container (a_pre)
										end (l_pref_parent_short_name, ?, ?, ?, ?, ?, ?, ?, ?)
									)
							l_hbox.extend (l_root_pixmap)
							l_hbox.set_minimum_size (120, 120)
							l_hbox.set_background_color ((create {EV_STOCK_COLORS}).white)
							parent_pixmap_box.extend (l_hbox)
							parent_pixmap_box.disable_item_expand (l_hbox)
							l_pref_hash.put (l_root_pixmap, l_pref_parent_short_name)
						end
					end
					l_known_pref_hash.forth
				end
			end
		end

	fill_container (parent_preference: READABLE_STRING_GENERAL)
			-- Show parent preferences.
		require
			parent_not_void: parent_preference /= Void
		local
			l_preference: PREFERENCE
			l_preferences: STRING_TABLE [PREFERENCE]
			l_row_index: INTEGER
		do
			grid.wipe_out
			grid.set_row_count_to (0)

			parent_title_label.set_text (parent_preference)
				-- Retrieve known preferences
			l_preferences := preferences.preferences
			from
				l_preferences.start
				l_row_index := 1
			until
				l_preferences.after
			loop
				l_preference := l_preferences.item_for_iteration
				if l_preference.name.substring (1, parent_preference.count).same_string_general (parent_preference) then
					show_preference_in_container (l_preference, l_row_index)
					l_row_index := l_row_index + 1
				end
				l_preferences.forth
			end
			grid.refresh_now
		end

	show_preference_in_container (a_preference: PREFERENCE; a_row_index: INTEGER)
				-- Show selected list preference in main container.
		require
			preference_not_void: a_preference /= Void
		local
			l_preference_widget: PREFERENCE_WIDGET
		do
			if attached {DIRECTORY_RESOURCE} a_preference as l_dr then
				create {DIRECTORY_RESOURCE_WIDGET} l_preference_widget.make_with_preference (l_dr)
				l_preference_widget.set_caller (Current)
				grid.set_item (1, a_row_index, create {EV_GRID_LABEL_ITEM}.make_with_text (a_preference.name))
				grid.set_item (2, a_row_index, l_preference_widget.change_item_widget)
			else
				if attached {COLOR_PREFERENCE} a_preference as l_cr then
					create {COLOR_PREFERENCE_WIDGET} l_preference_widget.make_with_preference (l_cr)
					l_preference_widget.set_caller (Current)
					grid.set_item (1, a_row_index, create {EV_GRID_LABEL_ITEM}.make_with_text (a_preference.name))
					grid.set_item (2, a_row_index, l_preference_widget.change_item_widget)
				elseif attached {BOOLEAN_PREFERENCE} a_preference as l_br then
					create {BOOLEAN_PREFERENCE_WIDGET} l_preference_widget.make_with_preference (l_br)
					l_preference_widget.set_caller (Current)
					grid.set_item (1, a_row_index, create {EV_GRID_LABEL_ITEM}.make_with_text (a_preference.name))
					grid.set_item (2, a_row_index, l_preference_widget.change_item_widget)
				end
			end

			grid.column (1).set_title ("Preference Name")
			grid.column (2).set_title ("Value")
			grid.column (1).resize_to_content
			grid.column (1).set_width (grid.column (1).width + padding_width)
		end

feature {NONE} -- Events

	on_close
			-- Close button has been pushed: apply the changes then close
			-- the Preferences Window.
		do
			preferences.save_preferences
			destroy
		end

	on_cancel
			-- Cancel button has been pushed: retrieve previous preference values to cancel those which
			-- were just modified.
		do
			destroy
		end

	on_restore
			-- Restore all preferences
		local
			l_confirmation_dialog: EV_CONFIRMATION_DIALOG
		do
			create l_confirmation_dialog
			l_confirmation_dialog.set_text ("This will reset ALL preferences to their default values%N%
				% and all previous settings will be overwritten.  Are you sure?")
			l_confirmation_dialog.show_modal_to_window (parent_window)
			if
				attached l_confirmation_dialog.selected_button as but_txt and then
				but_txt.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok)
			then
				preferences.restore_defaults
				if attached selected_preference_name as pn then
					fill_container (pn)
				end
			end
		end

feature {NONE} -- Private Attributes

	selected_preference_name: detachable READABLE_STRING_GENERAL
			-- Selected preference

	padding_width: INTEGER = 3;
			-- Column padding width

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
