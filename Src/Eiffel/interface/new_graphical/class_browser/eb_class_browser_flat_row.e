note
	description: "A row used in flat view of class browser"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_BROWSER_FLAT_ROW

inherit
	EB_CLASS_BROWSER_GRID_ROW

create
	make

feature{NONE} -- Initialization

	make (a_feature: like feature_item; a_browser: like browser)
			-- Initialize `feature_item' with `a_feature'.
		require
			a_feature_attached: a_feature /= Void
			a_feature_is_real_feature: a_feature.is_real_feature
			a_browser_attached: a_browser /= Void
		do
			feature_item := a_feature
			set_browser (a_browser)

			create class_item_internal
			create feature_item_internal

			short_generic_class_style.set_class_c (written_class)
			short_generic_class_tokens := short_generic_class_style.text
			class_image := string_representation_of_editor_tokens (short_generic_class_tokens)

			feature_signature_style.set_ql_feature (feature_item)
			feature_signature_tokens := feature_signature_style.text

			class_item_internal.set_stone_function (agent class_stone (written_class))
			feature_item_internal.set_stone_function (agent feature_stone (e_feature))
		end

feature -- Grid binding

	refresh
			-- Refresh current row.
		require
			grid_row_attached: grid_row /= Void
		do
			is_up_to_date := False
			update_row
		end

	bind_row (a_grid: EV_GRID; a_background_color: EV_COLOR; a_height: INTEGER)
			-- Bind current at the end of `a_grid' and set backgroud color of
			-- inserted row with `a_background_color', set row height with `a_height'.
		require
			a_grid_not_void: a_grid /= Void
			a_grid_valid: a_grid.is_tree_enabled and not a_grid.is_row_height_fixed
			a_background_color_not_void: a_background_color /= Void
			a_height_non_negative: a_height >= 0
		local
			l_row: EV_GRID_ROW
		do
			if is_parent or else is_expanded then
				a_grid.insert_new_row (a_grid.row_count + 1)
				l_row := a_grid.row (a_grid.row_count)
				l_row.set_background_color (a_background_color)
				l_row.set_height (a_height)
				if is_parent then
					if children_count > 0 then
						l_row.insert_subrow (1)
						l_row.subrow (1).set_height (0)
					end
					if is_expanded then
						if l_row.is_expandable then
							l_row.expand
						end
					else
						if l_row.is_expandable then
							l_row.collapse
						end
					end
				end
			else
				a_grid.insert_new_row (a_grid.row_count + 1)
				l_row := a_grid.row (a_grid.row_count)
				l_row.set_background_color (a_background_color)
				l_row.set_height (0)
			end
			set_grid_row (l_row)
			grid_row.set_item (1, class_grid_item)
			grid_row.set_item (2, feature_grid_item)
		end

feature -- Status report

	is_parent: BOOLEAN
			-- Is current row a parent row?
		do
			Result := parent = Current
		ensure
			good_result: Result implies (parent = Current)
		end

	is_expanded: BOOLEAN
			-- Is current row expanded?

	is_up_to_date: BOOLEAN
			-- Is status of current row up-to_date?

feature -- Access

	feature_item: QL_FEATURE
			-- Feature associated with current row

	e_feature: E_FEATURE
			-- E_FEATURE object of `feature_item'
		require
			real_feature: feature_item.is_real_feature
		do
			Result := feature_item.e_feature
		ensure
			result_attached: Result /= Void
		end

	written_class: CLASS_C
			-- Written class of `feature_item'
		do
			Result := feature_item.written_class
		ensure
			result_attached: Result /= Void
		end

	class_c: CLASS_C
			-- CLASS_C object of `feature_item'
		do
			Result := feature_item.class_c
		ensure
			result_attached: Result /= Void
		end

	children_count: INTEGER
			-- Number of subrow

	parent: like Current
			-- Parent row of current

	summary: STRING_32
			-- Summary of current row
		do
			Result := interface_names.l_feature_count (children_count + 1)
		ensure
			result_attached: Result /= Void
		end

feature -- Setting

	set_parent (a_parent: like parent)
			-- Set `parent' with `a_parent'.
		do
			parent := a_parent
			is_up_to_date := False
		ensure
			parent_set: parent = a_parent
		end

	set_is_expanded (b: BOOLEAN)
			-- Set `is_expanded' with `b'.
		do
			is_expanded := b
			is_up_to_date := False
		ensure
			is_expanded_set: is_expanded = b
		end

	set_children_count (a_count: INTEGER)
			-- Set `children_count' with `a_count'.
		do
			children_count := a_count
			is_up_to_date := False
		ensure
			children_count_set: children_count = a_count
		end

feature{NONE} -- Grid items

	class_grid_item: EB_GRID_EDITOR_TOKEN_ITEM
			-- Class item
		do
			update_row
			Result := class_item_internal
		ensure
			result_attached: Result /= Void
		end

	feature_grid_item: EB_GRID_EDITOR_TOKEN_ITEM
			-- Feature item
		do
			update_row
			Result := feature_item_internal
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Implementation

	feature_item_internal: like feature_grid_item
			-- Internal `feature_grid_item'

	class_item_internal: like class_grid_item
			-- Internal `class_grid_item'

	class_tooltip_tokens: LIST [EDITOR_TOKEN]
			-- Editor tokens for class tooltip
		do
			if class_tooltip_tokens_internal = Void then
				complete_generic_class_style.set_class_c (written_class)
				class_tooltip_tokens_internal := complete_generic_class_style.text
			end
			Result := class_tooltip_tokens_internal
		end

	class_tooltip_tokens_internal: like class_tooltip_tokens
			-- Implementation of `class_tooltip_tokens'

	class_image: STRING_32
			-- Image of class used in search

	feature_image: STRING_32
			-- Image of feature used in search
		do
			if feature_image_internal = Void then
				feature_image_internal := string_representation_of_editor_tokens (feature_signature_tokens)
			end
			Result := feature_image_internal
		ensure
			result_attached: Result /= Void
		end

	feature_comment: LIST [EDITOR_TOKEN]
			-- Feature comment
		do
			if feature_comment_internal = Void then
				feature_comment_internal :=ql_feature_comment (feature_item)
			end
			Result := feature_comment_internal
		ensure
			result_attached: Result /= Void
		end

	feature_comment_internal: like feature_comment
			-- Implementation of `feature_comment'

	feature_image_internal: like feature_image
			-- Implementation of `feature_image'

	short_generic_class_tokens: LIST [EDITOR_TOKEN]
			-- Editor tokens for class signature displayed in grid item

	feature_signature_tokens: LIST [EDITOR_TOKEN]
			-- Editor tokens for feature signature displayed in grid item

feature{NONE} -- Item setup

	setup_class_item_with_blank (a_item: EB_GRID_EDITOR_TOKEN_ITEM)
			-- Setup `a_item' using `class_c' into blank form.
		require
			a_item_attached: a_item /= Void
		do
			a_item.set_text ("")
			a_item.set_image ("")
			a_item.remove_pixmap
		end

	setup_feature_with_summary (a_item: like feature_grid_item)
			-- Setup `a_item' using `feature_item' to summary form.
		require
			a_item_attached: a_item /= Void
		do
			a_item.set_pixmap (pixmaps.icon_pixmaps.feature_group_icon)
			agent_style.set_text_function (agent summary)
			a_item.set_text_with_tokens (agent_style.text)
			a_item.set_image (feature_image)
			a_item.remove_general_tooltip
		end

	update_row
			-- Update status of current row.
		do
			if not is_up_to_date then
					-- Update class item.
				if is_parent then
					setup_class_item_with_short_signature (
						class_item_internal, written_class, short_generic_class_tokens, class_image,
						agent should_class_tooltip_be_displayed (written_class),
						agent class_tooltip_tokens)
				else
					setup_class_item_with_blank (class_item_internal)
				end
					-- Update feature item.
				if is_parent and not is_expanded then
					setup_feature_with_summary (feature_item_internal)
				else
					setup_feature_signature_item (
						feature_item_internal, feature_item.e_feature, feature_signature_tokens, feature_image,
						agent should_feature_tooltip_be_displayed, agent feature_comment)
				end
				is_up_to_date := True
			end
		ensure
			status_up_to_date: is_up_to_date
		end

	should_feature_tooltip_be_displayed: BOOLEAN
			-- Should feature tooltip display be displayed?
		do
			Result := browser.should_tooltip_be_displayed
			if Result then
				Result := feature_grid_item.general_tooltip.has_tooltip_text or else not is_expanded
			end
		end

invariant
	feature_item_attached: feature_item /= Void
	feature_item_is_real_feature: feature_item.is_real_feature
	e_feature_attached: e_feature /= Void
	children_count_correct: children_count > 0 implies is_parent
	class_image_attached: class_image /= Void
	short_generic_class_tokens_attached: short_generic_class_tokens /= Void
	feature_signature_tokens_attached: feature_signature_tokens /= Void

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
