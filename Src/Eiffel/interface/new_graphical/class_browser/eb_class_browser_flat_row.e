indexing
	description: "A row used in flat view of class browser"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_BROWSER_FLAT_ROW

inherit
	EB_GRID_ROW

create
	make

feature{NONE} -- Initialization

	make (a_feature: like feature_item; a_browser: like browser) is
			-- Initialize `feature_item' with `a_feature'.
		require
			a_feature_attached: a_feature /= Void
			a_feature_is_real_feature: a_feature.is_real_feature
			a_browser_attached: a_browser /= Void
		do
			feature_item := a_feature
			browser := a_browser
		ensure
			feature_item_set: feature_item = a_feature
			browser_set: browser = a_browser
		end

feature -- Grid binding

	refresh is
			-- Refresh current row.
		require
			grid_row_attached: grid_row /= Void
		do
			grid_row.set_item (1, class_grid_item)
			grid_row.set_item (2, feature_grid_item)
		end

	bind_row (a_grid: EV_GRID; a_background_color: EV_COLOR; a_height: INTEGER) is
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
			refresh
		end

feature -- Status report

	is_parent: BOOLEAN is
			-- Is current row a parent row?
		do
			Result := parent = Current
		ensure
			good_result: Result implies (parent = Current)
		end

	is_expanded: BOOLEAN
			-- Is current row expanded?

feature -- Access

	feature_item: QL_FEATURE
			-- Feature associated with current row

	e_feature: E_FEATURE is
			-- E_FEATURE object of `feature_item'
		do
			Result := feature_item.e_feature
		ensure
			result_attached: Result /= Void
		end

	written_class: CLASS_C is
			-- Written class of `feature_item'
		do
			Result := feature_item.written_class
		ensure
			result_attached: Result /= Void
		end

	class_c: CLASS_C is
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

	summary: STRING is
			-- Summary of current row
		do
			Result := (children_count + 1).out + " features"
		ensure
			result_attached: Result /= Void
		end

feature -- Setting

	set_parent (a_parent: like parent) is
			-- Set `parent' with `a_parent'.
		do
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

	set_is_expanded (b: BOOLEAN) is
			-- Set `is_expanded' with `b'.
		do
			is_expanded := b
		ensure
			is_expanded_set: is_expanded = b
		end

	set_children_count (a_count: INTEGER) is
			-- Set `children_count' with `a_count'.
		do
			children_count := a_count
		ensure
			children_count_set: children_count = a_count
		end

feature -- Grid operations

	class_grid_item: EB_GRID_CLASS_ITEM is
			-- Class item
		local
			l_style: EB_GRID_CLASS_ITEM_STYLE
		do
			if class_item_internal = Void then
				if is_parent then
					create {EB_GRID_SHORTENED_CLASS_STYLE}l_style
					l_style.disable_starred_class_name
					create class_item_internal.make (written_class, l_style)
					class_item_internal.disable_invisible_pixmap
				else
					create {EB_GRID_QUOTE_CLASS_STYLE}l_style
					l_style.disable_starred_class_name
					create class_item_internal.make (written_class, l_style)
					class_item_internal.enable_invisible_pixmap
				end
				class_item_internal.enable_pixmap
				class_item_internal.set_data (Current)
				class_item_internal.set_tooltip_display_function (agent browser.should_tooltip_be_displayed)
			else
				if is_parent then
					if not class_item_internal.style.is_shortened_signature_style then
						create {EB_GRID_SHORTENED_CLASS_STYLE}l_style
						l_style.disable_starred_class_name
						class_item_internal.set_style (l_style)
						class_item_internal.disable_invisible_pixmap
					end
				else
					if not class_item_internal.style.is_quote_style then
						create {EB_GRID_QUOTE_CLASS_STYLE}l_style
						l_style.disable_starred_class_name
						class_item_internal.set_style (l_style)
						class_item_internal.enable_invisible_pixmap
					end
				end
			end
			Result := class_item_internal
		ensure
			result_attached: Result /= Void
		end

	feature_grid_item: EB_GRID_FEATURE_ITEM is
			-- Feature item
		local
			l_style: EB_GRID_FEATURE_ITEM_STYLE
		do
			if feature_item_internal = Void then
				if is_parent and not is_expanded then
					create {EB_GRID_MESSAGE_FEATURE_STYLE}l_style.make (summary)
					create feature_item_internal.make (feature_item, l_style)
				else
					create {EB_GRID_FULL_FEATURE_STYLE}l_style
					create feature_item_internal.make (feature_item, l_style)
				end
				feature_item_internal.set_data (Current)
				feature_item_internal.set_tooltip_display_function (agent should_feature_tooltip_be_displayed)
			else
				if is_parent and not is_expanded then
					if not feature_item_internal.style.is_message_style then
						create {EB_GRID_MESSAGE_FEATURE_STYLE}l_style.make (summary)
						feature_item_internal.set_style (l_style)
					end
				else
					if not feature_item_internal.style.is_full_signature_style then
						create {EB_GRID_FULL_FEATURE_STYLE}l_style
						feature_item_internal.set_style (l_style)
					end
				end
			end
			Result := feature_item_internal
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Implementation

	feature_item_internal: like feature_grid_item
			-- Internal `feature_grid_item'

	class_item_internal: like class_grid_item
			-- Internal `class_grid_item'

	browser: EB_CLASS_BROWSER_FLAT_VIEW
			-- Browser in which current is displayed

	should_feature_tooltip_be_displayed: BOOLEAN is
			-- Should tooltip be displayed?
		do
			Result := browser.should_tooltip_be_displayed
			if Result then
				Result := feature_grid_item.general_tooltip.has_tooltip_text and then is_expanded
			end
		end

invariant
	feature_item_attached: feature_item /= Void
	feature_item_is_real_feature: feature_item.is_real_feature
	children_count_correct: children_count > 0 implies is_parent
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
