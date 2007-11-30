indexing
	description: "[
			Objects that provider completion possiblities for normal use.
			i.e. EB_CODE_COMPLETABLE_TEXT_FIELD which can auto complete names of features and classes
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_NORMAL_COMPLETION_POSSIBILITIES_PROVIDER

inherit
	EB_COMPLETION_POSSIBILITIES_PROVIDER
		rename
			code_completable as text_field,
			cursor_token as cursor_token_provider
		redefine
			reset,
			text_field,
			prepare_completion,
			cursor_token_provider
		end

	EB_COMPLETE_INFO_ANALYZER
		rename
			insertion as insertion_cell
		export
			{NONE} all
		redefine
			reset,
			go_to_next_token,
			go_to_previous_token,
			after_searched_token,
			set_up_local_analyzer
		end

	EB_SHARED_DEBUGGER_MANAGER

create
	make

feature {NONE} -- Initialization

	make (a_class_c: CLASS_C; a_feature_as: FEATURE_AS) is
			-- Initialization
		do
			set_context (a_class_c, a_feature_as)
		end

feature -- Access

	insertion: STRING is
			-- Insertion
		do
			Result := insertion_cell.item
		end

	context_class_c: CLASS_C
			-- The context related class.

	context_feature_as: FEATURE_AS
			-- The context related feature.

	text_field : EB_CODE_COMPLETABLE_TEXT_FIELD

	use_all_classes_in_universe: BOOLEAN
			-- Provide all classes in universe?

	dynamic_context_class_c_function: FUNCTION [ANY, TUPLE, CLASS_C]
	dynamic_context_feature_as_function: FUNCTION [ANY, TUPLE, FEATURE_AS]

feature -- Change

	set_context (a_class_c: CLASS_C; a_feature_as: FEATURE_AS) is
			-- Set `context_class_c' with `a_class_c'.
		do
			context_class_c := a_class_c
			context_feature_as := a_feature_as
			if a_feature_as /= Void then
				current_feature_as := [a_feature_as, a_feature_as.feature_names.first]
			else
				current_feature_as := Void
			end
			completion_possibilities := Void
			class_completion_possibilities := Void
		end

feature -- Basic operation

	prepare_completion is
			-- Prepare completion
		do
			Precursor
			create insertion_cell
			if dynamic_context_class_c_function /= Void then
				context_class_c := dynamic_context_class_c_function.item (Void)
			end
			if dynamic_context_feature_as_function /= Void then
				context_feature_as := dynamic_context_feature_as_function.item (Void)
			end
			if context_feature_as /= Void then
				current_feature_as := [context_feature_as, context_feature_as.feature_names.first]
			else
				current_feature_as := Void
			end
			create features_ast.make (1)
			if current_feature_as /= Void then
				features_ast.extend (current_feature_as)
			end
			watching_line := text_field.current_line
			if context_class_c /= Void then
				current_class_i := context_class_c.original_class
				current_class_c := context_class_c
				group := context_class_c.group
				if provide_features then
					current_token := text_field.current_token_in_line (watching_line)
					current_line := watching_line
					build_completion_list (current_token)
				end
			end
			if provide_classes then
				if not use_all_classes_in_universe and then group_callback /= Void then
					group := group_callback.item (Void)
				end
				if not use_all_classes_in_universe implies group /= Void then
					current_token := text_field.current_token_in_line (watching_line)
					current_line := watching_line
					build_class_completion_list (current_token)
				end
			end
		end

	reset is
		do
			Precursor {EB_COMPLETE_INFO_ANALYZER}
			Precursor {EB_COMPLETION_POSSIBILITIES_PROVIDER}
			watching_line := Void
			completion_possibilities := Void
			class_completion_possibilities := Void
			provide_features := False
			provide_classes := False
		end

feature -- Element change

	set_dynamic_context_functions (a_class_call: like dynamic_context_class_c_function; a_feat_call: like dynamic_context_feature_as_function) is
		do
			dynamic_context_class_c_function := a_class_call
			dynamic_context_feature_as_function := a_feat_call
		end

	set_group_callback (a_call: FUNCTION [ANY, TUPLE, CONF_GROUP]) is
			-- Group call back
		require
			a_call_not_void: a_call /= Void
		do
			group_callback := a_call
		ensure
			group_callback_not_void: group_callback = a_call
		end

	set_use_all_classes_in_universe (a_b: BOOLEAN) is
			-- Set `use_all_classes_in_universe' with `a_b'.
		do
			use_all_classes_in_universe := a_b
		end

feature {NONE} -- Implementation

	save_cursor_position is
			-- Save cursor position
		do
			text_field.save_cursor
		end

	retrieve_cursor_position is
			-- Retrieve cursor position
		do
			text_field.retrieve_cursor
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

	go_to_left_position is
			-- Go to left position by charactor.
		do
			text_field.go_left_char
		end

feature {NONE} -- Build completion possibilities

	stone_at_position (cursor: TEXT_CURSOR): STONE is
			-- Return stone associated with position pointed by `cursor', if any
			-- Do nothing.
		do
		end

	update is
			-- Do nothing
		do
		end

	cursor_token: EDITOR_TOKEN is
			-- Current token.
		do
			Result := text_field.current_token_in_line (watching_line)
		end

	cursor_token_provider: EDITOR_TOKEN is
			-- Current token. No buffer needed.
		do
			Result := text_field.current_token_in_line (text_field.current_line)
		end

	current_pos_in_token: INTEGER is
			--
		do
			Result := text_field.position_in_token
		end

	types_from_formal_type (a_class_c: CLASS_C; a_formal: FORMAL_A): TYPE_SET_A is
			-- For `_a_class_c' get actual type of `a_formal'.
		do
			if
				a_class_c /= Void and then
				a_class_c.generics /= Void and then
				a_class_c.generics.valid_index (a_formal.position)
			then
				Result := a_class_c.constraints (a_formal.position)
			end
		end

	set_up_local_analyzer (a_line: EDITOR_LINE; a_token: EDITOR_TOKEN; a_class_c: CLASS_C) is
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

	watching_line: EDITOR_LINE
			-- Line

	group_callback: FUNCTION [ANY, TUPLE, CONF_GROUP]
			-- Function to retrieve group

;indexing
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
