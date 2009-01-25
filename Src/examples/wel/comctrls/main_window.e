note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_icon,
			on_menu_command,
			on_control_id_command,
			on_size,
			on_menu_select,
			on_notify,
			background_brush
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	WEL_TTF_CONSTANTS
		export
			{NONE} all
		end

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

	WEL_IDB_CONSTANTS
		export
			{NONE} all
		end

	WEL_STANDARD_TOOL_BAR_BITMAP_CONSTANTS
		export
			{NONE} all
		end

	WEL_TTN_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
		local
			bitmap_index1, bitmap_index2: INTEGER
			l_tool: WEL_TOOL_INFO
			l_tool_bar: like tool_bar
			l_status_window: like status_window
			l_progress_bar: like progress_bar
			l_track_bar: like track_bar
			l_tooltip: like tooltip
			l_rich_edit: like rich_edit
			l_char_format: WEL_CHARACTER_FORMAT
			tool_bar_button4,
			tool_bar_button5,
			tool_bar_button6,
			tool_bar_button7,
			tool_bar_button8: WEL_TOOL_BAR_BUTTON
			tool_bar_bitmap, standard_tool_bar_bitmap: WEL_TOOL_BAR_BITMAP
		do
			make_top (Title)
			set_menu (main_menu)
			resize (450, 400)
			create static.make (Current,
				"To see tooltip controls, move the mouse on %
				%the track bar, the progress bar or the toolbar %
				%buttons.", 200, 50, 200, 70, -1)

			-- Create a track bar
			create l_track_bar.make_horizontal (Current, 10, 40, 110, 40, -1)
			track_bar := l_track_bar
			l_track_bar.set_range (0, 100)

			-- Create a progress bar
			create l_progress_bar.make (Current, 10, 110, 110, 20, -1)
			progress_bar := l_progress_bar

			-- Create a status window
			create l_status_window.make (Current, -1)
			status_window := l_status_window
			l_status_window.set_multiple_mode
			l_status_window.set_parts (<<300, 350, -1>>)

			-- Create a rich edit control
			create l_rich_edit.make (Current, "", 5, 150, 200, 150, -1)
			rich_edit := l_rich_edit
			create l_char_format.make
			l_char_format.set_face_name ("Arial")
			l_char_format.set_height_in_points (12)
			l_char_format.unset_bold
			l_rich_edit.set_character_format_all (l_char_format)
			l_rich_edit.set_text ("Rich edit control")

			-- Create a toolbar and buttons
			create l_tool_bar.make (Current, -1)
			tool_bar := l_tool_bar

			create tool_bar_bitmap.make (Bmp_toolbar)
			create standard_tool_bar_bitmap.make_by_predefined_id (Idb_std_small_color)

			l_tool_bar.add_bitmaps (standard_tool_bar_bitmap, 1)
			bitmap_index1 := l_tool_bar.last_bitmap_index

			l_tool_bar.add_bitmaps (tool_bar_bitmap, 1)
			bitmap_index2 := l_tool_bar.last_bitmap_index

			create tool_bar_button4.make_check (bitmap_index2 + 0, Cmd_bold)
			create tool_bar_button5.make_check (bitmap_index2 + 1, Cmd_italic)
			create tool_bar_button6.make_separator
			create tool_bar_button7.make_button (bitmap_index2 + 2, Cmd_progress_bar)
			create tool_bar_button8.make_button (bitmap_index2 + 3, Cmd_exit)

			l_tool_bar.add_buttons (<<
				tool_bar_button4,
				tool_bar_button5,
				tool_bar_button6,
				tool_bar_button7,
				tool_bar_button8>>)

			-- Create a tooltip
			create l_tooltip.make (Current, -1)
			tooltip := l_tooltip

			create l_tool.make
			tool_info1 := l_tool
			l_tool.set_window (l_track_bar)
			l_tool.set_flags (Ttf_subclass)
			l_tool.set_rect (l_track_bar.client_rect)
			l_tool.set_text_id (Str_tooltip) -- Use a string resource id
			l_tooltip.add_tool (l_tool)

			create l_tool.make
			tool_info2 := l_tool
			l_tool.set_window (l_progress_bar)
			l_tool.set_flags (Ttf_subclass)
			l_tool.set_rect (l_progress_bar.client_rect)
			l_tool.set_text ("This a tooltip for the progress bar") -- Use a string
			l_tooltip.add_tool (l_tool)
		end

feature -- Access

	static: ?WEL_STATIC

	progress_bar: ?WEL_PROGRESS_BAR

	track_bar: ?WEL_TRACK_BAR

	status_window: ?WEL_STATUS_WINDOW

	tool_bar: ?WEL_TOOL_BAR

	tooltip: ?WEL_TOOLTIP

	tool_info1, tool_info2: ?WEL_TOOL_INFO



	rich_edit: ?WEL_RICH_EDIT

	background_brush: WEL_BRUSH
			-- Dialog boxes background color is the same than
			-- button color.
		do
			create Result.make_by_sys_color (Color_btnface + 1)
		end

feature {NONE} -- Implementation

	on_notify (control_id: INTEGER; info: WEL_NMHDR)
			-- Draw the tooltips.
		local
			tt: WEL_TOOLTIP_TEXT
		do
			if info.code = Ttn_needtext then
				create tt.make_by_nmhdr (info)
				-- Set resource string id.
				tt.set_text_id (tt.hdr.id_from)
			end
		end

	on_control_id_command (control_id: INTEGER)
		do
			on_menu_command (control_id)
		end

	on_menu_command (menu_id: INTEGER)
			-- Execute the command identified by `menu_id'.
		local
			i: INTEGER
			l_progress_bar: like progress_bar
			l_rich_edit: like rich_edit
			l_tool_bar: like tool_bar
			l_char_format: WEL_CHARACTER_FORMAT
		do
			inspect
				menu_id
			when Cmd_exit then
				destroy
			when Cmd_progress_bar then
				from
					l_progress_bar := progress_bar
						-- Per invariant
					check l_progress_bar_attached: l_progress_bar /= Void end
					i := 0
				until
					i = 100
				loop
					l_progress_bar.step_it
					i := i + 10
				end
			when Cmd_bold, Cmd_italic then
				create l_char_format.make
				l_tool_bar := tool_bar
					-- Per invariant
				check l_tool_bar_attached: l_tool_bar /= Void end
				if l_tool_bar.button_checked (menu_id) then
					if menu_id = Cmd_bold then
						l_char_format.set_bold
					else
						l_char_format.set_italic
					end
				else
					if menu_id = Cmd_bold then
						l_char_format.unset_bold
					else
						l_char_format.unset_italic
					end
				end
				l_rich_edit := rich_edit
					-- Per invariant
				check l_rich_edit_attached: l_rich_edit /= Void end
				l_rich_edit.set_character_format_selection (l_char_format)
			else
			end
		end

	on_menu_select (menu_item: INTEGER; flags: INTEGER; a_menu: ?WEL_MENU)
			-- Display a message in the status window corresponding
			-- to the selected menu_item.
		local
			l_status_window: like status_window
		do
			l_status_window := status_window
				-- Per invariant
			check l_status_window_attached: l_status_window /= Void end
			l_status_window.set_text_part (0, resource_string_id (menu_item))
		end

	on_size (size_type: INTEGER; a_width: INTEGER; a_height: INTEGER)
			-- Reposition the status window and the tool bar when
			-- the window has been resized.
		local
			l_status_window: like status_window
			l_tool_bar: like tool_bar
		do
			l_status_window := status_window
			if l_status_window /= Void then
				l_status_window.reposition
			end
			l_tool_bar := tool_bar
			if l_tool_bar /= Void then
				l_tool_bar.reposition
			end
		end

	class_icon: WEL_ICON
			-- Window's icon
		once
			create Result.make_by_id (Id_ico_application)
		end

	main_menu: WEL_MENU
			-- Window's menu
		once
			create Result.make_by_id (Id_main_menu)
		ensure
			result_not_void: Result /= Void
		end

	Title: STRING = "WEL Common controls";
			-- Window's title

invariant
	tool_bar_attached: tool_bar /= Void
	status_window_attached: status_window /= Void
	rich_edit_attached: rich_edit /= Void
	progress_bar_attached: progress_bar /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class MAIN_WINDOW

