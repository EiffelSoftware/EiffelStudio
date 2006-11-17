indexing
	description: "Shared utilities for editor token related functionalites"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_EDITOR_TOKEN_UTILITY

inherit
	EB_SHARED_WRITER

	SHARED_TEXT_ITEMS

	EB_CONSTANTS

	EB_SHARED_MANAGERS

feature -- Editor token

	add_editor_token_representation (a_item: QL_ITEM; a_full_signature: BOOLEAN; a_associated_class: BOOLEAN; a_writer: like token_writer) is
			-- Add editor token representation of `a_item' into `a_writer'.
			-- If `a_full_signature' is True, add full signature of `a_item', otherwise, just name.
			-- If `a_associated_class' is True, and `a_item' is a feature item, class name will be prepended:
			-- like LINKED_LIST.first.
			-- {ANY}.out
		require
			a_item_attached: a_item /= Void
			a_writer_attached: a_writer /= Void
		local
			l_group: QL_GROUP
			l_class: QL_CLASS
			l_real_feature: QL_REAL_FEATURE
			l_invariant: QL_INVARIANT
			l_feature: QL_FEATURE
			l_target: QL_TARGET
		do
			if a_item.is_class then
				l_class ?= a_item
				if a_full_signature and then l_class.is_compiled then
					l_class.class_c.append_signature (a_writer, False)
				else
					a_writer.add_class (l_class.class_i)
				end
			elseif a_item.is_feature then
				if a_item.is_real_feature then
					l_real_feature ?= a_item
					l_feature := l_real_feature
				else
					l_invariant ?= a_item
					l_feature := l_invariant
				end
				if a_associated_class then
					a_writer.process_symbol_text (ti_l_curly)
					l_feature.class_c.append_name (a_writer)
					a_writer.process_symbol_text (ti_r_curly)
					a_writer.process_symbol_text (ti_dot)
				end
				if l_feature.is_real_feature then
					if a_full_signature then
						l_feature.e_feature.append_signature (a_writer)
					else
						a_writer.add_sectioned_feature_name (l_real_feature.e_feature)
					end
				else
					a_writer.add_string (l_feature.name)
				end
			elseif a_item.is_group then
				l_group ?= a_item
				a_writer.add_group (l_group.group, l_group.name)
			elseif a_item.is_target then
				l_target ?= a_item
				a_writer.process_target_name_text (l_target.name, l_target.target)
			else
				a_writer.add_string (a_item.name)
			end
		end

	editor_tokens_of_query_item_path (a_item: QL_ITEM; a_context_group: CONF_GROUP a_full_path: BOOLEAN; a_self_included: BOOLEAN; a_target_include: BOOLEAN): LIST [EDITOR_TOKEN] is
			-- List of editor tokens for `a_item'
			-- If `a_full_path' is True, include full path if `a_item' in form of "name.name.name".
			-- If `a_self_include' is True, include `a_item' itself, otherwise, only the path part of `a_item' is inlcuded.
			-- If `a_target_include' is True, include target in Result, otherwise all target items appear in path of `a_item' will be omitted.
			-- `a_context_group' is used to deal with renames.
		require
			a_item_attached: a_item /= Void
		local
			l_writer: like token_writer
			l_list: LINKED_LIST [QL_ITEM]
			l_parent: QL_ITEM
			l_count: INTEGER
		do
			l_writer := token_writer
			l_writer.new_line
			l_writer.set_context_group (a_context_group)

			l_writer.new_line
			create l_list.make
			if a_self_included then
				l_list.extend (a_item)
			end
			if a_full_path then
				from
					l_parent := a_item.parent
				until
					l_parent = Void
				loop
					l_list.put_front (l_parent)
					l_parent := l_parent.parent
				end
			end

			if not l_list.is_empty then
				from
					l_list.start
					l_count := l_list.count
				until
					l_list.after
				loop
					if not l_list.item.is_target or else a_target_include then
						add_editor_token_representation (l_list.item, False, False, l_writer)
						if l_list.index < l_list.count then
							l_writer.add_string (".")
						end
					end
					l_list.forth
				end
			end
			Result := l_writer.last_line.content
		end

	string_representation_of_editor_tokens (a_tokens: LIST [EDITOR_TOKEN]): STRING is
			-- String representation of `a_tokens'.
		require
			a_tokens_attached: a_tokens /= Void
		do
			create Result.make (256)
			from
				a_tokens.start
			until
				a_tokens.after
			loop
				Result.append (a_tokens.item.image)
				a_tokens.forth
			end
		ensure
			result_attached: Result /= Void
		end

	initialize_editor_token_tooltip (a_tooltip: EB_EDITOR_TOKEN_TOOLTIP) is
			-- Setup parameters for `a_tooltip'.
		require
			a_tooltip_attached: a_tooltip /= Void
		do
			a_tooltip.enable_pointer_on_tooltip
			a_tooltip.set_border_line_width (1)
			a_tooltip.set_left_border (4)
			a_tooltip.set_top_border (1)
			a_tooltip.set_right_border (3)
			a_tooltip.set_bottom_border (1)
			a_tooltip.set_tooltip_remain_delay_time (200)
			a_tooltip.enable_text_wrap
			a_tooltip.enable_repeat_tooltip_display
				-- FIXME: Querying the width of the main display is not good at creation time,
				-- because the parent window could be on a different display, and moreover it
				-- could be moved later to a different display.
			a_tooltip.set_tooltip_maximum_width (ev_screen.width - 30)
			a_tooltip.set_tooltip_maximum_height (ev_screen.height - 30)
			a_tooltip.set_tooltip_window_related_window_agent (agent last_focused_window)
		end

	last_focused_window: EV_WINDOW is
			-- Last focused window
		do
			Result := window_manager.last_focused_development_window.window
		end

	ev_screen: EB_STUDIO_SCREEN is
			-- Screen
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	editor_tokens_for_string (a_string: STRING_GENERAL): LIST [EDITOR_TOKEN] is
			-- Editor token representation of `a_string'
		require
			a_string_attached: a_string /= Void
		do
			create {LINKED_LIST [EDITOR_TOKEN]} Result.make
			Result.extend (create {EDITOR_TOKEN_TEXT}.make (a_string.to_string_8))
		ensure
			result_attached: Result /= Void and then not Result.is_empty
		end

feature -- Editor token style

	feature_name_style: EB_FEATURE_EDITOR_TOKEN_STYLE is
			-- Editor token style to generate just feature name
			-- Note: Do not change setting of this style.
		once
			create Result
			Result.disable_argument
			Result.disable_comment
			Result.disable_class
			Result.disable_return_type
			Result.disable_use_overload_name
			Result.disable_value_for_constant
		ensure
			result_attached: Result /= Void
		end

	feature_signature_style: EB_FEATURE_EDITOR_TOKEN_STYLE is
			-- Editor token style to generate full feature signature
			-- Note: Do not change setting of this style.
		once
			create Result
			Result.enable_argument
			Result.enable_value_for_constant
			Result.enable_return_type
			Result.disable_class
			Result.disable_comment
		ensure
			result_attached: Result /= Void
		end

	feature_comment_style: EB_FEATURE_EDITOR_TOKEN_STYLE is
			-- Editor token style to generate feature comment
			-- Note: Do not change setting of this style.
		once
			create Result
			Result.enable_comment
		ensure
			result_attached: Result /= Void
		end

	short_generic_class_style: EB_CLASS_EDITOR_TOKEN_STYLE is
			-- Editor token style to generate class information in short generic form.
			-- e.g., HASH_TABLE [G, H -> ...].
			-- Note: Do not change setting of this style.
		once
			create Result
			Result.enable_short_generic_form
			Result.disable_processed
			Result.disable_star
		ensure
			result_attached: Result /= Void
		end

	complete_generic_class_style: EB_CLASS_EDITOR_TOKEN_STYLE is
			-- Editor token style to generate class information in complete generic form.
			-- e.g., HASH_TABLE [G, H -> HASHABLE].
			-- Note: Do not change setting of this style.
		once
			create Result
			Result.enable_complete_generic_form
			Result.disable_processed
			Result.enable_star
		ensure
			result_attached: Result /= Void
		end

	path_style: EB_PATH_EDITOR_TOKEN_STYLE is
			-- Editor token style to generate path information for a query language item.
			-- Note: Do not change setting of this style.
		once
			create Result
			Result.disable_self
			Result.enable_parent
			Result.disable_target
		ensure
			result_attached: Result /= Void
		end

	agent_style: EB_AGENT_EDITOR_TOKEN_STYLE is
			-- Editor token style generator whose outptu is coming from an agent.
			-- Note: Do not change setting of this style.
		once
			create Result
		ensure
			result_attached: Result /= Void
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

end
