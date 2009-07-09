note
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UI_TABLE_VIEW

inherit
	UI_SCROLL_VIEW
		redefine
			iphone_class_name
		end

create
	make

feature {NONE} -- Initialization

	make (a_rect: CG_RECT)
			-- New instance of table located at `a_rect' coordinates.
		do
			allocate_object
			c_init_with_frame_and_style (item, a_rect.item, {UI_TABLE_VIEW_CONSTANTS}.style_plain)
		ensure
			exists: exists
			style_set: style = {UI_TABLE_VIEW_CONSTANTS}.style_plain
		end

	make_grouped (a_rect: CG_RECT)
		do
			allocate_object
			c_init_with_frame_and_style (item, a_rect.item, {UI_TABLE_VIEW_CONSTANTS}.style_grouped)
		ensure
			exists: exists
			style_set: style = {UI_TABLE_VIEW_CONSTANTS}.style_plain
		end

feature -- Access

	style: NATURAL_32
		require
			exists: exists
		do
			Result := c_style (item)
		ensure
			valid_style: Result = {UI_TABLE_VIEW_CONSTANTS}.style_plain or
				Result = {UI_TABLE_VIEW_CONSTANTS}.style_grouped
		end

	separator_style: NATURAL_32
		require
			exists: exists
		do
			Result := c_separator_style (item)
		ensure
			valid_separator_style: Result = {UI_TABLE_VIEW_CONSTANTS}.no_separator or
				Result = {UI_TABLE_VIEW_CONSTANTS}.single_line_separator
		end

	separator_color: UI_COLOR
		require
			exists: exists
		do
			create Result.share_from_pointer (c_separator_color (item))
		end

	data_source: UI_TABLE_VIEW_DATA_SOURCE
		require
			exists: exists
		do
			create Result.share_from_pointer (c_data_source (item))
		end

	row_height: REAL_32
			-- Height of rows in points
		require
			exists: exists
		do
			Result := c_row_height (item)
		end

	section_footer_height: REAL_32
			-- Height of section footers.
		require
			exists: exists
		do
			Result := c_section_footer_height (item)
		end

	section_header_height: REAL_32
			-- Height of section headers.
		require
			exists: exists
		do
			Result := c_section_header_height (item)
		end

	section_index_minimum_display_row_count: like ns_integer
		require
			exists: exists
		do
			Result := c_section_index_minimum_display_row_count (item)
		end

	table_footer_view: detachable UI_VIEW
		require
			exists: exists
		do
			if attached mapping.eiffel_object_from_c (c_table_footer_view (item)) as l_view then
				Result := l_view
			end
		end

	table_header_view: detachable UI_VIEW
		require
			exists: exists
		do
			if attached mapping.eiffel_object_from_c (c_table_header_view (item)) as l_view then
				Result := l_view
			end
		end

feature -- Status report

	is_editing: BOOLEAN
		require
			exists: exists
		do
			Result := c_is_editing (item)
		end

	is_selection_enabled: BOOLEAN
		require
			exists: exists
		do
			Result := c_allows_selection (item)
		end

	is_selection_enabled_during_edition: BOOLEAN
		require
			exists: exists
		do
			Result := c_allows_selection_during_editing (item)
		end

feature -- Element Changes

	begin_updates
		do
			c_begin_updates (item)
		end

	end_updates
		do
			c_end_updates (item)
		end

feature -- Settings

	set_separator_style (a_style: NATURAL_32)
			-- Set `separator_style' with `a_style'.
		require
			exists: exists
			valid_style: a_style = {UI_TABLE_VIEW_CONSTANTS}.no_separator or
				a_style = {UI_TABLE_VIEW_CONSTANTS}.single_line_separator
		do
			c_set_separator_style (item, a_style)
		ensure
			separator_style_set: separator_style = a_style
		end

	set_separator_color (a_color: UI_COLOR)
			-- Set `separator_color' with `a_color'.
		require
			exists: exists
			color_exists: a_color.exists
		do
			c_set_separator_color (item, a_color.item)
		ensure
			separator_color_set: separator_color ~ a_color
		end

	set_is_selection_enabled (v: BOOLEAN)
			-- Set `is_selection_enabled' with `v'.
		require
			exists: exists
		do
			c_set_allows_selection (item, v)
		ensure
			is_selection_enabled_set: is_selection_enabled = v
		end

	set_is_selection_enabled_during_edition (v: BOOLEAN)
			-- Set `is_selection_enabled_during_edition' with `v'.
		require
			exists: exists
		do
			c_set_allows_selection_during_editing (item, v)
		ensure
			is_selection_enabled_during_edition_set: is_selection_enabled_during_edition = v
		end

	set_is_editing (v: BOOLEAN)
		require
			exists: exists
		do
			c_set_is_editing (item, v)
		ensure
			is_editing_set: is_editing = v
		end

	set_is_editing_with_animation (v, a_animated: BOOLEAN)
		require
			exists: exists
		do
			c_set_is_editing_with_animation (item, v, a_animated)
		ensure
			is_editing_set: is_editing = v
		end

	set_row_height (v: like row_height)
			-- Set `row_height' with `v'.
		require
			exists: exists
		do
			c_set_row_height (item, v)
		ensure
			row_height_set: row_height = v
		end

	set_section_footer_height (v: like section_footer_height)
			-- Set `section_footer_height' with `v'.
		require
			exists: exists
		do
			c_set_section_footer_height (item, v)
		ensure
			section_footer_height_set: section_footer_height = v
		end

	set_section_header_height (v: like section_header_height)
			-- Set `section_header_height' with `v'.
		require
			exists: exists
		do
			c_set_section_header_height (item, v)
		ensure
			section_header_height_set: section_header_height = v
		end

	set_section_index_minimum_display_row_count (v: like section_index_minimum_display_row_count)
			-- Set `section_header_height' with `v'.
		require
			exists: exists
		do
			c_set_section_index_minimum_display_row_count (item, v)
		ensure
			section_index_minimum_display_row_count_set: section_index_minimum_display_row_count = v
		end

feature {NONE} -- Implementation

	iphone_class_name: IMMUTABLE_STRING_8
		once
			create Result.make_from_string ("UITableView")
		end

feature {NONE} -- Externals

	c_init_with_frame_and_style (a_tbl_ptr, a_rect_ptr: POINTER; a_style: NATURAL_32)
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
			a_rect_ptr_not_null: a_rect_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"[(UITableView *) $a_tbl_ptr initWithFrame:*(CGRect *) $a_rect_ptr style:(UITableViewStyle) $a_style];"
		end

	c_style (a_tbl_ptr: POINTER): NATURAL_32
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((UITableView *) $a_tbl_ptr).style;"
		end

	c_separator_style (a_tbl_ptr: POINTER): NATURAL_32
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((UITableView *) $a_tbl_ptr).separatorStyle;"
		end

	c_set_separator_style (a_tbl_ptr: POINTER; a_style: NATURAL_32)
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((UITableView *) $a_tbl_ptr).separatorStyle = $a_style;"
		end

	c_separator_color (a_tbl_ptr: POINTER): POINTER
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((UITableView *) $a_tbl_ptr).separatorColor;"
		end

	c_set_separator_color (a_tbl_ptr, a_color_ptr: POINTER)
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((UITableView *) $a_tbl_ptr).separatorColor = (UIColor *) $a_color_ptr;"
		end

	c_allows_selection (a_tbl_ptr: POINTER): BOOLEAN
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return EIF_TEST(((UITableView *) $a_tbl_ptr).allowsSelection);"
		end

	c_set_allows_selection (a_tbl_ptr: POINTER; v: BOOLEAN)
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((UITableView *) $a_tbl_ptr).allowsSelection = (BOOL) $v;"
		end

	c_allows_selection_during_editing (a_tbl_ptr: POINTER): BOOLEAN
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return EIF_TEST(((UITableView *) $a_tbl_ptr).allowsSelectionDuringEditing);"
		end

	c_set_allows_selection_during_editing (a_tbl_ptr: POINTER; v: BOOLEAN)
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((UITableView *) $a_tbl_ptr).allowsSelectionDuringEditing = (BOOL) $v;"
		end

	c_data_source (a_tbl_ptr: POINTER): POINTER
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((UITableView *) $a_tbl_ptr).dataSource"
		end

	c_set_data_source (a_tbl_ptr, a_src_ptr: POINTER)
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
			a_src_ptr_not_null: a_src_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((UITableView *) $a_tbl_ptr).dataSource = (id<UITableViewDataSource>) $a_src_ptr;"
		end

	c_delegate (a_tbl_ptr: POINTER): POINTER
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((UITableView *) $a_tbl_ptr).delegate"
		end

	c_set_delegate (a_tbl_ptr, a_del_ptr: POINTER)
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
			a_del_ptr_not_null: a_del_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((UITableView *) $a_tbl_ptr).delegate = (id<UITableViewDelegate>) $a_del_ptr;"
		end

	c_is_editing (a_tbl_ptr: POINTER): BOOLEAN
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return EIF_TEST(((UITableView *) $a_tbl_ptr).editing);"
		end

	c_set_is_editing (a_tbl_ptr: POINTER; v: BOOLEAN)
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((UITableView *) $a_tbl_ptr).editing = (BOOL) $v;"
		end

	c_set_is_editing_with_animation (a_tbl_ptr: POINTER; v, a_animated: BOOLEAN)
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"[(UITableView *) $a_tbl_ptr setEditing:(BOOL) $v animated:(BOOL) $a_animated];"
		end

	c_row_height (a_tbl_ptr: POINTER): REAL_32
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((UITableView *) $a_tbl_ptr).rowHeight;"
		end

	c_set_row_height (a_tbl_ptr: POINTER; v: REAL_32)
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((UITableView *) $a_tbl_ptr).rowHeight = (CGFloat) $v;"
		end

	c_section_footer_height (a_tbl_ptr: POINTER): REAL_32
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((UITableView *) $a_tbl_ptr).sectionFooterHeight"
		end

	c_set_section_footer_height (a_tbl_ptr: POINTER; v: REAL_32)
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((UITableView *) $a_tbl_ptr).sectionFooterHeight = (CGFloat) $v;"
		end

	c_section_header_height (a_tbl_ptr: POINTER): REAL_32
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((UITableView *) $a_tbl_ptr).sectionHeaderHeight"
		end

	c_set_section_header_height (a_tbl_ptr: POINTER; v: REAL_32)
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((UITableView *) $a_tbl_ptr).sectionHeaderHeight = (CGFloat) $v;"
		end

	c_section_index_minimum_display_row_count (a_tbl_ptr: POINTER): like ns_integer
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((UITableView *) $a_tbl_ptr).sectionIndexMinimumDisplayRowCount;"
		end

	c_set_section_index_minimum_display_row_count (a_tbl_ptr: POINTER; v: like ns_integer)
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			" ((UITableView *) $a_tbl_ptr).sectionIndexMinimumDisplayRowCount = (NSInteger) $v;"
		end

	c_table_footer_view (a_tbl_ptr: POINTER): POINTER
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((UITableView *) $a_tbl_ptr).tableFooterView;"
		end

	c_set_table_footer_view (a_tbl_ptr, a_view_ptr: POINTER)
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
			a_view_ptr_not_null: a_view_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			" ((UITableView *) $a_tbl_ptr).tableFooterView = (UIView *) $a_view_ptr;"
		end

	c_table_header_view (a_tbl_ptr: POINTER): POINTER
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((UITableView *) $a_tbl_ptr).tableHeaderView"
		end

	c_set_table_header_view (a_tbl_ptr, a_view_ptr: POINTER)
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
			a_view_ptr_not_null: a_view_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((UITableView *) $a_tbl_ptr).tableHeaderView = (UIView *) $a_view_ptr;"
		end

	c_begin_updates (a_tbl_ptr: POINTER)
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"[(UITableView *) $a_tbl_ptr beginUpdates];"
		end

	c_end_updates (a_tbl_ptr: POINTER)
		require
			a_tbl_ptr_not_null: a_tbl_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"[(UITableView *) $a_tbl_ptr endUpdates];"
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
