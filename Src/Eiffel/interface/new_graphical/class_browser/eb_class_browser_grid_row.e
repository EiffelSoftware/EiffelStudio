indexing
	description: "A grid row in class browser"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_CLASS_BROWSER_GRID_ROW

inherit
	EB_GRID_ROW

	EB_SHARED_EDITOR_TOKEN_UTILITY

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY

feature -- Access

	browser: EB_CLASS_BROWSER_GRID_VIEW [ANY]
			-- Broswer in which current row is displayed

feature -- Setting

	set_browser (a_browser: like browser) is
			-- Set `browser' with `a_browser'.
		require
			a_browser_attached: a_browser /= Void
		do
			browser := a_browser
		ensure
			browser_set: browser = a_browser
		end

feature -- Row expanding

	expand_parent_row_recursively (a_grid_row: EV_GRID_ROW) is
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

	new_general_tooltip (a_item: EB_GRID_COMPILER_ITEM; a_veto_function: FUNCTION [ANY, TUPLE, BOOLEAN]): EB_EDITOR_TOKEN_TOOLTIP is
			-- New general tooltip for `a_item'.
			-- `a_veto_function' is the function to decide if display of the tooltip should be vetoed.
		require
			a_item_attached: a_item /= Void
			a_veto_function_attached: a_veto_function /= Void
		do
			create Result.make (a_item.pointer_enter_actions, a_item.pointer_leave_actions, agent a_item.is_destroyed)
			Result.veto_tooltip_display_functions.extend (a_veto_function)
		ensure
			result_attached: Result /= Void
		end

	setup_general_tooltip (a_text_function: FUNCTION [ANY, TUPLE, LIST [EDITOR_TOKEN]]; a_tooltip: EB_EDITOR_TOKEN_TOOLTIP) is
			-- Set `a_tooltip' and `a_tooltip' will get its text from `a_text_function'.
		require
			a_text_function_attached: a_text_function /= Void
			a_tooltip_attached: a_tooltip /= Void
		local
			l_text: LIST [EDITOR_TOKEN]
		do
			l_text := a_text_function.item ([])
			if l_text = Void then
				create {LINKED_LIST [EDITOR_TOKEN]} l_text.make
			end
			a_tooltip.set_tooltip_text (l_text)
			initialize_editor_token_tooltip (a_tooltip)
		end

feature{NONE} -- Implementation

	setup_feature_signature_item (a_item: EB_GRID_COMPILER_ITEM; a_feature: E_FEATURE; a_text_tokens: LIST [EDITOR_TOKEN];
								  a_image: STRING; a_tooltip_veto_function: FUNCTION [ANY, TUPLE, BOOLEAN];
								  a_comment_agent: FUNCTION [ANY, TUPLE, LIST [EDITOR_TOKEN]]) is
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

	setup_class_item_with_short_signature (a_item: EB_GRID_COMPILER_ITEM; a_class_c: CLASS_C; a_text_tokens: LIST [EDITOR_TOKEN]; a_image: STRING;
										   a_tooltip_veto_function: FUNCTION [ANY, TUPLE, BOOLEAN];
										   a_full_signature_function: FUNCTION [ANY, TUPLE, LIST [EDITOR_TOKEN]]) is
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

invariant
	browser_attached: browser /= Void

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
