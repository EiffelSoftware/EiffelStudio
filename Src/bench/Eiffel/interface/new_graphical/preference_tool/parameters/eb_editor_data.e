indexing
	description: "Editor preferences"
	author: "Christophe Bonnard / Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EDITOR_DATA

inherit
	SHARED_RESOURCES
		redefine
			default_create
		end

	EV_FONT_CONSTANTS
		redefine
			default_create
		end
		
	OBSERVER
		redefine
			default_create
		end

	EB_SHARED_MANAGERS
		redefine
			default_create
		end

	EV_KEY_CONSTANTS
		export
			{NONE} all
		redefine		
			default_create
		end

feature {NONE} -- Initialization

	default_create is
		local
			rmanager: RESOURCE_OBSERVATION_MANAGER
			id: STRING
			keyword_name: STRING
			i: INTEGER
			count: INTEGER
		do
			create rmanager
			rmanager.add_observer ("normal_text_color", Current)
			rmanager.add_observer ("normal_background_color", Current)
			rmanager.add_observer ("selection_text_color", Current)
			rmanager.add_observer ("selection_background_color", Current)
			rmanager.add_observer ("string_text_color", Current)
			rmanager.add_observer ("string_background_color", Current)
			rmanager.add_observer ("keyword_text_color", Current)
			rmanager.add_observer ("keyword_background_color", Current)
			rmanager.add_observer ("spaces_background_color", Current)
			rmanager.add_observer ("spaces_text_color", Current)
			rmanager.add_observer ("comments_text_color", Current)
			rmanager.add_observer ("comments_background_color", Current)
			rmanager.add_observer ("number_text_color", Current)
			rmanager.add_observer ("number_background_color", Current)
			rmanager.add_observer ("operator_text_color", Current)
			rmanager.add_observer ("operator_background_color", Current)
			rmanager.add_observer ("breakpoint_background_color", Current)
			rmanager.add_observer ("assertion_tag_text_color", Current)
			rmanager.add_observer ("assertion_tag_background_color", Current)
			rmanager.add_observer ("indexing_tag_text_color", Current)
			rmanager.add_observer ("indexing_tag_background_color", Current)
			rmanager.add_observer ("reserved_text_color", Current)
			rmanager.add_observer ("reserved_background_color", Current)
			rmanager.add_observer ("generic_text_color", Current)
			rmanager.add_observer ("generic_background_color", Current)
			rmanager.add_observer ("local_text_color", Current)
			rmanager.add_observer ("local_background_color", Current)

			rmanager.add_observer ("underscore_is_separator", Current)
			rmanager.add_observer ("smart_indent", Current)
			rmanager.add_observer ("automatic_update", Current)
			rmanager.add_observer ("autocomplete_brackets_and_parenthesis", Current)
			rmanager.add_observer ("autocomplete_quotes", Current)
			rmanager.add_observer ("call_complete_with_any_features", Current)
			rmanager.add_observer ("syntax_autocomplete", Current)
			rmanager.add_observer ("quadruple_click", Current)
			rmanager.add_observer ("tab_for_indentation", Current)

			load_preferences
			from
				completed_keywords.start
			until
				completed_keywords.after
			loop
				keyword_name := completed_keywords.item
				if keyword_name.has (' ') then
					keyword_name := clone (keyword_name)
					keyword_name.replace_substring_all (" ", "_")
				end
				id := "autocomplete_" + keyword_name
				rmanager.add_observer (id, Current)
				id := "use_default_" + keyword_name
				rmanager.add_observer (id, Current)
				id := "custom_" + keyword_name + "_space"
				rmanager.add_observer (id, Current)
				id := "custom_" + keyword_name + "_return"
				rmanager.add_observer (id, Current)
				id := "custom_" + keyword_name + "_space_later"
				rmanager.add_observer (id, Current)
				id := "custom_" + keyword_name + "_return_later"
				rmanager.add_observer (id, Current)
				completed_keywords.forth
			end
			count := customizable_shortcuts.count
			from
				i := 1
			until
				i > count
			loop
				keyword_name := customizable_shortcuts.item (i)
				id := keyword_name + "_shortcut_key"
				rmanager.add_observer (id, Current)
				id := keyword_name + "_shortcut_ctrl"
				rmanager.add_observer (id, Current)
				id := keyword_name + "_shortcut_alt"
				rmanager.add_observer (id, Current)
				id := keyword_name + "_shortcut_shift"
				rmanager.add_observer (id, Current)
				i := i + 1
			end
		end
		
feature {TEXT}-- Resources

	tabulation_spaces: INTEGER
			-- number of spaces characters in a tabulation.

feature

	smart_identation: BOOLEAN
			-- Is smart identation enabled?

		--| Font color Preferences

	normal_text_color: EV_COLOR
			-- Color used to display normal text

	normal_background_color: EV_COLOR
			-- Background color used to display normal text

	selection_text_color: EV_COLOR
			-- Color used to display selected text

	selection_background_color: EV_COLOR
			-- Background color used to display selected text

	string_text_color: EV_COLOR
			-- Color used to display strings

	string_background_color: EV_COLOR
			-- Background color used to display strings

	keyword_text_color: EV_COLOR
			-- Color used to display keywords

	keyword_background_color: EV_COLOR
			-- Background color used to display keywords

	spaces_text_color: EV_COLOR
			-- Color used to display spaces

	spaces_background_color: EV_COLOR
			-- Background color used to display spaces

	comments_text_color: EV_COLOR
			-- Color used to display comments

	comments_background_color: EV_COLOR
			-- Background color used to display comments

	number_text_color: EV_COLOR
			-- Color used to display numbers

	number_background_color: EV_COLOR
			-- Background color used to display numbers

	operator_text_color: EV_COLOR
			-- Color used to display operator

	operator_background_color: EV_COLOR
			-- Background color used to display operator

	breakpoint_background_color: EV_COLOR
			-- Background color used to display breakpoints

	assertion_tag_text_color: EV_COLOR
	assertion_tag_background_color: EV_COLOR
	indexing_tag_text_color: EV_COLOR
	indexing_tag_background_color: EV_COLOR
	reserved_text_color: EV_COLOR
	reserved_background_color: EV_COLOR
	generic_text_color: EV_COLOR
	generic_background_color: EV_COLOR
	local_text_color: EV_COLOR
	local_background_color: EV_COLOR

	font: EDITOR_FONT
			-- Current text font.

	automatic_update: BOOLEAN
			-- if the text has been emodified by an external editor, should we
			-- reload the file automatically if no change has been made here ? 

	underscore_is_separator: BOOLEAN
			-- Should '_' be considered a word separator (used for word by word
			-- moves and selection)

	autocomplete_brackets_and_parenthesis: BOOLEAN
			-- Should we close the brackets and parenthesis automatically?

	autocomplete_quotes: BOOLEAN
			-- Should we close the quotes automatically?

	show_any_features: BOOLEAN
			-- Should autocomplete show features inherited from any ?

	syntax_complete_enabled: BOOLEAN
			-- should main keywords be completed ?

	quadruple_click_enabled: BOOLEAN
			-- is quadruple click (select all) enabled ?
			
	use_tab_for_indentation: BOOLEAN
			-- use tabulations (not spaces) for auto-indenting ?

	customized_strings: ARRAY [STRING]
			-- strings defined by the user.

feature -- Syntax Completion Customization

	completed_keywords: ARRAYED_LIST [STRING] is
			-- list of completed keywords
		local
			a: ARRAY [STRING]
		once
			create Result.make (35)
			a := <<
				"indexing", "class", "inherit", "creation", "feature", 
				"is", "require", "require else", "local", "do", "once", "deferred", "external", "rescue", "ensure", "ensure then", "alias",
				"if", "then", "elseif", "else", "inspect", "when", "from", "variant", "until", "loop", "debug", "check", 
				"rename", "redefine", "undefine", "select", "export",
				"precursor", "create", "obsolete", "invariant", "end"
				>>
			Result.fill (a)
			Result.compare_objects
		end

	complete_keywords: ARRAY [BOOLEAN]
			-- should the corresponding keyword in `completed_keywords' be completed ?

	insert_after_keyword: ARRAY [ARRAY[STRING]]
			-- strings to be inserted after keywords


feature -- Keybord shortcuts Customization

	customizable_shortcuts: ARRAY [STRING] is
			-- list of customizable shortcuts
		once
			Result := <<"autocomplete", "class_autocomplete", "show_search_panel", "show_search_and_replace_panel", "search_selection", "search_last", "search_backward",
			"customized_insertion_1", "customized_insertion_2", "customized_insertion_3">>
		end

	default_key_codes: ARRAY [INTEGER] is
			-- default key codes
		once
			Result := <<Key_space, Key_space, Key_f, Key_h, Key_F3, Key_F3, Key_F3, Key_F2, Key_F2, Key_F2>>
		end

	default_ctrl_alt_shift: ARRAY [ARRAY [BOOLEAN]] is
			-- default ctrl/alt/shift status associated with actions above
		once
			Result := << 	<<True, False, False>>,
					<<True, False, True>>,
					<<True, False, False>>,
					<<True, False, False>>,
					<<False, False, False>>,
					<<False, False, False>>,
					<<False, False, True>>,
					<<False, False, False>>,
					<<True, False, False>>,
					<<False, False, True>>	>>
		end

	key_codes_for_actions: ARRAYED_LIST [INTEGER]
			-- array of key codes associated with actions : for keybord shortcut customization

	ctrl_alt_shift_for_actions: ARRAY [ARRAY [BOOLEAN]]
			-- array of flags (ctrled / alted / shifted key or not ?) associated with actions : for keybord shortcut customization

	shorcut_name_for_action (action_number: INTEGER):STRING is
			-- description shortcut corresponding to `action_number'-th action
		local
			meta: ARRAY [BOOLEAN]
		do
			Result := clone (key_strings @ (key_codes_for_actions.i_th(action_number)))
			Result.put (Result.item(1).upper, 1)
			meta := ctrl_alt_shift_for_actions.item (action_number)
			if meta.item (3) then
				Result.prepend ("Shift+")
			end
			if meta.item (2) then
				Result.prepend ("Alt+")
			end
			if meta.item (1) then
				Result.prepend ("Ctrl+")
			end
		end

feature -- Element Change (General preferences)

	enable_smart_ident is
			-- Set `smart_identation' to True.
		do
			smart_identation := True
		ensure
			smart_identation_set: smart_identation
		end

	disable_smart_ident is
			-- Set `smart_identation' to False.
		do
			smart_identation := False
		ensure
			smart_identation_set: not smart_identation
		end

feature -- Update

	update is
			-- The preferences have changed.
		do
			update_preferences
			Window_manager.quick_refresh_all
		end

	load_preferences is
			-- Default Initialisations
		do
			tabulation_spaces := integer_resource_value ("tab_step", 4)
			create font.make_with_font (font_resource_value ("editor_font"))
			update_preferences
		end

	update_preferences is
			-- Update preferences that may be updated.
		local
			cr: COLOR_RESOURCE
		do
			normal_text_color := secure_color_resource_value ("normal_text_color", 0, 0, 0)
			normal_background_color := secure_color_resource_value ("normal_background_color", 255, 255, 255)
			selection_text_color := secure_color_resource_value ("selection_text_color", 255, 255, 128)
			selection_background_color := secure_color_resource_value ("selection_background_color", 0, 0, 128)
			string_text_color := secure_color_resource_value ("string_text_color", 255, 255, 128)
			string_background_color := color_resource_value ("string_background_color")
			cr ?= resources.item ("string_background_color")
			if cr /= Void then
				cr.allow_void
			end
			cr ?= resources.item ("keyword_background_color")
			if cr /= Void then
				cr.allow_void
			end
			cr ?= resources.item ("spaces_background_color")
			if cr /= Void then
				cr.allow_void
			end
			cr ?= resources.item ("comments_background_color")
			if cr /= Void then
				cr.allow_void
			end
			cr ?= resources.item ("string_background_color")
			if cr /= Void then
				cr.allow_void
			end
			cr ?= resources.item ("number_background_color")
			if cr /= Void then
				cr.allow_void
			end
			cr ?= resources.item ("operator_background_color")
			if cr /= Void then
				cr.allow_void
			end
			cr ?= resources.item ("breakpoint_background_color")
			if cr /= Void then
				cr.allow_void
			end
			cr ?= resources.item ("assertion_tag_background_color")
			if cr /= Void then
				cr.allow_void
			end
			cr ?= resources.item ("indexing_tag_background_color")
			if cr /= Void then
				cr.allow_void
			end
			cr ?= resources.item ("reserved_background_color")
			if cr /= Void then
				cr.allow_void
			end
			cr ?= resources.item ("generic_background_color")
			if cr /= Void then
				cr.allow_void
			end
			cr ?= resources.item ("local_background_color")
			if cr /= Void then
				cr.allow_void
			end
			keyword_text_color := secure_color_resource_value ("keyword_text_color", 0, 153, 255)
			keyword_background_color := color_resource_value ("keyword_background_color")
			spaces_text_color := secure_color_resource_value ("spaces_text_color", 128, 128, 128)
			spaces_background_color := color_resource_value ("spaces_background_color")
			comments_text_color := secure_color_resource_value ("comments_text_color", 204, 102, 255)
			comments_background_color := color_resource_value ("comments_background_color")
			number_text_color := secure_color_resource_value ("number_text_color", 153, 255, 153)
			number_background_color := color_resource_value ("number_background_color")
			operator_text_color := secure_color_resource_value ("operator_text_color", 0, 153, 255)
			operator_background_color := color_resource_value ("operator_background_color")
			breakpoint_background_color := color_resource_value ("breakpoint_background_color")
			assertion_tag_text_color := secure_color_resource_value ("assertion_tag_text_color", 0, 0, 0)
			assertion_tag_background_color := color_resource_value ("assertion_tag_background_color")
			indexing_tag_text_color := secure_color_resource_value ("indexing_tag_text_color", 0, 0, 0)
			indexing_tag_background_color := color_resource_value ("indexing_tag_background_color")
			reserved_text_color := secure_color_resource_value ("reserved_text_color", 0, 0, 0)
			reserved_background_color := color_resource_value ("reserved_background_color")
			generic_text_color := secure_color_resource_value ("generic_text_color", 0, 0, 0)
			generic_background_color := color_resource_value ("generic_background_color")
			local_text_color := secure_color_resource_value ("local_text_color", 0, 0, 0)
			local_background_color := color_resource_value ("local_background_color")

			smart_identation := boolean_resource_value("smart_indent", true)
			automatic_update := boolean_resource_value("automatic_update", true)
			underscore_is_separator := boolean_resource_value("underscore_is_separator", False)
			autocomplete_brackets_and_parenthesis := boolean_resource_value("autocomplete_brackets_and_parenthesis", False)
			autocomplete_quotes := boolean_resource_value("autocomplete_quotes", False)
			show_any_features := boolean_resource_value("call_complete_with_any_features", False)
			syntax_complete_enabled := boolean_resource_value("syntax_autocomplete", True)
			quadruple_click_enabled := boolean_resource_value("quadruple_click", True)
			use_tab_for_indentation := boolean_resource_value("tab_for_indentation", True)
			
			create customized_strings.make (1, 3)
			customized_strings.put (string_resource_value("customized_string_1", ""), 1)
			customized_strings.put (string_resource_value("customized_string_2", ""), 2)
			customized_strings.put (string_resource_value("customized_string_3", ""), 3)

			build_autocomplete_prefs
			build_shortcuts_prefs
		end

feature {NONE} -- Build preferences for autocomplete

	default_insert: ARRAY [ARRAY [STRING]] is
			-- default strings to be inserted after keywords
		once
			Result := <<	
						-- indexing
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$$cursor$">>,
						-- class
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- inherit
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- creation
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- feature
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$$cursor$">>,

						-- is
					<<" $cursor$", "%N$indent$%%T%%T-- $cursor$%N$indent$%T", " $cursor$", "%N$indent$$cursor$">>,
						-- require
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- require else
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- local
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- do
					<<" $cursor$ end", "%N$indent$%%T$cursor$%N$indent$end", " $cursor$", "%N$indent$%T$cursor$">>,
						-- once
					<<" $cursor$ end", "%N$indent$%%T$cursor$%N$indent$end", " $cursor$", "%N$indent$%T$cursor$">>,
						-- deferred
					<<" end$cursor$", "%N$indent$end$cursor$", " $cursor$", "%N$indent$$cursor$">>,
						-- external
					<<" %"$cursor$%" end", "%N$indent$%%T%"$cursor$%"%N$indent$end", " $cursor$", "%N$indent$$cursor$">>,
						-- rescue
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- ensure
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- ensure then
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- alias
					<<" %"$cursor$%"", "%N$indent$%%T%"$cursor$%"", " $cursor$", "%N$indent$$cursor$">>,
	


						-- if
					<<" $cursor$ then%N$indent$%%T%N$indent$end", "%N$indent$%%T$cursor$%N$indent$then%N$indent$%%T%N$indent$end", " $cursor$", "%N$indent$%T$cursor$">>,
						-- then
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- elseif
					<<" $cursor$ then%N$indent$%%T", "%N$indent$%%T$cursor$%N$indent$then%N$indent$%%T", " $cursor$", "%N$indent$%T$cursor$">>,
						-- else
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- inspect
					<<" $cursor$%N$indent$when  then%N$indent$%%T%N$indent$else%N$indent$%%T%N$indent$end", "%N$indent$%%T$cursor$%N$indent$when  then%N$indent$%%T%N$indent$else%N$indent$%%T%N$indent$end", " $cursor$", "%N$indent$%T$cursor$">>,
						-- when
					<<" $cursor$ then%N$indent$%%T", "%N$indent$%%T$cursor$%N$indent$then%N$indent$%%T", " $cursor$", "%N$indent$%T$cursor$">>,
						-- from
					<<" $cursor$%N$indent$until%N$indent$loop%N$indent$end", "%N$indent$%%T$cursor$%N$indent$until%N$indent$%%T%N$indent$loop%N$indent$%%T%N$indent$end", " $cursor$", "%N$indent$%T$cursor$">>,
						-- variant
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- until
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- loop
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- debug
					<<" $cursor$ end", "%N$indent$%%T$cursor$%N$indent$end", " $cursor$", "%N$indent$%T$cursor$">>,
						-- check
					<<" $cursor$ end", "%N$indent$%%T$cursor$%N$indent$end", " $cursor$", "%N$indent$%T$cursor$">>,

						-- rename
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- redefine
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- undefine
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- select
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- export
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,

						-- Precursor
					<<" {$cursor$}", "%N$indent$$cursor$", " $cursor$", "%N$indent$$cursor$">>,
						-- create
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$$cursor$">>,
						-- obsolete
					<<" %"$cursor$%"", "%N$indent$%%T%"$cursor$%"", " $cursor$", "%N$indent$$cursor$">>,
						-- invariant
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$$cursor$">>,
						-- end
					<<" $cursor$", "%N$indent$$cursor$", " $cursor$", "%N$indent$$cursor$">>

				>>
		end

	build_autocomplete_prefs is
		local
			i: INTEGER
			cnt: INTEGER
			id: STRING
			insert: ARRAY [STRING]
			keyword_name: STRING
		do
			cnt := completed_keywords.count
			create complete_keywords.make (1, cnt)
			create insert_after_keyword.make (1, cnt)
			from
				i := 1
			until
				i > cnt
			loop
				keyword_name := completed_keywords.i_th (i)
				if keyword_name.has (' ') then
					keyword_name := clone (keyword_name)
					keyword_name.replace_substring_all (" ", "_")
				end
				id := "autocomplete_" + keyword_name
				complete_keywords.put (boolean_resource_value(id, True), i)
				id := "use_default_" + keyword_name
				if boolean_resource_value(id, True) then
					insert_after_keyword.put (default_insert @ i, i)
				else
					create insert.make (1, 4)
					id := "custom_" + keyword_name + "_space"
					insert.put (string_resource_value(id, ""), 1)
					id := "custom_" + keyword_name + "_return"
					insert.put (string_resource_value(id, ""), 2)
					id := "custom_" + keyword_name + "_space_later"
					insert.put (string_resource_value(id, ""), 3)
					id := "custom_" + keyword_name + "_return_later"
					insert.put (string_resource_value(id, ""), 4)
					insert_after_keyword.put (insert, i)
				end
				i := i + 1
			end
		end	

	build_shortcuts_prefs is
		local
			i: INTEGER
			count: INTEGER
			action_name: STRING
			default_meta, meta: ARRAY [BOOLEAN]
			id: STRING
			key_code: INTEGER
		do
			count := customizable_shortcuts.count
			create key_codes_for_actions.make (count)
			create ctrl_alt_shift_for_actions.make (1, count)
			from
				i := 1
			until
				i > count
			loop
				default_meta := default_ctrl_alt_shift.item (i)
				action_name := customizable_shortcuts.item (i)

				id := action_name + "_shortcut_key"
				key_code := key_with_name (string_resource_value(id, ""))

				if key_code >= Key_strings.lower then 
					create meta.make (1, 3)
					key_codes_for_actions.extend (key_code)
					id := action_name + "_shortcut_ctrl"
					meta.put (boolean_resource_value(id, default_meta @ 1), 1)
					id := action_name + "_shortcut_alt"
					meta.put (boolean_resource_value(id, default_meta @ 2), 2)
					id := action_name + "_shortcut_shift"
					meta.put (boolean_resource_value(id, default_meta @ 3), 3)
				else
					key_codes_for_actions.extend (default_key_codes @ i)
					meta := default_meta
				end

				ctrl_alt_shift_for_actions.put (meta, i)

				i := i + 1
			end
		end

	key_with_name (name: STRING): INTEGER is
			-- key code corresponding to `name'
		require
			name /= Void
		local
			s1, s2: STRING
			i: INTEGER
			found: BOOLEAN
		do
			if name.is_empty then
				Result := Key_strings.lower - 1
			else
				s1 := clone (name)
				s1.to_lower
				from
					i := Key_strings.lower
				until
					found or i > Key_strings.upper
				loop
					s2 := clone (Key_strings @ i)
					s2.to_lower
					found := s1.is_equal (s2)
					i := i + 1
				end
				if found then
					Result := i - 1
				else
					Result := Key_strings.lower - 1
				end
			end
		end
invariant

	consistent_shortcut_arrays:	customizable_shortcuts.count = key_codes_for_actions.count
						and
					customizable_shortcuts.count = ctrl_alt_shift_for_actions.count

end -- class EB_EDITOR_DATA
