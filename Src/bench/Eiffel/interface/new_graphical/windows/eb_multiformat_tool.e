indexing
	description: "Editor able to display several formats."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_MULTIFORMAT_TOOL

inherit
	EB_TEXT_TOOL
		rename
			default_name as empty_tool_name,
			create_toolbar as create_toolbars
		redefine
			build_interface,
			create_toolbars,
			reset,
			synchronize,
			build_special_menu
		end

feature {NONE} -- Initialization

	init_formatters is
			-- Create the list of formats,
			-- initialize default format values.
		deferred
		ensure
			last_format_non_void: last_format /= Void
		end

feature {EB_TOOL_MANAGER} -- Initialization

	build_interface is
			-- Build system widget.
		do
			init_formatters
			Precursor
			check
				format_bar_exists: format_bar /= Void
					--| `format_bar' has been made in `create_toolbars'
					--| or in `build_toolbar'
			end
			build_format_bar (format_bar)
		end

feature -- Window Properties

	last_format: EB_FORMATTER
			-- Last format used

	format_list: EB_FORMATTER_LIST
			-- List of all formats, with the data used
			-- to build the associated toolbar.

	format_bar: EV_HORIZONTAL_BOX
			-- Format toolbar
			-- it always exists, but sometimes it is included in the edit bar.

	format_bar_menu_item: EV_CHECK_MENU_ITEM
			-- menu entry allowing to set if the format bar is shown or not.

	format_bar_is_used: BOOLEAN is
			-- Do the tool need an effective format_bar?
			-- (i.e. not included in the edit bar)
		deferred
		end

feature -- Window settings

	set_last_format (f: like last_format) is
			-- Assign `f' to `last_format'.
		require
			format_exists: f /= Void
		do
			if last_format /= f then
				if last_format /= Void then
					last_format.set_selected (False)
				end
				last_format := f
				last_format.set_selected (True)
			else
				last_format.set_selected (True)
			end
		ensure
			last_format_set: last_format = f
		end

	set_default_format is
			-- Default format of windows.
		do
		end

feature -- Update

	format_bar_menu_update (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Action performed when user presses
			-- the "Formatting toolbar" menu
		require
			menu_item_exists: format_bar_menu_item /= Void
		do
			if format_bar_menu_item.is_selected then
				format_bar.show
			else
				format_bar.hide
			end
		ensure
			toolbar_and_entry_consistent: 
				format_bar_menu_item.is_selected = format_bar.shown
		end

	update_format is
			-- Update the content of the window (only after saving the content of
			-- the tool).
			--| FIXME
			--| Christophe, 18 oct 1999
			--| this function looks pretty much like `synchronize_stone';
			--| we could maybe mix the two features in one.
		local
			old_do_format: BOOLEAN
			f: EB_FORMATTER
			arg: EV_ARGUMENT1 [ANY]
		do
			f := last_format
			old_do_format := f.do_format
			f.set_do_format (True)
			create arg.make (stone)
			f.launch_cmd.execute (arg, Void)
			f.set_do_format (old_do_format)
		end

	synchronize is
			-- Synchronize clickable elements with text, if possible.
		do
			synchronise_stone
		end

	synchronise_stone is
			-- Synchronize the root stone of the window
			-- and the history's stones.
		local
			old_do_format: BOOLEAN
			f: EB_FORMATTER
		do
			if
				stone /= Void and then
				stone.synchronized_stone /= Void
			then
				add_to_history (stone)
				history.synchronize

					-- The root stone is still valid.
				f := last_format
				old_do_format := f.do_format
				f.set_do_format (true)
				if history.item.origin_text /= Void then
					f.format (history.item)
				else
					f.format (stone)
				end
				f.set_do_format (old_do_format)
			else
				history.synchronize
					-- The root stone is not valid anymore.
				history.forth
				check 
					history.after 
				end
				set_default_format
				text_area.clear_window
--				set_file_name (Void)
				set_stone (Void)
				text_area.display
--				update_save_symbol
				set_title (empty_tool_name)
--				if hole_button /= Void then
--					hole_button.set_empty_symbol
--				end
			end
		end

feature -- Pick and Throw Implementation

	reset is
			-- Reset the window contents.
		do
			set_default_format
			Precursor
		end

feature {NONE} -- Implementation

	create_toolbars (par: EV_BOX) is
			-- Create all toolbars with parent `par'.
		local
			sep: EV_HORIZONTAL_SEPARATOR
		do
			Precursor (par)
			if format_bar_is_used then
				create sep.make (par)
				par.set_child_expandable (sep, False)
				create format_bar.make (par)
				par.set_child_expandable (format_bar, False)
--				format_bar.set_minimum_height (22)
			end
		end

	build_format_bar (a_toolbar: EV_BOX) is
			-- Fill `a_toolbar' with buttons related to different formats.
		local
			tb: EV_TOOL_BAR
			ri, peer: EV_TOOL_BAR_RADIO_BUTTON
			cfl: EB_FORMATTER_LIST
		do
			cfl := format_list
			create tb.make (a_toolbar)
			from
				cfl.start
			until
				cfl.after
			loop
				create ri.make (tb)
				ri.set_pixmap (cfl.item.symbol)
				if cfl.isfirst then
					peer := ri
				else
					ri.set_peer (peer)
				end
				cfl.item.launch_cmd.set_button (ri)
				cfl.forth
			end
		end

feature {EB_TOOL_MANAGER} -- Menus Implementation

	build_format_menu (a_menu: EV_MENU_ITEM_HOLDER) is
			-- Fill `a_menu' with entries from the `format_list' attribute.
		local
			ri, peer: EV_RADIO_MENU_ITEM
			cfl: EB_FORMATTER_LIST
		do
			cfl := format_list
			from
				cfl.start
			until
				cfl.after
			loop
				if cfl.isfirst then
					create ri.make_with_text (a_menu, cfl.item.menu_name)
					peer := ri
				else
					create ri.make_peer_with_text (a_menu, cfl.item.menu_name, peer)
				end
				cfl.item.launch_cmd.set_menu_item (ri)
				cfl.forth
			end
		end

	build_special_menu (a_menu: EV_MENU_ITEM_HOLDER) is
			-- Build the toolbar management entries in `a_menu'.
		local
			cmd: EV_ROUTINE_COMMAND
		do
			Precursor (a_menu)
			if format_bar_is_used then
				create format_bar_menu_item.make_with_text (a_menu, Interface_names.n_Format_bar_name)
				create cmd.make (~format_bar_menu_update)
				format_bar_menu_item.add_select_command (cmd, Void)
				format_bar_menu_item.add_unselect_command (cmd, Void)
			end
		end

end -- class EB_MULTIFORMAT_TOOL
