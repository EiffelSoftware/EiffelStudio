indexing
	description: "Code completion info analyzer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_COMPLETE_INFO_ANALYZER

inherit
	EB_CLASS_INFO_ANALYZER

	EB_SHARED_PREFERENCES

	SHARED_TEXT_ITEMS

	EB_SHARED_WRITER

feature -- Access

	features_position: ARRAYED_LIST [TUPLE [start_pos: INTEGER; end_pos:INTEGER]]
			-- array of features position in class text

	features_ast: ARRAYED_LIST [TUPLE [feat_as: FEATURE_AS; name: FEATURE_NAME]]
			-- array of feature_as corresponding to positions in `features_position'

feature -- Completion access

	insertion: CELL [STRING]
			-- strings to be partially completed : the first one is the dot or tilda if there is one
			-- the second one is the feature name to be completed

	insertion_count: INTEGER is
			-- length of the feature name to be completed
		require
			insertion_not_void: insertion /= Void
			feature_name_exists: not insertion.item.is_empty
		do
			Result := insertion.item.count
		end

	insertion_remainder: INTEGER
			-- The number of characters in the insertion remaining from the cursor position to the
			-- end of the token

	exploring_current_class: BOOLEAN
			-- was automatic completion called after a blank space ?

	completion_possibilities: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION]
			-- completion possibilities for the current position in the editor

feature -- Basic operations

	reset_completion_list is
			-- Reset completion possibilities
		do
			completion_possibilities := Void
		end

	build_completion_list (a_cursor_token: EDITOR_TOKEN) is
			-- create the list of completion possibilities for the position
			-- associated with `cursor'
		require
			cursor_token_not_void: a_cursor_token /= Void
		local
			token				: EDITOR_TOKEN
			feat_table			: E_FEATURE_TABLE
			feat_i_table		: FEATURE_TABLE
			feat				: E_FEATURE
			l_class_list		: LIST[CLASS_C]
			cls_c				: CLASS_C
			crtrs				: HASH_TABLE [EXPORT_I, STRING]
			externals			: ARRAYED_LIST [E_FEATURE]
			show_any_features	: BOOLEAN
			l_current_class_c	: CLASS_C
			l_class_as          : CLASS_AS
			l_named_tuple_type	: NAMED_TUPLE_TYPE_A
			l_has_renaming		: BOOLEAN
			l_constraints		: TYPE_SET_A
		do
			if is_ok_for_completion then
				create insertion
				insertion.put ("")
				is_create := False
				is_static := False
				last_type := Void
				last_constraints := Void
				last_target_type := Void
				last_formal := Void
				last_was_constrained := False
				last_was_multi_constrained := False
				create completion_possibilities.make (1, 30)
				create inserted_feature_table.make (30)
				cp_index := 1
				initialize_context
				token_writer.set_context_group (group)
				if current_class_i /= Void and then current_class_c /= Void then
					l_current_class_c := current_class_c
					token := cursor_token
					if token /= Void then
						l_class_list := class_c_to_complete_from (token, current_line, l_current_class_c, False, False)

						if exploring_current_class then
							set_up_local_analyzer (current_line, token, l_current_class_c)
							add_names_to_completion_list (Local_analyzer, l_current_class_c)

								-- Add precursors
							l_class_as := l_current_class_c.ast
							if l_class_as /= Void and current_feature_as /= Void  then
								add_precursor_possibilities (l_class_as, current_feature_as.feat_as)
							end
							local_analyzer.reset
						end
					end
					if l_class_list /= Void then
						if last_was_multi_constrained then
							check
								last_constraints_not_void: last_constraints /= Void
							end
							l_constraints := last_constraints
							l_has_renaming := extend_types_has_renaming (l_constraints)
						end
						from
							l_class_list.start
						until
							l_class_list.after
						loop

							cls_c := l_class_list.item
								-- Build the completion list based on data mined from
							if cls_c /= Void and then cls_c.has_feature_table then

									-- Add named tuple generics.
									-- A class c should have been found.
								l_named_tuple_type ?= last_type
								if l_named_tuple_type /= Void then
									add_named_tuple_generics (l_named_tuple_type)
								end

								feat_table := cls_c.api_feature_table
								feat_i_table := cls_c.feature_table
								if feat_i_table.overloaded_names /= Void then
									build_overload_list := True
								else
									build_overload_list := False
								end

								if is_create then
									if last_was_constrained then
										add_generics_creation_list (cls_c)
									else
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
													feat := feat_table.item (crtrs.key_for_iteration)
													if l_has_renaming then
														add_renaming_to_completion_possibilities (feat, l_constraints, cls_c)
													else
														add_feature_to_completion_possibilities	(feat)
													end
												end
												crtrs.forth
											end
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
											if l_has_renaming then
												add_renaming_to_completion_possibilities (feat, l_constraints, cls_c)
											else
												add_feature_to_completion_possibilities	(feat)
											end
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
											if l_has_renaming then
												add_renaming_to_completion_possibilities (feat, l_constraints, cls_c)
											else
												add_feature_to_completion_possibilities	(feat)
											end
										end
										feat_table.forth
									end
								end
							end
							l_class_list.forth
							if build_overload_list and then cls_c /= Void then
								build_in_overload_feature (cls_c)
							end
						end
					end
						-- Reset and sort matches
					if cp_index = 1 then
						completion_possibilities := Void
					else
						completion_possibilities := completion_possibilities.subarray (1, cp_index - 1)
						completion_possibilities.sort
					end
					reset_after_search
				end
			end
		end

feature -- Internal access

	inserted_feature_table: HASH_TABLE [E_FEATURE, INTEGER]

	cp_index: INTEGER

	Any_name: STRING is "ANY";

	current_pos_in_token: INTEGER is
			--
		deferred
		end

	save_cursor_position is
			--
		deferred
		end

	retrieve_cursor_position is
			--
		deferred
		end

feature {NONE} -- Private Status

	is_static: BOOLEAN
			-- was auto-complete called after "feature {class}" ?

	is_parenthesized: BOOLEAN
			-- was auto-complete called after parenthesis "(feature.function_call)." ?

	found_agent_keyword: BOOLEAN
			-- was auto-complete called after "agent {CLASS}"?

	build_overload_list: BOOLEAN

	extend_types_has_renaming (a_type_set: TYPE_SET_A): BOOLEAN is
			-- Do renamings exist in `a_type_set'?
		local
			l_renamed_type: RENAMED_TYPE_A [TYPE_A]
		do
			if a_type_set /= Void then
				from
					a_type_set.start
				until
					a_type_set.after or Result
				loop
					l_renamed_type := a_type_set.item
					if l_renamed_type.renaming /= Void then
						Result := True
					end
					a_type_set.forth
				end
			end
		end

	search_renamed_features_from_generics (a_type_set: TYPE_SET_A): HASH_TABLE [INTEGER, INTEGER] is
			-- Search renamed features from generics.
		require
			current_class_c_not_void: current_class_c /= Void
			a_type_set_not_void: a_type_set /= Void
		local
			l_feat_table: E_FEATURE_TABLE
			l_feature: E_FEATURE
			l_found_feat_id, l_feat_id, l_name_id: INTEGER
			l_renaming: RENAMING_A
			l_stop : BOOLEAN
		do
			l_feat_table := current_class_c.api_feature_table
			create Result.make (4)
			from
				l_feat_table.start
			until
				l_feat_table.after
			loop
				from
					l_feature := l_feat_table.item_for_iteration
					l_feat_id := l_feature.feature_id
					l_name_id := l_feature.name_id
					l_stop := False
					l_found_feat_id := -1
					a_type_set.start
				until
					a_type_set.after or l_stop
				loop
					l_renaming := a_type_set.item.renaming
					if l_renaming /= Void and then l_renaming.is_feature_renamed_by_name_id (l_name_id) then
						l_found_feat_id := l_renaming.renamed (l_feat_id)
						l_stop := l_found_feat_id /= l_feat_id
					end
					a_type_set.forth
				end
				if l_stop then
					Result.force (l_found_feat_id, l_found_feat_id)
				end
				l_feat_table.forth
			end
		end

feature -- Class names completion

	build_class_completion_list (a_token: EDITOR_TOKEN) is
			-- create the list of completion possibilities for the position
			-- associated with `cursor'
		require
			a_token_not_void: a_token /= Void
			group_not_void: group /= Void
		local
			cname				: STRING
			class_list			: ARRAYED_LIST [EB_NAME_FOR_COMPLETION]
			classes				: HASH_TABLE [CONF_CLASS, STRING]
			token				: EDITOR_TOKEN
			show_all	: BOOLEAN
			class_name			: EB_CLASS_FOR_COMPLETION
			name_name			: EB_NAME_FOR_COMPLETION
			cnt, i				: INTEGER
			l_class_i			: CLASS_I
		do
			create insertion
			insertion.put ("")
			is_create := False
			class_completion_possibilities := Void
			token_writer.set_context_group (group)
			build_overload_list := False
			if workbench.is_already_compiled and then (not workbench.is_compiling) then
				token := a_token.previous
				if
					(token.image.is_equal (Opening_brace) or token.image.is_equal (colon)) and then can_attempt_auto_complete_from_token (token)
				then
					show_all := True
				else
					if token /= Void and then token.is_text then
						insertion.put (token.image)
					end
				end
			end
			cname := ""
			classes := group.accessible_classes
			create class_list.make (100)
			from
				classes.start
			until
				classes.after
			loop
				l_class_i ?= classes.item_for_iteration
				if show_all then
					create class_name.make (l_class_i)
				 	class_list.extend (class_name)
				else
					if matches (classes.key_for_iteration, cname) then
						create class_name.make (l_class_i)
					 	class_list.extend (class_name)
					end
				end
				classes.forth
			end

			cnt := class_list.count
			if current_class_as /= Void and then current_class_as.generics /= Void then
				create class_completion_possibilities.make (1, current_class_as.generics.count + cnt)
				from
					current_class_as.generics.start
				until
					current_class_as.generics.after
				loop
					create name_name.make (current_class_as.generics.item.name.name)
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
			calculate_insertion (a_token)
		end

	class_completion_possibilities: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION]
			-- completion possibilities for the class name at current position in the editor.

feature {NONE} -- Implementation

	go_to_left_position is
			--
		deferred
		end

	cursor_token: EDITOR_TOKEN is
			-- Token at cursor position
		deferred
		end

	class_c_to_complete_from (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE a_compiled_class: CLASS_C; recurse, two_back: BOOLEAN): LIST[CLASS_C] is
			-- Class type to complete on from `token'
		local
			prev_token: EDITOR_TOKEN
			type: TYPE_A
			gone_back_two: BOOLEAN
			token: like a_token
			l_swapped: BOOLEAN
			l_create_token: EDITOR_TOKEN
		do
			token := a_token
			if token /= Void then
					-- Restore faked cursor position so we can complete before '.'
				if token.image.is_equal (".") then
					save_cursor_position
					go_to_left_position
					token := cursor_token
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
							is_create := create_before_position (current_line, prev_token)
							if is_create then
									-- Fetch create token, used later
								l_create_token := locate_create_before_position (current_line, prev_token)
							end
							is_static := static_call_before_position (current_line, prev_token)
							is_parenthesized := parenthesized_before_position (current_line, prev_token)
						elseif token_image_is_in_array (prev_token, Feature_call_separators) then
							Result := class_c_to_complete_from (prev_token, current_line, a_compiled_class, True, two_back)
						elseif prev_token.is_text and not two_back then
							gone_back_two := True
							Result := class_c_to_complete_from (prev_token, current_line, a_compiled_class, True, True)
						else
							exploring_current_class := True
						end
					end
				else
						-- The token is not text but we can try to autocomplete.
						-- It must be a space, or tab or end of line something like that so take the previous
						-- token to determine context
					if token.previous /= Void then
						Result := class_c_to_complete_from (token.previous, current_line, a_compiled_class, True, True)
					else
							-- Context unknown, assume current class
						exploring_current_class := True
					end

				end
			end
			if l_swapped = True then
					-- Restore faked cursor position so we can complete before '.'
					-- User is completing before '.'
				retrieve_cursor_position
				token := cursor_token
			end

			if Result = Void then
				if exploring_current_class then
					Result := create_class_list_and_insert (a_compiled_class)
				elseif prev_token /= Void and not is_create and not is_static and not is_parenthesized then
					if current_feature_as = Void then
						current_feature_as := feature_containing (prev_token, current_line)
					end
					type := type_from (prev_token, current_line)
					if type /= Void then
						Result := create_class_list_and_insert_associated_classes_from_type (type)
					end
					last_type := type
				elseif prev_token /= Void and is_create then
					if found_class /= Void then
							-- Looks like it was a creation expression since `found_class' was computed.
						Result := create_class_list_and_insert (found_class)
					else
							-- Looks like it was a creation instruction since `found_class' was not set.
						if current_feature_as = Void then
							current_feature_as := feature_containing (prev_token, current_line)
						end
						if prev_token /= Void then
							if is_parenthesized then
								if l_create_token /= Void then
									type := type_from (l_create_token, current_line)
									is_create := False
								end
							else
								type := type_from (prev_token, current_line)
							end

							if type /= Void then
								Result := create_class_list_and_insert_associated_classes_from_type (type)
							end
						end
					end
					last_type := type
				elseif is_static or is_parenthesized or found_agent_keyword then
					if found_class /= Void then
						Result := create_class_list_and_insert (found_class)
					else
							-- Multi constaint case
						if not error and then last_type /= Void then
							Result := create_class_list_and_insert_associated_classes_from_type (last_type)
						end
					end
				end
			end

			if not recurse then
				calculate_insertion (token)
			end
		end

	create_class_list_and_insert (a_compiled_class: CLASS_C): LIST[CLASS_C]
			-- Create new class list and insert `a_compiled_class'
			--
			-- `a_compiled_class' is, if not Void, inserted as first element into the class list directly .
		do
			create {LINKED_LIST[CLASS_C]} Result.make
			if a_compiled_class /= Void then
				Result.force (a_compiled_class)
			end
		ensure
			inserted_if_not_void: a_compiled_class /= Void implies Result.first = a_compiled_class and Result.count = 1
		end

	create_class_list_and_insert_associated_classes_from_type (a_type: TYPE_A): LIST[CLASS_C]
			-- Create new class list and insert all associated classes from `a_type'
			--
			-- `a_type's associated_classes are inserted into the class list of `Result'
		require
			a_type_not_void: a_type /= Void
		local
			l_type_set: TYPE_SET_A
			l_class: CLASS_C
		do
			if a_type.is_type_set then
				l_type_set ?= a_type.actual_type
				Result := l_type_set.associated_classes
			else
				if a_type.has_associated_class then
					l_class := a_type.associated_class
				end
				Result := create_class_list_and_insert (l_class)
			end
		ensure
			create_class_list_and_insert_associated_classes_from_type_not_void: Result /= Void
			at_least_one_element_in_result: Result.count > 0
		end

	add_names_to_completion_list (a_analyser: EB_LOCAL_ENTITIES_FINDER; a_current: CLASS_C) is
			-- Adds locals and arguments to completion list and adds 'Current' based on `a_current'
		require
			a_analyser_not_void: a_analyser /= Void
		local
			l_basic: EB_NAME_FOR_COMPLETION
			l_names: DYNAMIC_LIST [STRING]
		do
			create l_basic.make_token (create {EDITOR_TOKEN_KEYWORD}.make ("Current"))
			insert_in_completion_possibilities (l_basic)
			if a_analyser.has_return_type then
				create l_basic.make_token (create {EDITOR_TOKEN_KEYWORD}.make ("Result"))
				insert_in_completion_possibilities (l_basic)
			end
			if preferences.editor_data.show_any_features then
				create l_basic.make_token (create {EDITOR_TOKEN_KEYWORD}.make ("Void"))
				insert_in_completion_possibilities (l_basic)
			end

			l_names := a_analyser.found_names
			if l_names /= Void and then not l_names.is_empty then
				from
					l_names.start
				until
					l_names.after
				loop
					create l_basic.make (l_names.item)
					insert_in_completion_possibilities (l_basic)
					l_names.forth
				end
			end
		end

	add_feature_to_completion_possibilities (feat: E_FEATURE) is
			-- add the signature of `feat' to `completion_possibilities'
		require
			completion_possibilities_not_void: completion_possibilities /= Void
			feat_is_not_void: feat /= Void
		do
			if not build_overload_list then
				internal_add_feature (feat)
			else
				inserted_feature_table.put (feat, names_heap.id_of (feat.name))
			end
		end

	internal_add_feature (feat: E_FEATURE) is
			-- Internal add feat to `completion_possibilities'
		require
			feat_not_void: feat /= Void
		local
			l_feature: EB_FEATURE_FOR_COMPLETION
		do
			if feat.is_infix then
				create l_feature.make (feat, Void, False)
				l_feature.set_has_dot (False)
				insert_in_completion_possibilities (l_feature)
			elseif not feat.is_prefix then
				create l_feature.make (feat, Void, False)
				if (feat.is_once or feat.is_constant) and preferences.editor_data.once_and_constant_in_upper then
					l_feature.put ((l_feature @ 1).upper, 1)
				end
				insert_in_completion_possibilities (l_feature)
			end
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

	build_in_overload_feature (a_class: CLASS_C) is
			-- Build overload features in possibilities.
		require
			a_class_not_void: a_class /= Void
		local
			l_overloaded_names: HASH_TABLE [ARRAYED_LIST [INTEGER], INTEGER]
			l_features: ARRAYED_LIST [INTEGER]
			l_new_group: BOOLEAN
			feat: E_FEATURE
			l_feature: EB_FEATURE_FOR_COMPLETION
			l_father: EB_NAME_FOR_COMPLETION
			l_father_name: STRING
			l_e_feature: E_FEATURE
		do
			l_overloaded_names := a_class.feature_table.overloaded_names
			if inserted_feature_table /= Void and then not inserted_feature_table.is_empty then
				from
					l_overloaded_names.start
				until
					l_overloaded_names.after
				loop
					l_features := l_overloaded_names.item_for_iteration
					l_new_group := False
					l_father := Void
					from
						l_features.start
					until
						l_features.after
					loop
						if inserted_feature_table.has_key (l_features.item) then
							l_e_feature := inserted_feature_table.found_item
							if not l_new_group then
								l_new_group := True
									-- Create father NAME node
								l_father_name := names_heap.item (l_overloaded_names.key_for_iteration)
								if l_e_feature.type /= Void then
									create {EB_NAME_WITH_TYPE_FOR_COMPLETION}l_father.make (l_father_name, l_e_feature.type, l_e_feature.associated_feature_i)
								else
									create l_father.make (l_father_name)
								end
								insert_in_completion_possibilities (l_father)
							end
								-- Create child node and insert it into father node.
							create l_feature.make (l_e_feature,
													names_heap.item (l_overloaded_names.key_for_iteration),
													True)
							l_father.add_child (l_feature)
								-- Remove child feature from inserted_feature_table.
							inserted_feature_table.remove (l_features.item)
						end
						l_features.forth
					end
					if l_father /= Void then
						l_father.sort_children
					end
					l_overloaded_names.forth
				end
					-- Insert all remaining features from inserted_feature_table into completion_possibilities.
				from
					inserted_feature_table.start
				until
					inserted_feature_table.after
				loop
					feat := inserted_feature_table.item_for_iteration
					internal_add_feature (feat)
					inserted_feature_table.forth
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

	feature_containing (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE): TUPLE [feat_as: FEATURE_AS; name: FEATURE_NAME] is
			-- Feature containing `a_token' in class text.  If token is not in a feature return Void.
		require
			a_token_not_void: a_token /= Void
			features_ast_not_void: features_ast /= Void
		local
			token: EDITOR_TOKEN
			line: EDITOR_LINE
			tfs, tfs2: EDITOR_TOKEN_FEATURE_START
			index: INTEGER
			l_done: BOOLEAN
			l_end_position: INTEGER
		do
			token := current_token
			line := current_line
			current_line := a_line
			current_token := a_token
			from
			until
				current_token = Void or l_done
			loop
				go_to_previous_token
				tfs ?= current_token
				if tfs /= Void then
					if tfs.start_position < a_token.pos_in_text and a_token.pos_in_text < tfs.end_position then
						l_done := True
					else
						if l_end_position = 0 then
							l_end_position := tfs.end_position
						elseif l_end_position /= tfs.end_position then
							l_done := True
							tfs := Void
						end
					end
				end
			end

				-- Let's try to find a feature forward. For example we could be on the `frozen' keyword
				-- of a feature declaration with synonym but the feature start token is on the name not
				-- the `frozen' keyword (see bug#11173).
			from
				current_line := a_line
				current_token := a_token
				l_done := False
			until
				(current_token = Void or else current_token.next = Void) or l_done
			loop
				if current_token.is_feature_start then
					tfs2 ?= current_token
					check tfs2_not_void : tfs2 /= Void end
						-- If we are completely out of the current feature start, then no need to look further,
						-- the `tfs' we found earlier is the right one.
					l_done := (tfs2.start_position > a_token.pos_in_text or a_token.pos_in_text > tfs2.end_position)
					if not l_done then
						tfs := tfs2
					end
				end
				go_to_next_token
			end

			if tfs /= Void then
				index := tfs.feature_index_in_table
				if features_ast.valid_index (index) then
					Result := features_ast @ index
				end
			end
			current_token := token
			current_line := line
		ensure
			valid_result: Result /= Void implies (Result.feat_as /= Void and Result.name /= Void)
		end

	static_call_before_position (a_line: EDITOR_LINE; a_token: EDITOR_TOKEN): BOOLEAN is
			-- Is "feature" preceeding current position ?
		local
			line: EDITOR_LINE
			token: EDITOR_TOKEN
			par_cnt: INTEGER
			l_temp_token: EDITOR_TOKEN
			l_temp_line: EDITOR_LINE
		do
			line := current_line
			current_line := a_line
			token := current_token
			current_token := a_token
			found_agent_keyword := False
			found_precursor := False
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
					-- Check if "agent" is preceding.
				l_temp_token := current_token
				l_temp_line := current_line
				go_to_previous_token
				if current_token /= Void and then token_image_is_same_as_word (current_token, "agent") then
					found_agent_keyword := True
				end
				if current_token /= Void and then token_image_is_same_as_word (current_token, "precursor") then
					found_precursor := True
				end
				current_token := l_temp_token
				current_line := l_temp_line

				go_to_next_token
				error := error or else found_agent_keyword or else found_precursor or else current_token = Void or else type_of_class_corresponding_to_current_token = Void
				if not error then
					Result := True
				end
			end
			current_token := token
			current_line := line
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
			line := current_line
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
	            	current_feature_as := feature_containing (token, a_line)
	            	type := type_from (token, a_line)
	            	if type /= Void then
	            		if type.is_type_set then
							last_type := type
							found_class := Void
	            		else
	            			last_type := type
		            		if type.has_associated_class then
			            		found_class := type.associated_class
		            		end
	            		end
		            else
		            	found_class := Void
		            end
	            end
            end
		end

	add_precursor_possibilities (a_class: CLASS_AS; a_feature: FEATURE_AS) is
			-- Extend completion possiblities with appliable Precursors.
		require
			a_class_attached: a_class /= Void
			a_feature_attached: a_feature /= Void
		local
			l_parents: PARENT_LIST_AS
			l_parent: PARENT_AS
			l_redefining: EIFFEL_LIST [FEATURE_NAME]
			l_feat_name: FEATURE_NAME
			l_arguments: EIFFEL_LIST [TYPE_DEC_AS]
			l_type_dec: TYPE_DEC_AS
			l_cursor: INTEGER
			l_redefining_cursor: INTEGER
			l_args_cursor: INTEGER
			l_name: STRING
			l_continue: BOOLEAN
			l_completion_name: EB_PRECURSOR_FOR_COMPLETION
			l_class_from: ARRAYED_LIST [EDITOR_TOKEN]
			l_args: ARRAYED_LIST [EDITOR_TOKEN]
			l_type: ARRAYED_LIST [EDITOR_TOKEN]
			l_class_name: STRING
			l_class_token: EDITOR_TOKEN_CLASS
			l_type_a: TYPE_A
			l_feature_i: FEATURE_I
			l_error: BOOLEAN
			l_tokens: LIST [EDITOR_TOKEN]
			l_arg_item: INTEGER
		do
			l_parents := a_class.parents
			if l_parents /= Void and then not l_parents.is_empty then
				l_cursor := l_parents.index
				l_name := a_feature.feature_name.name
				from
					l_parents.start
				until
					l_parents.after
				loop
					l_parent := l_parents.item
					if l_parent /= Void then
						l_redefining := l_parent.redefining
						if l_redefining /= Void and then not l_redefining.is_empty then
							l_continue := False
							l_redefining_cursor := l_redefining.index
							from
								l_redefining.start
							until
								l_redefining.after or l_continue
							loop
								l_feat_name := l_redefining.item
								l_continue := l_feat_name.visual_name.is_case_insensitive_equal (l_name)
								if l_continue then
											-- Found a precursor match
									if l_parent.type /= Void then
											-- Class from
										create l_class_from.make (20)
										l_class_from.extend (create {EDITOR_TOKEN_SPACE}.make (1))
										l_class_from.extend (create {EDITOR_TOKEN_OPERATOR}.make (ti_l_curly))
										l_class_name := l_parent.type.class_name.name
										l_class_token := class_token_of_name (l_class_name)
										l_class_from.extend (l_class_token)
										l_class_from.extend (create {EDITOR_TOKEN_OPERATOR}.make (ti_r_curly))
										if current_class_c /= Void then
											if current_class_c.has_feature_table then
												l_feature_i := current_class_c.feature_named (a_feature.feature_name.name)
											end
											if l_feature_i = Void then
												l_feature_i := current_class_c.feature_named ("is_equal")
												check
													l_feature_i_not_void: l_feature_i /= Void
												end
											end
											if a_feature.body /= Void then
												l_arguments := a_feature.body.arguments
												if l_arguments /= Void and then not l_arguments.is_empty then
														-- Add current feature argument list
													create l_args.make (50)
													l_args.extend (create {EDITOR_TOKEN_OPERATOR}.make (ti_l_parenthesis))
													l_args_cursor := l_arguments.index
													from
														l_arguments.start
													until
														l_arguments.after or l_error
													loop
														l_type_dec := l_arguments.item
														l_type_a := local_evaluated_type (l_type_dec.type, current_class_c, l_feature_i)
														if l_type_a /= Void then
															l_tokens := tokens_of_type_a (l_type_a, l_feature_i)
															from
																l_type_dec.id_list.start
															until
																l_type_dec.id_list.after
															loop
																l_arg_item := l_type_dec.id_list.item
																l_args.extend (create {EDITOR_TOKEN_LOCAL}.make (names_heap.item (l_arg_item)))
																l_args.extend (create {EDITOR_TOKEN_OPERATOR}.make (ti_colon))
																l_args.extend (create {EDITOR_TOKEN_SPACE}.make (1))
																l_args.append (l_tokens)
																l_type_dec.id_list.forth
																if not l_type_dec.id_list.after then
																	l_args.extend (create {EDITOR_TOKEN_OPERATOR}.make (ti_comma))
																	l_args.extend (create {EDITOR_TOKEN_SPACE}.make (1))
																end
															end
														else
															l_error := True
														end
														l_arguments.forth
														if not l_arguments.after then
															l_args.extend (create {EDITOR_TOKEN_OPERATOR}.make (ti_comma))
															l_args.extend (create {EDITOR_TOKEN_SPACE}.make (1))
														end
													end
													l_args.extend (create {EDITOR_TOKEN_OPERATOR}.make (ti_r_parenthesis))
													if l_error then
														l_args := Void
													end
													l_arguments.go_i_th (l_args_cursor)
												end
											end
										end
									end
									create l_completion_name.make (l_class_from, l_type, l_args)
									insert_in_completion_possibilities (l_completion_name)
								end
								l_redefining.forth
							end

							l_redefining.go_i_th (l_redefining_cursor)
						end
					end
					l_parents.forth
				end
				l_parents.go_i_th (l_cursor)
			end
		end

	add_named_tuple_generics (a_type: NAMED_TUPLE_TYPE_A) is
			-- Add named tuple generics to completion possibilities.
		require
			a_type_not_void: a_type /= Void
		local
			l_feat_name: EB_NAME_WITH_TYPE_FOR_COMPLETION
			l_array: ARRAY [TYPE_A]
			i: INTEGER
			l_type: TYPE_A
		do
			from
				l_array := a_type.generics
				i := l_array.lower
			until
				i > l_array.upper
			loop
				l_type := a_type.generics.item (i).actual_type
				if l_type.is_loose then
					l_type := l_type.instantiation_in (l_type, a_type.associated_class.class_id)
				end
				create l_feat_name.make (a_type.label_name (i).twin, l_type, current_feature_i)
				insert_in_completion_possibilities (l_feat_name)
				i := i + 1
			end
		end

	add_generics_creation_list (a_class_c: CLASS_C) is
			-- Add constrained generics creation to completion possiblities.
		local
			l_generics: EIFFEL_LIST [FORMAL_DEC_AS]
			l_formal_as: FORMAL_DEC_AS
			l_list: EIFFEL_LIST [FEATURE_NAME]
			l_table: E_FEATURE_TABLE
			l_feat: E_FEATURE
		do
			check
				current_class_c /= Void
			end
			l_generics := current_class_c.generics
			l_table := a_class_c.api_feature_table
			check
				last_constained_type_not_void: last_formal /= Void
			end
			l_formal_as := l_generics.i_th (last_formal.position)
			if l_formal_as /= Void and then l_formal_as.creation_feature_list /= Void then
				from
					l_list := l_formal_as.creation_feature_list
					l_list.start
				until
					l_list.after
				loop
					if l_table.has_key (l_list.item.visual_name) then
						l_feat := l_table.found_item
						if l_feat.is_exported_to (current_class_c) then
							add_feature_to_completion_possibilities (l_feat)
						end
					end
					l_list.forth
				end
			end
		end

	calculate_insertion (token: EDITOR_TOKEN) is
			--
		local
			prev_token: EDITOR_TOKEN
			l_char: CHARACTER
		do
			insertion_remainder := 0
			insertion.put ("")
			if can_attempt_auto_complete_from_token (token) then
				if token.is_text or token.is_blank then
						-- The cursor is in a text token so we complete based upon the previous token unless the cursor
						-- is somewhere inside this token..
					prev_token := token.previous

					if prev_token /= Void and current_pos_in_token = 1 then
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
									insertion.put (prev_token.image)
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
										insertion.put (prev_token.image)
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
										insertion.put (prev_token.image)
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
					elseif current_pos_in_token > 1 then
							-- Cursor is current in a token at `cursor.pos_in_token'
						if not token.is_blank then
								-- Happens when completing 'a.bb|bbbb.c'						
							insertion.put (token.image.substring (1, current_pos_in_token - 1))
							insertion_remainder := token.length - (current_pos_in_token - 1)
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
							insertion.put (prev_token.image)
							insertion_remainder := 0
						else
								-- Happens when completing ')|.b.c'
						end
					end
				end
			end
		end

	tokens_of_type_a (a_type: TYPE_A; a_feature: FEATURE_I): LIST [EDITOR_TOKEN] is
			-- Tokens of type a
		require
			a_type_not_void: a_type /= Void
			a_feature_not_void: a_feature /= Void
		do
			token_writer.new_line
			a_type.ext_append_to (token_writer, a_feature.e_feature.associated_class)
			Result := token_writer.last_line.content
		ensure
			result_not_void: Result /= Void
		end

	class_token_of_name (a_name: STRING): EDITOR_TOKEN_CLASS is
			-- Class token of `a_name'
		require
			a_name_not_void: a_name /= Void
		local
			l_class_i: CLASS_I
			l_class_c: CLASS_C
			l_list: LINKED_SET [CONF_CLASS]
		do
			create Result.make (a_name)
			l_list := current_class_c.group.class_by_name (a_name, True)
			if not l_list.is_empty then
				l_class_i ?= l_list.first
			end
			if l_class_i /= Void then
				l_class_c ?= l_class_i.compiled_representation
				if l_class_c /= Void then
					Result.set_pebble (create {CLASSC_STONE}.make (l_class_c))
				else
					Result.set_pebble (create {CLASSI_STONE}.make (l_class_i))
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	add_renaming_to_completion_possibilities (a_feat: E_FEATURE; a_type_set: TYPE_SET_A; a_extended_class: CLASS_C) is
			-- Renamed feature from feature.
			-- a_type_set is flattened.
		require
			a_type_set_not_void: a_type_set /= Void
			a_type_set_not_formal: not a_type_set.has_formal
			a_feat_not_void: a_feat /= Void
			a_extended_class_not_void: a_extended_class /= Void
		local
			l_renaming: RENAMING_A
			l_name_id, l_new_name_id: INTEGER
			l_features_found_count: INTEGER
			l_type_set: TYPE_SET_A
			l_name_for_completion: EB_FEATURE_FOR_COMPLETION
			l_stop: BOOLEAN
		do
			l_name_id := a_feat.name_id
			from
					-- `e_feature_state_by_name_id' doesn't ensure the cursor position, so we twin here.
				l_type_set := a_type_set.twin
				l_type_set.start
			until
					-- We stop when the feature was added.
					-- It *should* always be found. So `l_type_set.after' implies `l_stop'.
					-- If we find more than one feature we do not want to display it.
				l_type_set.after or l_stop
			loop
				if a_extended_class.class_id = l_type_set.item.associated_class.class_id then
						-- Ok, so we have three cases:
						-- * The feature was not found. It has to be renamed in that case, otherwise we have internal errors.
						-- * The feature was found and it has _not_ been renamed at all.
						-- * The feature was found but there is a switch of feature names like "rename a as b, b as a end"
						--   and we have to find out it's new name.
						-- The code below has to handle these cases correctly.
					l_renaming := l_type_set.item.renaming
					if l_renaming /= Void then
						l_new_name_id := l_renaming.new_name (l_name_id)
							-- Now we check that under this (possibly renamed) name the feature occurs only once.
						l_features_found_count := l_type_set.e_feature_state_by_name_id (l_new_name_id).features_found_count
						if l_features_found_count = 1 then
							if l_new_name_id /= l_name_id then
								create l_name_for_completion.make (a_feat, names_heap.item (l_new_name_id), False)
								insert_in_completion_possibilities (l_name_for_completion)
							else
								add_feature_to_completion_possibilities (a_feat)
							end
						else
								-- The feature occurs more than once, we do not want to add it.
							check no_internal_error: l_features_found_count > 1 end
						end
					else
							-- If there is no renaming, we still need to ensure the feature added is unique,
							-- or we don't add it to the list, because the code will be rejected by the compiler.
						l_features_found_count := l_type_set.e_feature_state_by_name_id (l_name_id).features_found_count
						if l_features_found_count = 1 then
							add_feature_to_completion_possibilities (a_feat)
						end
					end
					l_stop := True
				else
						-- This calls is in the else part as a call to forth is not ok in the
						-- case we called `e_feature_state_by_name_id' because it uses the internal cursor as well.
					l_type_set.forth
				end
			end
		end

invariant
	invariant_clause: True -- Your invariant here

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end
