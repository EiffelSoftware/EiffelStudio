indexing
	description: "Window that displays a text area and a list of possible features for automatic completion"
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_COMPLETION_CHOICE_WINDOW

inherit
	EV_WINDOW

	EV_KEY_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end
	
	EB_CONSTANTS
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

create
	make_with_editor

feature {NONE}-- Initialization

	make_with_editor (an_editor: EB_SMART_EDITOR; feature_name: STRING; completion_possibilities: SORTABLE_ARRAY [EB_FEATURE_NAME_FOR_COMPLETION]) is
			-- create the window and associate it with `an_editor'
		local
			vbox: EV_VERTICAL_BOX
		do
			editor := an_editor
			before_complete := feature_name
			sorted_names := completion_possibilities
			sorted_names.compare_objects
			create choice_list
			build_displayed_list (feature_name)
			
				-- if there is only one possibility, we insert it without displaying the window
			show_needed := choice_list.count /= 1
			if show_needed then			
				make_with_title (Interface_names.t_Autocomplete_window)
				set_minimum_size (200,150)
				create vbox
				if before_complete /= Void then
					create to_be_inserted.make_with_text (before_complete)
					to_be_inserted.set_caret_position (before_complete.count + 1)
				else
					create to_be_inserted
				end

				vbox.extend (to_be_inserted)
				vbox.disable_item_expand (to_be_inserted)
				vbox.extend (choice_list)
				extend (vbox)
				to_be_inserted.key_press_actions.extend (~on_key_pressed)
				to_be_inserted.change_actions.extend (~on_text_edited)
				enable_user_resize
				focus_in_actions.extend (~on_focus)
				focus_out_actions.extend (~on_lose_focus)
				to_be_inserted.focus_out_actions.extend (~on_lose_focus)
				choice_list.focus_out_actions.extend (~on_lose_focus)
				choice_list.pointer_button_release_actions.extend (~mouse_selection)
			end
			if not choice_list.is_empty then
				choice_list.first.enable_select
			end
			if not show_needed then
				close_and_complete				
			end
		end
		

feature -- Access

	editor: EB_SMART_EDITOR
			-- associated window

	to_be_inserted: EV_TEXT_FIELD
			-- text field for user input

	choice_list: EV_LIST
			-- list displaying possible feature signatures

	sorted_names: SORTABLE_ARRAY[EB_FEATURE_NAME_FOR_COMPLETION]
			-- list of possible feasture signatures sorted alphabetically

	before_complete: STRING


feature -- Status report

	show_needed: BOOLEAN
			-- Should the window be displayed ?


feature -- Events handling

	mouse_selection (x_pos, y_pos, button: INTEGER; unused1,unused2,unused3: DOUBLE; unused4,unused5:INTEGER) is
			-- process mouse click in the list
		do
			if 
				button = 1 and choice_list.selected_item /= Void			
			then
				close_and_complete
			else
				to_be_inserted.set_focus
			end
		end

	on_key_pressed (ev_key: EV_KEY) is
			-- process user input in `to_be_inserted'
		local
			ix: INTEGER
		do
			if ev_key /= Void then
				inspect
					ev_key.code
				when Key_enter then
					close_and_complete
				when Key_up then
					if choice_list.selected_item /= Void then
						ix:= choice_list.index_of (choice_list.selected_item,1)
						if ix <= 1 then
							ix := choice_list.count
						else
							ix := (ix - 1)
						end
					else
						ix := 1
					end
					choice_list.i_th (ix).enable_select
					choice_list.ensure_item_visible (choice_list.i_th (ix))
				when Key_down then
					if choice_list.selected_item /= Void then
						ix:= choice_list.index_of (choice_list.selected_item,1)
						if ix >= choice_list.count then
							ix := 1
						else
							ix := (ix + 1)
						end
					else
						ix := 1
					end
					choice_list.i_th (ix).enable_select
					choice_list.ensure_item_visible (choice_list.i_th (ix))
				when Key_page_up then
					if choice_list.selected_item /= Void then
						ix:= choice_list.index_of (choice_list.selected_item,1)
						if ix <= 10 then
							ix := choice_list.count
						else
							ix := ix - 10
						end
					else
						ix := 1
					end
					choice_list.i_th (ix).enable_select
					choice_list.ensure_item_visible (choice_list.i_th (ix))
				when Key_page_down then
					if choice_list.selected_item /= Void then
						ix:= choice_list.index_of (choice_list.selected_item,1)
						if ix > choice_list.count - 10 then
							ix := 1
						else
							ix := ix + 10
						end
					else
						ix := 1
					end
					choice_list.i_th (ix).enable_select
					choice_list.ensure_item_visible (choice_list.i_th (ix))
				when Key_escape then
					exit
					editor.set_focus
				else
					if 
						editor.Editor_preferences.key_codes_for_actions.index_of (ev_key.code, 1) = 1
							and then
						current_meta_keys.is_equal (editor.Editor_preferences.ctrl_alt_shift_for_actions.item (1))
					then
						close_and_complete
					end
				end
			end
		end

	on_focus is
			-- give focus to `to_be_inserted'
		do
			to_be_inserted.set_focus
		end

	on_lose_focus is
			-- close window
		do
			if not (
				is_destroyed
					or else
				has_focus 
					or else 
				to_be_inserted.has_focus
					or else 
				choice_list.has_focus
				)
			then
				exit
			end
		end

	on_text_edited is
			-- process user entry
		local
			searched_w: STRING
		do
			if to_be_inserted.text /= Void and then not to_be_inserted.text.is_empty then
				searched_w := to_be_inserted.text.out
			end
			build_displayed_list (searched_w)
			if not choice_list.is_empty then
				choice_list.first.enable_select
			end			
		end

feature -- Basic operations

	complete_with (word: STRING) is
			-- fill `to_be_inserted' with `word'
		require
			word_not_void: word /= Void
			word_not_empty: not word.is_empty
		do
			before_complete := word
			to_be_inserted.set_text (word)
			to_be_inserted.set_caret_position (word.count + 1)
		end

feature {NONE} -- Implementation

			
	index_offset: INTEGER
			-- Index in `sorted_names' of the first element in `choice_list'
			
	build_displayed_list (name: STRING) is
			--  
		local
			for_search: EB_FEATURE_NAME_FOR_COMPLETION
			displayed_count: INTEGER
		do
			if name= Void or else name.is_empty then
				index_offset := 0
				displayed_count := sorted_names.count
			else
				from
					create for_search.make_with_name (name)
					index_offset := pos_of_first_greater (sorted_names, for_search) - 1
				until
					sorted_names.upper < (index_offset + displayed_count + 1) or else not sorted_names.item (index_offset + displayed_count + 1).begins_with (name)
				loop
					displayed_count := displayed_count + 1
				end
			end
			choice_list.wipe_out
			if displayed_count > 0 then
				choice_list.set_strings (sorted_names.subarray (index_offset + 1, index_offset + displayed_count))
			end
		end

	format (a_list: LIST[STRING]): LINKED_LIST[STRING] is
			-- process list items to be displayed
		do
			from
				a_list.start
				create Result.make
			until
				a_list.after
			loop
				Result.extend (a_list.item.substring (1,a_list.item.count - 1))
				a_list.forth
			end
		end

	point_if_needed: STRING is
		do
			if editor.exploring_current_class then
				Result := ""
			else
				Result := "."
			end
		end

	close_and_complete is
			-- close the window and perform completion with selected item
		local
			ix: INTEGER
		do
			is_closing := True
			if choice_list.selected_item /= Void then
				ix:= choice_list.index_of (choice_list.selected_item,1) + index_offset
				if sorted_names.item (ix).has_dot then
					editor.complete_from_window (point_if_needed + sorted_names.item (ix), True)
				else
					editor.complete_from_window (" " + sorted_names.item (ix), True)
				end
			else
				if to_be_inserted.text /= void then
					editor.complete_from_window (point_if_needed + to_be_inserted.text, False)
				end
			end
			if show_needed then
				destroy	
			end
			editor.set_focus
		end

	exit is
			-- cancel autocomplete
		do
			if not is_closing then
				is_closing := True
				if before_complete /= void then
					editor.complete_from_window (point_if_needed + before_complete, False)
				end
				destroy
				editor.exit_complete_mode
			end
		end
		
	is_closing: BOOLEAN
			-- is the window being closed ?

	current_meta_keys: ARRAY [BOOLEAN] is
		do
			Result := <<ev_application.ctrl_pressed, ev_application.alt_pressed, ev_application.shift_pressed>>
		end

	pos_of_first_greater (table: SORTABLE_ARRAY [EB_FEATURE_NAME_FOR_COMPLETION]; a_name:EB_FEATURE_NAME_FOR_COMPLETION): INTEGER is
			--
		local
			low, up, mid: INTEGER
		do
			if table.item (table.lower) >= a_name then
				Result := table.lower
			elseif table.item (table.upper) <= a_name then
				Result := table.upper
			else
				from
					low := table.lower
					up := table.upper
					mid := low
				until
					up - low <= 1
				loop
					mid := (up + low) // 2
					if table.item (mid) >= a_name then
						up := mid
					else
						low := mid
					end
				end
				Result := up
			end
		ensure
			table.item (table.lower) >= a_name 
				or else
			table.item (table.upper) <= a_name 
				or else
			(	table.item (Result - 1) < a_name and
				table.item (Result) >= a_name)
		end		

end -- class EB_COMPLETION_CHOICE_WINDOW
