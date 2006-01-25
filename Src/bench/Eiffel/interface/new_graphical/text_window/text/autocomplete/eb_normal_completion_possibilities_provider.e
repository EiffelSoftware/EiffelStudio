indexing
	description: "[
			Objects that provider completion possiblities for normal use.
			i.e. EB_CODE_COMPLETABLE_TEXT_FIELD which can auto complete names of features and classes"
			]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_NORMAL_COMPLETION_POSSIBILITIES_PROVIDER

inherit
	EB_COMPLETION_POSSIBILITIES_PROVIDER
		rename
			code_completable as text_field
		redefine
			text_field,
			prepare_completion
		end

	EB_CLASS_INFO_ANALYZER
		export
			{NONE} all
		redefine
			reset,
			go_to_next_token,
			go_to_previous_token,
			after_searched_token,
			set_up_local_analyzer
		end

	EB_SHARED_PREFERENCES

	EB_SHARED_DEBUG_TOOLS

create
	make

feature -- Initialization

	make (a_class_c: CLASS_C; a_feature_as: FEATURE_AS; a_static: BOOLEAN) is
			-- Initialization
			-- Set `class_c' with `a_class_c'.
			-- If a_static, we do not provide possibilities from context information.
		do
			context_class_c := a_class_c
			static := a_static
			context_feature_as := a_feature_as
			current_feature_as := a_feature_as
			completion_possibilities := Void
			class_completion_possibilities := Void
		ensure
			static_set: static = a_static
		end

feature -- Access

	completion_possibilities: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION]
			-- Completions proposals for feature completion.

	class_completion_possibilities: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION]
			-- Completions proposals for class completion.

	insertion: STRING is
			--
		do
			Result := insertion_cell.item
		end

	insertion_remainder: INTEGER

	context_class_c: CLASS_C
			-- The context related class.

	context_feature_as: FEATURE_AS
			-- The context related feature.

	text_field : EB_CODE_COMPLETABLE_TEXT_FIELD

feature -- Basic operation

	prepare_completion is
			--
		do
			Precursor
			create insertion_cell
			if not static then
				context_class_c := eb_debugger_manager.debugging_class_c
				context_feature_as := eb_debugger_manager.debugging_feature_as
			end
			current_feature_as := context_feature_as
			watching_line := text_field.current_line
			if context_class_c /= Void then
				current_class_name := context_class_c.name
				cluster_name := context_class_c.cluster.cluster_name
				if provide_features then
					build_completion_list
				end
			end
			if provide_classes then
				build_class_completion_list
			end
		end

feature {NONE} -- Implementation

	external_features (cl: CLASS_C): ARRAYED_LIST [E_FEATURE] is
			-- List of the external features of `cl'.
		require
			valid_class: cl /= Void
		local
			ft: FEATURE_TABLE
			feat: FEATURE_I
		do
			if cl.has_feature_table then
				ft := cl.feature_table
				create Result.make (20)
				from
					ft.start
				until
					ft.after
				loop
					feat := ft.item_for_iteration
					if feat.has_static_access then
						Result.extend (feat.api_feature (ft.feat_tbl_id))
					end
					ft.forth
				end
			end
		end

	insert_in_completion_possibilities (name: EB_NAME_FOR_COMPLETION) is
			--
		require
			name /= Void
		do
			if completion_possibilities.capacity < cp_index then
				completion_possibilities.grow (cp_index + 50)
			end
			completion_possibilities.put (name, cp_index)
			cp_index := cp_index + 1
		end

	add_feature_to_completion_possibilities (feat: E_FEATURE) is
			-- add the signature of `feat' to `completion possibilities'
		require
			completion_possibilities_not_void: completion_possibilities /= Void
			feat_is_not_void: feat /= Void
		local
			l_feature: EB_FEATURE_FOR_COMPLETION
		do
			if feat.is_infix then
				create l_feature.make (feat)
				l_feature.set_has_dot (False)
				insert_in_completion_possibilities (l_feature)
			elseif not feat.is_prefix then
				create l_feature.make (feat)
				if (feat.is_once or feat.is_constant) and preferences.editor_data.once_and_constant_in_upper then
					l_feature.put ((l_feature @ 1).upper, 1)
				end
				insert_in_completion_possibilities (l_feature)
			end
		end

	add_names_to_completion_list (a_analyser: EB_LOCAL_ENTITIES_FINDER; a_current: CLASS_C) is
			-- Adds locals and arguments to completion list and adds 'Current' based on `a_current'
		require
			a_analyser_not_void: a_analyser /= Void
		local
			l_basic: EB_NAME_FOR_COMPLETION
			l_names: DYNAMIC_LIST [STRING]
		do
			create l_basic.make_with_name ("Current")
			insert_in_completion_possibilities (l_basic)
			if a_analyser.has_return_type then
				create l_basic.make_with_name ("Result")
				insert_in_completion_possibilities (l_basic)
			end
			if preferences.editor_data.show_any_features then
				create l_basic.make_with_name ("Void")
				insert_in_completion_possibilities (l_basic)
			end

			l_names := a_analyser.found_names
			if l_names /= Void and then not l_names.is_empty then
				from
					l_names.start
				until
					l_names.after
				loop
					create l_basic.make_with_name (l_names.item)
					insert_in_completion_possibilities (l_basic)

					l_names.forth
				end
			end
		end

feature {NONE} -- Class info analyzer

	go_to_previous_token is
			-- move current token backward if possible
		local
			found: BOOLEAN
			uncomplete_string: BOOLEAN
		do
			if current_token /= Void then
				from
					if is_string (current_token) and then not current_token.image.is_empty then
							-- we check if there is a string split on several lines
						if current_token.image @ 1 = '%%' then
							uncomplete_string := True
						end
					end
						-- we move to previous token, if there is one
					if current_token /= current_line.first_token then
						current_token := current_token.previous
					else
						current_token := current_line.real_first_token
					end
						-- we will go backward until current_token is text (not comment, string, blank or eol)
				until
					current_token = Void or else current_token = current_line.real_first_token or found
				loop
					if current_token.is_text and then not is_comment (current_token) then
							-- it is a text token

						if uncomplete_string then
								-- a string is split on several lines
								-- we skip its beginning
							if is_string (current_token) then
								uncomplete_string := False
							end
							if current_token /= current_line.first_token then
								current_token := current_token.previous
							else
								current_token := current_line.real_first_token
							end
						else
							if is_string (current_token) and then not current_token.image.is_empty then
									-- we check if a string is split on several lines
								if current_token.image @ 1 = '%%' then
									uncomplete_string := True
								else
										-- if the string is on one lines, we skip it
									if current_token /= current_line.first_token then
										current_token := current_token.previous
									else
										current_token := current_line.real_first_token
									end
								end
							else
									-- if current_token is text but not comment or string, it is interesting
									-- we stop
								found := true
							end
						end
					else
							-- we skip all the token which are not interesting
						if current_token /= current_line.first_token then
							current_token := current_token.previous
						else
							current_token := current_line.real_first_token
						end
					end
				end
			end
		end

	go_to_next_token is
			-- move current token forward if possible
		local
			found: BOOLEAN
			uncomplete_string: BOOLEAN
		do
			if current_token /= Void then
				from
					if is_string (current_token) and then not current_token.image.is_empty then
							-- we check if there is a string split on several lines
						if current_token.image @ current_token.image.count = '%%' then
							uncomplete_string := True
						end
					end
						-- we move to previous token, if there is one
					if current_token.next /= Void then
						current_token := current_token.next
					else
						current_token := current_line.eol_token
					end
						-- we will go backward until current_token is text (not comment, string, blank or eol)
				until
					current_token = Void or else current_token = current_line.eol_token or found
				loop
					if current_token.is_text and then not is_comment (current_token) then
							-- it is a text token
						if uncomplete_string then
								-- a string is split on several lines
								-- we skip its beginning
							if is_string (current_token) then
								uncomplete_string := False
							end
							if current_token.next /= Void then
								current_token := current_token.next
							else
								current_token := current_line.eol_token
							end
						else
							if is_string (current_token) and then not current_token.image.is_empty then
									-- we check if a string is split on several lines
								if current_token.image @ 1 = '%%' then
									uncomplete_string := True
								else
										-- if the string is on one lines, we skip it
									if current_token.next /= Void then
										current_token := current_token.next
									else
										current_token := current_line.eol_token
									end
								end
							else
									-- if current_token is text but not comment or string, it is interesting
									-- we stop
								found := true
							end
						end
					else
							-- we skip all tokens which are not interesting
						if current_token.next /= Void then
							current_token := current_token.next
						else
							current_token := current_line.eol_token
						end
					end
				end
			end
		end

	after_searched_token: BOOLEAN is
			-- is `current_token' after `searched_token' ?
			-- We only care about one line.
			-- True if current_token is Void.
		do
			if current_token = Void then
				Result := True
			else
				Result := (current_token.position > searched_token.position)
			end
		end

feature {NONE} -- Build completion possibilities

	stone_at_position (cursor: TEXT_CURSOR): STONE is
			-- Return stone associated with position pointed by `cursor', if any
			-- Do nothing.
		do
		end

	update is
			--
		do

		end

	reset is
			--
		do
			Precursor
			watching_line := Void
			completion_possibilities := Void
			class_completion_possibilities := Void
			is_prepared := false
			provide_features := false
			provide_classes := false
		end

	insertion_cell: CELL [STRING]
			-- strings to be partially completed : the first one is the dot or tilda if there is one
			-- the second one is the feature name to be completed

	build_class_completion_list is
			-- create the list of completion possibilities for the position
			-- associated with `cursor'
		local
			cname				: STRING
			clusters			: ARRAYED_LIST [CLUSTER_I]
			class_list			: ARRAYED_LIST [EB_NAME_FOR_COMPLETION]
			classes				: HASH_TABLE [CLASS_I, STRING]
			token				: EDITOR_TOKEN
			show_all	: BOOLEAN
			class_name			: EB_CLASS_FOR_COMPLETION
			name_name			: EB_NAME_FOR_COMPLETION
			cnt, i				: INTEGER
			l_saved_token: EDITOR_TOKEN
		do
			insertion_cell.put ("")
			is_create := False
			class_completion_possibilities := Void
			token := text_field.current_token_in_line (watching_line)
			l_saved_token := token
			if workbench.is_already_compiled and then (not workbench.is_compiling) and then token /= Void then
				token := token.previous
				if
					(token.image.is_equal (Opening_brace) or token.image.is_equal (colon)) and then can_attempt_auto_complete_from_token (token)
				then
					show_all := True
				else
					if token /= Void and then token.is_text then
						insertion_cell.put (token.image)
					end
				end
			end
				cname := ""
				from
					create class_list.make (100)
					clusters := Universe.clusters
					clusters.start
				until
					clusters.after
				loop
					if show_all then
						from
							classes := clusters.item.classes
							classes.start
						until
							classes.after
						loop
							create class_name.make (classes.item_for_iteration)
						 	class_list.extend (class_name)
							classes.forth
						end
					else
						from
							classes := clusters.item.classes
							classes.start
						until
							classes.after
						loop
							if matches (classes.key_for_iteration, cname) then
								create class_name.make (classes.item_for_iteration)
							 	class_list.extend (class_name)
							end
							classes.forth
						end
					end
					clusters.forth
				end

				cnt := class_list.count
				if current_class_as /= Void and then current_class_as.generics /= Void then
					create class_completion_possibilities.make (1, current_class_as.generics.count + cnt)
					from
						current_class_as.generics.start
					until
						current_class_as.generics.after
					loop
						create name_name.make_with_name (current_class_as.generics.item.name)
						class_list.put_front (name_name)
						current_class_as.generics.forth
					end
				end

				if cnt > 0 then
					if class_completion_possibilities = Void then
						create class_completion_possibilities.make (1, cnt)
					else
						cnt := class_list.count
					end
					from
						i := 1
						class_list.start
					until
						i > cnt
					loop
						class_completion_possibilities.put (class_list.item, i)
						i := i + 1
						class_list.forth
					end
					class_completion_possibilities.sort
				end
				reset_after_search
				calculate_insertion (l_saved_token)
		end

	matches (str, pat: STRING): BOOLEAN is
			-- Is `pat' the beginning of `str'?
		require
			valid_strings: str /= Void and pat /= Void
		local
			i: INTEGER
			minc: INTEGER
			pat_area, str_area: SPECIAL [CHARACTER]
		do
			str_area := str.area
			pat_area := pat.area
			minc := pat.count
			if str.count >= minc then
				from
					Result := True
				until
					i = minc or not Result
				loop
					Result := (pat_area.item (i)) = (str_area.item (i))
					i := i + 1
				end
			end
		ensure
			Result = str.substring (1, pat.count).is_equal (pat)
		end

	build_completion_list is
			-- create the list of completion possibilities for the position
			-- associated with `cursor'
		require
			is_prepared: is_prepared
		local
			token				: EDITOR_TOKEN
			feat_table			: E_FEATURE_TABLE
			feat				: E_FEATURE
			cls_c				: CLASS_C
			crtrs				: HASH_TABLE [EXPORT_I, STRING]
			externals			: ARRAYED_LIST [E_FEATURE]
			show_any_features	: BOOLEAN
			l_current_class_c	: CLASS_C
			l_saved_token: EDITOR_TOKEN
		do
			insertion_cell.put ("")
			is_create := False
			is_static := False
			create completion_possibilities.make (1, 30)
			cp_index := 1
			initialize_context
			l_saved_token := text_field.current_token_in_line (watching_line)
			if current_class_i /= Void and then current_class_i.is_compiled then
				l_current_class_c := current_class_i.compiled_class
				token := text_field.current_token_in_line (watching_line)
				if token /= Void then
					cls_c := class_c_to_complete_from (token, watching_line, l_current_class_c, False, False)

					if exploring_current_class then
						set_up_local_analyzer (watching_line, token, l_current_class_c)
						add_names_to_completion_list (Local_analyzer, l_current_class_c)
						local_analyzer.reset
					end
				end

					-- Build the completion list based on data mined from
				if cls_c /= Void and then cls_c.has_feature_table then
					feat_table := cls_c.api_feature_table
					if is_create then
							-- Creators
						crtrs := cls_c.creators
						if crtrs /= Void then
							from
								crtrs.start
							until
								crtrs.after
							loop
								if
									feat_table.has (crtrs.key_for_iteration) and then
									crtrs.item_for_iteration.is_exported_to (l_current_class_c)
								then
									add_feature_to_completion_possibilities	(feat_table.item (crtrs.key_for_iteration))
								end
								crtrs.forth
							end
						end
					elseif is_static then
							-- Externals
						externals := external_features (cls_c)
						show_any_features := 	preferences.editor_data.show_any_features
													or else
												cls_c.name_in_upper.is_equal (Any_name)
						if externals /= Void then
							from
								externals.start
							 until
								externals.after
							loop
							feat := externals.item
							if
								(exploring_current_class or else feat.is_exported_to (l_current_class_c)) and then
								(show_any_features or else not feat.written_class.name_in_upper.is_equal (Any_name))
							then
								add_feature_to_completion_possibilities (feat)
							end
								externals.forth
							end
						end
					else
						show_any_features := preferences.editor_data.show_any_features or else cls_c.name_in_upper.is_equal (Any_name)
						from
							feat_table.start
						until
							feat_table.after
						loop
							feat := feat_table.item_for_iteration
							if
								(exploring_current_class or else feat.is_exported_to (l_current_class_c)) and then
								(show_any_features or else not feat.written_class.name_in_upper.is_equal (Any_name)) and then
								(not feat.is_infix and not feat.is_prefix)
							then
								add_feature_to_completion_possibilities (feat)
							end
							feat_table.forth
						end
					end
				end

					-- Reset and sort matches
				reset_after_search
				if cp_index = 1 then
					completion_possibilities := Void
				else
					completion_possibilities := completion_possibilities.subarray (1, cp_index - 1)
					completion_possibilities.sort
				end
			end
		end

	class_c_to_complete_from (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE; a_compiled_class: CLASS_C; recurse, two_back: BOOLEAN): CLASS_C is
			-- Class type to complete on from `token'
		local
			prev_token: EDITOR_TOKEN
			type: TYPE_A
			gone_back_two: BOOLEAN
			token: EDITOR_TOKEN
--			old_token: EDITOR_TOKEN
			old_position: INTEGER
			l_swapped: BOOLEAN
		do
			token := a_token
			if token /= Void then
					-- Restore faked cursor position so we can complete before '.'
				if token.image.is_equal (".") then
--					old_token := text_field.current_token_in_line (a_line)
					old_position := text_field.caret_position
					text_field.set_caret_position (text_field.caret_position - 1)
					token := text_field.current_token_in_line (a_line)
					l_swapped := True
				end
			end

			exploring_current_class := False
			if can_attempt_auto_complete_from_token (token) then
				if token.is_text then
						-- The cursor is in a text token so we complete based upon the previous token.					
					prev_token := token.previous
					if prev_token /= Void then
						if token_image_is_in_array (token, Feature_call_separators) then
								-- Token is dot or tilda					
							is_create := create_before_position (a_line, prev_token)
							is_static := static_call_before_position (a_line, prev_token)
							is_parenthesized := parenthesized_before_position (a_line, prev_token)
						elseif token_image_is_in_array (prev_token, Feature_call_separators) then
							Result := class_c_to_complete_from (prev_token, a_line, a_compiled_class, True, two_back)
						elseif prev_token.is_text and not two_back then
							gone_back_two := True
							Result := class_c_to_complete_from (prev_token, a_line, a_compiled_class, True, True)
						else
							exploring_current_class := True
						end
					end
				else
						-- The token is not text but we can try to autocomplete.
						-- It must be a space, or tab or end of line something like that so take the previous
						-- token to determine context
					if token.previous /= Void then
						Result := class_c_to_complete_from (token.previous, a_line, a_compiled_class, True, True)
					else
							-- Context unknown, assume current class
						exploring_current_class := True
					end

				end
			end
			if l_swapped = True then
					-- Restore faked cursor position so we can complete before '.'
					-- User is completing before '.'
				text_field.set_caret_position (old_position)
				token := text_field.current_token_in_line (a_line)
			end

			if Result = Void then
				if exploring_current_class then
					Result := a_compiled_class
				elseif prev_token /= Void and not is_create and not is_static and not is_parenthesized then
--					current_feature_as := feature_containing (prev_token, cursor.line)
					type := type_from (prev_token, a_line)
					if type /= Void then
						Result := type.associated_class
					end
				elseif is_create then
					if found_class /= Void then
							-- Looks like it was a creation expression since `found_class' was computed.
						Result := found_class
					else
							-- Looks like it was a creation instruction since `found_class' was not set.
--						current_feature_as := feature_containing (prev_token, cursor.line)
						type := type_from (prev_token, a_line)
						if type /= Void then
							Result := type.associated_class
						end
					end
				elseif is_static or is_parenthesized then
					Result := found_class
				end
			end

			if not recurse then
				calculate_insertion (token)
			end
		end

	calculate_insertion (token: EDITOR_TOKEN) is
			--
		local
			prev_token: EDITOR_TOKEN
			l_char: CHARACTER
			pos_in_token: INTEGER
		do
			insertion_remainder := 0
			insertion_cell.put ("")
			pos_in_token := text_field.position_in_token
			if can_attempt_auto_complete_from_token (token) then
				if token.is_text or token.is_blank then
						-- The cursor is in a text token so we complete based upon the previous token unless the cursor
						-- is somewhere inside this token..
					prev_token := token.previous

					if prev_token /= Void and pos_in_token = 1 then
						if prev_token.is_text and then token_image_is_in_array (prev_token, Feature_call_separators) then
								-- Previous token is a separator so take there is no insertion term
							l_char := token.image.item (1)
							if l_char.is_alpha then
									-- Happens when completing 'a.b.|c'
								insertion_remainder := token.image.count
							else
									-- Happens when completing 'a.b.|)'
							end
						elseif token_image_is_in_array (token, Feature_call_separators) then
							if prev_token.is_text then
									-- Token is a separator so take the entire previous token as insertion, if it is an Eiffel identifier							
								l_char := prev_token.image.item (prev_token.image.count)
								if l_char.is_alpha or l_char.is_digit or l_char = '_' then
										-- Previous token is an Eiffel identifier
										-- Happens when completing 'a.b|.c'
									insertion_cell.put (prev_token.image)
								else
										-- Happens when completing '|.b.c' or '(|.b.c)'
								end
							end
						else
							if token.is_blank and not prev_token.is_blank then
									-- Previous token is a partially completed term.
									-- Happens when completing 'a.b.c| '
								if not prev_token.image.is_empty then
									l_char := prev_token.image.item (prev_token.image.count)
									if l_char.is_alpha or l_char.is_digit or l_char = '_' then
											-- Previous token is an Eiffel identifier
										insertion_cell.put (prev_token.image)
									end
								end
--							elseif prev_token.is_blank then
--									-- There is blank or a token separator before cursor
--									-- Happens when completing ' |a.b.c'
--									-- Note: This code is commented out because completion should add the select item before
--									--       'a' and not overwrite 'a'
--								insertion_remainder := token.image.count
							elseif token.is_text and prev_token.is_text then
									-- Happens when you completer '(a.b.c|)'
									-- Also happens for '(|a.b.c)' but we do not want to replace the open parenthesis or 'a' (see previous rule)
								if not prev_token.image.is_empty then
									l_char := prev_token.image.item (prev_token.image.count)
									if l_char.is_alpha or l_char.is_digit or l_char = '_' then
											-- Previous token is an Eiffel identifier
										insertion_cell.put (prev_token.image)
									end
								end
									-- Uncomment to have 'a' be replaced when completing '(|a.b.c)'
--								if not token.image.is_empty then
--									l_char := token.image.item (token.image.count)
--									if l_char.is_alpha then
--											-- Token is an Eiffel identifier
--										insertion_remainder := token.image.count		
--									end
--								end
							end
						end
					elseif pos_in_token > 1 then
							-- Cursor is current in a token at `cursor.pos_in_token'
						if not token.is_blank then
								-- Happens when completing 'a.bb|bbbb.c'						
							insertion_cell.put (token.image.substring (1, pos_in_token - 1))
							insertion_remainder := token.length - (pos_in_token - 1)
						else
							-- Happens when completing 'if | then'
						end
					else
						check
							not_reachable: False
						end
					end
				else
						-- The token is not text so the insertion must be taken from the previous token IF that is text
					prev_token := token.previous
					if prev_token /= Void and then prev_token.is_text and then not token_image_is_in_array (prev_token, feature_call_separators) then
						l_char := prev_token.image.item (prev_token.image.count)
						if l_char.is_alpha or l_char.is_digit or l_char = '_' then
								-- Previous token is an Eiffel identifier
								-- Happens when completing 'p|'
							insertion_cell.put (prev_token.image)
							insertion_remainder := 0
						else
								-- Happens when completing ')|.b.c'
						end
					end
				end
			end
		end

	parenthesized_before_position (a_line: EDITOR_LINE; a_token: EDITOR_TOKEN): BOOLEAN is
			-- Is feature call made on parenthesized expression?  If so determine type of parenthesized expression and put in
			-- `found_class'.  If cannot evaluate expression `found_class' will be Void.
		local
			line: EDITOR_LINE
			token,
			par_token: EDITOR_TOKEN
			par_cnt: INTEGER
			blnk: EDITOR_TOKEN_BLANK
			type: TYPE_A
		do
			line := a_line
			token := a_token
			if token_image_is_same_as_word (token, closing_parenthesis) then
				Result := True
				from
	        		par_cnt := 1
				until
					token = Void or par_cnt = 0
	 			loop
					token := token.previous
					if token_image_is_same_as_word (token , closing_parenthesis) then
						par_cnt := par_cnt + 1
					elseif token_image_is_same_as_word (token , opening_parenthesis) then
						par_cnt := par_cnt - 1
	 				end
				end

	 			if token /= Void then -- token = "("
	 				par_token := token
	 				from
						blnk ?= token.previous
					until
						blnk = Void
					loop
						token := blnk
						blnk ?= token.previous
					end
						-- token.previous is not blank : either feature name or line or expression beginning
					if is_beginning_of_expression (token.previous) then
						token := par_token
					else
						token := token.previous
					end
				end
	            if token /= Void then
--	            	current_feature_as := feature_containing (token, a_cursor.line)
	            	type := type_from (token, line)
	            	if type /= Void then
		            	found_class := type.associated_class
		            end
	            end
            end
		end

			create_before_position (a_line: EDITOR_LINE; a_token: EDITOR_TOKEN): BOOLEAN is
			-- is "create" preceeding current position ?
		local
			line: EDITOR_LINE
			token: EDITOR_TOKEN
			par_cnt: INTEGER
		do
			line := current_line
			current_line := a_line
			token := current_token
			current_token := a_token
			go_to_previous_token
			Result := token_image_is_same_as_word (current_token, Create_word)
			if not Result and then token_image_is_same_as_word (current_token, closing_brace) then
				from
					par_cnt := 1
				until
					par_cnt = 0 or else current_token = Void
				loop
					go_to_previous_token
					if token_image_is_same_as_word (current_token, Opening_brace) then
						par_cnt:= par_cnt - 1
					elseif token_image_is_same_as_word (current_token, Closing_brace) then
						par_cnt:= par_cnt + 1
					end
				end
				go_to_next_token
				error := error or else current_token = Void or else type_of_class_corresponding_to_current_token = Void
				if not error then
					go_to_previous_token
					go_to_previous_token
					Result := token_image_is_same_as_word (current_token, Create_word)
				end
			end
			current_token := token
			current_line := line
		end

	static_call_before_position (a_line: EDITOR_LINE; a_token: EDITOR_TOKEN): BOOLEAN is
			-- Is "feature" preceeding current position ?
		local
			line: EDITOR_LINE
			token: EDITOR_TOKEN
			par_cnt: INTEGER
		do
			line := current_line
			current_line := a_line
			token := current_token
			current_token := a_token
			if token_image_is_same_as_word (current_token, Closing_brace) then
				from
					par_cnt := 1
				until
					par_cnt = 0 or else current_token = Void
				loop
					go_to_previous_token
					if token_image_is_same_as_word (current_token, Opening_brace) then
						par_cnt:= par_cnt - 1
					elseif token_image_is_same_as_word (current_token, Closing_brace) then
						par_cnt:= par_cnt + 1
					end
				end
				go_to_next_token
				error := error or else current_token = Void or else type_of_class_corresponding_to_current_token = Void
				if not error then
					Result := True
				end
			end
			current_token := token
			current_line := line
		end


	type_from (token: EDITOR_TOKEN; line: EDITOR_LINE): TYPE_A is
			-- try to analyze class text to find type associated with word represented by `token'
		require
			token_not_void: token /= Void
			line_not_void: line /= Void
			token_in_line: line.has_token (token)
			current_class_i_not_void: current_class_i /= Void
			current_class_i_compiled: current_class_i.is_compiled
		do
			current_token := token
			searched_token := token
			current_line := line
			searched_line := line
			error := False
			find_expression_start
			if not error then
				Result := searched_type
			end
		end

	searched_type: TYPE_A is
			-- analyze class text from `current_token' to find type associated with `searched_token'
		require
			current_class_i_not_void: current_class_i /= Void
			current_class_i_compiled: current_class_i.is_compiled
		local
			exp: LINKED_LIST [EDITOR_TOKEN]
			name: STRING
			par_cnt: INTEGER
			processed_class: CLASS_C
			type: TYPE_A
			formal: FORMAL_A
			feat: E_FEATURE
			l_current_class_c: CLASS_C
		do
			from
				l_current_class_c := current_class_i.compiled_class
				Result := l_current_class_c.actual_type
				if token_image_is_same_as_word (current_token, "create") then
					go_to_next_token
					is_create := True
					error := not token_image_is_same_as_word (current_token, "{")
					if not error then
						go_to_next_token
						error := current_token = Void
						if not error then
							Result := type_of_class_corresponding_to_current_token
							skip_parenthesis ('{', '}')
						end
					end
				elseif token_image_is_same_as_word (current_token, "(") then
						-- if we find a closing parenthesis, we go directly to the corresponding
						-- opening parenthesis
					par_cnt:= 1
					from
						create exp.make
					until
						par_cnt = 0 or else current_token = Void
					loop
						go_to_next_token
						exp.extend (current_token)
						if token_image_is_same_as_word (current_token, ")") then
							par_cnt:= par_cnt - 1
						elseif token_image_is_same_as_word (current_token, "(") then
							par_cnt:= par_cnt + 1
						end
					end
					if current_token = Void then
						error := True
					else
						if exp.count > 0 then
							exp.finish
							exp.remove
						end
						Result := complete_expression_type (exp)
					end
				else
					name := current_token.image.as_lower
					if name.is_equal ("precursor") then
						go_to_next_token
						if token_image_is_same_as_word (current_token, "{") then
							go_to_next_token
							error := error or else current_token = Void
							if not error then
								Result := type_of_class_corresponding_to_current_token
								skip_parenthesis ('{', '}')
								if Result /= Void and then Result.associated_class /= Void then
									if Result.associated_class.has_feature_table then
										feat := Result.associated_class.feature_with_name (current_feature_as.feature_name)
									end
								end
							end
						else
							go_to_previous_token
							if current_feature_as /= Void and then l_current_class_c.parents /= Void then
								from
									l_current_class_c.parents.start
								until
									feat /= Void or else l_current_class_c.parents.after
								loop
									type := l_current_class_c.parents.item
									if type.associated_class /= Void and then type.associated_class.has_feature_table then
										feat := type.associated_class.feature_with_name (current_feature_as.feature_name)
									end
									l_current_class_c.parents.forth
								end
							end
						end
					else
						if l_current_class_c.has_feature_table then
							feat := l_current_class_c.feature_with_name (name)
						end
						is_create := create_before_position (current_line, current_token)
					end
					if feat = Void then
							-- Could not find feature, may be a local or argument
						Result := type_of_local_entity_named (name)
						if Result = Void then
							Result := type_of_constants_or_reserved_word (current_token)
						end
					else
							-- Found feature						
						error := True
						Result := feat.type
					end

					if Result /= Void then
						if Result.is_like and then Result.actual_type.is_formal then
								-- Get type from like formal
							Result := Result.actual_type
						end
						if Result.is_formal then
							formal ?= Result
							Result := type_from_formal_type (l_current_class_c, formal)
						end
						error := False
					end
				end
				go_to_next_token
				if not error and then token_image_is_same_as_word (current_token, "(") then
					skip_parenthesis ('(', ')')
					go_to_next_token
				end
				if not error then
					if after_searched_token then
						error := Result = Void
					else
						error := Result = Void or else not token_image_is_in_array (current_token, feature_call_separators)
						go_to_next_token
					end
				end
			until
				error or else after_searched_token
			loop
				name := current_token.image.as_lower
				processed_class := Result.associated_class
				error := True
				if processed_class /= Void and then processed_class.has_feature_table then
					feat := processed_class.feature_with_name (name)
					if feat /= Void then
						if feat.type /= Void then
							type := feat.type
							if type.is_formal then
								formal ?= type
								if
									Result /= Void and then
									Result.has_generics and then
									Result.generics.valid_index (formal.position)
								then
									Result := Result.generics.item (formal.position)
									error := False
								end
							else
								Result := type
								error := False
							end
						end
					end
				end
				go_to_next_token
				if token_image_is_same_as_word (current_token, "(") then
					skip_parenthesis ('(', ')')
					go_to_next_token
				end
				error := error or else not (after_searched_token or else token_image_is_same_as_word (current_token, "."))
				is_create := is_create and then after_searched_token
				go_to_next_token
			end
			if error then
				Result := Void
			end
		end

	type_from_formal_type (a_class_c: CLASS_C; a_formal: FORMAL_A): TYPE_A is
			-- For `_a_class_c' get actual type of `a_formal'.
		do
			if
				a_class_c /= Void and then
				a_class_c.generics /= Void and then
				a_class_c.generics.valid_index (a_formal.position)
			then
				Result := a_class_c.constraint (a_formal.position)
			end
		end

	set_up_local_analyzer (a_line: EDITOR_LINE; a_token: EDITOR_TOKEN; a_class_c: CLASS_C) is
			--
		local
			l_analyzer: EB_LOCAL_ENTITIES_FINDER_FROM_AST
		do
			l_analyzer ?= local_analyzer
			if l_analyzer = Void then
				create l_analyzer.make
				local_analyzer_cell.put (l_analyzer)
			end
			if context_feature_as /= Void then
				l_analyzer.build_entities_list (context_feature_as)
			end
		end

	static: BOOLEAN

	is_create: BOOLEAN

	is_static: BOOLEAN

	is_parenthesized: BOOLEAN

	exploring_current_class: BOOLEAN

	watching_line: EDITOR_LINE

	Any_name: STRING is "ANY"

	cp_index: INTEGER

invariant
	invariant_clause: True -- Your invariant here

end
