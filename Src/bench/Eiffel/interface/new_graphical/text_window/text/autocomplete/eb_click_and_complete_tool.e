indexing
	description: "Objects that analyze search the editor content for clickable position"
	author: "Etienne AMODEO"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLICK_AND_COMPLETE_TOOL

inherit

	EB_SHARED_EDITOR_DATA

	EB_CLASS_INFO_ANALYZER
		redefine
			reset
		end

creation

	default_create

feature -- Initialisation

	initialize (a_content: CLICKABLE_TEXT; a_class_name, a_cluster_name: STRING; after_save: BOOLEAN) is
			-- initialize the tool before analyzing a class called `a_classname' located in cluster called `a_cluster_name'
			-- `a_content' is text of this class
		require
			a_content_is_not_void: a_content /= Void
			a_class_name_is_not_void: a_class_name /= Void
			a_cluster_name_is_not_void: a_cluster_name /= Void
		local
			current_class_i: CLASS_I
			class_c: CLASS_C
		do
			current_class_name := a_class_name
			cluster_name := a_cluster_name
			content := a_content
			is_ready := False
			can_analyze_current_class := False
			if not Workbench.is_compiling then
	 			current_class_i := Universe.class_named (current_class_name, Universe.cluster_of_name (cluster_name))
				if current_class_i /= Void and then current_class_i.compiled then
					class_c := current_class_i.compiled_class
					generate_ast (class_c, after_save)
					can_analyze_current_class := last_syntax_error = Void and then current_class_as /= Void
				end
			end
		end

feature -- Analysis preparation

	prepare_on_click_analysis is
			-- gather information necessary to analysis
		do
			set_indexes
			make_click_list_from_ast
			is_ready := True
		end

	setup_line (a_line: EDITOR_LINE) is
			-- set the `pos_in_text' attribute of interesting tokens.
		require
			class_as_already_built: current_class_as /= Void
			line_not_void: a_line /= Void
			features_position_not_void: features_position /= Void
		local
			token, prev, next: EDITOR_TOKEN
			tfs: EDITOR_TOKEN_FEATURE_START
			line: EDITOR_LINE			
		do
			from
				line := a_line
				token := line.first_token
			until
				token = Void or else token = line.eol_token
			loop
				if token.is_text then
					if is_keyword (token) then
							-- no interesting token : skip
					elseif is_comment (token) then
							-- no interesting token : skip
					elseif is_string (token) then
							-- no interesting token : skip

							-- If a string is written one several lines (more than 2 in fact),
							-- it will be made of several token, some of which may not be
							-- string tokens (those like % .... % ) 
						if split_string then
							split_string := False
						elseif token.image @ token.image.count /= '%"' then
							split_string := True
						end
					else
						if not split_string then
								-- "Normal" text token
							if not features_position.after and then pos_in_file >= features_position.item then
									-- `current_token' is the beginning of a feature
									-- we replace this text token with a "feature start token"
								prev := token.previous
								next := token.next
								create {EDITOR_TOKEN_FEATURE_START} tfs.make (token.image, content.tab_size_cell)
								tfs.set_pos_in_text (pos_in_file)
								tfs.set_feature_index_in_table (features_position.index)
								if prev /= Void then
									prev.set_next_token (tfs)
								end
								tfs.set_previous_token (prev)
								tfs.set_next_token (next)
								if next /= Void then
									next.set_previous_token (tfs)
								end
								features_position.forth
							else
								token.set_pos_in_text (pos_in_file)						
							end
						end
					end
				end
				pos_in_file := token.length + pos_in_file
				token := token.next
			end
			if is_eol (token) then
				if file_standard_is_windows then
					pos_in_file := pos_in_file + 2
				else
					pos_in_file := pos_in_file + 1
				end
			end
		end

	update is
			-- update class text information 
		do
			build_features_arrays
			reset_positions_and_indexes
			make_click_list_from_ast
			is_ready := True
		end


feature -- Reinitialization

	reset_setup_lines_variables is
			-- reinitialize variables used by `setup_lines'
			-- to be executed before `setup_lines' is launched for the first time
		require
			features_position_not_void: features_position /= Void
		do
			pos_in_file := 0
			split_string := False
			features_position.start
		end
feature -- Status

	file_standard_is_windows: BOOLEAN

	set_file_standard_is_windows (value: BOOLEAN) is
			-- assign `value' to `file_standard_is_windows'.
		do
			file_standard_is_windows := value
		end

feature {NONE} -- Retrieve information from text

	set_indexes is
			-- calculate `invariant_index' and `features_index'
		local
			invariant_assertion_list: EIFFEL_LIST [TAGGED_AS]
		do
			invariant_index := current_class_as.end_position
			if (not current_class_as.has_empty_invariant) and then current_class_as.invariant_part /= Void then
				invariant_assertion_list := current_class_as.invariant_part.assertion_list
				from
					invariant_assertion_list.start
				until
					invariant_assertion_list.after
				loop
					invariant_index := invariant_index.min (invariant_assertion_list.item.start_position)
					invariant_assertion_list.forth
				end				
			end
			if current_class_as.features /= Void and then features_position.count > 0 then
				features_index := features_position @ 1
			else
				features_index := invariant_index
			end
		end

		
feature -- Retrieve information from ast

	build_features_arrays is
			-- build tables associating FEATURE_AS objects with positions in text
		require
			current_class_as_not_void: current_class_as /= Void
		local
			feature_clauses: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			feature_list: EIFFEL_LIST [FEATURE_AS]
			index: INTEGER
			insert: BOOLEAN
			position: INTEGER
			size: INTEGER
		do
			feature_clauses := current_class_as.features
			if feature_clauses /= Void then
				from 
					feature_clauses.start
				until
					feature_clauses.after
				loop
					if feature_clauses.item.features /= Void then
						size := feature_clauses.item.features.count + size
					end
					feature_clauses.forth
				end
				create features_position.make (size)
				create features_ast.make (size)
				from 
					feature_clauses.start
				until
					feature_clauses.after
				loop
					if feature_clauses.item.features /= Void then
						feature_list := feature_clauses.item.features
						if feature_list /= Void then
							from
								feature_list.start
							until
								feature_list.after
							loop
								position := feature_list.item.start_position
								from
									index := features_position.count
								until
									index <= 0 or insert
								loop
									if features_position @ index < position then
										insert := True
									else
										index := index - 1
									end
								end
								if index = features_position.count then
									features_position.extend (position)
									features_ast.extend (feature_list.item)
								else
									features_position.go_i_th (index)
									features_position.put_left (position)
									features_ast.go_i_th (index)
									features_ast.put_left (feature_list.item)
								end
								feature_list.forth
							end
						end
					end
					feature_clauses.forth
				end
			else
				create features_position.make (0)
				create features_ast.make (0)
			end
		ensure
			features_position_not_void: features_position /= Void
			features_ast_not_void: features_ast /= Void
		end

feature -- Click list update

	reset_positions_and_indexes is
			-- look for position of subsection of class text (inherit, invariant, creation..)
			-- and set the `pos_in_text' attribute of interesting tokens.
		require
			class_as_already_built: current_class_as /= Void
			feature_position_not_void: features_position /= Void
		local
			token, prev, next: EDITOR_TOKEN
			tfs: EDITOR_TOKEN_FEATURE_START
			line: EDITOR_LINE
			search_indexes: BOOLEAN
			invariant_assertion_list: EIFFEL_LIST [TAGGED_AS]
		do
			reset_setup_lines_variables
			invariant_index := current_class_as.end_position
			if (not current_class_as.has_empty_invariant) and then current_class_as.invariant_part /= Void then
				invariant_assertion_list := current_class_as.invariant_part.assertion_list
				from
					invariant_assertion_list.start
				until
					invariant_assertion_list.after
				loop
					invariant_index := invariant_index.min (invariant_assertion_list.item.start_position)
					invariant_assertion_list.forth
				end				
			end
			if current_class_as.features /= Void and then features_position.count > 0 then
				features_index := features_position @ 1
			else
				features_index := invariant_index
			end			
			from
				content.start
				line := content.current_line
				token := line.first_token
				pos_in_file := 0
				search_indexes := True
			until
				token = Void
			loop
				if token.is_text then
					if is_keyword (token) then
							-- no interesting token : skip
					elseif is_comment (token) then
							-- no interesting token : skip
					elseif is_string (token) then
							-- no interesting token : skip

							-- If a string is written one several lines (more than 2 in fact),
							-- it will be made of several token, some of which may not be
							-- string tokens (those like % .... % ) 
						if token.image @ token.image.count /= '%"' then
							from
								if token.next /= Void then
									pos_in_file := token.length + pos_in_file
									token := token.next
								elseif line.next /= Void then
									line := line.next
									pos_in_file := pos_in_file + 1
									if file_standard_is_windows then
										pos_in_file := pos_in_file + 1
									end
									token := line.first_token
								end
							invariant
								token /= Void
							until
								is_string (token)
							loop
								if token.next /= Void then
									pos_in_file := token.length + pos_in_file
									token := token.next
								elseif line.next /= Void then
									line := line.next
									pos_in_file := pos_in_file + 1
									if file_standard_is_windows then
										pos_in_file := pos_in_file + 1
									end
									token := line.first_token
								else
									token := Void
								end
							end
						end
					else
							-- "Normal" text token
						if not features_position.after and then pos_in_file >= features_position.item then
							prev := token.previous
							next := token.next
							create {EDITOR_TOKEN_FEATURE_START} tfs.make (token.image, content.tab_size_cell)
							tfs.set_pos_in_text (pos_in_file)
							tfs.set_feature_index_in_table (features_position.index)
							if prev /= Void then
								prev.set_next_token (tfs)
							end
							tfs.set_previous_token (prev)
							tfs.set_next_token (next)
							if next /= Void then
								next.set_previous_token (tfs)
							end
							features_position.forth
						else
							token.set_pos_in_text (pos_in_file)						
						end
					end
				end
				if token.next /= Void then
					pos_in_file := token.length + pos_in_file
					token := token.next
				elseif line.next /= Void then
					line := line.next
					pos_in_file := pos_in_file + 1
					if file_standard_is_windows then
						pos_in_file := pos_in_file + 1
					end
					token := line.first_token
				else
					token := Void
				end
			end							
		end

feature {NONE} -- Private Access : indexes

	features_index: INTEGER
			-- index of the first feature clause in text

	invariant_index: INTEGER
			-- index of "invariant" keyword in text

feature {NONE} -- Private Access

	split_string: BOOLEAN
			-- is processed token part of a split string ?

feature -- Basic Operations

	build_completion_list (cursor: TEXT_CURSOR) is
			-- create the list of completion possibilities for the position
			-- associated with `cursor'
		require
			cursor_not_void: cursor /= Void
		local
			token				: EDITOR_TOKEN
			feat_table			: E_FEATURE_TABLE 
			feat				: E_FEATURE
			cls_c				: CLASS_C
			type				: TYPE_A
			crtrs				: EXTEND_TABLE [EXPORT_I, STRING]
			par_cnt				: INTEGER
			par_token			: EDITOR_TOKEN
			blnk				: EDITOR_TOKEN_BLANK
			show_any_features	: BOOLEAN
		do
			create insertion.make (1,2)
			insertion.put ("", 1)
			insertion.put ("", 2)
			is_create := False
			create completion_possibilities.make (1, 30)
			cp_index := 1
			initialize_context
			if context_initialized_successfully then
				if cursor.token /= Void then
					token := cursor.token.previous
					if 
						is_beginning_of_expression (token)
					then
						exploring_current_class := True
						local_analyzer.build_entities_list (cursor.line, token, False)
						add_names_to_completion_list (Local_analyzer.found_names)
						local_analyzer.reset
						cls_c := current_class_c
					elseif token /= Void and then token.is_text then
						exploring_current_class := False
						if token_image_is_in_array (token, Feature_call_separators) then
								-- token is dot or tilda
							if token.image @ 1 = '%L' and then is_beginning_of_expression (token.previous) then
								exploring_current_class := True
								cls_c := current_class_c
								token := Void
							else
								insertion.put (token.image.out, 1)
								is_create := create_before_position (cursor.line, token)
							end
						else
								-- token is beginning of feature name
							insertion.put (token.image.out, 2)
							token := token.previous
							if is_beginning_of_expression (token) then
								exploring_current_class := True
								cls_c := current_class_c
								local_analyzer.build_entities_list (cursor.line, token, False)
								add_names_to_completion_list (Local_analyzer.found_names)
								local_analyzer.reset
								token := Void
							else
								if token_image_is_in_array (token, Feature_call_separators) then
									if token.image @ 1 = '%L' and then is_beginning_of_expression (token.previous) then
										exploring_current_class := True
										cls_c := current_class_c
										token := Void
									else
										insertion.put (token.image.out, 1)
										is_create := create_before_position (cursor.line, token)
									end
								else
									token := Void
								end
							end
						end
						if token /= Void and not is_create then
							token := token.previous
							if token /= Void then
								if token_image_is_same_as_word (token, ")") then
									from
										par_cnt := 1
									until
										token = Void or par_cnt = 0	
									loop
										token := token.previous
										if token_image_is_same_as_word (token , ")") then
											par_cnt := par_cnt + 1
										elseif token_image_is_same_as_word (token , "(") then
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
								end
								if token /= Void then
									current_feature_as := feature_containing (token, cursor.line)
									type := type_from (token, cursor.line)
									if type /= Void then
										cls_c := type.associated_class
									end
								end
							end
						end
					end
				end
				if is_create and then found_class /= Void then 
					cls_c := found_class
				end
				if cls_c /= Void and then cls_c.has_feature_table then
					feat_table := cls_c.api_feature_table
					if is_create then
							-- we consider only the creators
						crtrs := cls_c.creators
						if crtrs /= Void then
							from
								crtrs.start
							until
								crtrs.after
							loop
								if feat_table.has (crtrs.key_for_iteration) then
									add_feature_to_completion_possibilities	(feat_table.item (crtrs.key_for_iteration))
								end								
								crtrs.forth
							end
						end
					else
						show_any_features := 	Editor_preferences.show_any_features
													or else
												cls_c.name_in_upper.is_equal (Any_name)
						from
							feat_table.start
						until
							feat_table.after
						loop
							feat := feat_table.item_for_iteration
							if 
								(
									exploring_current_class
										or else
									feat.is_exported_to (current_class_c)
								)
									and then
								(
									show_any_features
										or else
									not feat.written_class.name_in_upper.is_equal (Any_name)
								)
							then
								add_feature_to_completion_possibilities (feat)
							end
							feat_table.forth
						end
					end
				end
			end
			reset_after_search
			if cp_index = 1 then
				completion_possibilities := Void
			else
				completion_possibilities := completion_possibilities.subarray (1, cp_index - 1)
				completion_possibilities.sort
			end
		end

	stone_at_position (cursor: TEXT_CURSOR): STONE is
			-- Return stone associated with position pointed by `cursor', if any
		local
			ft		: FEATURE_AS
			feat		: E_FEATURE
			a_position	: INTEGER
			token		: EDITOR_TOKEN
			line		: EDITOR_LINE
		do
			initialize_context
			if context_initialized_successfully then
				token := cursor.token
				line := cursor.line
				a_position := token.pos_in_text
				Result := stone_in_click_ast (a_position)
				if Result = Void and then (a_position >= features_index or else token_image_is_same_as_word (token, "precursor")) then
					if a_position >= invariant_index then
						feat := described_feature (token, line, Void)
					elseif a_position >= features_index or else token_image_is_same_as_word (token, "precursor") then
						ft := feature_containing (token, line)
						if ft /= Void then
							inspect
								feature_part_at (token, line)
							when instruction_part then
								feat := described_feature (token, line, ft)
							when assertion_part then
								feat := described_feature (token, line, ft)
							else
							end
						end
					end
					if feat /= Void then
						create {FEATURE_STONE} Result.make (feat)
					end
				end
			end
			reset_after_search
		end

feature -- Private Access : position tables & ast

	features_position: ARRAYED_LIST [INTEGER]
			-- array of features position in class text

	features_ast: ARRAYED_LIST [FEATURE_AS]
			-- array of feature_as corresponding to positions in `features_position'

feature -- Reinitialization

	reset is
			-- set class attributes to default values
		do
			Precursor {EB_CLASS_INFO_ANALYZER}
			reset_after_search
		end

feature -- Completion access

	insertion: ARRAY [STRING]
			-- strings to be partially completed : the first one is the dot or tilda if there is one
			-- the second one is the feature name to be completed

	insertion_count: INTEGER is
			-- length of the feature name to be completed
		require
			insertion_not_void: insertion /= Void
			feature_name_exists: insertion.valid_index (2)
		do
			Result := insertion.item (2).count 
		end

	exploring_current_class: BOOLEAN
			-- was automatic completion called after a blank space ?

	completion_possibilities: SORTABLE_ARRAY [EB_FEATURE_NAME_FOR_COMPLETION]
			-- completion possibilities for the current position in the editor

feature {NONE} -- Private Status

	is_create: BOOLEAN
			-- was auto-complete called after "create" ?

feature {NONE} -- Completion implementation

	type_from (token: EDITOR_TOKEN; line: EDITOR_LINE): TYPE_A is
			-- try to analyze class text to find type associated with word represented by `token'
		require
			token_not_void: token /= Void
			line_not_void: line /= Void
			token_in_line: line.has_token (token)
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
			current_class_c_not_void: current_class_c /= Void
		local
			exp: LINKED_LIST [EDITOR_TOKEN]
			name: STRING
			par_cnt: INTEGER
			processed_class: CLASS_C
			type: TYPE_A
			formal: FORMAL_A
			feat: E_FEATURE
		do
			from
				Result := current_class_c.actual_type
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
					name := current_token.image.out
					name.to_lower
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
							if current_feature_as /= Void and then current_class_c.parents /= Void then
								from
									current_class_c.parents.start
								until
									feat /= Void or else current_class_c.parents.after
								loop
									type := current_class_c.parents.item
									if type.associated_class /= Void and then type.associated_class.has_feature_table then
										feat := type.associated_class.feature_with_name (current_feature_as.feature_name)
									end
									current_class_c.parents.forth
								end
							end
						end
					else
						feat := current_class_c.feature_with_name (name)
						is_create := create_before_position (current_line, current_token)
					end
					if feat = Void then		
						Result := type_of_local_entity_named (name)
						if Result = Void then
							Result := type_of_constants_or_reserved_word (current_token)
						end
					else
						error := True
						if feat.type /= Void then
							type := feat.type
							if type.is_formal then
								formal ?= type
								if 
									Result /= Void and then
									Result.has_generics and then 
									Result.generics.valid_index (formal.position)
								then
									Result := Result.generics @ (formal.position)
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
				name := current_token.image.out
				name.to_lower
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
									Result := Result.generics @ (formal.position)
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

	add_names_to_completion_list (name_list: LIST [STRING]) is
			-- 
		local
			name: EB_FEATURE_NAME_FOR_COMPLETION
		do
			from
				name_list.start
			until
				name_list.after
			loop
				create name.make_with_name (name_list.item)
				insert_in_completion_possibilities (name)
				name_list.forth
			end
		end

	add_feature_to_completion_possibilities (feat: E_FEATURE) is
			-- add the signature of `feat' to `completion possibilities'
		require
			completion_possibilities_not_void: completion_possibilities /= Void
			feat_is_not_void: feat /= Void
		local
			name	: EB_FEATURE_NAME_FOR_COMPLETION
			found	: BOOLEAN
		do
			if feat.is_infix then
				from
					infix_table.start
					found := false
				until
					found or infix_table.after
				loop
					found := feat.name.is_equal (infix_table.item_for_iteration)
					if found then
						create name.make_with_name (infix_table.key_for_iteration + feat.feature_signature.substring(feat.name.count + 1, feat.feature_signature.count))
					end
					infix_table.forth
				end
				if not found then
					create name.make_with_name (feat.feature_signature.substring (8, feat.feature_signature.count))
				end
				name.set_has_dot (False)
				insert_in_completion_possibilities (name)
			elseif not feat.is_prefix then
				create name.make_with_name (feat.feature_signature)
				if feat.is_once or feat.is_constant then
					name.put ((name @ 1).upper, 1)
				end
				insert_in_completion_possibilities (name)
			end
		end

feature {NONE}-- Implementation

	insert_in_completion_possibilities (name: EB_FEATURE_NAME_FOR_COMPLETION) is
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
		
	cp_index: INTEGER

	feature_containing (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE): FEATURE_AS is
			-- feature containing `a_token' in class text
		require
			features_position_not_void: features_position /= Void
			features_ast_not_void: features_ast /= Void
		local
			token: EDITOR_TOKEN
			line: EDITOR_LINE
			tfs: EDITOR_TOKEN_FEATURE_START
			index: INTEGER
		do
			token := current_token
			line := current_line
			from
				current_line := a_line
				current_token := a_token
			until
				current_token = Void or else current_token.is_feature_start
			loop
				go_to_previous_token
			end
			tfs ?= current_token
			if tfs /= Void then
				index := tfs.feature_index_in_table
				if features_ast.valid_cursor_index (index) then
					Result := features_ast @ index
				end
			end
			current_token := token
			current_line := line
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
			Result := token_image_is_same_as_word (current_token, "create")
			if not Result and then token_image_is_same_as_word (current_token, "}") then
				from
					par_cnt:= 1
				until
					par_cnt = 0 or else current_token = Void
				loop
					go_to_previous_token
					if token_image_is_same_as_word (current_token, "{") then
						par_cnt:= par_cnt - 1
					elseif token_image_is_same_as_word (current_token, "}") then
						par_cnt:= par_cnt + 1
					end
				end
				go_to_next_token
				error := error or else current_token = Void or else type_of_class_corresponding_to_current_token = Void
				if not error then
					go_to_previous_token
					go_to_previous_token
					Result := token_image_is_same_as_word (current_token, "create")
				end
			end
			current_token := token
			current_line := line			
		end

	Any_name: STRING is "ANY"
				
end -- class EB_CLICK_AND_COMPLETE_TOOL
