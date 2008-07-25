indexing
	description: "A grid row used in grid feature_item/related_feature view"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_BROWSER_CALLER_CALLEE_ROW

inherit
	EB_CLASS_BROWSER_GRID_ROW

	EB_SHARED_WRITER

	EB_EDITOR_TOKEN_IDS

create
	make

feature{NONE} -- Initialization

	make (a_browser: like browser; a_feature: like feature_item; a_related_feature: like related_feature; a_row_type: INTEGER; a_for_caller: BOOLEAN) is
			-- Initialize Current row.
		require
			a_browser_attached: a_browser /= Void
			a_feature_attached: a_feature /= Void
			a_row_type_valid: is_row_type_valid (a_row_type)
		do
			set_browser (a_browser)
			set_feature_item (a_feature)
			set_related_feature (a_related_feature)
			set_row_type (a_row_type)
			setup_image
			set_is_for_caller (a_for_caller)
		end

feature -- Access

	flag: NATURAL_16
			-- Flag to distinguish different accessors such as assigner, creator

	feature_item: QL_FEATURE
			-- feature_item

	related_feature: QL_FEATURE
			-- related_feature

	image: STRING
			-- String representation of Current row, used in sorting

	row_type: INTEGER
			-- Type of Current row

	starting_column_index: INTEGER
			-- Index for the first item in Current row

	item (a_index: INTEGER): EV_GRID_ITEM is
			-- The `a_index'-th grid item in Current row
		require
			a_index_valid: a_index >= starting_column_index and then a_index <= starting_column_index + 2
		do
			if a_index - starting_column_index = 0 then
				Result := grid_item
			else
				calculate_reference_position
				Result := accessor_grid_item
			end
		end

feature -- Access/Row type

	compact_feature_row: INTEGER is 1
	class_row: INTEGER is 2
	feature_name_row: INTEGER is 3

feature -- Status report

	is_row_type_valid (a_row_type: like row_type): BOOLEAN is
			-- Is `a_row_type' valid?
		do
			Result := a_row_type = compact_feature_row or else
					  a_row_type = class_row or else
					  a_row_type = feature_name_row
		end

	is_for_caller: BOOLEAN
			-- Is Current row to display caller information?

	has_position_calculated: BOOLEAN
			-- Has positions of caller/callee been calculated?

feature -- Setting

	set_feature_item (a_feature_item: like feature_item) is
			-- Set `feature_item' with `a_feature_item'.
		require
			a_feature_item_attached: a_feature_item /= Void
		do
			feature_item := a_feature_item
		ensure
			feature_item_set: feature_item = a_feature_item
		end

	set_related_feature (a_related_feature: like related_feature) is
			-- Set `related_feature' with `a_related_feature'.
		do
			related_feature := a_related_feature
		ensure
			related_feature_set: related_feature = a_related_feature
		end

	set_image (a_image: like image) is
			-- Set `image' with `a_image'.
		require
			a_image_attached: a_image /= Void
		do
			create image.make_from_string (a_image)
		ensure
			image_set: image /= Void and then image.is_equal (a_image)
		end

	set_row_type (a_row_type: like row_type) is
			-- Set `row_type' with `a_row_type'.
		do
			row_type := a_row_type
		ensure
			row_type_set: row_type = a_row_type
		end

	set_is_for_caller (b: BOOLEAN) is
			-- Set `is_for_caller' with `b'.
		do
			is_for_caller := b
		ensure
			is_for_caller_set: is_for_caller = b
		end

	set_starting_column_index (a_index: INTEGER) is
			-- Set `starting_column_index' with `a_index'.
		do
			starting_column_index := a_index
		ensure
			starting_column_index_set: starting_column_index = a_index
		end

	set_flag (a_flag: like flag) is
			-- Set `flag' with `a_flag'.
		do
			flag := a_flag
		ensure
			flag_set: flag = a_flag
		end

	bind_reference_position_item is
			-- Bind reference position item into grid.
		do
			if not has_position_calculated then
				calculate_reference_position
			end
			if is_binded_to_grid then
				grid_row.set_item (starting_column_index + 1, accessor_grid_item)
			end
		end

	calculate_reference_position is
			-- Calculate reference (callers/callees) positions for `feature_item' and display them in another grid item.
		local
			l_accessor_visitor: like accessor_visitor
			l_caller: like feature_item
			l_callee: like feature_item
			l_accessors: LIST [TUPLE [a_ast: AST_EIFFEL; a_class: CLASS_C]]
		do
			if row_type = feature_name_row and then not has_position_calculated then
				if is_for_caller then
					l_caller := feature_item
					l_callee := related_feature
				else
					l_caller := related_feature
					l_callee := feature_item
				end

				if l_callee /= Void and then l_callee.is_real_feature then
					l_accessor_visitor := accessor_visitor
					l_accessor_visitor.set_flag (flag)
					l_accessor_visitor.find_accessors (l_callee, l_caller)
					l_accessors := l_accessor_visitor.accessors
					if l_accessors.is_empty then
						-- Fixme: add code
					else
						create_accessor_grid_item (l_accessors)
					end
				end
				set_has_position_calculated (True)
			end
		end

	accessor_visitor: EB_ACCESSED_FEATURE_VISITOR is
			-- Visitor to calculate reference positions
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

feature -- Grid binding

	bind_row (a_grid_row: EV_GRID_ROW; a_column_index: INTEGER; a_force_reference_calculation: BOOLEAN) is
			-- Bind Current row into `grid' starting from column indexed by `a_column_index'.
			-- If `a_force_reference_calculation' is True, referenced position grid item will be binded also.
		local
			l_accessor_grid_item: like accessor_grid_item
		do
			if is_binded_to_grid and then grid_row.parent /= Void then
				grid_row.clear
			end
			starting_column_index := a_column_index
			set_grid_row (a_grid_row)
			a_grid_row.set_item (a_column_index, grid_item)
			a_grid_row.set_data (Current)

			if a_force_reference_calculation and then not has_position_calculated then
				calculate_reference_position
			end
			l_accessor_grid_item := accessor_grid_item
			if l_accessor_grid_item /= Void then
				a_grid_row.set_item (a_column_index + 1, l_accessor_grid_item)
			end
		end

feature{NONE} -- Implementation/Text

	compact_feature_name_text (a_feature: QL_FEATURE): like grid_item_text is
			-- compact text for `a_feature'.
			-- For example: "item from LINKED_LIST"
		require
			a_feature_attached: a_feature /= Void
		local
			l_plain_style: like plain_text_style
		do
			Result := feature_name_text (a_feature)

			l_plain_style := plain_text_style
			l_plain_style.set_source_text (from_string)
			Result.append (l_plain_style.text)

			Result.append (class_name_text (a_feature.class_c))
		ensure
			result_attached: Result /= Void
		end

	class_name_text (a_class: CLASS_C): like grid_item_text is
			-- Text for name of `a_class'.
		require
			a_class_attached: a_class /= Void
		local
			l_class_style: like just_class_name_style
		do
			l_class_style := just_class_name_style
			l_class_style.set_class_c (a_class)
			Result := l_class_style.text
		ensure
			result_attached: Result /= Void
		end

	feature_name_text (a_feature: QL_FEATURE): like grid_item_text is
			-- Text for name of `a_feature'
		require
			a_feature_attached: a_feature /= Void
		local
			l_feature_style: like feature_name_style
		do
			l_feature_style := feature_name_style
			l_feature_style.set_ql_feature (a_feature)
			Result := l_feature_style.text
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Implementation/Data

	grid_item: EB_GRID_EDITOR_TOKEN_ITEM is
			-- Grid item to be displayed
		local
			l_grid_item: like grid_item_internal
			l_feature_item: like feature_item
		do
			if grid_item_internal = Void then
				create l_grid_item
				l_grid_item.set_pixmap (grid_item_pixmap)
				l_grid_item.set_text_with_tokens (grid_item_text)

					-- Setup stone for grid item.
				l_feature_item := feature_item
				if row_type = class_row then
					l_grid_item.set_stone (create {CLASSC_STONE}.make (l_feature_item.class_c))
				else
					if l_feature_item.is_real_feature then
						l_grid_item.set_stone (create {FEATURE_STONE}.make (l_feature_item.e_feature))
					else
						l_grid_item.set_stone (create {AST_STONE}.make (l_feature_item.written_class, l_feature_item.ast))
					end
				end
				l_grid_item.set_image (image)
				grid_item_internal := l_grid_item
			end
			Result := grid_item_internal
		ensure
			result_attached: Result /= Void
			stone_set: Result.stone /= Void
		end

	grid_item_pixmap: EV_PIXMAP is
			-- Pixmap for `grid_item'
		do
			inspect
				row_type
			when compact_feature_row then
				Result := feature_pixmap (feature_item)
			when class_row then
				Result := pixmap_from_class_i (feature_item.class_c.lace_class)
			when feature_name_row then
				Result := feature_pixmap (feature_item)
			end
		ensure
			result_attached: Result /= Void
		end

	feature_pixmap (a_feature: QL_FEATURE): EV_PIXMAP is
			-- Pixmap for `a_feature'
		require
			a_feature_attached: a_feature /= Void
		do
			if a_feature.is_real_feature then
				Result := pixmap_from_e_feature (a_feature.e_feature)
			else
				Result := pixmaps.icon_pixmaps.class_features_invariant_icon
			end
		ensure
			result_attached: Result /= Void
		end

	grid_item_text: LIST [EDITOR_TOKEN] is
			-- Text for `grid_item'
		do
			inspect
				row_type
			when compact_feature_row then
				Result := compact_feature_name_text (feature_item)
			when class_row then
				Result := class_name_text (feature_item.class_c)
			when feature_name_row then
				Result := feature_name_text (feature_item)
			end
		ensure
			result_attached: Result /= Void
		end

	grid_item_internal: like grid_item
			-- Implementation of `grid_item'

	from_string: STRING is
			-- String " from "
		do
			Result := interface_names.l_from_x.twin
			Result.to_lower
			Result.right_adjust
			Result.left_adjust
			Result.prepend (" ")
			Result.append (" ")
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Implementation

	setup_image is
			-- Setup `image' according to `feature_item', `related_feature' and `row_type'.
		local
			l_image: like image
			l_feature_item: like feature_item
		do
			create l_image.make (20)
			l_feature_item := feature_item

			inspect
				row_type
			when compact_feature_row then
				l_image.append (l_feature_item.name)
				l_image.append (from_string)
				l_image.append (l_feature_item.class_c.name)
			when class_row then
				l_image.append (l_feature_item.class_c.name)
			when feature_name_row then
				l_image.append (l_feature_item.name)
			end
			set_image (l_image)
		ensure
			image_attached: image /= Void
		end

	set_has_position_calculated (b: BOOLEAN) is
			-- Set `has_position_calculated' with `b'.
		do
			has_position_calculated := b
		ensure
			has_position_calculated_set: has_position_calculated = b
		end

feature{NONE} -- Actions

	create_accessor_grid_item (a_accessors: LIST [TUPLE [a_ast: AST_EIFFEL; a_class: CLASS_C]]) is
			-- Create grid item to display `a_ccessors'.
		require
			a_accessors_attached: a_accessors /= Void
			a_accessors_valid: (not a_accessors.is_empty) and then (not a_accessors.has (Void))
		local
			l_item: ES_GRID_LIST_ITEM
		do
			check accessor_grid_item = Void end
			create l_item
			from
				a_accessors.start
			until
				a_accessors.after
			loop
				l_item.insert_component (accessor_grid_item_component (a_accessors.index, a_accessors.item.a_ast, a_accessors.item.a_class), a_accessors.index)
				a_accessors.forth
			end
			l_item.enable_component_pebble
			accessor_grid_item := l_item
		ensure
			accessor_grid_item_attached: accessor_grid_item /= Void
		end

	accessor_grid_item: EV_GRID_ITEM
			-- Grid item to display accessors for `related_feature'

	accessor_grid_item_component (a_index: INTEGER; a_accessor: AST_EIFFEL; a_written_class: CLASS_C): ES_GRID_ITEM_COMPONENT is
			-- Grid item component for `a_accessor'
		require
			a_index_positive: a_index > 0
			a_accessor_attached: a_accessor /= Void
			a_written_class_attached: a_written_class /= Void
		local
			l_component: EB_GRID_EDITOR_TOKEN_COMPONENT
			l_writer: like token_writer
			l_appearance: like feature_appearance
			l_tooltip: EB_EDITOR_TOKEN_TOOLTIP
		do
			l_writer := token_writer
			l_writer.new_line
				-- For AST in another class, we use a different appearance.
			if a_written_class.class_id /= feature_item.class_c.class_id then
				l_appearance := assertion_tag_appearance
			else
				l_appearance := feature_appearance
			end
			l_writer.process_ast ("#" + a_index.out, a_accessor, a_written_class, l_appearance, True, cursors.cur_feature, cursors.cur_x_feature)
			create l_component.make (l_writer.last_line.content, 2)

				-- Setup general tooltip.
			if a_written_class.class_id /= feature_item.class_c.class_id then
				create l_tooltip.make (l_component.pointer_enter_actions, l_component.pointer_leave_actions, Void, agent l_component.is_owner_destroyed)
				l_tooltip.enable_pointer_on_tooltip
				plain_text_style.set_source_text (interface_names.l_from_x)
				complete_generic_class_style.set_class_c (a_written_class)
				l_tooltip.set_tooltip_text ((plain_text_style + complete_generic_class_style).text)
				l_tooltip.veto_tooltip_display_functions.extend (agent: BOOLEAN do Result := browser.should_tooltip_be_displayed end)
				initialize_editor_token_tooltip (l_tooltip)
				l_component.set_general_tooltip (l_tooltip)
			end

			Result := l_component
		ensure
			result_attached: Result /= Void
		end

invariant
	feature_item_attached: feature_item /= Void
	image_attached: image /= Void

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
