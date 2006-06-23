indexing
	description: "Tooltip to display feature comment"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_COMMENT_TOOLTIP

inherit
	EB_EDITOR_TOKEN_TOOLTIP
		rename
			make as old_tooltip_make
		export
			{NONE}set_tooltip_text
		redefine
			tokens
		end

	SHARED_SERVER

	EB_SHARED_FORMAT_TABLES

	EB_SHARED_WRITER

create
	make

feature{NONE} -- Initialization

	make (a_feature: like feature_item; a_enter_actions: like pointer_enter_actions;
	      a_leave_actions: like pointer_leave_actions;
	      a_destroy_function: like owner_destroy_function) is
			-- Initialize agents used for current tooltip.
			-- See `pointer_enter_actions', `pointer_leave_actions',
			-- `owner_destroy_function', for more information.
		require
			a_feature_attached: a_feature /= Void
			a_enter_actions_attached: a_enter_actions /= Void
			a_leave_actions_attached: a_leave_actions /= Void
			a_destroy_function_attached: a_destroy_function /= Void
		do
			feature_item := a_feature
			old_tooltip_make (a_enter_actions,
					  a_leave_actions,
					  a_destroy_function)
		ensure
			feature_item_set: feature_item = a_feature
		end

feature -- Access

	feature_item: E_FEATURE
			-- Feature associated with current tooltip

	tokens: ARRAYED_LIST [EDITOR_TOKEN] is
			-- `tokens' stored in list
		local
			l_comments: EIFFEL_COMMENTS
			l_tokens: LINKED_LIST [EDITOR_TOKEN]
			l_comment: STRING
			l_feature_text_formatter: DOTNET_FEAT_TEXT_FORMATTER_DECORATOR
			l_classi: CLASS_I
			l_consumed_type: CONSUMED_TYPE
			l_ext_class: EXTERNAL_CLASS_I
			l_lines: LIST [EIFFEL_EDITOR_LINE]
			l_line: LIST [EDITOR_TOKEN]
		do
			if internal_tokens = Void then
				create internal_tokens.make (0)
				if feature_item.is_il_external then
						-- For .NET external features
					l_classi := feature_item.associated_class.lace_class
					if consumed_types.has (l_classi.name) then
						l_consumed_type := consumed_types.item (l_classi.name)
					else
						l_ext_class ?= l_classi
						check
							l_ext_class_not_void: l_ext_class /= Void
						end
						l_consumed_type := l_ext_class.external_consumed_type
						if l_consumed_type /= Void then
							consumed_types.put (l_consumed_type, l_classi.name)
						end
					end
					token_writer.enable_multiline
					create l_feature_text_formatter.make (feature_item, l_consumed_type, token_writer)
					l_feature_text_formatter.prepare_for_feature (l_feature_text_formatter.current_feature)
					l_feature_text_formatter.put_comments
					token_writer.new_line
					l_lines := token_writer.lines
					from
						l_lines.start
					until
						l_lines.after
					loop
						l_line := l_lines.item.content
						from
							l_line.start
							if not l_line.after and l_line.item.is_tabulation then
								l_line.remove
							end
						until
							l_line.after
						loop
							if l_line.index = 1 and then l_line.item.is_text then
								if l_line.item.image.substring (1, 2).is_equal (once "--") then
									l_line.item.image.keep_tail (l_line.item.image.count - 2)
								end
							end
							l_line.item.update_width
							internal_tokens.extend (l_line.item)
							l_line.forth
						end
						if l_lines.item /= l_lines.last and l_line.count > 0 then
							internal_tokens.extend (create{EDITOR_TOKEN_EOL}.make)
						end
						l_lines.forth
					end
					token_writer.wipe_out_lines
					token_writer.disable_multiline
				else
						-- For normal features
					token_writer.new_line
					l_comments := feature_item.ast.comment (match_list_server.item (feature_item.written_class.class_id))
					create l_tokens.make
					if l_comments.count > 0 then
						token_writer.set_comment_context_class (feature_item.associated_class)
						from
							l_comments.start
						until
							l_comments.after
						loop
							token_writer.new_line
							l_comment := l_comments.item.content
							l_comment.left_adjust
							token_writer.add_comment_text (l_comment.out)
							l_tokens.fill (token_writer.last_line.content)
							l_tokens.extend (create{EDITOR_TOKEN_EOL}.make)
							l_comments.forth
						end
						from
							l_tokens.start
						until
							l_tokens.after
						loop
							l_tokens.item.update_width
							internal_tokens.extend (l_tokens.item)
							l_tokens.forth
						end
					end
				end
			end
			Result := internal_tokens
		end

invariant
	feature_item_attached: feature_item /= Void

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
