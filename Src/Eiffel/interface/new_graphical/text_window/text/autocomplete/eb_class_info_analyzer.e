indexing
	description: "Objects that analyze class text to make it clickable and allow automatic completion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_CLASS_INFO_ANALYZER

inherit
	ANY

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_TMP_SERVER
		export
			{NONE} all
		end

	SHARED_INST_CONTEXT
		export
			{NONE} all
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

	PREFIX_INFIX_NAMES
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	EB_TOKEN_TOOLKIT
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	SHARED_TYPES
		export
			{NONE} all
		end

feature -- Access

	group: CONF_GROUP
			-- Group which contains analyzed class

	content: CLICKABLE_TEXT
			-- text currently displayed

	current_class_as: CLASS_AS
			-- CLASS_AS object corresponding to the edited class text

	last_syntax_error: SYNTAX_ERROR
			-- last syntax error (found by generate_ast)

feature -- Status report

	can_analyze_current_class: BOOLEAN
			-- can current class text be analyzed ?

	is_ready: BOOLEAN
		-- is the analysis completed ?

feature -- Basic operations

	stone_at_position (cursor: TEXT_CURSOR): STONE is
			-- Return stone associated with position pointed by `cursor', if any
		require
			cursor_not_void: cursor /= Void
		deferred
		end

feature -- Element change

	clear_syntax_error is
			-- wipe out `last_syntax_error'
		do
			last_syntax_error := Void
		end

feature -- Analysis preparation

	update is
		deferred
		end

feature -- Reinitialization

	reset is
			-- set class attributes to default values
		do
			current_class_i := Void
			current_class_c := Void
			--if Workbench.system_defined then
			--	System.set_current_class (Void)
			--end
			group := Void
			content := Void
			is_ready := False
			pos_in_file := 1
		end

	reset_after_search is
			-- set attributes related to search to default values
		do
			error := False
			current_token := Void
			searched_token := Void
			current_line := Void
			searched_line := Void
			--if Workbench.system_defined then
			--	System.set_current_class (Void)
			--end
			current_feature_as := Void
			found_class := Void
		end

feature {NONE} -- Private Access

	pos_in_file: INTEGER
			-- position in file of processed_token

	searched_token: EDITOR_TOKEN
			-- token which was clicked or which is to be completed

	searched_line: EDITOR_LINE
			-- line containing `searched_token'

	current_feature_as: TUPLE [feat_as: FEATURE_AS; name: FEATURE_NAME]
			-- `FEATURE_AS/FEATURE_NAME' corresponding to the feature containing `searched_token'

	is_for_feature: BOOLEAN
			-- Is current type/feature searching for a feature?

feature {EB_ADDRESS_MANAGER} -- Private Access

	current_token: EDITOR_TOKEN
			-- token being analyzed

	current_line: EDITOR_LINE
			-- line containing `current_token'

feature {NONE} -- Private Status

	error: BOOLEAN
			-- did an error occur ?

	found_precursor: BOOLEAN
			-- Was auto-complete called after "Precursor {CLASS}"?

	is_create: BOOLEAN
			-- was auto-complete called after "create" ?

feature {NONE} -- Click ast exploration

	clickable_position_list: ARRAY [EB_CLICKABLE_POSITION]
			-- list of clickable positions

	make_click_list_from_ast is
			-- build the click list from information in the CLASS_C object.
		local
			pos, i, j, pos_in_txt, c: INTEGER
			a_click_ast: CLICK_AST
			clickable: CLICKABLE_AST
			l_precursor: PRECURSOR_AS
			clickable_position: EB_CLICKABLE_POSITION
			ast_list: CLICK_LIST
			a_class: CLASS_I
			prov_list: LINKED_LIST [EB_CLICKABLE_POSITION]
			f_name: FEATURE_NAME
			inherit_clauses: SORTABLE_ARRAY [INTEGER]
			parents: EIFFEL_LIST [PARENT_AS]
			class_name: STRING
			has_parents: BOOLEAN
		do
			if is_ok_for_completion then
				initialize_context
				if current_class_i /= Void then
					parents := current_class_as.parents
					has_parents := parents /= Void
					if has_parents then
						create inherit_clauses.make (1, parents.count + 1)
						from
							parents.start
							i := 1
						until
							parents.after
						loop
							inherit_clauses.put (parents.item.start_position, i)
							parents.forth
							i := i + 1
						end
						inherit_clauses.put (current_class_as.inherit_clause_insert_position, i)
						inherit_clauses.sort
					end
					ast_list := current_class_as.click_list
					if ast_list /= Void then
						c := ast_list.count
						create prov_list.make
						from
							pos := 1
						until
							pos > c
						loop
							a_click_ast := ast_list.i_th (pos)
							clickable := a_click_ast.node
							if clickable.is_class or else clickable.is_precursor then
								a_class := clickable_info.associated_eiffel_class (current_class_i, clickable)
								if a_class /= Void then
									create clickable_position.make (a_click_ast.start_position, a_click_ast.end_position)
									if clickable.is_class then
										clickable_position.set_class (clickable.class_name.name)
									else
										l_precursor ?= clickable
										check l_precursor_not_void: l_precursor /= Void end
										clickable_position.set_class (l_precursor.parent_base_class.class_name.name)
									end
									prov_list.extend (clickable_position)
								end
							elseif clickable.is_feature then
								f_name ?= clickable
								class_name := Void
								if f_name /= Void and has_parents then
									pos_in_txt := a_click_ast.start_position
									if pos_in_txt < inherit_clauses @ i then
										from
											j := 1
										until
											j = i or else pos_in_txt < inherit_clauses @ j
										loop
											j := j + 1
										end
										if j /= 1 and then pos_in_txt < inherit_clauses @ j then
											a_class := clickable_info.
												associated_eiffel_class (current_class_i, parents.i_th (j - 1).type)
											if a_class /= Void then
												class_name := a_class.name
											else
												class_name := Void
											end
										end
									end
								end
								if class_name = Void then
									class_name := current_class_i.name
								end
								create clickable_position.make (a_click_ast.start_position, a_click_ast.end_position)
								clickable_position.set_feature (class_name, clickable.feature_name.name)
								prov_list.extend (clickable_position)
							end
							pos := pos + 1
						end
					end
					create clickable_position_list.make (1, prov_list.count)
					from
						prov_list.start
						pos := 1
					until
						prov_list.after
					loop
						clickable_position_list.put (prov_list.item, pos)
						pos := pos + 1
						prov_list.forth
					end
				end
			end
		end

	generate_ast (c: CLASS_C; after_save: BOOLEAN) is
			-- Parse the text of the class `c'. Return True if could parse successfully,
			-- False otherwise
		require
			c_not_void: c /= Void
		local
			l_eiffel_class: EIFFEL_CLASS_C
			is_retried: BOOLEAN
		do
			if not is_retried then
				if not c.is_precompiled and c.file_is_readable then
					last_syntax_error := Void
					l_eiffel_class ?= c
					check
						l_eiffel_class_not_void: l_eiffel_class /= Void
						not_error_handler_has_error: not error_handler.has_error
					end
					current_class_as := l_eiffel_class.parsed_ast (after_save)
					if current_class_as = Void then
							-- If a syntax error ocurred, we retrieve the old ast.
						current_class_as := c.ast
						if error_handler.has_error and then {l_syn: SYNTAX_ERROR} error_handler.error_list.first then
								-- Set the new syntax error
							last_syntax_error := l_syn
						end
							-- Clear error handler, as per-note in parsed_ast
						error_handler.wipe_out
					end
				else
						-- Class is precompiled, we should not reparse it since its definition
						-- is frozen for the compiler.
					current_class_as := c.ast
				end
			end
		rescue
			is_retried := True
			retry
		end

feature {NONE}-- Clickable/Editable implementation

	stone_in_click_ast (a_position: INTEGER): STONE is
			-- search in the click_ast for a stone to associate with `a_position' in text
		require
			group_not_void: group /= Void
			group_is_valid: group.is_valid
		local
			index_min, index_max, middle: INTEGER
			position: INTEGER
			click_pos: EB_CLICKABLE_POSITION
			class_i: CLASS_I
			feat: E_FEATURE
		do
			if clickable_position_list /= Void then
				index_min := 1
				index_max := clickable_position_list.count
				if a_position >= (clickable_position_list @ 1).start then
						-- search in the list
					if a_position >= (clickable_position_list @ index_max).start then
						index_min := index_max
					else
						from

						until
							index_min >= index_max - 1
						loop
							middle := index_min + (index_max - index_min) // 2
							position := (clickable_position_list @ middle).start
							if position > a_position then
								index_max := middle
							else
								index_min := middle
							end
						end
					end
					click_pos := clickable_position_list @ index_min
					if a_position <= click_pos.stop then
						if click_pos.is_feature then
							class_i := Universe.safe_class_named (click_pos.class_name, group)
							if class_i /= Void and then class_i.is_compiled and then class_i.compiled_class.has_feature_table then
								feat := class_i.compiled_class.feature_with_name (click_pos.feature_name)
								if feat /= Void then
									create {FEATURE_STONE} Result.make (feat)
								end
							end
						elseif click_pos.is_class then
							class_i := Universe.safe_class_named (click_pos.class_name, group)
							if class_i /= Void then
								if class_i.is_compiled then
									create {CLASSC_STONE} Result.make (class_i.compiled_class)
								else
									create {CLASSI_STONE} Result.make (class_i)
								end
							end
						end
					end
				end
			end
		end

	described_feature (token: EDITOR_TOKEN; line: EDITOR_LINE; ft: FEATURE_AS): E_FEATURE is
			-- search in feature represented by `ft' the feature associated with `token' if any
		require
			token_not_void: token /= Void
			line_not_void: line /= Void
			token_in_line: line.has_token (token)
		local
			l_type: TYPE_A
		do
			if is_ok_for_completion then
				initialize_context
				if current_class_c /= Void then
					if not token_image_is_in_array (token, unwanted_symbols) then
						if ft /= Void then
							current_feature_as := [ft, ft.feature_names.first]
						else
							current_feature_as := Void
						end
						error := False
						last_was_constrained := False
						last_feature := Void
						is_for_feature := True
						l_type := type_from (token, line)
						is_for_feature := False
						Result := last_feature
					end
				end
			end
		end

	last_feature: E_FEATURE
			-- Last feature found for PnD.

feature {NONE} -- Implementation (`type_from')

	type_from (token: EDITOR_TOKEN; line: EDITOR_LINE): TYPE_A is
			-- try to analyze class text to find type associated with word represented by `token'
		require
			token_not_void: token /= Void
			line_not_void: line /= Void
			token_in_line: line.has_token (token)
			current_class_c_not_void: current_class_c /= Void
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
			current_class_c_not_void: current_class_c /= Void
		local
			exp: LINKED_LIST [EDITOR_TOKEN]
			name: STRING
			par_cnt: INTEGER
			type: TYPE_A
			feat: E_FEATURE
			l_current_class_c: CLASS_C
			l_precursor_from: TYPE_A
			l_current_class_c_parents: FIXED_LIST [CL_TYPE_A]
		do
			from
				last_constraints := Void
				last_target_type := Void
				last_formal := Void
				last_was_constrained := False
				last_was_multi_constrained := False
				l_current_class_c := current_class_c
				written_class := current_class_c
				type := l_current_class_c.actual_type
				if token_image_is_same_as_word (current_token, "create") then
					go_to_next_token
					is_create := True
					error := not token_image_is_same_as_word (current_token, opening_brace)
					if not error then
						go_to_next_token
						error := current_token = Void
						if not error then
							type := type_of_class_corresponding_to_current_token
							skip_parenthesis (opening_brace, closing_brace)
						end
					end
				elseif token_image_is_same_as_word (current_token, opening_brace) then
						-- Static call {CLASS}.abc.abc
					go_to_next_token
					error := error or else current_token = Void
					if not error then
						type := type_of_class_corresponding_to_current_token
						skip_parenthesis (opening_brace, closing_brace)
					end
				elseif token_image_is_same_as_word (current_token, opening_parenthesis) then
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
						if token_image_is_same_as_word (current_token, closing_parenthesis) then
							par_cnt:= par_cnt - 1
						elseif token_image_is_same_as_word (current_token, opening_parenthesis) then
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
						type := complete_expression_type (exp)
						if type /= Void then
								-- Fixme: some problems here, type is possible multi-constaint.
							last_target_type := type
							if type.has_associated_class then
								written_class := type.associated_class
							end
						end
					end
				else
						-- "precursor" is safe to compare to STRING_8.
					name := string_32_to_lower (current_token.wide_image).as_string_8
					if name.is_equal ("precursor") then
						go_to_next_token
						if token_image_is_same_as_word (current_token, opening_brace) then
							go_to_next_token
							error := error or else current_token = Void
							if not error then
								l_precursor_from := type_of_class_corresponding_to_current_token
								skip_parenthesis (opening_brace, closing_brace)
								if l_precursor_from /= Void then
										-- Precursor {CLASS}: Result.associated_class /= Void
									check
										has_associated_class: l_precursor_from.has_associated_class
									end
									written_class := l_precursor_from.associated_class
									if l_precursor_from.associated_class.has_feature_table then
										feat := l_precursor_from.associated_class.feature_with_name (current_feature_as.name.internal_name.name)
									end
								end
							end
						else
							go_to_previous_token
							l_current_class_c_parents := l_current_class_c.parents
							if current_feature_as /= Void and then l_current_class_c_parents /= Void then
								from
									l_current_class_c_parents.start
								until
									feat /= Void or else l_current_class_c_parents.after
								loop
									l_precursor_from := l_current_class_c_parents.item
									check
										type_as_associated_class: type.has_associated_class
									end
									if type.associated_class.has_feature_table then
										feat := l_precursor_from.associated_class.feature_with_name (current_feature_as.name.internal_name.name)
										written_class := l_precursor_from.associated_class
									end
									l_current_class_c_parents.forth
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
						type := type_of_local_entity_named (name)
						if type = Void then
							type := type_of_constants_or_reserved_word (current_token)
						end
					else
							-- Found feature
						error := False
						type := feat.type
					end
				end
				go_to_next_token
				if not error and then token_image_is_same_as_word (current_token, opening_parenthesis) then
					skip_parenthesis (opening_parenthesis, closing_parenthesis)
					go_to_next_token
				end
					-- Here I go away from the `Result' to other variables, they are:
					-- `last_constraints' and `last_target_type'
					-- (I think it's better to use variable names with a comment as we somehow split up the paths.
					-- Using Result for the one case and `last_constraints' for mc is one possiblity. But it is asymetric.
					-- In each iteration we may meet multi constrained formals, in such a case
					-- `last_constraints' is used. `last_constraints' does _not_ contain any formals nor other typesets.
					-- Otherwise `last_target_type' is used.
				if type /= Void then
					if last_target_type /= Void then
						move_to_next_target (type, last_target_type, written_class)
					elseif last_constraints /= Void then
						move_to_next_target (type, last_constraints, written_class)
					else
						move_to_next_target (type, current_class_c.actual_type, written_class)
					end
				end
				if not error and then token_image_is_same_as_word (current_token, opening_bracket) then
					skip_parenthesis (opening_bracket, closing_bracket)
					go_to_next_token
					type := process_bracket_type
					if not error and then type /= Void then
							-- `written_class' has been set when `process_bracket_type'
						check
							written_class /= Void
						end
						if last_target_type /= Void then
							move_to_next_target (type, last_target_type, written_class)
						elseif last_constraints /= Void then
							move_to_next_target (type, last_constraints, written_class)
						end
					end
				end
				if not error then
					if after_searched_token then
						error := type = Void
					else
						error := type = Void or else not token_image_is_in_array (current_token, feature_call_separators)
						go_to_next_token
					end
				end
				last_feature := feat
			until
				error or else after_searched_token
			loop
					-- Safe to use STRING_8 to get type.
				name := string_32_to_lower (current_token.wide_image).as_string_8

				type := internal_type_from_name (name)

					-- Prepare for the next round
				if type /= Void then
						-- In case we have a formal type we will:
						-- * compute the flat version (without formals) of the constraints and store it in `last_constraints'
						-- In case we have an any other type (including an anchored) we will:
						-- * instantiate it and make it available in `last_target_type' right away.
					move_to_next_target (type, last_type, written_class)
				else
					error := True
				end

				go_to_next_token
				if token_image_is_same_as_word (current_token, opening_parenthesis) then
					skip_parenthesis (opening_parenthesis, closing_parenthesis)
					go_to_next_token
				end
				if not error and then token_image_is_same_as_word (current_token, opening_bracket) then
					skip_parenthesis (opening_bracket, closing_bracket)
					go_to_next_token
					type := process_bracket_type
					if not error and then type /= Void then
						check
							written_class /= Void
						end
						move_to_next_target (type, last_type, written_class)
					end
				end
				error := error or else not (after_searched_token or else token_image_is_same_as_word (current_token, "."))
				is_create := is_create and then after_searched_token
				go_to_next_token
			end
			if error then
				Result := Void
			else
				if last_target_type /= Void then
						-- ordinary: one type, one class
					Result := last_target_type
				else
						-- multi constraint: several classes provide features
					Result := last_constraints
				end
			end
		end

	internal_type_from_name (a_name: STRING): TYPE_A is
			--
		require
			a_name_not_void: a_name /= Void
		local
			l_feature_state: TUPLE [feature_item: E_FEATURE; class_type_of_feature: CL_TYPE_A; features_found_count: INTEGER; constraint_position: INTEGER]
			feat: E_FEATURE
			type: TYPE_A
			l_pos: INTEGER
			l_named_tuple_type: NAMED_TUPLE_TYPE_A
			l_processed_class: CLASS_C
		do
			if last_was_multi_constrained then
					-- We're in the multi constraint case.
					-- We have the constraining type set `last_constraints' and a feature name `a_name'.
					-- The objective is to compute `last_target_type' and to get a `E_FEATURE' instance
					-- of the feature named `a_name' and store it in `feat'.
				check last_target_type_not_known: last_target_type = Void end
				l_feature_state := last_constraints.e_feature_state_by_name (a_name)
				if l_feature_state.features_found_count = 0 then
						-- There's no feature with the name `a_name' in the type set.
					feat := Void
				elseif	l_feature_state.features_found_count = 1 then
						-- We found exactly one feautre, this is good.
						-- Let's store the class type to which the feature belongs into `last_target_type'.
					feat := l_feature_state.feature_item
					last_target_type := l_feature_state.class_type_of_feature
					written_class := last_target_type.associated_class
				else
						-- We don't provide a list, since the code doesn't compile already.
					feat := Void
				end
				if feat /= Void and then feat.type /= Void then
					type := feat.type
				else
					type := Void
				end
			else
				check
					Result_has_associated_class: last_target_type.has_associated_class
				end
				l_named_tuple_type ?= last_target_type
				l_processed_class := last_target_type.associated_class
				written_class := l_processed_class
				if l_processed_class /= Void and then l_processed_class.has_feature_table or l_named_tuple_type /= Void then
					type := Void
					if l_named_tuple_type /= Void then
						l_pos := l_named_tuple_type.label_position (a_name)
						if l_pos > 0 then
							type := l_named_tuple_type.generics.item (l_pos)
						end
						if type = Void then
							feat := l_processed_class.feature_with_name (a_name)
							if feat /= Void then
								type := feat.type
							end
						end
					else
						feat := l_processed_class.feature_with_name (a_name)
						if feat = Void and then last_was_constrained and then not last_formal.is_single_constraint_without_renaming (current_class_c) then
								-- Renamed in constaint clause?
							feat := feature_of_constaint_renamed (last_formal, a_name)
						end
						if feat /= Void then
							type := feat.type
						end
					end
				end
			end
			last_feature := feat
			Result := type
		end

	move_to_next_target (a_type, a_parent_type: TYPE_A; a_class: CLASS_C) is
			-- Makes the transition from `a_parent_type' to `a_type'.
			-- It binds a loose type and computes the proper constraints for formals.
			-- if you have `l_a.f.g', `l_a's type would be `a_parent type' and `f's type would be `a_type'.
			--
			-- `a_type' is a possible loose type (`is_lose')
			--| Non-loose types are not affected.
		require
			a_type_not_void: a_type /= Void
			a_class_not_void: a_class /= Void
		local
			l_class: CLASS_C
			l_is_named_tuple: BOOLEAN
		do
			if a_type.is_valid then
				l_is_named_tuple := a_parent_type.is_named_tuple
				l_class := current_class_c
				if a_type.is_loose then
					if l_is_named_tuple then
						last_target_type := a_type.actual_type.instantiation_in (a_type, a_class.class_id)
					else
						last_target_type := a_type.actual_type.instantiation_in (a_parent_type, a_class.class_id)
					end
					last_type := last_target_type
					if last_target_type /= Void and then last_target_type.is_valid then
						last_target_type := last_target_type.actual_type
						last_was_constrained := last_target_type.is_formal
						last_formal ?= last_target_type
						if last_was_constrained then
							last_was_multi_constrained := not last_formal.is_single_constraint_without_renaming (l_class)
							if last_was_multi_constrained then
									-- We're in the multi constraint case, let's compute a flat version (without formals) of all constraints.							
								last_constraints := last_formal.constraints (l_class).constraining_types_if_possible (l_class)
									-- We don't know yet the real target type (it'll be one out of last_constraints)
								last_target_type := Void
							else
								last_target_type := last_formal.constrained_type (l_class)
							end
						end
						error := False
					end
				else
						-- Non formal status.
					if not a_parent_type.is_tuple then
						last_target_type := a_type.actual_type.instantiation_in (a_parent_type, a_class.class_id)
					else
						last_target_type := a_type
					end

					last_type := last_target_type
					last_was_multi_constrained := False
					last_was_constrained := False
					error := False
				end
			end
		end

	create_before_position (a_line: EDITOR_LINE; a_token: EDITOR_TOKEN): BOOLEAN is
			-- is "create" preceeding current position ?
		do
			Result := locate_create_before_position (a_line, a_token) /= Void
		end

	locate_create_before_position (a_line: EDITOR_LINE; a_token: EDITOR_TOKEN): EDITOR_TOKEN is
			-- Attempts to locate "create" before token `a_token'
		local
			line: EDITOR_LINE
			token: EDITOR_TOKEN
			par_cnt: INTEGER
		do
			line := current_line
			current_line := a_line
			token := current_token
			current_token := a_token
			if not token_image_is_same_as_word (current_token, closing_brace) then
				go_to_previous_token
			end
			if token_image_is_same_as_word (current_token, Create_word) then
				Result := current_token
			end
			if Result = Void and then token_image_is_same_as_word (current_token, closing_brace) then
				from
					par_cnt := 1
				until
					par_cnt = 0 or else current_token = Void or else Result /= Void
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
					if token_image_is_same_as_word (current_token, create_word) then
						Result := current_token
					end
				end
			end
			current_token := token
			current_line := line
		end

	process_bracket_type: TYPE_A
			-- Process when encountering brackets.
		require
			a_process_type_not_void: written_class /= Void
		local
			type: TYPE_A
			l_feature: FEATURE_I
			l_class: CLASS_C
			l_type_set_a: TYPE_SET_A
			l_list: LIST [CLASS_C]
		do
			if last_was_multi_constrained then
					-- We're in the multi constraint case.
					-- We have the constraining type set `last_constraints' and a feature name `a_name'.
					-- The objective is to compute `last_target_type' and to get a `E_FEATURE' instance
					-- of the feature named `a_name' and store it in `feat'.
				check last_target_type_not_known: last_target_type = Void end
				l_type_set_a := last_constraints.constraining_types (written_class)
				l_list := l_type_set_a.associated_classes
				from
					l_list.start
				until
					l_list.after or else l_feature /= Void
				loop
					l_class := l_list.item
					if l_class.has_feature_table then
						l_feature := l_class.feature_table.alias_item (bracket_str)
						written_class := l_class
					end
					l_list.forth
				end
			elseif last_target_type /= Void then
				check
					has_associated_class: last_target_type.has_associated_class
				end
				if last_target_type.associated_class.has_feature_table then
					l_feature := last_target_type.associated_class.feature_table.alias_item (bracket_str)
					written_class := last_target_type.associated_class
				end
			end
			if l_feature /= Void then
				error := error or False
				type := l_feature.type
			else
				error := True
				written_class := Void
			end
				-- Bracket feature is never used by PnD, we ignore it.
			last_feature := Void
			Result := type
		ensure
			Result_not_void_implies_processed_class_not_void: Result /= Void implies written_class /= Void
		end

	feature_of_constaint_renamed (a_formal: FORMAL_A; a_new_name: STRING): E_FEATURE is
			-- Constaint renamed feature of current class.
		require
			a_formal_not_void: a_formal /= Void
			a_new_name_not_void: a_new_name /= Void
			current_class_c_not_void: current_class_c /= Void
		local
			l_renames: ARRAY [RENAMING_A]
			l_renaming: RENAMING_A
			i, upper, l_new_name_id, l_old_name_id: INTEGER
		do
			l_new_name_id := names_heap.id_of (a_new_name)
			l_renames := current_class_c.constraint_renaming (current_class_c.generics.i_th (last_formal.position))
			from
				i := l_renames.lower
				upper := l_renames.upper
			until
				i > upper or Result /= Void
			loop
				l_renaming := l_renames.item (i)
				if l_renaming /= Void then
					l_old_name_id := l_renaming.item (l_new_name_id)
					if l_old_name_id > 0 then
						Result := current_class_c.feature_with_name_id (l_old_name_id)
					end
				end
				i := i + 1
			end
		end

	written_class: CLASS_C

	last_type : TYPE_A
		-- Last type stores for `searched_type'.

feature {NONE}-- Implementation

	feature_part_at (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE): INTEGER is
			-- find in which part of the feature body `a_token' is
		local
			found: BOOLEAN
			token: EDITOR_TOKEN
			line: EDITOR_LINE
		do
			Result := no_interesting_part
			from
				token := a_token
				line := a_line
			until
				token = Void or found
			loop
				if is_keyword (token) then
					if token_image_is_in_array (token, feature_body_keywords) then
						found := True
						if token_image_is_in_array (token, feature_contract_keywords) then
							Result := assertion_part
						elseif token_image_is_in_array (token, feature_executable_keywords) then
							Result := instruction_part
						elseif token_image_is_in_array (token, feature_local_keywords) then
							Result := local_part
						end
					end
				end
				if token = line.first_token then
					if line.previous = Void then
						token := Void
					else
						line := line.previous
						token := line.eol_token
					end
				else
					token := token.previous
				end
			end
		end

	assertion_part: INTEGER is 1

	instruction_part: INTEGER is 2

	local_part: INTEGER is 3

	no_interesting_part: INTEGER is 4

	find_expression_start is
			-- find where to begin the analysis (set current_token/line)
		local
			par_cnt: INTEGER
			stop: BOOLEAN
			l_token : EDITOR_TOKEN
			l_line: EDITOR_LINE
		do
			if token_image_is_same_as_word (current_token, closing_bracket) then
				go_to_previous_token
				skip_parenthesis_backward (opening_bracket, closing_bracket)
				go_to_previous_token
				if token_image_is_same_as_word (current_token, closing_brace) then
						-- Precursor {CLASS} [i].
					go_to_previous_token
					skip_parenthesis_backward (opening_brace, closing_brace)
					go_to_previous_token
				end
			end
			if found_precursor then
					-- Precursor {CLASS}.
				if token_image_is_same_as_word (current_token, closing_brace) then
					go_to_previous_token
					skip_parenthesis_backward (opening_brace, closing_brace)
					go_to_previous_token
				end
			end
			go_to_previous_token
			if current_token /= Void then
				if
						-- not the "~feature" case
					current_token.wide_image.is_empty
						or else
					current_token.wide_image @ 1 /= ('%L').to_character_32
						or else
					not is_beginning_of_expression (current_token.previous)
				then
					from
					until
						error or stop or else not token_image_is_in_array (current_token, feature_call_separators)
					loop
						go_to_previous_token
						stop := False
						if token_image_is_same_as_word (current_token, Closing_parenthesis) then
								-- if we find a closing parenthesis, we go directly to the corresponding
								-- opening parenthesis
							go_to_previous_token
							skip_parenthesis_backward (opening_parenthesis, closing_parenthesis)
							error := current_token = Void
								-- we reached the closing parenthesis
								-- we go back one token further if parenthesis seem to be arguments
							go_to_previous_token
							stop := token_image_is_in_array (current_token, closing_separators) or else
								token_image_is_in_array (current_token, parenthesis) or else
									(is_keyword (current_token) and then not token_image_is_in_array (current_token, special_keywords))
						end
						if token_image_is_same_as_word (current_token, closing_bracket) then
								-- if we find a closing parenthesis, we go directly to the corresponding
								-- opening parenthesis
							go_to_previous_token
							skip_parenthesis_backward (opening_bracket, closing_bracket)
							error := current_token = Void
								-- we reached the closing parenthesis
								-- we go back one token further if parenthesis seem to be arguments
							go_to_previous_token
							stop := token_image_is_in_array (current_token, closing_separators) or else
								token_image_is_in_array (current_token, parenthesis) or else
									(is_keyword (current_token) and then not token_image_is_in_array (current_token, special_keywords))
						end
						if not stop then
								-- Try to find create {CLASS}Result.make
							go_to_previous_token
							if not token_image_is_same_as_word (current_token, Closing_brace) then
								go_to_next_token
							end
								-- special case with "create" and "Precursor"
							if token_image_is_same_as_word (current_token, Closing_brace) then
								from
									par_cnt:= - 1
								until
									par_cnt = 0 or else current_token = Void
								loop
									go_to_previous_token
									if token_image_is_same_as_word (current_token, Closing_brace) then
										par_cnt:= par_cnt - 1
									elseif token_image_is_same_as_word (current_token, Opening_brace) then
										par_cnt:= par_cnt + 1
									end
								end
								l_token := current_token
								l_line := current_line

								go_to_previous_token

								if current_token = Void then
									error := True
								else
									if not token_image_is_in_array (current_token, special_keywords) then
										current_token := l_token
										current_line := l_line
									end
								end
							end
							go_to_previous_token
						end
					end
				end
					-- loop stopped : we went one token too far
				go_to_next_token
			end
			error := current_token = Void or else error
		end

	complete_expression_type (exp: LINKED_LIST[EDITOR_TOKEN]): TYPE_A is
			-- analyze expression represented by list of token `exp'
		require
			exp_not_void: exp /= Void
			current_class_c_not_void: current_class_c /= Void
		local
			sub_exp: like exp
			infix_expected: BOOLEAN
			infix_list: ARRAYED_LIST[STRING]
			expression_table: ARRAYED_LIST [LINKED_LIST[EDITOR_TOKEN]]
			type_list: LINKED_LIST [TYPE_A]
			par_cnt: INTEGER
			stop: BOOLEAN
		do
				-- first, we check that the expression can be analyzed, i.e. there is a sequence
				-- sub_expression infix sub_expression ...
				-- we store those sub_expression in `expression_table'
			from
				exp.start
				create infix_list.make(0)
				create expression_table.make(0)
			until
				exp.after or else error
			loop
				if infix_expected then
						-- the infix must be in our list
						-- otherwise, we will not analyze this expression
					if is_known_infix (exp.item) then
							-- Disallow infix rather than ASCII.
						infix_list.extend (exp.item.wide_image.as_string_8)
					else
						error := True
					end
					exp.forth
					infix_expected := False
				else
					from
					until
						exp.after or else not is_known_prefix (exp.item)
					loop
--| FIXME ? 						-- as for all known prefix the returned type equals to the base type,
							-- we forget about them
						exp.forth
					end
					create sub_exp.make
					stop := False
					error := exp.after
					if not error then
						if token_image_is_same_as_word (exp.item, Opening_parenthesis) then
								-- if there is a parenthesis, we fill the new `sub_exp' with what's inside
							from
								par_cnt := 1
								sub_exp.extend (exp.item)
							until
								par_cnt = 0 or else exp.after
							loop
								exp.forth
								if not exp.after then
									sub_exp.extend (exp.item)
									if token_image_is_same_as_word (exp.item, Closing_parenthesis) then
										par_cnt := par_cnt - 1
									elseif token_image_is_same_as_word (exp.item, Opening_parenthesis) then
										par_cnt := par_cnt + 1
									end
								end
							end
							if exp.after or else sub_exp.count < 1 then
								error := True
							else
								exp.forth
									-- we now look if there is a feature call after closing parenthesis
								if not exp.after then
									if token_image_is_in_array (exp.item, feature_call_separators) then
										sub_exp.extend (exp.item)
										exp.forth
										if exp.after then
											error := True
										end
									else
										stop := True
									end
								end
							end
						end
					end
					from

					until
						error or else exp.after or else stop
					loop
						sub_exp.extend (exp.item)
						exp.forth
							-- if it is a function, we skip the arguments
							-- we do not need them to knw the returned type
						if not exp.after then
							if token_image_is_same_as_word (exp.item, Opening_parenthesis) then
								from
									par_cnt := 1
								until
									par_cnt = 0 or else exp.after
								loop
									exp.forth
									if token_image_is_same_as_word (exp.item, Closing_parenthesis) then
										par_cnt := par_cnt - 1
									elseif token_image_is_same_as_word (exp.item, Opening_parenthesis) then
										par_cnt := par_cnt + 1
									end
								end
								if exp.after then
									error := True
								else
									exp.forth
								end
							end
							if not exp.after then
								if token_image_is_in_array (exp.item, feature_call_separators) then
									sub_exp.extend (exp.item)
									exp.forth
									if exp.after then
										error := True
									end
								else
									stop := True
								end
							end
						end
					end
					if not error then
						expression_table.extend (sub_exp)
						infix_expected := True
					end
				end
			end
			error := error or else not infix_expected
			if not error then
				type_list := corresponding_type_list (expression_table)
				if type_list /= Void then
					if type_list.count = 1 then
						Result := type_list.first
					elseif type_list.count = infix_list.count + 1 then
						Result := expression_type (type_list, infix_list)
					end
				end
			end
		end

	expression_type (type_list: LINKED_LIST [TYPE_A]; infix_list: ARRAYED_LIST[STRING]): TYPE_A is
			-- find type of expression represented by the list of operands type `type_list' and list of operators `infix_list'
		require
			infix_list_not_void: infix_list /= Void
			type_list_not_void: type_list /= Void
			current_class_c_not_void: current_class_c /= Void
		local
			priority: LINKED_LIST[INTEGER]
			index: INTEGER
		do
			create priority.make
			from
				infix_groups.start
			until
				infix_groups.after
			loop
				infix_groups.item.compare_objects
				from
					infix_list.start
				until
					infix_list.after
				loop
					if infix_groups.item.has (infix_list.item) then
						priority.extend (infix_list.index)
					end
					infix_list.forth
				end
				infix_groups.forth
			end
			from

			until
				error or priority.is_empty
			loop
				priority.start
				type_list.start
				index := priority.item
				priority.remove
				from
					priority.start
				until
					priority.after
				loop
					if priority.item > index then
						priority.replace(priority.item - 1)
					end
					priority.forth
				end
				type_list.go_i_th (index)
				infix_list.go_i_th (index)
				Result := type_returned_by_infix (type_list.item, infix_list.item)
				if Result = Void then
					error := True
				else
					type_list.remove
					type_list.replace (Result)
					infix_list.remove
				end
			end
			if error then
				Result := Void
			end
		end

	corresponding_type_list (expression_table: ARRAYED_LIST [LINKED_LIST[EDITOR_TOKEN]]): LINKED_LIST [TYPE_A] is
			-- create list of type from a list of expression (represented by lists of tokens)
		require
			expression_table_not_void: expression_table /= Void
			current_class_c_not_void: current_class_c /= Void
		local
			sub_exp, recur_exp: LINKED_LIST[EDITOR_TOKEN]
			l_type_set: TYPE_SET_A
			type: TYPE_A
			par_cnt: INTEGER
			name: STRING
			l_processed_class: CLASS_C
			processed_feature: E_FEATURE
			formal: FORMAL_A
			l_current_class_c: CLASS_C
		do
			l_current_class_c := current_class_c
			create Result.make
			from
				expression_table.start
			until
				error or else expression_table.after
			loop
				sub_exp := expression_table.item
				expression_table.forth
				from
					sub_exp.start
					if token_image_is_same_as_word (sub_exp.item, Opening_parenthesis) then
							-- Arguments have not been inserted in this list.
							-- If there are parenthesis, it is an independent expression
						create recur_exp.make
						from
							par_cnt := 1
						until
							par_cnt = 0 or else sub_exp.after
						loop
							sub_exp.forth
							if not sub_exp.after then
								recur_exp.extend (sub_exp.item)
								if token_image_is_same_as_word (sub_exp.item, Closing_parenthesis) then
									par_cnt := par_cnt - 1
								elseif token_image_is_same_as_word (sub_exp.item, Opening_parenthesis) then
									par_cnt := par_cnt + 1
								end
							end
						end
						if sub_exp.after or else recur_exp.count < 1 then
							error := True
						else
								-- recur_exp contains the closing parenthesis. We remove it.
							recur_exp.finish
							recur_exp.remove
							type := complete_expression_type (recur_exp)
						end
					else
							-- type is Void
							-- Safe to get feature from STRING_8.
						name := string_32_to_lower (sub_exp.item.wide_image).as_string_8
						if l_current_class_c.has_feature_table then
							processed_feature := l_current_class_c.feature_with_name (name)
						end
						if processed_feature /= Void then
							if processed_feature.type /= Void then
								if processed_feature.type.is_formal then
									formal ?= processed_feature.type
									type := l_current_class_c.actual_type
									if
										type /= Void and then
										type.has_generics and then
										type.generics.valid_index (formal.position)
									then
										type := type.generics @ (formal.position)
										error := False
									end
								else
									type := processed_feature.type
								end
							end
						else
							type := type_of_local_entity_named (name)
							if type = Void then
								type := type_of_constants_or_reserved_word (sub_exp.item)
							end
						end
						error := type = Void
					end
					sub_exp.forth
				until
					error or else sub_exp.after
				loop
					if token_image_is_in_array (sub_exp.item, feature_call_separators) then
						sub_exp.forth
						if sub_exp.after then
							error := True
						else
								-- Safe to get feature from STRING_8.
							name := string_32_to_lower (sub_exp.item.wide_image).as_string_8
							if type.is_formal then
								formal ?= type
								if l_current_class_c.is_valid_formal_position (formal.position) then
									if formal.is_single_constraint_without_renaming (l_current_class_c) then
										type := formal.constrained_type_if_possible (l_current_class_c)
									else
										l_type_set := formal.constrained_types_if_possible (l_current_class_c)
									end
								else
									-- TODO: Can this case ever occur in a valid system?
								end
							end
							if type.has_associated_class then
									-- This case includes the ordinary case and the case were we had
									-- a single constrained formal without a renaming (constrained_type has been called).
								l_processed_class := type.associated_class
								if l_processed_class /= Void and then l_processed_class.has_feature_table then
									processed_feature := l_processed_class.feature_with_name (name)
								end
							else
									-- Maybe we computed a type set?
								if l_type_set /= Void then
									processed_feature := l_type_set.e_feature_state_by_name (name).feature_item
								end
							end
								-- Set to `Void' as we are in a loop.
							type := Void
							l_type_set := Void
								-- If we found a feature continue...
								if processed_feature /= Void and then processed_feature.type /= Void then
									if processed_feature.type.is_formal then
										formal ?= processed_feature.type
										if
											type /= Void and then
											type.has_generics and then
											type.generics.valid_index (formal.position)
										then
											type := type.generics @ (formal.position)
										end
									else
										type := processed_feature.type
									end
								end
							sub_exp.forth
						end
					else
						type := Void
					end
					error := type = Void
				end
				if not error then
					Result.extend (type)
				end
			end
			if error then
				Result := Void
			end
		end

	type_of_class_corresponding_to_current_token: TYPE_A is
		require
			group_not_void: group /= Void
			group_is_valid: group.is_valid
		local
			cc_stone: CLASSC_STONE
			image: STRING
			class_i: CLASS_I
			l_token: EDITOR_TOKEN
			l_feat: E_FEATURE
		do
			found_class := Void
			cc_stone ?= stone_in_click_ast (current_token.pos_in_text)
			if cc_stone /= Void and then cc_stone.e_class /= Void then
				found_class := cc_stone.e_class
				Result := found_class.actual_type
			end
			if Result = Void then
					-- Class name can only be STRING_8.
				image := string_32_to_upper (current_token.wide_image).as_string_8
				class_i := Universe.safe_class_named (image, group)
				if class_i /= Void and then class_i.is_compiled then
					found_class := class_i.compiled_class
					Result := found_class.actual_type
				end
			end
			if Result = Void then
					-- "like" is safe to compare to STRING_8.
				image := string_32_to_lower (current_token.wide_image).as_string_8
				if image.is_equal ("like") then
					if current_token.next /= Void and then current_token.next.next /= Void then
						l_token := current_token.next.next
						if l_token.is_text then
								-- A feature name is safe to compare to STRING_8.
							image := string_32_to_lower (l_token.wide_image).as_string_8
							if current_class_c /= Void then
								l_feat := current_class_c.feature_with_name (image)
								if l_feat /= Void then
									Result := l_feat.type
								end
								if Result = Void then
									Result := type_of_local_entity_named (image)
								end
								if Result = Void then
									Result := type_of_constants_or_reserved_word (l_token)
								end
							end
						end
					end
				end
				if Result = Void then
						-- Safe get type of generic by STING_8.
					Result := type_of_generic (current_token.wide_image.as_string_8)
				end
				if Result /= Void then
					if not Result.is_loose then
						found_class := Result.associated_class
					end
				end
			end
		end

	found_class: CLASS_C

	type_returned_by_infix (a_type: TYPE_A; a_name: STRING): TYPE_A is
			-- type returned by operator named `name' applied on type `a_type'
		require
			a_type_not_void: a_type /= Void
			a_name_not_void: a_name /= Void
			current_class_c_not_void: current_class_c /= Void
		local
			name: STRING
			feat: E_FEATURE
			cls_c: CLASS_C
			formal: FORMAL_A
		do
			name := a_name.as_lower
			if name.is_equal (Equal_sign) or name.is_equal (Different_sign) then
				Result := boolean_type
			else
				cls_c := a_type.associated_class
				if cls_c /= Void and then cls_c.has_feature_table then
					written_class := cls_c
					feat := cls_c.feature_with_name (infix_feature_name_with_symbol (name))
					if feat /= Void and then feat.type /= Void then
						Result := feat.type
						if Result.is_formal then
							formal ?= Result
							if formal /= Void and then a_type.has_generics and then a_type.generics.valid_index (formal.position) then
								Result := a_type.generics @ (formal.position)
							end
						end
					end
				end
			end
		end

	type_of_local_entity_named (a_name: STRING): TYPE_A is
			-- return type of argument or local variable named `name' found in `current_feature_as'
			-- Void if there is none
		require
			current_class_c_not_void: current_class_c /= Void
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		local
			l_token: EDITOR_TOKEN
			l_line: EDITOR_LINE
			l_name: STRING_32
			l_analyzer: !ES_EDITOR_CLASS_ANALYZER
			l_result: ?ES_EDITOR_ANALYZER_STATE_INFO
			l_locals: !HASH_TABLE [?TYPE_A, STRING_32]
			l_feature: like current_feature_i
			l_class: like current_class_c
			retried: BOOLEAN
		do
			if not retried then
				l_feature := current_feature_i
				l_class := current_class_c
				if l_feature /= Void and then l_class /= Void and then a_name /= Void and then not a_name.is_empty then
					l_token := current_token
					l_line := current_line
					if l_token /= Void and then l_line /= Void then
						create l_analyzer.make_with_feature (l_class, l_feature)
						l_result := l_analyzer.scan (l_token, l_line)
						if l_result /= Void and then l_result.has_current_frame then
							if not l_result.current_frame.is_empty then
								l_locals := l_result.current_frame.all_locals
								l_name := a_name.as_string_32
								if l_locals.has (l_name) then
									Result := l_locals.item (l_name)
								end
							end
						end
					end
				end
			end
		rescue
			retried := True
			retry
		end

	type_of_constants_or_reserved_word (token: EDITOR_TOKEN): TYPE_A is
			-- return type associated with `token' if it represents a constant
			-- or a reserved word. If not, return Void
		require
			current_class_c_not_void: current_class_c /= Void
		local
			nb: EDITOR_TOKEN_NUMBER
			ch: EDITOR_TOKEN_CHARACTER
			current_feature: E_FEATURE
			l_current_class_c: CLASS_C
		do
			if is_keyword (token) then
				l_current_class_c := current_class_c
				if token_image_is_same_as_word (token, Current_word) then
					Result := l_current_class_c.actual_type
				elseif
					token_image_is_same_as_word (token, Result_word) and then
					current_feature_as /= Void and then l_current_class_c.has_feature_table
				then
						-- First check the local declarations
					Result := type_of_local_entity_named ({EIFFEL_KEYWORD_CONSTANTS}.result_keyword)
					if Result = Void then
							-- Used the compiled information
						current_feature := l_current_class_c.feature_with_name (
							current_feature_as.name.internal_name.name)
						if current_feature /= Void then
							Result := current_feature.type
						end
					end
				elseif token_image_is_in_array (token, boolean_values) then
					Result := boolean_type
				end
			else
				nb ?= token
				if nb /= Void then
					if nb.wide_image.occurrences('.') > 0 then
						Result := real_64_type
					else
						Result := integer_type
					end
				else
					ch ?= token
					if ch /= Void then
						Result := character_type
					end
				end
			end
--| FIXME: Missing manifest arrays and strings
		end

	type_of_generic (a_str: STRING): TYPE_A is
			-- Type a formal generic
		require
			a_str_not_void: a_str /= Void
			current_class_c_not_void: current_class_c /= Void
		local
			l_gens: EIFFEL_LIST [FORMAL_DEC_AS]
			l_des_as: FORMAL_DEC_AS
			end_loop: BOOLEAN
		do
			l_gens := current_class_c.generics
			if l_gens /= Void then
				from
					l_gens.start
				until
					l_gens.after or else end_loop
				loop
					if a_str.is_equal (l_gens.item.name.name) then
						end_loop := True
						l_des_as := l_gens.item
						create {FORMAL_A}Result.make (l_des_as.is_reference, l_des_as.is_expanded, l_des_as.position)
					end
					l_gens.forth
				end
			end
		end

feature {NONE}-- Implementation

	local_evaluated_type (a_type: TYPE_AS; a_current_class: CLASS_C; a_feature: FEATURE_I): TYPE_A is
			-- Given `a_type' from AST resolve its type in `a_current_class' for feature called
			-- `a_feature_name'.
		require
			a_type_not_void: a_type /= Void
			a_current_class_not_void: a_current_class /= Void
			a_feature_not_void: a_feature /= Void
		local
			l_feat: FEATURE_I
		do
			l_feat := a_feature
			type_a_checker.init_for_checking (l_feat, a_current_class, Void, Void)
			Result := type_a_generator.evaluate_type_if_possible (a_type, a_current_class)
			if Result /= Void then
				Result := type_a_checker.solved (Result, a_type)
			end
		end

	after_searched_token: BOOLEAN is
			-- is `current_token' after `searched_token' ?
			-- True if `current_token' is Void
		local
			l_cur_index, l_searched_index: INTEGER
		do
			if current_token = Void then
				Result := True
			else
				check
					current_line_is_valid: current_line.is_valid
					searched_line_is_valid: searched_line.is_valid
				end
				l_cur_index := current_line.index
				l_searched_index := searched_line.index
				Result := (l_cur_index > l_searched_index) or else
					((l_cur_index = l_searched_index) and then (current_token.position > searched_token.position))
			end
		end

	go_to_previous_token is
			-- move current token backward if possible
		local
			found: BOOLEAN
			uncomplete_string: BOOLEAN
		do
			check
				current_line_attached: current_token /= Void implies current_line /= Void
			end
			if current_token /= Void and current_line /= Void then
				from
					if is_string (current_token) and then not current_token.wide_image.is_empty then
							-- we check if there is a string split on several lines
						if current_token.wide_image @ 1 = ('%%').to_character_32 then
							uncomplete_string := True
						end
					end
						-- we move to previous token, if  there is one
					if current_token /= current_line.first_token then
						current_token := current_token.previous
					elseif current_line.previous /= Void then
						current_line := current_line.previous
						current_token := current_line.eol_token
					else
						current_token := Void
					end
						-- we will go backward until current_token is text (not comment, string, blank or eol)
				until
					current_token = Void or found
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
							elseif current_line.previous /= Void then
								current_line := current_line.previous
								current_token := current_line.eol_token
							else
								current_token := Void
							end
						else
							if is_string (current_token) and then not current_token.wide_image.is_empty then
									-- we check if a string is split on several lines
								if current_token.wide_image @ 1 = ('%%').to_character_32 then
									uncomplete_string := True
								else
										-- if the string is on one lines, we skip it
									if current_token /= current_line.first_token then
										current_token := current_token.previous
									elseif current_line.previous /= Void then
										current_line := current_line.previous
										current_token := current_line.eol_token
									else
										current_token := Void
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
							elseif current_line.previous /= Void then
								current_line := current_line.previous
								current_token := current_line.eol_token
						else
							current_token := Void
						end
					end
				end
			end
			if current_token = Void then
				current_line := Void
			end
		end

	go_to_next_token is
			-- move current token forward if possible
		local
			found: BOOLEAN
			uncomplete_string: BOOLEAN
		do
			check
				current_line_attached: current_token /= Void implies current_line /= Void
			end
			if current_token /= Void and current_line /= Void then
				from
					if is_string (current_token) and then not current_token.wide_image.is_empty then
							-- we check if there is a string split on several lines
						if current_token.wide_image @ current_token.wide_image.count = ('%%').to_character_32 then
							uncomplete_string := True
						end
					end
						-- we move to previous token, if there is one
					if current_token.next /= Void then
						current_token := current_token.next
					elseif current_line.next /= Void then
						current_line := current_line.next
						current_token := current_line.first_token
					else
						current_token := Void
					end
						-- we will go backward until current_token is text (not comment, string, blank or eol)
				until
					current_token = Void or found
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
							elseif current_line.next /= Void then
								current_line := current_line.next
								current_token := current_line.first_token
							else
								current_token := Void
							end
						else
							if is_string (current_token) and then not current_token.wide_image.is_empty then
									-- we check if a string is split on several lines
								if current_token.wide_image @ 1 = ('%%').to_character_32 then
									uncomplete_string := True
								else
										-- if the string is on one lines, we skip it
									if current_token.next /= Void then
										current_token := current_token.next
									elseif current_line.next /= Void then
										current_line := current_line.next
										current_token := current_line.first_token
									else
										current_token := Void
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
						elseif current_line.next /= Void then
							current_line := current_line.next
							current_token := current_line.first_token
						else
							current_token := Void
						end
					end
				end
			end
			if current_token = Void then
				current_line := Void
			end
		end

	skip_parenthesis (opening_char, closing_char: STRING) is
		local
			op, cl: STRING
			par_cnt: INTEGER
		do
			op := opening_char
			cl := closing_char
			from
				par_cnt:= 1
			until
				par_cnt = 0 or else current_token = Void
			loop
				go_to_next_token
				if token_image_is_same_as_word (current_token, cl) then
					par_cnt:= par_cnt - 1
				elseif token_image_is_same_as_word (current_token, op) then
					par_cnt:= par_cnt + 1
				end
			end
			error := error or else current_token = Void
		end

	skip_parenthesis_backward (opening_char, closing_char: STRING) is
		local
			op, cl: STRING
			par_cnt: INTEGER
		do
			op := opening_char
			cl := closing_char
			from
				par_cnt:= 1
			until
				par_cnt = 0 or else current_token = Void
			loop
				go_to_previous_token
				if token_image_is_same_as_word (current_token, op) then
					par_cnt:= par_cnt - 1
				elseif token_image_is_same_as_word (current_token, cl) then
					par_cnt:= par_cnt + 1
				end
			end
			error := error or else current_token = Void
		end

feature {NONE} -- Implementation

	is_ok_for_completion: BOOLEAN is
			-- Can we perform completion?
		do
			Result := group /= Void and then group.is_valid
			if Result then
				Result := not workbench.is_compiling or else workbench.last_reached_degree < 6
			end
		end

	initialize_context is
			-- Initialize `current_class_i'.
		require
			is_ok_for_completion: is_ok_for_completion
		local
			class_c: CLASS_C
			l_classi: CLASS_I
			l_overrides: ARRAYED_LIST [CONF_CLASS]
		do
			if current_class_i /= Void then
				if current_class_i.is_compiled then
						-- If current_class_i is an overriden class,
						-- we do not try analysing its compiling infomation.
					if current_class_i.config_class.is_overriden then
						class_c := Void
					else
						class_c := current_class_i.compiled_class
					end
				elseif current_class_i.config_class.does_override then
						-- If a class is an overriding class, we take its overrides and
						-- try analysing one of them compiled.
					from
						l_overrides := current_class_i.config_class.overrides
						l_overrides.start
					until
						class_c /= Void or l_overrides.after
					loop
						if l_overrides.item.is_compiled then
							l_classi ?= l_overrides.item
							check
								class_i: l_classi /= Void
							end
							class_c := l_classi.compiled_class
						end
						l_overrides.forth
					end
				else
					class_c := Void
				end
				if class_c /= Void then
					current_class_c := class_c
				end
			end
		end

	current_class_i: CLASS_I
			-- current class

	current_class_c: CLASS_C
			-- Current class_c
			-- Temp class_c, it could be an overriding class_c, while `current_class_i' is not compiled.

	current_feature_i: FEATURE_I is
			-- Current feature_i
		local
			l_current_class_c: CLASS_C
		do
			if current_class_c /= Void then
				l_current_class_c := current_class_c
				if l_current_class_c.has_feature_table then
					if current_feature_as /= Void then
						Result := l_current_class_c.feature_named (current_feature_as.name.internal_name.name)
					end
				end
					-- We hack here to avoid current feature void.
					-- type_a_checker only need a feature for like_argument checking.
					-- So it goes here only when we try to analyse a name within a typed feature
					-- which is after a saved but not compiled feature.
					-- It 90% works, only fails when we try to find a type that is a like_argument.
				if Result = Void then
					Result := l_current_class_c.feature_named ("is_equal")
				end
			end
		end

	platform_is_windows: BOOLEAN is
			-- Is the current platform Windows?
		once
			Result := (create {PLATFORM_CONSTANTS}).is_windows
		end

feature {NONE} -- Implementation

	is_sorted (positions: ARRAY [EB_CLICKABLE_POSITION]): BOOLEAN is
			-- is `positions' sorted ?
			-- for check purpose only
		local
			i: INTEGER
			count: INTEGER
		do
			from
				i := 2
				count := positions.count
				Result := True
			until
				(not Result) or else  i > positions.count
			loop
				Result := positions.item (i - 1) < positions.item (i)
				i := i + 1
			end
		end

	item_greater_than (i: INTEGER; table: ARRAY[INTEGER]): INTEGER is
			-- search in `table', which has to be sorted, the index of the first
			-- item greater than `i'
			-- returns 0 if there is none
		local
			index_min, index_max, middle: INTEGER
			position: INTEGER
		do
			index_min := 1
			index_max := table.count
			if i >= table @ 1 then
					-- search in the list
				if i >= table @ index_max then
					index_min := index_max
				else
					from

					until
						index_min >= index_max - 1
					loop
						middle := index_min + (index_max - index_min) // 2
						position := table @ middle
						if position > i then
							index_max := middle
						else
							index_min := middle
						end
					end
				end
				Result := index_min
			end
		end

	last_was_constrained: BOOLEAN
			-- Last type of class name was constrained?

	last_was_multi_constrained: BOOLEAN
			-- Last type of class name was multi constrained?

	last_formal: FORMAL_A

	last_target_type: TYPE_A
			-- Type of last target.
			-- It is `Void' for multi constraints until it gets selected by a single found feature.

	last_constraints: TYPE_SET_A
			-- Constraints of last_formal for the multi constraint case.
			-- This is Void for the single constraint case.
			-- If not Void `last_target_type' will be computed by using the supplied feature name and `last_constraints'
			-- So `last_target_type' is actually a member of the `last_constraints' type set.
			-- does _not_ contain any formals nor other typesets.

feature {EB_COMPLETION_POSSIBILITIES_PROVIDER} -- Constants

	boolean_values: ARRAY [STRING] is
		once
			Result := <<"True", "False">>
		end

	feature_call_separators: ARRAY [STRING] is
		once
			Result := <<".", "~">>
		end

	unwanted_symbols: ARRAY [STRING] is
		once
			Result := <<".", "(", "{", "[", "]", "}", ")", "$">>
		end

	feature_body_keywords: ARRAY [STRING] is
		once
			Result := <<"obsolete", "require", "local", "do", "once", "deferred", "ensure", "recue", "unique", "is", "assign">>
		end

	feature_contract_keywords: ARRAY [STRING] is
		once
			Result := <<"require", "ensure">>
		end

	feature_executable_keywords: ARRAY [STRING] is
		once
				-- We treat assgin as fake executable.
			Result := <<"do", "once", "rescue", "assign">>
		end

	feature_local_keywords: ARRAY [STRING] is
		once
			Result := <<"local">>
		end

	special_keywords: ARRAY [STRING] is
		once
			Result := <<"create", "precursor", "result">>
		end

	parenthesis: ARRAY [STRING] is
		once
			Result := <<"(", ")">>
		end

	closing_separators: ARRAY [STRING] is
		once
			Result := <<":=", "?=", ";", ",">>
		end

	infix_groups: LINKED_LIST[ARRAY[STRING]] is
			-- list of operators groups, sorted by priority
		once
			create Result.make
			Result.extend (<<"@">>)
			Result.extend (<<"^">>)
			Result.extend (<<"*", "/", "//", "\\">>)
			Result.extend (<<"+", "-">>)
			Result.extend (<<"/=", "=", ">", ">=", "<", "<=">>)
			Result.extend (<<"and">>)
			Result.extend (<<"xor">>)
			Result.extend (<<"or">>)
			Result.extend (<<"implies">>)
		end

invariant

	current_token_in_current_line: (current_line = Void and current_token = Void) or else (current_line /= Void and then current_line.has_token (current_token))

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

end -- class EB_CLASS_INFO_ANALYZER
