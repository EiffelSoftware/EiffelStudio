note
	description: "Feature browser row"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_BROWSER_GRID_ROW

inherit
	EB_CLASS_BROWSER_GRID_ROW
		redefine
			browser
		end

create
	make

feature{NONE} -- Initialization

	make (a_feature: like feature_item; a_branch_id: INTEGER; a_browser: like browser; a_written_class_used: BOOLEAN; a_signature_displayed: BOOLEAN)
			-- Initialize `feature_item' with `a_feature' and
			-- `branch_id' with `a_branch_id'.
			-- `a_written_class_used' indicates if written class of `a_feature' is displayed.
			-- `a_signature_displayed' indicates if full signature of `a_feature' is displayed instead of just feature name.
		require
			a_feature_attached: a_feature /= Void
			a_feature_valid: a_feature.is_valid_domain_item
			a_browser_attached: a_browser /= Void
		local
			l_style: EB_EDITOR_TOKEN_STYLE
		do
			feature_item := a_feature
			branch_id := a_branch_id
			set_browser (a_browser)
			is_written_class_used := a_written_class_used
			is_signature_displayed := a_signature_displayed

			short_generic_class_style.set_class_c (feature_item.class_c)
			short_class_tokens := short_generic_class_style.text
			short_class_image := string_representation_of_editor_tokens (short_class_tokens)

			if is_written_class_used then
				short_generic_class_style.set_class_c (feature_item.written_class)
				short_written_class_tokens := short_generic_class_style.text
				short_written_class_image := string_representation_of_editor_tokens (short_written_class_tokens)
			end

			if is_signature_displayed then
				feature_signature_style.set_e_feature (feature_item.e_feature)
				l_style := feature_signature_style
			else
				feature_signature_style.set_e_feature (feature_item.e_feature)
				l_style := feature_signature_style
			end
			if browser.is_version_from_displayed then
				if
					feature_item.is_real_feature and then
					feature_item.e_feature.same_as (browser.feature_item)
				then
					agent_style.set_text_function (agent interface_names.l_version_from_message)
					l_style := l_style + agent_style
				end
			end
			feature_signature_tokens := l_style.text
			feature_image := string_representation_of_editor_tokens (feature_signature_tokens)
		ensure
			feature_signature_tokens_attached: feature_signature_tokens /= Void
			feature_item_set: feature_item = a_feature
			branch_id_set: branch_id = a_branch_id
			browser_set: browser = a_browser
		end

feature -- Status report

	is_written_class_used: BOOLEAN
			-- Should `written_class' of `feature_item' be displayed?

	is_signature_displayed: BOOLEAN
			-- Is full feature signature displayed?
			-- If False, just display feature name.

	should_feature_tooltip_be_displayed: BOOLEAN
			-- Should tooltip displayed be vetoed?
		do
			Result := browser.should_tooltip_be_displayed
			if Result then
				Result := feature_grid_item.general_tooltip.has_tooltip_text
			end
		end

feature -- Setting

	set_parent (a_parent: like parent)
			-- Set `parent' with `a_parent'.
		do
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

feature -- Access		

	feature_item: QL_FEATURE
			-- Feature assoicated with current row

	branch_id: INTEGER
			-- Branch Id

	parent: EV_GRID_ROW
			-- Parent row of current

	browser: EB_FEATURE_BROWSER_GRID_VIEW
			-- Browser in which current row is contained			

	class_grid_item: EB_GRID_EDITOR_TOKEN_ITEM
			-- Class item
		do
			if class_item_internal = Void then
				create class_item_internal
				setup_class_item_with_short_signature (
					class_item_internal, feature_item.class_c, short_class_tokens, short_class_image,
					agent should_class_tooltip_be_displayed (feature_item.class_c), agent complete_class_name_tokens
				)
				class_item_internal.set_stone_function (agent class_stone (feature_item.class_c))
			end
			Result := class_item_internal
		ensure
			result_attached: Result /= Void
		end

	written_class_grid_item: EB_GRID_EDITOR_TOKEN_ITEM
			-- Written class item
		require
			writen_class_used: is_written_class_used
		do
			if is_written_class_used and then feature_item.class_c.class_id /= feature_item.written_class.class_id then
				if written_class_item_internal = Void then
					create written_class_item_internal
					setup_class_item_with_short_signature (
						written_class_item_internal, feature_item.written_class, short_written_class_tokens, short_written_class_image,
						agent should_class_tooltip_be_displayed (feature_item.written_class), agent complete_written_class_name_tokens
					)
					written_class_item_internal.set_stone_function (agent class_stone (feature_item.written_class))
				end
				Result := written_class_item_internal
			end
		end

	feature_grid_item: EB_GRID_EDITOR_TOKEN_ITEM
			-- Feature item
		do
			if feature_item_internal = Void  then
				create feature_item_internal
				setup_feature_signature_item (
					feature_item_internal, feature_item.e_feature, feature_signature_tokens, feature_image,
					agent should_feature_tooltip_be_displayed, agent feature_comment
				)
				feature_item_internal.set_stone_function (agent feature_stone (feature_item.e_feature))
			end
			Result := feature_item_internal
		ensure
			result_attached: Result /= Void
		end

	feature_image: STRING_32
			-- String representation of `feature_signature' used in grid search.

feature -- Grid binding

	bind_row (a_row: EV_GRID_ROW; a_grid: EV_GRID; a_background_color: EV_COLOR; a_height: INTEGER)
			-- Bind current as a subrow of `a_row' in `a_grid'. if `a_row' is Void, insert a new
			-- row in `a_grid' directly.
			-- Set backgroud color of inserted row with `a_background_color',
			-- set row height with `a_height'.
		require
			a_grid_not_void: a_grid /= Void
			a_grid_valid: a_grid.is_tree_enabled
			a_background_color_not_void: a_background_color /= Void
			a_height_non_negative: a_height >= 0
		local
			l_row: EV_GRID_ROW
		do
			if a_row /= Void then
				a_row.insert_subrow (a_row.subrow_count + 1)
				l_row := a_row.subrow (a_row.subrow_count)
				set_parent (a_row)
			else
				a_grid.insert_new_row (a_grid.row_count + 1)
				l_row := a_grid.row (a_grid.row_count)
			end
			l_row.set_item (1, class_grid_item)
			l_row.set_item (2, feature_grid_item)
			if is_written_class_used then
				l_row.set_item (3, written_class_grid_item)
			end
			set_grid_row (l_row)
		end

feature{NONE} -- Implementation

	class_item_internal: like class_grid_item
			-- Internal `class_grid_item'

	written_class_item_internal: like written_class_grid_item
			-- Internal `written_class_grid_item'

	feature_item_internal: like feature_grid_item
			-- Internal `feature_grid_item'

	short_class_tokens: LIST [EDITOR_TOKEN]
			-- Editor tokens containing short generic form of `feature_item'.`class_c'

	short_class_image: STRING_32
			-- Image of `feature_item'.`class_c' used in grid search

	short_written_class_tokens: LIST [EDITOR_TOKEN]
			-- Editor tokens containing short generic form of `feature_item'.`written_class'

	short_written_class_image: STRING_32
			-- Image of `feature_item'.`written_class' used in grid search

	complete_written_class_name_tokens: LIST [EDITOR_TOKEN]
			-- Editor tokens to display complete written class form of `feature_item'.`written_class_c'.
		do
			if complete_written_class_name_tokens_internal = Void then
				complete_generic_class_style.set_class_c (feature_item.written_class)
				complete_written_class_name_tokens_internal := complete_generic_class_style.text
			end
			Result := complete_written_class_name_tokens_internal
		end

	complete_written_class_name_tokens_internal: like complete_written_class_name_tokens
			-- Implementation of `complete_written_class_name_tokens'

	feature_signature_tokens: LIST [EDITOR_TOKEN]
			-- Editor tokens to display feature signature.

	feature_comment: LIST [EDITOR_TOKEN]
			-- Feature comment
		do
			if feature_comment_internal = Void then
				feature_comment_style.set_ql_feature (feature_item)
				feature_comment_internal := feature_comment_style.text
			end
			Result := feature_comment_internal
		ensure
			result_attached: Result /= Void
		end

	feature_comment_internal: like feature_comment
			-- Implementation of `feature_comment'

	complete_class_name_tokens: LIST [EDITOR_TOKEN]
			-- Editor tokens to display complete class form of `feature_item'.`class_c'.
		do
			if complete_class_name_tokens_internal = Void then
				complete_generic_class_style.set_class_c (feature_item.class_c)
				complete_class_name_tokens_internal := complete_generic_class_style.text
			end
			Result := complete_class_name_tokens_internal
		end

	complete_class_name_tokens_internal: like complete_class_name_tokens
			-- Implementation of `complete_class_name_tokens'

invariant
	short_class_tokens_attached: short_class_tokens /= Void
	short_class_image_attached: short_class_image /= Void

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
