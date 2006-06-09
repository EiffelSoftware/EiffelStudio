indexing
	description: "Objects that analyze search the editor content for clickable position"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne AMODEO"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLICK_AND_COMPLETE_TOOL

inherit
	EB_COMPLETE_INFO_ANALYZER
		rename
			build_completion_list as build_completion_list_analyse,
			build_class_completion_list as build_class_completion_list_analyse
		redefine
			reset
		end

create

	default_create

feature -- Initialization

	initialize (a_content: CLICKABLE_TEXT; a_class: CLASS_I; a_group: like group; after_save: BOOLEAN) is
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
			if not Workbench.is_compiling then
				initialize_context
				if current_class_c /= Void then
					generate_ast (current_class_c, after_save)
					can_analyze_current_class := last_syntax_error = Void and then current_class_as /= Void
				end
			end
		end

	reset_setup_lines_variables is
			-- reinitialize variables used by `setup_lines'
			-- to be executed before `setup_lines' is launched for the first time
		require
			features_position_not_void: features_position /= Void
		do
			pos_in_file := 1
			split_string := False
			features_position.start
		end

	reset is
			-- set class attributes to default values
		do
			Precursor {EB_COMPLETE_INFO_ANALYZER}
			reset_after_search
		end

feature -- Analysis preparation

	prepare_on_click_analysis is
			-- gather information necessary to analysis
		do
			set_indexes
			make_click_list_from_ast
			is_ready := True
		end

	setup_line (a_line: EIFFEL_EDITOR_LINE) is
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
					elseif is_string (token) then
							-- no interesting token : skip

							-- If a string is written one several lines (more than 2 in fact),
							-- it will be made of several token, some of which may not be
							-- string tokens (those like % .... % )
						if split_string then
							split_string := False
						elseif token.image @ token.image.count /= '%"' then
							split_string := True
						else
								-- It might be an operator name
							token.set_pos_in_text (pos_in_file)
						end
					else
						if not split_string then
								-- "Normal" text token
							if not features_position.after and then pos_in_file >= features_position.item then
									-- `current_token' is the beginning of a feature
									-- we replace this text token with a "feature start token"
								prev := token.previous
								next := token.next
								create {EDITOR_TOKEN_FEATURE_START} tfs.make (token.image)
								tfs.set_pos_in_text (pos_in_file)
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

	build_completion_list (a_cursor: like current_cursor) is
			-- Build feature completion list.
		require
			a_cursor_not_void: a_cursor /= Void
		do
			current_cursor := a_cursor
			current_line := current_cursor.line
			current_token := a_cursor.token
			current_feature_as := feature_containing_cursor (a_cursor)
			build_completion_list_analyse (current_token)
		end

	build_class_completion_list (a_cursor: like current_cursor) is
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

feature -- Basic Operations

	stone_at_position (cursor: TEXT_CURSOR): STONE is
			-- Return stone associated with position pointed by `cursor', if any
		local
			ft		: FEATURE_AS
			feat		: E_FEATURE
			a_position	: INTEGER
			token		: EDITOR_TOKEN
			line		: EIFFEL_EDITOR_LINE
		do
			initialize_context
			if current_class_i /= Void then
				token := cursor.token
				line ?= cursor.line
				a_position := token.pos_in_text
				Result := stone_in_click_ast (a_position)
				if Result = Void or else token_image_is_same_as_word (token, "precursor") then
					if a_position >= invariant_index then
						feat := described_feature (token, line, Void)
					elseif click_possible (token) then
						ft := feature_containing (token, line)
						if ft /= Void then
							inspect
								feature_part_at (token, line)
							when instruction_part then
								feat := described_feature (token, line, ft)
							when assertion_part then
								feat := described_feature (token, line, ft)
							when local_part then
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

	go_to_left_position is
			-- Go to left position by charactor
		do
			current_cursor.go_left_char
		end

feature -- Status

	file_standard_is_windows: BOOLEAN

	set_file_standard_is_windows (value: BOOLEAN) is
			-- assign `value' to `file_standard_is_windows'.
		do
			file_standard_is_windows := value
		end

	feature_containing_cursor (a_cursor: TEXT_CURSOR): FEATURE_AS is
			-- Feature containing current cursor if exits.
			-- If not void returns.
		do
			if features_position /= Void and features_ast /= Void then
				Result := feature_containing (a_cursor.token, a_cursor.line)
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

	current_pos_in_token: INTEGER is
			-- position of current token
		do
			check
				current_cursor_not_void: current_cursor /= Void
			end
			Result := current_cursor.pos_in_token
		end

	current_cursor: EDITOR_CURSOR
			-- Current cursor

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
								is_string (token) or token = Void
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
						else
								-- It might be an operator name
							token.set_pos_in_text (pos_in_file)
						end
					else
							-- "Normal" text token
						if not features_position.after and then pos_in_file >= features_position.item then
							prev := token.previous
							next := token.next
							create {EDITOR_TOKEN_FEATURE_START} tfs.make (token.image)
							tfs.set_pos_in_text (pos_in_file)
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
							features_position.forth
						else
							token.set_pos_in_text (pos_in_file)
						end
					end
				end
				if token /= Void and then token.next /= Void then
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

	save_cursor_position is
			-- Save cursor position
		do
			old_token := current_cursor.token
			old_position := current_cursor.pos_in_token
		end

	retrieve_cursor_position is
			-- Retrieve cursor position
		do
			current_cursor.set_current_char (old_token, old_position)
		end

	old_token: EDITOR_TOKEN

	old_position: INTEGER

feature {NONE} -- Private Access : indexes

	features_index: INTEGER
			-- index of the first feature clause in text

	invariant_index: INTEGER
			-- index of "invariant" keyword in text

	split_string: BOOLEAN
			-- is processed token part of a split string?


feature {NONE} -- Implementation

	click_possible (a_token: EDITOR_TOKEN): BOOLEAN is
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
			if token.pos_in_text > 0 then
					-- pos_in_text has already been setup.
				Result := True
			elseif token.is_text then
				if is_keyword (token) then
					-- no interesting token except precursor
					if token_image_is_same_as_word (token, "precursor") then
						Result := True
					end
				elseif is_comment (token) then
					-- no interesting token : skip
				elseif is_string (token) then
					-- no interesting token : skip
					-- We do not care the operator case here.
				else
						-- "Normal" text token
					Result := True
				end
			end
		end

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

end -- class EB_CLICK_AND_COMPLETE_TOOL
