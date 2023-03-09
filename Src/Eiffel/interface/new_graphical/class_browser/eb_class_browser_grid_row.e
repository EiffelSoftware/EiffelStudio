note
	description: "A grid row in class browser"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_CLASS_BROWSER_GRID_ROW

inherit
	EVS_GRID_ROW

	EB_SHARED_EDITOR_TOKEN_UTILITY

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{NONE} all
		end

	QL_UTILITY

	QL_SHARED

feature -- Access

	browser: EB_CLASS_BROWSER_GRID_VIEW [ANY]
			-- Broswer in which current row is displayed

	class_stone (a_class: CLASS_C): STONE
			-- Class stone for `a_class'
		require
			a_class_attached: a_class /= Void
		do
			create{CLASSC_STONE} Result.make (a_class)
		end

	feature_stone (a_feature: E_FEATURE): STONE
			-- Feature stone associated with Current item
		require
			a_feature_attached: a_feature /= Void
		do
			create{FEATURE_STONE} Result.make (a_feature)
		end

	cluster_stone (a_group: CONF_GROUP): STONE
			-- Cluster stone from `a_group'
		require
			a_group_attached: a_group /= Void
		do
			create{CLUSTER_STONE} Result.make (a_group)
		end

	ql_feature_comment (a_feature: QL_FEATURE): LIST [EDITOR_TOKEN]
			-- Editor token representation of comment of `a_feature'
		require
			a_feature_attached: a_feature /= Void
		do
			feature_comment_style.set_ql_feature (a_feature)
			Result := feature_comment_style.text
		ensure
			result_attached: Result /= Void
		end

feature -- Setting

	set_browser (a_browser: like browser)
			-- Set `browser' with `a_browser'.
		require
			a_browser_attached: a_browser /= Void
		do
			browser := a_browser
		ensure
			browser_set: browser = a_browser
		end

feature -- Row expanding

	expand_parent_row_recursively (a_grid_row: EV_GRID_ROW)
			-- Expand parent rows of `a_grid_row' recursively.
		require
			a_grid_row_attached: a_grid_row /= Void
			a_grid_row_in_grid: a_grid_row.parent /= Void
		local
			l_grid_row: EV_GRID_ROW
		do
			l_grid_row := a_grid_row.parent_row
			if l_grid_row /= Void then
				if l_grid_row.is_expandable and then not l_grid_row.is_expanded  then
					l_grid_row.expand
				end
				expand_parent_row_recursively (l_grid_row)
			end
		end

feature -- General tooltip

	new_general_tooltip (a_item: EB_GRID_EDITOR_TOKEN_ITEM; a_veto_function: FUNCTION [BOOLEAN]): EB_EDITOR_TOKEN_TOOLTIP
			-- New general tooltip for `a_item'.
			-- `a_veto_function' is the function to decide if display of the tooltip should be vetoed.
		require
			a_item_attached: a_item /= Void
			a_veto_function_attached: a_veto_function /= Void
		do
			create Result.make (a_item.pointer_enter_actions, a_item.pointer_leave_actions, a_item.select_actions, agent a_item.is_destroyed)
			Result.veto_tooltip_display_functions.extend (a_veto_function)
		ensure
			result_attached: Result /= Void
		end

	setup_general_tooltip (a_text_function: FUNCTION [LIST [EDITOR_TOKEN]]; a_tooltip: EB_EDITOR_TOKEN_TOOLTIP)
			-- Set `a_tooltip' and `a_tooltip' will get its text from `a_text_function'.
		require
			a_text_function_attached: a_text_function /= Void
			a_tooltip_attached: a_tooltip /= Void
		local
			l_text: LIST [EDITOR_TOKEN]
		do
			l_text := a_text_function.item (Void)
			if l_text = Void then
				create {LINKED_LIST [EDITOR_TOKEN]} l_text.make
			end
			a_tooltip.set_tooltip_text (l_text)
			initialize_editor_token_tooltip (a_tooltip)
		end

feature{NONE} -- Implementation

	setup_feature_signature_item (a_item: EB_GRID_EDITOR_TOKEN_ITEM; a_feature: E_FEATURE; a_text_tokens: LIST [EDITOR_TOKEN];
								  a_image: STRING_32; a_tooltip_veto_function: FUNCTION [BOOLEAN];
								  a_comment_agent: FUNCTION [LIST [EDITOR_TOKEN]])
			-- Setup `a_item' to display information `a_feature' in its full signature form whose text comes from `a_text_tokens'.
			-- `a_image' is the string used in grid search.
			-- `a_tooltip_veto_function' decides if tooltip display for `a_item' is vetoed.
			-- `a_comment_agent' returns comment for `a_feature'.
		require
			a_item_attached: a_item /= Void
			a_feature_attached: a_feature /= Void
			a_text_tokens_attached: a_text_tokens /= Void
			a_image_attached: a_image /= Void
			a_tooltip_veto_function_attached: a_tooltip_veto_function /= Void
			a_comment_agent_attached: a_comment_agent /= Void
		local
			l_tooltip: EB_EDITOR_TOKEN_TOOLTIP
		do
			a_item.set_pixmap (pixmap_from_e_feature (a_feature))
			a_item.set_text_with_tokens (a_text_tokens)
			a_item.set_image (a_image)
			l_tooltip := new_general_tooltip (a_item, a_tooltip_veto_function)
			l_tooltip.before_display_actions.extend (agent setup_general_tooltip (a_comment_agent, l_tooltip))
			a_item.set_general_tooltip (l_tooltip)
		end

	setup_class_item_with_short_signature (a_item: EB_GRID_EDITOR_TOKEN_ITEM; a_class_c: CLASS_C; a_text_tokens: LIST [EDITOR_TOKEN]; a_image: STRING_32;
										   a_tooltip_veto_function: FUNCTION [BOOLEAN];
										   a_full_signature_function: FUNCTION [LIST [EDITOR_TOKEN]])
			-- Setup `a_item' to display information about `a_class_c' in short generic form whose text comes from `a_text_tokens'.
			-- `a_image' is the string used in grid search.
			-- `a_tooltip_veto_function' is used to decide if tooltip display for `a_class_c' is vetoed.
			-- `a_full_signature_function' returns text of `a_class_c' in complete generic form.
		require
			a_item_attached: a_item /= Void
			a_class_c_attached: a_class_c /= Void
			a_text_tokens_attached: a_text_tokens /= Void
			a_image_attached: a_image /= Void
			a_tooltip_veto_function_attached: a_tooltip_veto_function /= Void
			a_full_signature_function_attached: a_full_signature_function /= Void
		local
			l_tooltip: EB_EDITOR_TOKEN_TOOLTIP
		do
			a_item.set_pixmap (pixmap_from_class_i (a_class_c.original_class))
			a_item.set_text_with_tokens (a_text_tokens)
			a_item.set_image (a_image)
			if a_class_c.is_generic then
				l_tooltip := new_general_tooltip (a_item, a_tooltip_veto_function)
				l_tooltip.before_display_actions.extend (agent setup_general_tooltip (a_full_signature_function, l_tooltip))
				a_item.set_general_tooltip (l_tooltip)
			else
				a_item.remove_general_tooltip
			end
		end

	should_class_tooltip_be_displayed (a_class: CLASS_C): BOOLEAN
			-- Should tooltip for `a_class' be display?
		require
			a_class_attached: a_class /= Void
		local
			l_generic_generator: QL_GENERIC_DOMAIN_GENERATOR
		do
			Result := browser.should_tooltip_be_displayed
			if Result then
				create l_generic_generator.make (generic_criterion_factory.criterion_with_name (query_language_names.ql_cri_has_constraint, []), True)
				Result := attached {QL_GENERIC_DOMAIN} query_class_item_from_class_c (a_class).wrapped_domain.new_domain (l_generic_generator) as l_generic_domain and then
					not l_generic_domain.is_empty
			end
		end

invariant
	browser_attached: browser /= Void

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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

end
