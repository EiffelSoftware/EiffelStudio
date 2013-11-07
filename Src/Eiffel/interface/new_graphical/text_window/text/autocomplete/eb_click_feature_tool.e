note
	description: "Object that analyze a feature text to make it clickable"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLICK_FEATURE_TOOL

inherit
	EB_CLASS_INFO_ANALYZER

create
	default_create

feature -- Initialization

	initialize (feat: E_FEATURE)
			-- initialize the tool before analyzing a class called `a_classname' located in cluster called `a_cluster_name'
			-- `a_content' is text of this class
		require
			feat_is_not_void: feat /= Void
		local
			class_c: CLASS_C
			current_feature: E_FEATURE
			l_feat_as: FEATURE_AS
		do
			current_class_c := feat.written_class
			can_analyze_current_class := False
			if current_class_c /= Void and then not Workbench.is_compiling then
				current_class_i := current_class_c.original_class
				group := current_class_i.group
				current_feature_name := feat.name_32
				current_feature_id := feat.name_id
				is_ready := False
				if current_class_i /= Void then --and then not current_class_i.date_has_changed then
					class_c := current_class_c
					if class_c.has_feature_table then
						generate_ast (class_c, False)
						if last_syntax_error = Void and then current_class_as /= Void then
							current_feature := class_c.feature_with_name_id (feat.name_id)
							if current_feature /= Void then
								l_feat_as := current_feature.ast
								current_feature_as := [l_feat_as, l_feat_as.feature_names.first]
								if feat.associated_class /= Void then
									can_analyze_current_class := True
								end
							end
						end
					end
				end
			end
		end

	set_content (a_content: CLICKABLE_TEXT)
		require
			content_is_not_void: a_content /= Void
			can_analyze: can_analyze_current_class
		do
			content := a_content
		end

feature -- Basic operation

	stone_at_position (cursor: TEXT_CURSOR): STONE
			-- Return stone associated with position pointed by `cursor', if any
		local
			ft		: FEATURE_AS
			feat		: E_FEATURE
			a_position	: INTEGER
			token		: EDITOR_TOKEN
			line		: EDITOR_LINE
			l_current_class_c: CLASS_C
		do
			if current_class_i /= Void and then current_class_c /= Void then
				l_current_class_c := current_class_c
				if l_current_class_c.has_feature_table then
					feat := l_current_class_c.feature_with_name_id (current_feature_id)
					if feat /= Void then
						ft := feat.ast
						feat := Void
					end
				end
				token := cursor.token
				line := cursor.line
				a_position := token.pos_in_text
				Result := stone_in_click_ast (a_position)
				if Result = Void and then ft /= Void then
					inspect
						feature_part_at (token, line)
					when
						instruction_part,
						assertion_part,
						local_part,
						signature_part
					then
						feat := described_feature (token, line, ft)
					else
					end
				end
				if feat /= Void then
					create {FEATURE_STONE} Result.make (feat)
				end
			end
			reset_after_search
		end

feature -- Analysis preparation

	prepare_on_click_analysis
			-- gather information necessary to analysis
		do
			reset_positions
			make_click_list_from_ast
			is_ready := True
		end

	update
		do
		end

	reset_positions
			-- look for position of subsection of class text (inherit, invariant, creation..)
			-- and set the `pos_in_text' attribute of interesting tokens.
		require
			class_as_already_built: current_class_as /= Void
			content_not_void: content /= Void
		local
			token: EDITOR_TOKEN
			line: EDITOR_LINE
			feature_name: FEATURE_NAME
			feature_name_image: STRING_32
		do
			if current_feature_as /= Void then
				feature_name := current_feature_as.name
				if feature_name.is_frozen then
					feature_name_image := "frozen"
				elseif feature_name.is_infix then
					feature_name_image := "infix"
				elseif feature_name.is_prefix then
					feature_name_image := "prefix"
				else
					feature_name_image := feature_name.internal_name.name_32
				end
			else
				feature_name_image := current_feature_name
			end
			split_string := False
			pos_in_file := 1
			from
				content.start
				line := content.current_line
				token := line.first_token
			until
				token = Void or token_image_is_same_as_word (token, feature_name_image)
			loop
				if token.next /= Void then
					token := token.next
				elseif line.next /= Void then
					line := line.next
					token := line.first_token
				else
					token := Void
				end
			end
			if token = Void or else current_feature_as = Void then
				error := True
			else
				pos_in_file := current_feature_as.name.start_position
			end
			from
			until
				error or else token = Void
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
						if token.wide_image @ token.wide_image.count /= ('%"').to_character_32 then
							from
								if token.next /= Void then
									pos_in_file := token.character_length + pos_in_file
									token := token.next
								elseif line.next /= Void then
									line := line.next
									pos_in_file := pos_in_file + 1
									if platform_is_windows then
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
									pos_in_file := token.character_length + pos_in_file
									token := token.next
								elseif line.next /= Void then
									line := line.next
									pos_in_file := pos_in_file + 1
									if platform_is_windows then
										pos_in_file := pos_in_file + 1
									end
									token := line.first_token
								else
									token := Void
								end
							end
						end
					end
				end
				token.set_pos_in_text (pos_in_file)
				if token.next /= Void then
					pos_in_file := token.character_length + pos_in_file
					token := token.next
				elseif line.next /= Void then
					line := line.next
					pos_in_file := pos_in_file + 1
					if platform_is_windows then
						pos_in_file := pos_in_file + 1
					end
					token := line.first_token
				else
					token := Void
				end
			end
		end

feature -- Implementation

	split_string: BOOLEAN

	current_feature_name: STRING_32

	current_feature_id: INTEGER;

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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

end -- class EB_CLICK_FEATURE_TOOL
