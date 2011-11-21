note
	description: "An enhanced toolbar with support for resource-files and flat style"
	status: "See notice at end of class."
	author: "Andreas Leitner"
	date: "$Date$"
	revision: "$Revision$"

class WEX_TOOL_BAR

inherit
	WEL_TOOL_BAR

	WEL_TTF_CONSTANTS
		export
			{NONE} all
		end

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

create
	make_by_menu_id
feature --s that do not belong here
		Tb_style_flat: INTEGER
				-- should be in WEL_TB_STYLE_CONSTANTS
			external
				"C [macro <cctrl.h>]"
			alias
				"TBSTYLE_FLAT"
			end

feature

	make_by_menu_id (a_parent: WEL_WINDOW; tool_bar_id: INTEGER)
			-- create a WEX_TOOL_BAR from a resource (specified by a resource id)
		do
			make (a_parent, -1)
			load_tool_bar_by_id (tool_bar_id)
		end

	load_tool_bar_by_id (tool_bar_id: INTEGER)
			-- deletes all current buttons and adds button as specified in the resource script
		require
			exists: exists
		local
			tool_bar_data: WEX_TOOL_BAR_DATA
			button: WEL_TOOL_BAR_BUTTON
			bitmap: WEL_TOOL_BAR_BITMAP
			index: INTEGER
			button_index: INTEGER

		do
			create tool_bar_data.make_by_id (tool_bar_id)
			delete_all_buttons

			set_bitmap_size (tool_bar_data.width, tool_bar_data.height)
			set_button_size (tool_bar_data.width + 7, tool_bar_data.height + 7)
			from
			until
				index >= tool_bar_data.command_id_count
			loop
				if tool_bar_data.command_id_at (index) = 0 then
					create button.make_separator
				else
					create button.make_button (button_index, tool_bar_data.command_id_at (index))
					button_index := button_index + 1
				end
				index := index + 1
				add_buttons (<<button>>)
			end

			-- TODO: propably bitmap needs to be reset instead of added?
			create bitmap.make (tool_bar_id)
			add_bitmaps (bitmap, 1)

			set_tool_tips
		end

	set_flat_style (yes: BOOLEAN)
			-- if `yes' = true the toolbar will appear flat
		require
			exists: exists
		do
			if yes then
				set_style (set_flag (style, Tb_style_flat))
			else
				set_style (clear_flag (style, Tb_style_flat))
			end
		end

	set_tool_tips
			-- for each button it takes the resource string with the same id (command_id), takes the substring
			-- that is after the first "%N", but only to an optional following second "%N" and sets it as
			-- tooltip for this button.
		require
			exists: exists
		local
			index: INTEGER
			a_tooltip: WEL_TOOLTIP
			tool_info: WEL_TOOL_INFO

		do
			-- Create a tooltip
			create a_tooltip.make (Current.parent, -1)

			from
				index := 0
			until
				index >= button_count
			loop
				create tool_info.make
				tool_info.set_window (Current)
				tool_info.set_flags (Ttf_subclass)
				tool_info.set_rect (button_rect (index))
				tool_info.set_text (get_tool_tip_text_by_id (i_th_button (index).command_id))
				a_tooltip.add_tool (tool_info)
				index := index + 1
			end
			set_tooltip (a_tooltip)

		end

	get_tool_tip_text_by_id (index: INTEGER): STRING
			-- returns text between first and second "%N" of the specified resource string
			-- if index is invalid the Result will be an empty string
		require
			exists: exists
		local
			a_text: STRING
			new_line: INTEGER
		do
			a_text := resource_string_id (index)

			if a_text.count >= 1 then
				new_line := a_text.substring_index ("%N", 1)

				if new_line /= 0 then
					a_text.keep_tail ( a_text.count - new_line)

					new_line := a_text.substring_index ("%N", 1)
					if new_line /= 0 then
						a_text.keep_head ( new_line - 1)
					end
					Result := a_text
				end
			end
			if Result = Void then
				create Result.make (0)
			end
		ensure
			result_not_void: Result /= Void
		end

	get_button_text_by_id (index: INTEGER): STRING
			-- returns text after last "%N" of the specified resource string
			-- currently not used, but may be used in future when the "button-text-style" is
			-- supported.	
		require
			exists: exists
		local
			a_text: STRING
			new_line: INTEGER
		do
			a_text := resource_string_id (index)

			if a_text.count >= 1 then
				new_line := a_text.substring_index ("%N", 1)


				if new_line /= 0 then
					a_text.keep_tail ( a_text.count - new_line)

					new_line := a_text.substring_index ("%N", 1)
					if new_line /= 0 then
						a_text.keep_tail ( a_text.count - new_line)
					end
					Result := a_text
				end
			end

			if Result = Void then
				create Result.make (0)
			end
		ensure
			result_not_void: Result /= Void
		end

	delete_all_buttons
			-- Deletes all buttons
		require
			exists: exists
		local
			i: INTEGER
		do
			from
			until
				i >= button_count
			loop
				delete_button (0)
				i := i + 1
			end
		ensure
			button_count_is_zero: button_count = 0
		end

end

--|-------------------------------------------------------------------------
--| WEX, Windows Eiffel library eXtension
--| Copyright (C) 1998  Robin van Ommeren, Andreas Leitner
--| See the file forum.txt included in this package for licensing info.
--|
--| Comments, Questions, Additions to this library? please contact:
--|
--| Robin van Ommeren						Andreas Leitner
--| Eikenlaan 54M								Arndtgasse 1/3/5
--| 7151 WT Eibergen							8010 Graz
--| The Netherlands							Austria
--| email: robin.van.ommeren@wxs.nl		email: andreas.leitner@teleweb.at
--| web: http://home.wxs.nl/~rommeren	web: about:blank
--|-------------------------------------------------------------------------
