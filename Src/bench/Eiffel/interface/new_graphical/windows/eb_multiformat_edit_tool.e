indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_MULTIFORMAT_EDIT_TOOL

inherit
	EB_EDITOR
		rename
			create_toolbar as create_toolbars
		redefine
			build_interface,
			create_toolbars,
			set_text_from_file,
			show_file,
			reset
		end

feature {NONE} -- Initialization

	init_formatters is
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
--			if format_bar_is_used then
				build_format_bar (format_bar)
--			else
--				build_format_bar (edit_bar)
--			end
-- we assume that format_bar is always created,
-- in `create toolbar' or in `build_edit_bar'
		end

feature -- Window Properties

	last_format: EB_FORMATTER
			-- Last format used

	format_list: EB_FORMATTER_LIST
			-- List of all formats, with the data used
			-- to build the associated toolbar

	format_bar: EV_HORIZONTAL_BOX
			-- Format toolbar
			-- it always exists, even if the tool never uses it,
			-- for the `create_toolbars' creation instruction not
			-- to be rejected by the compiler.

	format_bar_is_used: BOOLEAN is
			-- Do the tool need an effective format_bar?
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

	update is
			-- Update the content of the window (only after saving the content of
			-- the tool.
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

	set_text_from_file (f: PLAIN_TEXT_FILE) is
			-- Display content of file `f' and its name as the title
			-- of the ancestor tool. 
		do
			Precursor (f)
			set_default_format
		end

	show_file (f: PLAIN_TEXT_FILE) is
			-- Display content of file `f' and its name as the title
			-- of the ancestor tool. Forget about clicking and stones.
		do
			Precursor (f)
			set_default_format
		end

feature -- Pick and Throw Implementation

	reset is
			-- Reset the window contents.
		do
			set_default_format
			precursor
		end

feature {NONE} -- Implementation

	create_toolbars (par: EV_BOX) is
			-- Create all toolbars with parent `a_parent'.
		local
			sep: EV_HORIZONTAL_SEPARATOR
		do
			precursor (par)
			if format_bar_is_used then
				create sep.make (par)
				par.set_child_expandable (sep, False)
				create format_bar.make (par)
				par.set_child_expandable (format_bar, False)
--				format_bar.set_minimum_height (22)
			end
		end

	build_format_bar (a_toolbar: EV_BOX) is
		local
--			ri, peer: EV_RADIO_MENU_ITEM
			eb: EV_BUTTON
			cfl: EB_FORMATTER_LIST
		do
			cfl := format_list
			from
				cfl.start
			until
				cfl.after
			loop
--				if cfl.isfirst then
--					create ri.make_with_text (a_menu, cfl.item.menu_name)
--					peer := ri
--				else
--					create ri.make_peer_with_text (a_menu, cfl.item.menu_name, peer)
--				end
				create eb.make (a_toolbar)
				eb.set_pixmap (cfl.item.symbol)
				cfl.item.launch_cmd.set_button (eb)
				cfl.forth
			end
		end

feature {EB_TOOL_MANAGER} -- Menus Implementation

	build_format_menu (a_menu: EV_MENU_ITEM_HOLDER) is
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

end -- class EB_MULTIFORMAT_EDIT_TOOL
