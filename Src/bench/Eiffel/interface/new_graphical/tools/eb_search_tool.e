indexing
	description	: "Tool to search and replace a string in the current file, %
				  %the current cluster or the whole system."
	author		: "Etienne Amodeo"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_SEARCH_TOOL

inherit
	EB_TOOL
		rename
			make as old_make
		export
			{NONE} show
		redefine
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

	EB_SHARED_EDITOR_DATA
		export
			{NONE} all
		end
	
	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_manager: EB_DEVELOPMENT_WINDOW; an_explorer_bar: like explorer_bar) is
		require
			manager_is_not_void: a_manager /= Void
		do
			old_make (a_manager, an_explorer_bar)
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
			preferences: EB_DEVELOPMENT_WINDOW_DATA
		do
			create label.make_with_text (Interface_names.l_Search_for)
			label.align_text_left
			size := label.minimum_width

			create keyword_field
			keyword_field.change_actions.extend (~enable_disable_search_button)
			keyword_field.key_press_actions.extend (~key_pressed (?, True))
			keyword_field.set_minimum_width (Layout_constants.Dialog_unit_to_pixels (100))

			create search_box
			search_box.set_padding (3)
			search_box.extend (label)
			search_box.extend (keyword_field)

			create replace_check_button.make_with_text (Interface_names.l_Replace_with)
			replace_check_button.select_actions.extend (~switch_mode)
			replace_check_button.key_press_actions.extend (~key_pressed (?, True ))
			size := size.max (replace_check_button.minimum_width)
			create replace_field
			replace_field.set_minimum_width (Layout_constants.Dialog_unit_to_pixels (100))
			replace_field.key_press_actions.extend (~key_pressed (?, False))
			create replace_text.make (0)

			create replace_box
			replace_box.extend (replace_check_button)
			replace_box.disable_item_expand (replace_check_button)
			replace_box.extend (replace_field)

			options_box := build_options_box
			buttons_box := build_buttons_box
			
			create preferences
			if not preferences.show_search_options then
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

	build_explorer_bar is
			-- Build the associated explorer bar item and
			-- Add it to `explorer_bar'
		do
			create explorer_bar_item.make (explorer_bar, widget, title, True)
			explorer_bar_item.set_menu_name (menu_name)
			explorer_bar_item.set_pixmap (pixmap)
			explorer_bar.add (explorer_bar_item)
			explorer_bar.repack_widgets
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

	pixmap: ARRAY [EV_PIXMAP] is
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
					update_combo_box (keyword_field.text.out)
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
			Result :=
				explorer_bar_item.is_visible -- i.e. not closed
					and then
				manager.left_tools_are_visible
					and then
				not	explorer_bar_item.is_minimized
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
		do
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
			explorer_bar_item.recycle
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
					if keyword_field.text /= Void and then (not keyword_field.text.is_empty) and then search_is_possible then
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
					meta_keys.compare_objects
					if (Editor_preferences.key_codes_for_actions @ 5) = k.code and then meta_keys.is_equal (Editor_preferences.ctrl_alt_shift_for_actions @ 5) then
						if keyword_field.text /= Void and then not keyword_field.text.is_empty and then search_only then
							search
						end
					elseif (Editor_preferences.key_codes_for_actions @ 6) = k.code and then meta_keys.is_equal (Editor_preferences.ctrl_alt_shift_for_actions @ 6) then
						if keyword_field.text /= Void and then not keyword_field.text.is_empty and then search_only then
							search_performer.go_reverse
							search
						end
					end
				end
			end
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
			options_button.set_pixmap (Pixmaps.Icon_nothing)
			options_button.align_text_left
			options_button.pointer_button_press_actions.force_extend (~toggle_options)
			create options_toolbar
			options_toolbar.extend (options_button)
			create frm
			frm.extend (options_toolbar)
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
			create search_button.make_with_text_and_action (Interface_names.b_Search,~search)
			search_button.disable_sensitive
			create replace_button.make_with_text_and_action (Interface_names.b_Replace,~replace)

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
			if editor.number_of_lines /= 0 then
				-- search box is shown
					-- user choices are taken into account
				search_performer.set_editor (editor)
				currently_searched := keyword_field.text
				update_combo_box (currently_searched.out)
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
			-- replace the current occurence of the searched word
		require
			replace_via_search_box_only: shown
		do
			if editor.number_of_lines /= 0 then
				if editor.is_editable then
					search_performer.set_editor (editor)
					if replace_field.text = Void then
						create currently_replacing.make (0)
					else
						currently_replacing := replace_field.text
					end
					currently_searched := keyword_field.text
					update_combo_box (currently_searched.out)
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
				if replace_text.is_empty or else replace_field = Void or else replace_field.text.is_empty then
					create replace_text.make (0)
				else
					replace_text := replace_field.text
				end
				replace_field.remove_text
				replace_field.hide
				replace_check_button.set_text (Interface_names.l_Replace_with_ellipsis)
				replace_all_button.disable_sensitive
				replace_button.disable_sensitive
			else
				if not replace_text.is_empty then
					replace_field.set_text (replace_text)
				else
					replace_field.remove_text
				end
				replace_field.show
				replace_check_button.set_text (Interface_names.l_Replace_with)
				replace_all_button.enable_sensitive
				if keyword_field.text /= Void and then keyword_field.text.count > 0 then 
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
			if use_wildcards_button.is_selected and then for_test /= Void then
				for_test.prune_all ('*')
				for_test.prune_all ('?')
			end
			Result := for_test /= Void and then for_test.count > 0
		end
		

end -- class EB_SEARCH_TOOL
