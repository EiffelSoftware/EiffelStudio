indexing
	description: "[
		An EiffelStudio dockable tool window base implementation for EiffelStudio tools.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	ES_DOCKABLE_TOOL_WINDOW [G -> EV_WIDGET]

inherit
	EB_TOOL
		rename
			title_for_pre as tool_ref_id,
			pixmap as icon_pixmap,
			pixel_buffer as icon,
			build_interface as on_before_initialize
		redefine
			build_mini_toolbar,
			icon,
			icon_pixmap,
			show
		end

	ES_SHARED_COLORS
		export
			{NONE} all
		end

	SHARED_SERVICE_PROVIDER
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	frozen initialize
			-- Initializes the creation of the tool
		require
			not_is_initialized: not is_initialized
		do
			if has_tool_bar then
				widget.extend (create_tool_container_widget (user_widget))
			else
				widget.extend (user_widget)
			end
			build_tool_interface (user_widget)
			is_initialized := True
		ensure
			is_initialized: is_initialized
		end

	on_before_initialize
			-- Use to perform additional creation initializations
		do
		end

feature {NONE} -- User interface initialization

	build_mini_toolbar
			-- Build mini tool bar.
		do
			mini_toolbar := mini_tool_bar_widget
		end

	build_tool_interface (a_widget: G)
			-- Builds the tools user interface elements.
			-- Note: This function is called prior to showing the tool for the first time.
			--
			-- `a_widget': A widget to build the tool interface using.
		require
			a_widget_attached: a_widget /= Void
			not_a_widget_is_destoryed: not a_widget.is_destroyed
			not_is_initialized: not is_initialized
		deferred
		ensure
			not_is_initialized: not is_initialized
		end

feature -- Access

	tool_ref_id: STRING
			-- Reference identifier, typical used in a preference persistance mechanism.
		do
			Result := generating_type.as_lower
		end

	frozen title: STRING_GENERAL assign set_title
			-- Title of the tool which for show, it maybe not in English.
		do
			Result := internal_title
			if Result = Void then
					-- Retrieve default title
				Result := tool_title
				internal_title := Result
			end
		ensure then
			result_consistent: Result = Result
		end

	frozen icon: EV_PIXEL_BUFFER assign set_icon
			-- The icon that appears in tabbed tools and menu items
		do
			Result := internal_icon
			if Result = Void then
				Result := tool_icon_buffer
				internal_icon := Result
			end
		ensure then
			result_attached: Result /= Void
			result_consistent: Result = Result
		end

	frozen widget: EV_VERTICAL_BOX
			-- Tool's visual root container element.
		do
			Result := internal_widget
			if Result = Void then
				create Result
				internal_widget := Result
			end
		ensure then
			result_attached: Result /= Void
			result_consistent: Result = widget
		end

feature {NONE} -- Access

	frozen user_widget: G
			-- Access to user widget, as `widget' may not be the indicated user widget due to
			-- tool bar additions
		do
			Result := internal_user_widget
			if Result = Void then
				Result := create_widget
				internal_user_widget := Result

				if not is_initialized then
						-- Initialize if necessary.
					initialize
				end
			end
		ensure then
			result_attached: Result /= Void
			result_consistent: Result = user_widget
		end

	frozen mini_tool_bar_widget: SD_TOOL_BAR
			-- Access to user widget, as `widget' may not be the indicated user widget due to
			-- tool bar additions
		local
			l_cell: like internal_mini_tool_bar_widget
			l_items: DS_LINEAR [SD_TOOL_BAR_ITEM]
		do
			l_cell := internal_mini_tool_bar_widget
			if l_cell = Void then
				create l_cell
				internal_mini_tool_bar_widget := l_cell

				l_items := create_mini_tool_bar_items
				if l_items /= Void then
					create Result.make
					l_items.do_all (agent Result.extend)
					l_cell.put (Result)
					Result.compute_minimum_size
				end
			else
				Result := l_cell.item
			end
		ensure
			result_consistent: Result = mini_tool_bar_widget
		end

	frozen tool_bar_widget: SD_TOOL_BAR
			-- Main tool tool bar
		local
			l_cell: like internal_tool_bar_widget
			l_items: DS_LINEAR [SD_TOOL_BAR_ITEM]
		do
			l_cell := internal_tool_bar_widget
			if l_cell = Void then
				create l_cell
				internal_tool_bar_widget := l_cell

				l_items := create_tool_bar_items
				if l_items /= Void then
					create Result.make
					l_items.do_all (agent Result.extend)
					l_cell.put (Result)
					Result.compute_minimum_size
				end
			else
				Result := l_cell.item
			end
		ensure
			result_consistent: Result = tool_bar_widget
		end

	frozen right_tool_bar_widget: SD_TOOL_BAR
			-- Secondary right tool bar
		local
			l_cell: like internal_right_tool_bar_widget
			l_items: DS_LINEAR [SD_TOOL_BAR_ITEM]
		do
			l_cell := internal_right_tool_bar_widget
			if l_cell = Void then
				create l_cell
				internal_right_tool_bar_widget := l_cell

				l_items := create_right_tool_bar_items
				if l_items /= Void then
					create Result.make
					Result.extend (create {SD_TOOL_BAR_SEPARATOR}.make)
					l_items.do_all (agent Result.extend)
					l_cell.put (Result)
				end
			else
				Result := l_cell.item
			end
		ensure
			result_consistent: Result = right_tool_bar_widget
		end

	tool_icon_buffer: like icon
			-- The tool's original icon as a pixel buffer.
		deferred
		ensure
			result_attached: Result /= Void
		end

	tool_title: like title
			-- The tool's original title.
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	frozen stock_pixmaps: ES_PIXMAPS_16X16
			-- Shared access to stock 16x16 EiffelStudio pixmaps
		once
			Result := (create {EB_SHARED_PIXMAPS}).icon_pixmaps
		ensure
			result_attached: Result /= Void
		end

	frozen stock_mini_pixmaps: ES_PIXMAPS_10X10
			-- Shared access to stock 10x10 EiffelStudio pixmaps
		once
			Result := (create {EB_SHARED_PIXMAPS}).mini_pixmaps
		ensure
			result_attached: Result /= Void
		end

	frozen preferences: EB_PREFERENCES
		require
			preferences_initialized: (create {EB_SHARED_PREFERENCES}).preferences_initialized
		once
			Result := (create {EB_SHARED_PREFERENCES}).preferences
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Concealed access

	frozen icon_pixmap: EV_PIXMAP
			-- Pixmap as it appears in toolbars and menu, there is no pixmap by default.
		do
			Result := internal_icon_pixmap
			if Result = Void then
				Result := icon.to_pixmap
				internal_icon_pixmap := Result
			end
		ensure then
			result_attached: Result /= Void
			result_consistent: Result = Result
		end

feature -- Element change

	set_title (a_title: like title)
			-- Set tool's label title
			--
			-- `a_title': Title to set
		do
			internal_title := a_title
			content.set_long_title (a_title)
		ensure
			title_set: title = a_title
		end

	set_icon (a_buffer: like icon)
			-- Sets tool icon to `a_buffer'
			--
			-- `a_buffer': A pixel buffer that presents the tool's icon.
		do
				-- Set pixmap icon to void to ensure it's updated on next call
			internal_icon_pixmap := Void
			internal_icon := a_buffer

			content.set_pixel_buffer (a_buffer)
			content.set_pixmap (icon_pixmap)
		ensure
			icon_set: icon = a_buffer
		end

feature -- Basic operations

	show
			-- Show the tool, if possible
		do
			if not is_initialized then
					-- Delayed initialization may mean the user interface has not been shown yet.
					-- Call to user_widget should create the widget
				if user_widget = Void then
						-- Just in case user_widget does not retrieve a widget, try initialize.
					initialize
				end
			end
			Precursor {EB_TOOL}
		ensure then
			is_initialized: is_initialized
		end

feature -- Status report

	is_initialized: BOOLEAN
			-- Indicates if the user interface has been initialized

feature {NONE} -- Status report

	frozen has_mini_tool_bar: BOOLEAN
			-- Indicates if tool has a mini tool bar
		do
			Result := mini_toolbar /= Void or right_tool_bar_widget /= Void
		end

	frozen has_tool_bar: BOOLEAN
			-- Indicates if tool has a tool bar
		do
			Result := tool_bar_widget /= Void or right_tool_bar_widget /= Void
		end

	is_tool_bar_bottom_aligned: BOOLEAN
			-- Indicates if the tool bar should be presented at the bottom of the tool
			-- Redefine to change this.
		do
			Result := False
		end

feature {NONE} -- Factory

	create_widget: G
			-- Create a new container widget upon request.
			-- Note: You may build the tool elements here or in `build_too_interface'
		deferred
		ensure
			result_attached: Result /= Void
		end

	create_mini_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items to display on the window title
		do
		ensure
			not_reuslt_is_empty: Result /= Void implies not Result.is_empty
			result_contains_attached_items: Result /= Void implies not Result.has (Void)
		end

	create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items to display at the top of the tool.
		deferred
		ensure
			not_reuslt_is_empty: Result /= Void implies not Result.is_empty
			result_contains_attached_items: Result /= Void implies not Result.has (Void)
		end

	create_right_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items that should be displayed at the top, but right aligned.
			-- Note: Redefine to add a right tool bar.
		do
		ensure
			not_reuslt_is_empty: Result /= Void implies not Result.is_empty
			result_contains_attached_items: Result /= Void implies not Result.has (Void)
		end

	create_tool_container_widget (a_widget: G): EV_VERTICAL_BOX
			-- Creates the tool's tool bars if `tool_bar_items' and/or `right_tool_bar_items' contain items
			--
			-- `a_widget': The user widget to place in container.
		require
			a_widget_attached: a_widget /= Void
			has_tool_bar: has_tool_bar
		local
			l_top_padding: EV_CELL
			l_padding: EV_CELL
			l_container: EV_HORIZONTAL_BOX
			l_hs: EV_HORIZONTAL_SEPARATOR
			l_tool_bar: like tool_bar_widget
			l_right_tool_bar: like right_tool_bar_widget
		do
			l_tool_bar := tool_bar_widget
			l_right_tool_bar := right_tool_bar_widget

				-- Top padding compensates for {SD_TOOL_BAR} not vertically aligning tool bars
			create l_top_padding
			l_top_padding.set_minimum_height (1)

			create l_container
			l_container.set_minimum_height (26)

				-- Add left tool bar
			if l_tool_bar /= Void then
				l_container.extend (l_tool_bar)
			end

				-- Add right tool bar
			if l_right_tool_bar /= Void then
				create l_padding
				l_container.extend (l_padding)
				l_container.extend (l_right_tool_bar)
				l_right_tool_bar.compute_minimum_size
				l_container.disable_item_expand (l_right_tool_bar)
			end

			create Result
			if is_tool_bar_bottom_aligned then
				Result.extend (a_widget)

				create l_hs
				l_hs.set_minimum_height (2)
				Result.extend (l_hs)
				Result.disable_item_expand (l_hs)
			end
			Result.extend (l_top_padding)
			Result.disable_item_expand (l_top_padding)
			Result.extend (l_container)
			Result.disable_item_expand (l_container)
			if not is_tool_bar_bottom_aligned then
				Result.extend (a_widget)
			end
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Internal implementation cache

	internal_icon_pixmap: like icon_pixmap
			-- Cached version of `pixmap'

	internal_icon: like icon
			-- Cached version of `icon'

	internal_title: like title
			-- Mutable version of `title'

	internal_widget: like widget
			-- Cached version of `widget'

	internal_user_widget: G
			-- User widget, which was returned from `create_widget'

	internal_mini_tool_bar_widget: CELL [like mini_tool_bar_widget]
			-- Cached version of `mini_tool_bar_widget'

	internal_tool_bar_widget: CELL [like tool_bar_widget]
			-- Cached version of `tool_bar_widget'

	internal_right_tool_bar_widget: CELL [like right_tool_bar_widget]
			-- Cached version of `right_tool_bar_widget'

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
