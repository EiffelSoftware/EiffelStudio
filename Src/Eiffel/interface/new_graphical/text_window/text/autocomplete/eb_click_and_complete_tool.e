﻿note
	description: "Objects that analyze search the editor content for clickable position"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne AMODEO"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLICK_AND_COMPLETE_TOOL

inherit
	EB_COMPLETE_INFO_ANALYZER
		rename
			build_feature_completion_list as build_feature_completion_list_analyse,
			build_class_completion_list as build_class_completion_list_analyse,
			build_alias_name_completion_list as build_alias_name_completion_list_analyse
		redefine
			reset
		end

create

	default_create

feature -- Initialization

	initialize (a_content: CLICKABLE_TEXT; a_class: CLASS_I; a_group: like group; after_save: BOOLEAN)
			-- initialize the tool before analyzing a class called `a_classname' located in cluster called `a_cluster_name'
			-- `a_content' is text of this class
		require
			a_content_is_not_void: a_content /= Void
			a_class_is_not_void: a_class /= Void
			a_group_is_not_void: a_group /= Void
			a_group_is_vaild: a_group.is_valid
		do
			current_class_i := a_class
			group := a_group
			content := a_content
			is_ready := False
			can_analyze_current_class := False
			if is_ok_for_completion then
				initialize_context
				if attached current_class_c as cl_c then
					generate_ast (cl_c, after_save)
					can_analyze_current_class := current_class_as /= Void
				end
			end
		end

	reset_setup_lines_variables
			-- reinitialize variables used by `setup_lines'
			-- to be executed before `setup_lines' is launched for the first time
		require
			features_position_not_void: features_position /= Void
		do
			pos_in_file := 1
			split_string := False
			features_position.start
		end

	reset
			-- set class attributes to default values
		do
			Precursor {EB_COMPLETE_INFO_ANALYZER}
			reset_after_search
		end

feature {NONE} -- Access

	code_templates: DS_BILINEAR [ES_CODE_TEMPLATE_DEFINITION]
			-- Code template definitions for snippets.
		require
			code_template_catalog_is_service_available: code_template_catalog.service /= Void
		do
			if attached code_template_catalog.service as l_service then
				Result := l_service.code_templates
			else
				create {DS_ARRAYED_LIST [ES_CODE_TEMPLATE_DEFINITION]} Result.make_default
			end
		end

feature -- Analysis preparation

	prepare_on_click_analysis
			-- gather information necessary to analysis
		do
			set_indexes
			make_click_list_from_ast
			is_ready := True
		end

	setup_line (a_line: EIFFEL_EDITOR_LINE)
			-- set the `pos_in_text' attribute of interesting tokens.
		require
			class_as_already_built: current_class_as /= Void
			line_not_void: a_line /= Void
			features_position_not_void: features_position /= Void
		local
			token, prev, next: EDITOR_TOKEN
			tfs: EDITOR_TOKEN_FEATURE_START
			line: EIFFEL_EDITOR_LINE
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
					else
							-- "Normal" text token
						if not split_string and then not features_position.after and then pos_in_file >= features_position.item.start_pos then
								-- `current_token' is the beginning of a feature
								-- we replace this text token with a "feature start token"
							prev := token.previous
							next := token.next
							create {EDITOR_TOKEN_FEATURE_START} tfs.make_with_pos (token.wide_image,
								features_position.item.start_pos, features_position.item.end_pos)
							if
								is_string (token)
								or else (
									attached {EDITOR_TOKEN_FEATURE_START} token as l_fst and then
									l_fst.text_color_id = l_fst.string_text_color_id
								)
							then
									-- This happens when processing a prefix/infix feature or reprocessing
									-- the click text.
								tfs.set_text_color_string
							end
							tfs.set_is_clickable (True)
							tfs.set_feature_index_in_table (features_position.index)
							if prev /= Void then
								prev.set_next_token (tfs)
							end
							tfs.set_previous_token (prev)
							tfs.set_next_token (next)
							tfs.update_position
							tfs.update_width
							if next /= Void then
								next.set_previous_token (tfs)
							end
								-- This is needed in case the cursor was on the abandoned token.
							if attached content.cursor as l_cursor then
								l_cursor.update_current_char
							end
							features_position.forth
							token := tfs
						elseif is_string (token) then
								-- no interesting token : skip

								-- If a string is written one several lines (more than 2 in fact),
								-- it will be made of several token, some of which may not be
								-- string tokens (those like % .... % )
							if split_string then
								split_string := False
							elseif token.wide_image [token.wide_image.count] /= {CHARACTER_32} '%"' then
								split_string := True
							else
									-- It might be an operator name
								token.set_is_clickable (True)
							end
						else
							if not has_colon_followed (token, line) then
								token.set_is_clickable (True)
							end
						end
					end
				end
				token.set_pos_in_text (pos_in_file)
				pos_in_file := token.character_length + pos_in_file
				token := token.next
			end
			if is_eol (token) then
				token.set_pos_in_text (pos_in_file)
				pos_in_file := token.character_length + pos_in_file
			end
		end

	update
			-- update class text information
		do
			build_features_arrays
			reset_positions_and_indexes
			make_click_list_from_ast
			is_ready := True
		end

	build_feature_completion_list (a_cursor: like current_cursor)
			-- Build feature completion list.
		require
			a_cursor_not_void: a_cursor /= Void
		local
			l_stone: detachable FEATURE_STONE
			l_current_feature_as: like feature_containing_cursor
			n: INTEGER_32
		do
			current_cursor := a_cursor
			current_line := current_cursor.line
			current_token := a_cursor.token
			l_current_feature_as := feature_containing_cursor (a_cursor)
			current_feature_as := l_current_feature_as
			build_feature_completion_list_analyse (current_token, current_cursor.pos_in_token)

			if
				l_current_feature_as /= Void and
				attached {SMART_TEXT} content as stext
			then
				n := a_cursor.pos_in_characters
				stext.find_feature_named (l_current_feature_as.name.visual_name)
				if attached {FEATURE_STONE} stext.stone_at (stext.cursor) as l_fstone then
					l_stone := l_fstone
				end
				stext.cursor.go_to_position (n)
			end

			if l_stone /= Void then
				build_template_list (l_stone)
				build_global_template_list (l_stone)
			end
		ensure
			same_cursor_position: a_cursor.pos_in_characters = old (a_cursor.pos_in_characters)
		end

	build_class_completion_list (a_cursor: like current_cursor)
			-- Build class completion list.
		require
			a_cursor_not_void: a_cursor /= Void
		do
			current_cursor := a_cursor
			current_line := current_cursor.line
			current_token := a_cursor.token
			current_feature_as := Void
			build_class_completion_list_analyse (current_token)
		end

	build_alias_name_completion_list (a_cursor: like current_cursor)
			-- Build class completion list.
		require
			a_cursor_not_void: a_cursor /= Void
		do
			current_cursor := a_cursor
			current_line := current_cursor.line
			current_token := a_cursor.token
			current_feature_as := Void
			build_alias_name_completion_list_analyse (current_token)
		end

	build_template_list (a_stone: detachable FEATURE_STONE)
			-- Build feature template completion list
		local
			l_templates: DS_BILINEAR [ES_CODE_TEMPLATE_DEFINITION_ITEM]
			l_template:  EB_TEMPLATE_FOR_COMPLETION
		do
			if
				a_stone /= Void and then
				last_type /= Void and then
				attached code_template_catalog.service -- Is interface useable?
			then
				l_templates := filter_conformance_templates
				from
					l_templates.start
				until
					l_templates.after
				loop
						-- Add template to the completion possibilities list
					if
						attached {ES_CODE_TEMPLATE_DEFINITION_ITEM} l_templates.item_for_iteration as l_code_template and then
						attached l_code_template.title as l_title and then
						attached {SMART_TEXT} content as l_content and then
						attached l_content.cursor.token.previous as prev and then prev.wide_image.same_string_general (".") and then
						attached prev.previous as prev2
					then
						create l_template.make (l_code_template, a_stone, prev2.wide_image)
						l_template.set_class_i (current_class_i)
						insert_in_completion_possibilities (l_template)
					end
					l_templates.forth
				end
				if attached feature_completion_possibilities as l_completion_possibilities then
						-- Note: this happens when the target object has no exported feature.
						--		 (should the `completion_possibilities` be empty instead of Void?)
					feature_completion_possibilities := l_completion_possibilities.subarray (1, cp_index - 1)
					feature_completion_possibilities.sort
				end
			end
		end


	build_global_template_list (a_stone: detachable FEATURE_STONE)
			-- Build feature template completion list
		local
			l_templates: DS_BILINEAR [ES_CODE_TEMPLATE_DEFINITION_ITEM]
			l_template:  EB_TEMPLATE_FOR_COMPLETION
		do
			if
				a_stone /= Void and then
				last_type = Void and then
				attached code_template_catalog.service and then -- Is interface useable?
				attached {SMART_TEXT} content as l_content and then
				attached l_content.cursor.token.previous as prev and then not prev.wide_image.same_string_general (".")
			then
				l_templates := filter_global_templates
				from
					l_templates.start
				until
					l_templates.after
				loop
						-- Add template to the completion possibilities list
					if
						attached {ES_CODE_TEMPLATE_DEFINITION_ITEM} l_templates.item_for_iteration as l_code_template and then
						attached l_code_template.title as l_title
					then
						create l_template.make (l_code_template, a_stone, "")
						l_template.set_class_i (current_class_i)
						insert_in_completion_possibilities (l_template)
						l_templates.forth
					else
						l_templates.forth
					end
				end
				feature_completion_possibilities := feature_completion_possibilities.subarray (1, cp_index - 1)
				feature_completion_possibilities.sort
			end
		end

feature -- Basic Operations

	stone_at_position (cursor: TEXT_CURSOR): STONE
			-- Return stone associated with position pointed by `cursor', if any
		local
			ft		: FEATURE_AS
			feat		: E_FEATURE
			a_position	: INTEGER
			token		: EDITOR_TOKEN
			line		: EIFFEL_EDITOR_LINE
		do
			if is_ok_for_completion then
				initialize_context
				if attached current_class_i as curr_class_i then
					token := cursor.token
					if attached {EIFFEL_EDITOR_LINE} cursor.line as l_eiffel_line then
						line := l_eiffel_line
					end
					a_position := token.pos_in_text
					Result := stone_in_click_ast (a_position)
					if Result = Void or else token_image_is_same_as_word (token, "precursor") then
						if line = Void then
							check is_eiffel_line: False end
						elseif a_position >= invariant_index then
								-- In Invariant clause ...
								-- FIXME jfiat [2018/05/17] : find way to resolve token for invariants.
							if attached described_access_id (token, line, Void) as tu then
								feat := tu.feat
								create {FEATURE_STONE} Result.make (feat)
							else
								feat := Void
							end
						elseif click_possible (token) then
							if attached feature_containing (token, line) as l_content then
								ft := l_content.feat_as
								inspect
									feature_part_at (token, line)
								when
									instruction_part,
									assertion_part,
									local_part,
									signature_part
								then
									if attached described_access_id (token, line, ft) as loc then
										feat := loc.feat
										check loc_with_feat: feat /= Void end
										if attached loc.ast as l_ast then
											create {ACCESS_ID_FEATURE_STONE} Result.make_with_feature (loc.feat, loc.ast)
										else
											create {FEATURE_STONE} Result.make (feat)
										end
									else
										feat := Void
									end
								else
								end
							end
						end
					end
				end
				reset_after_search
			end
		end

	go_to_left_position
			-- Go to left position by charactor
		do
			current_cursor.go_left_char
		end

feature -- Status

	feature_containing_cursor (a_cursor: TEXT_CURSOR): TUPLE [feat_as: FEATURE_AS; name: FEATURE_NAME]
			-- Feature containing current cursor if exits.
			-- If not void returns.
		do
			if features_ast /= Void then
				Result := feature_containing (a_cursor.token, a_cursor.line)
			end
		ensure
			valid_result: Result /= Void implies (Result.feat_as /= Void and Result.name /= Void)
		end

feature -- Retrieve information from ast

	build_features_arrays
			-- build tables associating FEATURE_AS objects with positions in text
		require
			current_class_as_not_void: current_class_as /= Void
		local
			l_feature_clauses: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			l_feature_list: EIFFEL_LIST [FEATURE_AS]
			l_is_first_name: BOOLEAN
			l_body_end_position, l_names_end_position: INTEGER
			l_names: EIFFEL_LIST [FEATURE_NAME]
			l_feature: FEATURE_AS
		do
			l_feature_clauses := current_class_as.features
			if l_feature_clauses /= Void then
				create features_position.make (100)
				create features_ast.make (100)
				from
					l_feature_clauses.start
				until
					l_feature_clauses.after
				loop
					l_feature_list := l_feature_clauses.item.features
					from
						l_feature_list.start
					until
						l_feature_list.after
					loop
						l_feature := l_feature_list.item
						l_body_end_position := l_feature.character_end_position
						from
							l_names := l_feature.feature_names
							l_names_end_position := l_names.character_end_position
							l_is_first_name := True
							l_names.start
						until
							l_names.after
						loop
							features_ast.extend ([l_feature, l_names.item])
							if l_is_first_name then
								l_is_first_name := False
								features_position.extend ([l_names.item.character_start_position, l_body_end_position])
							else
								features_position.extend ([l_names.item.character_start_position, l_names_end_position])
							end
							l_names.forth
						end
						l_feature_list.forth
					end
					l_feature_clauses.forth
				end
			else
				create features_position.make (0)
				create features_ast.make (0)
			end
		ensure
			features_position_not_void: features_position /= Void
			features_ast_not_void: features_ast /= Void
		end

	current_pos_in_token: INTEGER
			-- position of current token
		do
			check
				current_cursor_not_void: current_cursor /= Void
			end
			Result := current_cursor.pos_in_token
		end

feature -- Click list update

	reset_positions_and_indexes
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
			l_image: STRING_32
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
				features_index := features_position.i_th (1).start_pos
			else
				features_index := invariant_index
			end
			from
				content.start
				line := content.current_line
				token := line.first_token
				pos_in_file := 1
				search_indexes := True
			until
				token = Void
			loop
				if token.is_text then
					if is_keyword (token) then
						-- no interesting token : skip
					elseif is_comment (token) then
							-- no interesting token : skip
					else
							-- "Normal" text token
						if not features_position.after and then pos_in_file >= features_position.item.start_pos then
							prev := token.previous
							next := token.next
							create {EDITOR_TOKEN_FEATURE_START} tfs.make_with_pos (token.wide_image,
								features_position.item.start_pos, features_position.item.end_pos)
							if
								is_string (token)
								or else (
									attached {EDITOR_TOKEN_FEATURE_START} token as l_fst and then
									l_fst.text_color_id = l_fst.string_text_color_id
								)
							then
									-- This happens when processing a prefix/infix feature or reprocessing
									-- the click text.
								tfs.set_text_color_string
							end
							token.set_is_clickable (True)
							tfs.set_feature_index_in_table (features_position.index)
							if prev /= Void then
								prev.set_next_token (tfs)
							end
							tfs.set_previous_token (prev)
							tfs.set_next_token (next)
							tfs.update_position
							tfs.update_width
							if next /= Void then
								next.set_previous_token (tfs)
							end
								-- This is needed in case the cursor was on the abandoned token.
							if attached content.cursor as l_cursor then
								l_cursor.update_current_char
							end
							features_position.forth
							token := tfs
						elseif is_string (token) then
								-- If a string is written one several lines (more than 2 in fact),
								-- it will be made of several token, some of which may not be
								-- string tokens (those like % .... % )
							l_image := token.wide_image
							if not l_image.is_empty and then l_image [l_image.count] /= {CHARACTER_32} '%"' then
								from
									if token.next /= Void then
										pos_in_file := token.character_length + pos_in_file
										token.set_pos_in_text (pos_in_file)
										token := token.next
									elseif line.next /= Void then
										line := line.next
										pos_in_file := token.character_length + pos_in_file
										token.set_pos_in_text (pos_in_file)
										token := line.first_token
									end
								invariant
									token /= Void
								until
									is_string (token) or token = Void
								loop
									if token.next /= Void then
										pos_in_file := token.character_length + pos_in_file
										token.set_pos_in_text (pos_in_file)
										token := token.next
									elseif line.next /= Void then
										line := line.next
										pos_in_file := token.character_length + pos_in_file
										token.set_pos_in_text (pos_in_file)
										token := line.first_token
									else
										token := Void
									end
								end
							else
									-- It might be an operator name
								token.set_is_clickable (True)
							end
						else
							if not has_colon_followed (token, line) then
								token.set_is_clickable (True)
							end
						end
					end
				end
				if token /= Void then
					token.set_pos_in_text (pos_in_file)
				end
				if token /= Void and then token.next /= Void then
					pos_in_file := token.character_length + pos_in_file
					token := token.next
				elseif line.next /= Void then
					line := line.next
					pos_in_file := token.character_length + pos_in_file
					token := line.first_token
				else
					token := Void
				end
			end
		end

feature {NONE} -- Retrieve information from text

	set_indexes
			-- calculate `invariant_index' and `features_index'
		local
			invariant_assertion_list: EIFFEL_LIST [TAGGED_AS]
		do
			invariant_index := current_class_as.character_end_position
			if (not current_class_as.has_empty_invariant) and then current_class_as.invariant_part /= Void then
				invariant_assertion_list := current_class_as.invariant_part.assertion_list
				from
					invariant_assertion_list.start
				until
					invariant_assertion_list.after
				loop
					invariant_index := invariant_index.min (invariant_assertion_list.item.character_start_position)
					invariant_assertion_list.forth
				end
			end
			if current_class_as.features /= Void and then features_position.count > 0 then
				features_index := features_position.i_th (1).start_pos
			else
				features_index := invariant_index
			end
		end

	save_cursor_position
			-- Save cursor position
		do
			if saved_positions = Void then
				create saved_positions.make
			end
			saved_positions.put_front (current_cursor.twin)
		end

	retrieve_cursor_position
			-- Retrieve cursor position
		local
			l_cursor: EDITOR_CURSOR
		do
			if saved_positions /= Void and then not saved_positions.is_empty then
				saved_positions.go_i_th (1)
				l_cursor  := saved_positions.item
				saved_positions.remove
				current_cursor.set_current_char (l_cursor.token, l_cursor.pos_in_token)
			end
		end

	saved_positions : LINKED_LIST [EDITOR_CURSOR]

feature {NONE} -- Private Access : indexes

	features_index: INTEGER
			-- index of the first feature clause in text

	invariant_index: INTEGER
			-- index of "invariant" keyword in text

	split_string: BOOLEAN
			-- is processed token part of a split string?

feature {NONE} -- Helpers

	frozen file_notifier: SERVICE_CONSUMER [FILE_NOTIFIER_S]
			-- Access to the file notifier service
		once
			create Result
		ensure
			Result /= Void
		end

	frozen code_template_catalog: SERVICE_CONSUMER [ES_CODE_TEMPLATE_CATALOG_S]
		once
			create Result
		ensure
			Result /= Void
		end


feature {NONE} -- Code template conformance

	filter_conformance_templates: DS_ARRAYED_LIST [ES_CODE_TEMPLATE_DEFINITION_ITEM]
			-- List of code code templates filtered by conformance.
		local
			l_templates: like code_templates
			l_result: DS_ARRAYED_LIST [ES_CODE_TEMPLATE_DEFINITION_ITEM]
			l_cursor: DS_BILINEAR_CURSOR [ES_CODE_TEMPLATE_DEFINITION]
		do
			create l_result.make_default

			l_templates := code_templates
			if not l_templates.is_empty then
				l_cursor := l_templates.new_cursor
					from
					l_cursor.start
				until
					l_cursor.after
				loop
						-- Only load templates filter by context.
					if l_cursor.item.is_valid_template and then has_type_conformance (l_cursor.item) then
						if attached l_cursor.item.items as l_items then
							across l_items as ic loop l_result.force_last (ic.item) end
						end
					end
					l_cursor.forth
				end
			end
			Result := l_result
		end


	filter_global_templates: DS_ARRAYED_LIST [ES_CODE_TEMPLATE_DEFINITION_ITEM]
			-- List of code code templates filtered by conformance.
		local
			l_templates: like code_templates
			l_result: DS_ARRAYED_LIST [ES_CODE_TEMPLATE_DEFINITION_ITEM]
			l_cursor: DS_BILINEAR_CURSOR [ES_CODE_TEMPLATE_DEFINITION]
		do
			create l_result.make_default

			l_templates := code_templates
			if not l_templates.is_empty then
				l_cursor := l_templates.new_cursor
					from
					l_cursor.start
				until
					l_cursor.after
				loop
						-- Only load templates filter by context.
					if l_cursor.item.is_valid_template  and then l_cursor.item.context = Void then
						if attached l_cursor.item.items as l_items then
							across l_items as ic loop l_result.force_last (ic.item) end
						end
					end
					l_cursor.forth
				end
			end
			Result := l_result
		end

	has_type_conformance (a_definition: ES_CODE_TEMPLATE_DEFINITION): BOOLEAN
			-- Is the current `last_type' conforms_to context definition in the template.
		do
			if
				attached a_definition.context as l_context and then
				not l_context.is_empty
			then
				type_parser.parse_from_string_32 ({STRING_32} "type " + l_context, Void)
				if attached type_parser.type_node as l_class_type_as then
						-- Convert TYPE_AS into TYPE_A.
					if
						attached type_a_generator.evaluate_type (l_class_type_as, written_class) as l_type_a and then
						attached last_type as l_last_type and then
						l_last_type.is_valid_for_class (current_class_c)
					then
						Result := l_last_type.conform_to (current_class_c, l_type_a)
					end
				end
			end
		end

feature {NONE} -- Implementation

	current_cursor: EDITOR_CURSOR
		-- Current cursor

	cursor_token: EDITOR_TOKEN
			-- Token at cursor position
		do
			check
				current_cursor_not_void: current_cursor /= Void
			end
			Result := current_cursor.token
		end

	click_possible (a_token: EDITOR_TOKEN): BOOLEAN
			-- Is `a_token' possibly clickable?
			-- Does the same checking as `setup_line'
			-- But here we only check if current token can possibly clickable.
			-- Take into account that the line have not set up yet.
		require
			a_token_not_void: a_token /= Void
		local
			token: EDITOR_TOKEN
		do
			token := a_token
			if token.is_clickable and then token.pos_in_text > 0 then
					-- is_clickable has already been setup.
				Result := True
			elseif token.is_text then
				if is_keyword (token) then
					-- no interesting token except precursor
					if token_image_is_same_as_word (token, "precursor") then
						Result := True
					end
				end
			end
		end

	has_colon_followed (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE): BOOLEAN
			-- Does `a_token' have a colon followed?
		require
			a_token_not_void: a_token /= Void
			a_line_not_void: a_line /= Void
		local
			l_token: EDITOR_TOKEN
			l_line: EDITOR_LINE
		do
			from
				l_line := a_line
				l_token := a_token.next
				if l_token = Void and then l_line.next /= Void then
					l_line := l_line.next
					l_token := l_line.first_token
				end
			until
				l_token = Void or else l_token.is_text
			loop
				l_token := l_token.next
				if l_token = Void and then l_line.next /= Void then
					l_line := l_line.next
					l_token := l_line.first_token
				end
			end
			if l_token /= Void then
				Result := token_equal (l_token, ":")
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
