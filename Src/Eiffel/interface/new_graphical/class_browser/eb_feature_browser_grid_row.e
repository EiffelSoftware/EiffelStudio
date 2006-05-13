indexing
	description: "Feature browser row"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_BROWSER_GRID_ROW

inherit
	EB_GRID_ROW

create
	make

feature{NONE} -- Initialization

	make (a_feature: like feature_item; a_branch_id: INTEGER; a_browser: like browser) is
			-- Initialize `feature_item' with `a_feature' and
			-- `branch_id' with `a_branch_id'.
		require
			a_feature_attached: a_feature /= Void
			a_feature_valid: a_feature.is_valid_domain_item
			a_browser_attached: a_browser /= Void
		do
			feature_item := a_feature
			branch_id := a_branch_id
			browser := a_browser
		ensure
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

feature -- Setting

	set_is_written_class_used (b: BOOLEAN) is
			-- Set `is_written_class_used' with `b'.
		do
			is_written_class_used := b
		ensure
			is_written_class_used_set: is_written_class_used = b
		end

	set_parent (a_parent: like parent) is
			-- Set `parent' with `a_parent'.
		do
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

	set_is_signature_displayed (b: BOOLEAN) is
			-- Set `is_signature_displayed' with `b'.
		do
			is_signature_displayed := b
		ensure
			is_signature_displayed_set: is_signature_displayed = b
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

feature -- Access

	class_grid_item: EB_GRID_CLASS_ITEM is
			-- Class item
		local
			l_style: EB_GRID_CLASS_ITEM_STYLE
		do
			if class_item_internal = Void then
				create {EB_GRID_JUST_NAME_CLASS_STYLE}l_style
				l_style.disable_starred_class_name
				create class_item_internal.make (feature_item.class_c, l_style)
				class_item_internal.enable_pixmap
				class_item_internal.set_tooltip_display_function (agent browser.should_tooltip_be_displayed)
			end
			Result := class_item_internal
		ensure
			result_attached: Result /= Void
		end

	written_class_grid_item: EB_GRID_CLASS_ITEM is
			-- Written class item
		local
			l_style: EB_GRID_CLASS_ITEM_STYLE
		do
			if is_written_class_used and then feature_item.class_c.class_id /= feature_item.written_class.class_id then
				if written_class_item_internal = Void then
					create {EB_GRID_JUST_NAME_CLASS_STYLE}l_style
					l_style.disable_starred_class_name
					create written_class_item_internal.make (feature_item.written_class, l_style)
					written_class_item_internal.enable_pixmap
					written_class_item_internal.set_tooltip_display_function (agent should_feature_tooltip_be_displayed)
				end
				Result := written_class_item_internal
			end
		end

	feature_grid_item: EB_GRID_FEATURE_ITEM is
			-- Feature item
		local
			l_style: EB_GRID_FEATURE_ITEM_STYLE
		do
			if feature_item_internal = Void then
				if is_signature_displayed then
					create {EB_GRID_FULL_FEATURE_STYLE}l_style
				else
					create {EB_GRID_JUST_NAME_FEATURE_STYLE}l_style
				end
				if browser.is_version_from_displayed then
					if
						feature_item.is_real_feature and then
						feature_item.e_feature.same_as (browser.feature_item)
					then
						l_style := create {EB_GRID_VERSION_FROM_FEATURE_STYLE}.make (l_style)
					end
				end
				create feature_item_internal.make (feature_item, l_style)
				feature_item_internal.set_tooltip_display_function (agent should_feature_tooltip_be_displayed)
			end
			Result := feature_item_internal
		ensure
			result_attached: Result /= Void
		end

feature -- Grid binding

	bind_row (a_row: EV_GRID_ROW; a_grid: EV_GRID; a_background_color: EV_COLOR; a_height: INTEGER) is
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

	should_feature_tooltip_be_displayed: BOOLEAN is
			-- Should tooltip be displayed?
		do
			Result := browser.should_tooltip_be_displayed
			if Result then
				Result := feature_grid_item.general_tooltip.has_tooltip_text
			end
		end

invariant
	feature_item_attached: feature_item /= Void
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
