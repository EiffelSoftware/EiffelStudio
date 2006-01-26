indexing
	description	: "Tool to search and replace a string in the current file, %
				  %the current cluster or the whole system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Etienne Amodeo"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_SEARCH_TOOL

inherit
	EB_TOOL
		export
			{NONE} show
		redefine
			make,
			menu_name,
			pixmap,
			manager
		end

	EV_KEY_CONSTANTS
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	REFACTORING_HELPER

	TEXT_OBSERVER
		rename
			set_manager as set_text_observer_manager
		end

create
	make

feature {NONE} -- Initialization

	make (a_manager: EB_DEVELOPMENT_WINDOW) is
		do
			Precursor {EB_TOOL} (a_manager)
			create search_performer.make
		end

	build_interface is
			-- Build all the tool's widgets.
		local
			vbox: EV_VERTICAL_BOX
			search_box: EV_VERTICAL_BOX
			replace_box: EV_VERTICAL_BOX
			label: EV_LABEL
			size: INTEGER
			buttons_box: EV_BOX
			options_box: EV_BOX
			frame: EV_FRAME
		do
			create label.make_with_text (Interface_names.l_Search_for)
			label.align_text_left
			size := label.minimum_width

			create keyword_field
			keyword_field.change_actions.extend (agent enable_disable_search_button)
			keyword_field.key_press_actions.extend (agent key_pressed (?, True))
			keyword_field.set_minimum_width (Layout_constants.Dialog_unit_to_pixels (100))
			keyword_field.drop_actions.extend (agent display_stone_signature (keyword_field, ?))

			create search_box
			search_box.set_padding (3)
			search_box.extend (label)
			search_box.extend (keyword_field)

			create replace_check_button.make_with_text (Interface_names.l_Replace_with)
			replace_check_button.select_actions.extend (agent switch_mode)
			replace_check_button.key_press_actions.extend (agent key_pressed (?, True ))
			size := size.max (replace_check_button.minimum_width)
			create replace_field
			replace_field.set_minimum_width (Layout_constants.Dialog_unit_to_pixels (100))

			replace_field.key_press_actions.extend (agent key_pressed (?, False))
			replace_field.drop_actions.extend (agent display_stone_signature (replace_field, ?))
			create replace_text.make (0)

			create replace_box
			replace_box.extend (replace_check_button)
			replace_box.disable_item_expand (replace_check_button)
			replace_box.extend (replace_field)

			options_box := build_options_box
			buttons_box := build_buttons_box

			if not preferences.development_window_data.show_search_options then
				toggle_options
			end

			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)
			vbox.set_padding (Layout_constants.Small_border_size)
			vbox.extend (search_box)
			vbox.disable_item_expand (search_box)
			vbox.extend (replace_box)
			vbox.disable_item_expand (replace_box)
			vbox.extend (options_box)
			vbox.disable_item_expand (options_box)
			vbox.extend (buttons_box)
			vbox.disable_item_expand (buttons_box)

			create frame
			frame.set_style ((create {EV_FRAME_CONSTANTS}).Ev_frame_raised)
			frame.extend (vbox)

			switch_mode
			widget := frame
		end

	build_explorer_bar_item (explorer_bar: EB_EXPLORER_BAR) is
			-- Build the associated explorer bar item and
			-- Add it to `explorer_bar'
		do
			create explorer_bar_item.make (explorer_bar, widget, title, True)
			explorer_bar_item.set_menu_name (menu_name)
			explorer_bar_item.set_pixmap (pixmap)
			explorer_bar.add (explorer_bar_item)
		end

feature -- Access

	manager: EB_DEVELOPMENT_WINDOW

	widget: EV_WIDGET
			-- Widget representing Current

	title: STRING is
			-- Title of the tool
		do
			Result := Interface_names.t_Search_tool
		end

	menu_name: STRING is
			-- Name as it may appear in a menu.
		do
			Result := Interface_names.m_Search_tool
		end

	pixmap: EV_PIXMAP is
			-- Pixmap as it may appear in toolbars and menus.
		do
			Result := Pixmaps.Icon_search
		end

	search_performer: EB_SEARCH_PERFORMER
			-- tool that actually performs the search

	currently_searched: STRING
			-- string to be search

	currently_replacing: STRING
			-- string to be search

feature {NONE}-- Controls

	keyword_field: EV_COMBO_BOX
			-- Text field where the user type in the word he's looking for.

	replace_field: EV_TEXT_FIELD
			-- Text field where the user type in the replacement word.

	search_button: EV_BUTTON
			-- Search button

	replace_button: EV_BUTTON
			-- Replace button

	replace_check_button : EV_CHECK_BUTTON
			-- Replace check button

	replace_all_button: EV_CHECK_BUTTON
			-- Replace check button

	replace_all_label: EV_LABEL
			-- replace all label

	replace_text: STRING
			-- text to replace found words

	case_sensitive_button: EV_CHECK_BUTTON
			-- button to choose case sensitivity or not

	whole_word_button: EV_CHECK_BUTTON
			-- button to look for isolated words

	use_wildcards_button: EV_CHECK_BUTTON
			-- button to tell if pattern contains wild card.

	search_backward_button: EV_CHECK_BUTTON
			-- button to search backward

feature -- Element change

	set_current_searched (word: STRING) is
			-- assign `word' to `currently_searched'
		do
			currently_searched := word
			if keyword_field /= Void then
				if keyword_field.text /= Void and then not keyword_field.text.is_empty then
					update_combo_box (keyword_field.text)
				end
				if word = Void or else word.is_empty then
					keyword_field.remove_text
				else
					keyword_field.set_text (word)
				end
			end
		end

feature -- Status report

	mode_is_search: BOOLEAN is
			-- are replace fields/buttons inactive ?
		do
			Result := not replace_check_button.is_selected
		end

	is_visible: BOOLEAN is
			-- Can `Current' be seen on screen?
		do
			Result := widget.is_displayed
		end

	options_shown: BOOLEAN is
			-- Are the options shown ?
		do
			Result := options.is_show_requested
		end

feature -- Status setting

	set_mode_is_search (value: BOOLEAN) is
			-- show/hide replace field according to `value'
		do
			if value then
				if replace_check_button.is_selected then
					replace_check_button.disable_select
					--switch_mode
				end
			elseif not replace_check_button.is_selected then
				replace_check_button.enable_select
			end
		end

	force_new_search is
			-- force new search
		do
			search_performer.force_search
		end

feature -- Action

	set_focus is
			-- give the focus to the pattern field
		require
			is_visible
		do
			keyword_field.set_focus
		end

	show_and_set_focus is
			-- show the search tool and set focus to the search text field
		require
			explorer_bar_item_not_void: explorer_bar_item /= Void
		do
			fixme ("it can occurs the explorer_bar_item is bad (void or maybe destroyed ..")
			explorer_bar_item.show
			if explorer_bar_item.is_minimized then
				explorer_bar_item.restore
			end
			if currently_searched /= Void and then currently_searched.is_empty then
				keyword_field.set_text (currently_searched)
			end
			if currently_replacing /= Void and then currently_replacing.is_empty then
				replace_field.set_text (currently_replacing)
			end
			keyword_field.set_focus
		end

	go_to_next_found is
			-- highlight next found item if possible
		do
			if shown then
				if search_button.is_sensitive then
					search
					if not editor.has_focus then
						editor.set_focus
					end
				end
			else
				default_search
			end
		end

	go_to_previous_found is
			-- highlight previous found item if possible
		do
			search_performer.go_reverse
			go_to_next_found
		end

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			if explorer_bar_item /= Void then
				explorer_bar_item.recycle
			end
			widget := Void
			manager := Void
		end

feature {NONE} -- Implementation

	search_history_size: INTEGER is 10

	update_combo_box (word: STRING) is
			-- add word to combo box list
		local
			l: LIST[STRING]
		do
			l := keyword_field.strings
			if l /= Void then
				l.compare_objects
			end
			if l = Void or else not l.has (word) then
				if keyword_field.count = search_history_size then
					keyword_field.start
					keyword_field.remove
				end
				keyword_field.extend (create {EV_LIST_ITEM}.make_with_text (word))
			end
			if keyword_field.text.is_empty or else not word.is_equal (keyword_field.text) then
				keyword_field.set_text (word)
			end
		end

	key_pressed (k: EV_KEY; search_only: BOOLEAN) is
			-- Key `k' was pressed in the interface.
			-- If k is Enter then launch the search, if it is Esc then hide the search interface.
		local
			meta_keys: ARRAY [BOOLEAN]
		do
			if k /= Void then
				if k.code = Key_enter then
					if not keyword_field.text.is_empty and then search_is_possible then
						if search_only then
							search
						else
							replace
						end
					end
				elseif k.code = Key_escape then
					close
					ev_application.do_once_on_idle (agent editor.set_focus)
				else
					meta_keys := <<ev_application.ctrl_pressed, ev_application.alt_pressed, ev_application.shift_pressed>>
					if search_selection_shortcut.matches (k, ev_application.alt_pressed, ev_application.ctrl_pressed, ev_application.shift_pressed) then
						if not keyword_field.text.is_empty and then search_only then
							search
						end
					elseif search_last_shortcut.matches (k, ev_application.alt_pressed, ev_application.ctrl_pressed, ev_application.shift_pressed) then
						if not keyword_field.text.is_empty and then search_only then
							search_performer.go_reverse
							search
						end
					end
				end
			end
		end

	search_selection_shortcut: SHORTCUT_PREFERENCE is
			--
		once
			Result := preferences.editor_data.shortcuts.item ("search_selection")
		end

	search_last_shortcut: SHORTCUT_PREFERENCE is
			--
		once
			Result := preferences.editor_data.shortcuts.item ("search_last")
		end

	search_backward_shortcut: SHORTCUT_PREFERENCE is
			--
		once
			Result := 	preferences.editor_data.shortcuts.item ("search_backward")
		end

	options: EV_FRAME

	options_button: EV_TOOL_BAR_BUTTON

	toggle_options is
			-- Hide options if they are shown, show them if they are hidden.
		do
			if options.is_show_requested then
				options.hide
				options_button.set_text (Interface_names.l_Search_options_show)
			else
				options.show
				options_button.set_text (Interface_names.l_Search_options_hide)
			end
		end

	build_options_box: EV_VERTICAL_BOX is
			-- Create and return a box containing the search options
		local
			vbox: EV_VERTICAL_BOX
			frm: EV_FRAME
			options_toolbar: EV_TOOL_BAR
			cell: EV_CELL
		do
				-- Option "Match case"
			create case_sensitive_button.make_with_text (Interface_names.l_Match_case)
			case_sensitive_button.key_press_actions.extend (agent key_pressed (?, True))

				-- Option "Whole word"
			create whole_word_button.make_with_text (Interface_names.l_Whole_word)
			whole_word_button.key_press_actions.extend (agent key_pressed (?, True))

				-- Option "Use wildcards"
			create use_wildcards_button.make_with_text (Interface_names.l_Use_wildcards)
			use_wildcards_button.key_press_actions.extend (agent key_pressed (?, True))
			use_wildcards_button.select_actions.extend (agent enable_disable_search_button)

				-- Option "Replace all"
			create replace_all_button.make_with_text (Interface_names.l_Replace_all)
			replace_all_button.key_press_actions.extend (agent key_pressed (?, True))

				-- Option "Search backward"
			create search_backward_button.make_with_text (Interface_names.l_Search_backward)
			search_backward_button.key_press_actions.extend (agent key_pressed (?, True))


			create vbox
			vbox.set_border_width (5)
			vbox.extend (case_sensitive_button)
			vbox.extend (whole_word_button)
			vbox.extend (use_wildcards_button)
			vbox.extend (replace_all_button)
			vbox.extend (search_backward_button)

			create options_button.make_with_text (Interface_names.l_Search_options_hide)
			options_button.select_actions.extend (agent toggle_options)
			create options_toolbar
			options_toolbar.extend (options_button)
			create frm
				-- This is a small workaround for a bug on Windows, where a toolbar
				-- directly inserted within an EV_FRAME, overlaps the bottom of the frame.
				-- There is currently no easy fix for this so this code has been added temporarily
				-- as a work around. Julian.
			create cell
			frm.extend (cell)
			cell.extend (options_toolbar)
			create Result
			Result.extend (frm)
			Result.disable_item_expand (frm)

			create options
			options.extend (vbox)
			Result.extend (options)

--			create option_box
--			option_box.set_padding (0)
--			create hb
--			options.extend (fr)
--			options.disable_item_expand (fr)
--			options.extend (options)
--			option_box.disable_item_expand (options)
--			create cl
--			cl.set_minimum_width (5)
--			hb.extend (cl)
--			hb.disable_item_expand (cl)
--			hb.extend (option_box)
--		--	hb.disable_item_expand (option_box)
--			create cl
--			cl.set_minimum_width (5)
--			hb.extend (cl)
--			hb.disable_item_expand (cl)
--			hb.set_border_width (5)
--		--	fr.set_style (4)
--			widget.extend (hb)
--			widget.disable_item_expand (hb)


	--		create frm
	--		frm.set_text (Interface_names.l_Options)
	--		frm.extend (vbox)
--			create options
--			create ck.make_with_text ("Options")
--			ck.select_actions.extend ( ~toggle_options)
--			create cl
--			options.extend (cl)
--			options.disable_item_expand (cl)
--			options.extend (vbox)
--			create vbox
--			vbox.extend (ck)
--			vbox.extend (options)
--			create Result
--			Result.extend (vbox)
--			Result.set_padding (10)
		ensure
			Valid_result: Result /= Void and then not Result.is_empty
		end

	build_buttons_box: EV_HORIZONTAL_BOX is
			-- Create and return a box containing the search buttons
		local
			cell: EV_CELL
		do
			create search_button.make_with_text_and_action (Interface_names.b_Search,agent search)
			search_button.disable_sensitive
			create replace_button.make_with_text_and_action (Interface_names.b_Replace,agent replace)

			create Result
			Result.set_padding (Layout_constants.Small_padding_size)

			create cell
			Result.extend (cell)

			Result.extend (search_button)
			Result.disable_item_expand (search_button)
			search_button.set_minimum_width (replace_button.width)
			Result.extend (replace_button)
			Result.disable_item_expand (replace_button)
			create cell
			Result.extend (cell)
		ensure
			Valid_result: Result /= Void and then not Result.is_empty
		end

	search is
			-- launch the search
		require
			toll_is_visible: shown
			search_is_possible: search_button.is_sensitive
			manager_is_not_void: manager /= Void
		do
			if not editor.is_empty then
				-- search box is shown
					-- user choices are taken into account
				search_performer.set_editor (editor)
				currently_searched := keyword_field.text
				update_combo_box (currently_searched)
				search_performer.set_search_whole_word (whole_word_button.is_selected)
				search_performer.set_case_sensitive (case_sensitive_button.is_selected)
				search_performer.set_use_wildcards (use_wildcards_button.is_selected)
				search_performer.set_replace_all (replace_all_button.is_selected)
				if search_backward_button.is_selected then
					search_performer.go_reverse
				end
				search_performer.search (currently_searched)
			end
		end

	default_search is
		do
			if currently_searched /= Void and then not currently_searched.is_empty then
					-- search is possible but the search box is not shown
					-- default options
				search_performer.set_editor (editor)
				search_performer.set_search_whole_word (False)
				search_performer.set_case_sensitive (False)
				search_performer.set_replace_all (False)
				search_performer.set_use_wildcards (False)
				search_performer.search (currently_searched)
			end
		end

	replace is
			-- replace the current occurrence of the searched word
		require
			replace_via_search_box_only: shown
		do
			if editor.number_of_lines /= 0 then
				if editor.is_editable then
					search_performer.set_editor (editor)
					currently_replacing := replace_field.text
					currently_searched := keyword_field.text
					update_combo_box (currently_searched)
					search_performer.set_search_whole_word (whole_word_button.is_selected)
					search_performer.set_case_sensitive (case_sensitive_button.is_selected)
					search_performer.set_replace_all (replace_all_button.is_selected)
					search_performer.set_use_wildcards (use_wildcards_button.is_selected)
					search_performer.replace (currently_searched, currently_replacing)
				else
					editor.display_not_editable_warning_message
				end
			end
		end

	switch_mode is
			-- switch from the normal mode to the replace mode
			-- or the opposite
		do
			if not replace_check_button.is_selected then
				replace_text := replace_field.text
				replace_field.remove_text
				replace_field.hide
				replace_check_button.set_text (Interface_names.l_Replace_with_ellipsis)
				replace_all_button.disable_sensitive
				replace_button.disable_sensitive
			else
				replace_field.set_text (replace_text)
				replace_field.show
				replace_check_button.set_text (Interface_names.l_Replace_with)
				replace_all_button.enable_sensitive
				if search_is_possible then
					replace_button.enable_sensitive
				end
			end
		end

	enable_disable_search_button is
			-- disable the search buton if the search field is empty
		do
			if search_is_possible then
				search_button.enable_sensitive
				if replace_check_button.is_selected then
					replace_button.enable_sensitive
				end
			else
				search_button.disable_sensitive
				replace_button.disable_sensitive
			end
		end

	editor: EB_EDITOR is
			-- current_editor
		do
			Result := manager.current_editor
		end

	search_is_possible: BOOLEAN is
			-- Is it possible to look for the current content of the "search for:" field?
		local
			for_test: STRING
		do
			for_test := keyword_field.text
			if use_wildcards_button.is_selected and then not for_test.is_empty then
				for_test.prune_all ('*')
				for_test.prune_all ('?')
			end
			Result := not for_test.is_empty
		end

	display_stone_signature (textable: EV_TEXTABLE; a_stone: FILED_STONE) is
			-- Display signature name of `a_stone' in `textable'.
		require
			textable_not_void: textable /= Void
			a_stone_not_void: a_stone /= Void
		local
			stone_signature: STRING
		do
			if a_stone.stone_signature /= Void then
					-- FIXME Protected against Void, as there is no postcondition
					-- on `stone_signature', although it appears it should never be Void,
					-- it must be protected for now. Julian 07/22/03

				stone_signature := a_stone.stone_signature
				if stone_signature.has (' ') then
						-- Generic classes, and features with arguments have their arguments
						-- included, so we strip everything except the name.
					stone_signature := stone_signature.substring (1, stone_signature.index_of (' ', 1) - 1)
				end
				textable.set_text (stone_signature)
			end
		ensure
			text_set: a_stone /= Void implies textable.text.is_equal (a_stone.stone_signature)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_SEARCH_TOOL
