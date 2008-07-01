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

	EB_EDITOR_TOKEN_IDS

feature -- Editor token

	string_representation_of_editor_tokens (a_tokens: LIST [EDITOR_TOKEN]): STRING_32 is
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
				Result.append (a_tokens.item.wide_image)
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
				-- FIXME: Querying the width of the main display is not good at creation time,
				-- because the parent window could be on a different display, and moreover it
				-- could be moved later to a different display.
			a_tooltip.set_tooltip_maximum_width (ev_screen.width - 30)
			a_tooltip.set_tooltip_maximum_height (ev_screen.height - 30)
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
			Result.extend (create {EDITOR_TOKEN_TEXT}.make (a_string.as_string_32))
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
			Result.disable_written_class
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
			Result.disable_written_class
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

	just_class_name_style: EB_CLASS_EDITOR_TOKEN_STYLE is
			-- Editor token style to generate class information (just class name).
			-- e.g., HASH_TABLE.
			-- Note: Do not change setting of this style.
		once
			create Result
			Result.enable_just_name
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
			Result.disable_curly
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
			Result.disable_curly
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
			Result.enable_indirect_parent
			Result.disable_target
		ensure
			result_attached: Result /= Void
		end

	agent_style: EB_AGENT_EDITOR_TOKEN_STYLE is
			-- Editor token style generator whose output is coming from an agent.
			-- Note: Do not change setting of this style.
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	feature_with_class_style: EB_FEATURE_EDITOR_TOKEN_STYLE is
			-- Feature style used to display feature information in form of "{CLASS}.feature" where {CLASS} is associated class of that feature.
			-- Note: Do not change setting of this style.
		once
			create Result
			Result.enable_class
			Result.disable_argument
			Result.disable_comment
			Result.disable_return_type
			Result.disable_use_overload_name
			Result.disable_value_for_constant
			Result.disable_written_class
		ensure
			result_attached: Result /= Void
		end

	feature_with_written_class_style: EB_FEATURE_EDITOR_TOKEN_STYLE is
			-- Feature style used to display feature information in form of "{CLASS}.feature" where {CLASS} is written class of that feature.
			-- Note: Do not change setting of this style.
		once
			create Result
			Result.disable_class
			Result.disable_argument
			Result.disable_comment
			Result.disable_return_type
			Result.disable_use_overload_name
			Result.disable_value_for_constant
			Result.enable_written_class
		ensure
			result_attached: Result /= Void
		end

	ql_name_style: EB_SIMPLE_QL_NAME_STYLE is
			-- Name style for query item
			-- Note: Do not change setting of this style.			
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	plain_text_style: EB_TEXT_EDITOR_TOKEN_STYLE is
			-- Plain text style
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Editor token appearance

	feature_appearance: TUPLE [INTEGER, INTEGER, INTEGER] is
			-- Feature appearance
		do
			Result := [editor_font_id, feature_text_color_id, feature_background_color_id]
		ensure
			result_attached: Result /= Void
		end

	assertion_tag_appearance: TUPLE [INTEGER, INTEGER, INTEGER] is
			-- Assertion tag appearance
		do
			Result := [editor_font_id, assertion_tag_text_color_id, assertion_tag_background_color_id]
		ensure
			result_attached: Result /= Void
		end

	warning_appearance: TUPLE [INTEGER, INTEGER, INTEGER] is
			-- Warning message appearance
		do
			Result := [editor_font_id, warning_text_color_id, warning_background_color_id]
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
