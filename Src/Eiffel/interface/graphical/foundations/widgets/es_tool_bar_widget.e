note
	description: "[
		An ESF widget that can host a tool bar, like ESF dockable tools ({ES_DOCKABLE_TOOL_PANEL}) and 
		ESF dialogs ({ES_DIALOG}).
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	ES_TOOL_BAR_WIDGET [G -> EV_WIDGET]

inherit
	ES_WINDOW_WIDGET [EV_VERTICAL_BOX]
		rename
			widget as container_widget,
			create_widget as new_container_widget
		redefine
			internal_recycle,
			internal_detach_entities
		end

convert
	container_widget: {EV_WIDGET, EV_VERTICAL_BOX}

feature {NONE} -- Initialization

	frozen build_widget_interface (a_container_widget: !EV_VERTICAL_BOX)
			-- <Precursor>
		local
            l_top_padding: EV_CELL
            l_padding: EV_CELL
            l_container: EV_HORIZONTAL_BOX
            l_tool_bar: like tool_bar_widget
            l_right_tool_bar: like right_tool_bar_widget
            l_border: EV_CELL
        do
        		-- Create real widget
        	widget := new_widget

        	if has_tool_bar then
        			-- Build the tool bar
				l_tool_bar := tool_bar_widget
	            l_right_tool_bar := right_tool_bar_widget

	                -- Top padding compensates for {SD_TOOL_BAR} not vertically aligning tool bars
	            create l_top_padding
	            l_top_padding.set_minimum_height (2)

	            create l_container
	            l_container.set_minimum_height (26)

	                -- Add left tool bar
	            if l_tool_bar /= Void then
					if {lt_widget: EV_WIDGET} l_tool_bar then
						l_container.extend (lt_widget)
					else
						check not_possible: False end
					end
	            end

	                -- Add right tool bar
	            if l_right_tool_bar /= Void then
					if {lt_widget_2: EV_WIDGET} l_right_tool_bar then
		                create l_padding
		                l_container.extend (l_padding)
		                l_container.extend (lt_widget_2)
		                l_right_tool_bar.compute_minimum_size
		                l_container.disable_item_expand (lt_widget_2)
					else
						check not_possible: False end
					end
	            end

	            if is_tool_bar_bottom_aligned then
					build_tool_bar_widget_interface (widget)
	                a_container_widget.extend (widget)

--	                create l_hs
--	                l_hs.set_minimum_height (2)
--	                a_container_widget.extend (l_hs)
--	                a_container_widget.disable_item_expand (l_hs)

	                if is_tool_bar_separated then
	                		-- Add separator
						create l_border
						l_border.set_minimum_height (1)
						l_border.set_background_color (colors.stock_colors.color_3d_shadow)
		                a_container_widget.extend (l_border)
		                a_container_widget.disable_item_expand (l_border)
	                end
	            end

	            a_container_widget.extend (l_top_padding)
	            a_container_widget.disable_item_expand (l_top_padding)
	            a_container_widget.extend (l_container)
	            a_container_widget.disable_item_expand (l_container)

	            if not is_tool_bar_bottom_aligned then
	                if is_tool_bar_separated then
	                		-- Add separator
						create l_border
						l_border.set_minimum_height (1)
						l_border.set_background_color (colors.stock_colors.color_3d_shadow)
		                a_container_widget.extend (l_border)
		                a_container_widget.disable_item_expand (l_border)
	                end
						-- Build the actual widget
					build_tool_bar_widget_interface (widget)
	                a_container_widget.extend (widget)
	            end
	       	else
	       			-- There is not tool bar, just extend the widget

					-- Build the actual widget
				build_tool_bar_widget_interface (widget)
	       		a_container_widget.extend (widget)
        	end
		end

	build_tool_bar_widget_interface (a_widget: !G)
			-- Builds tool bar widget's interface.
			--
			-- `a_widget': The widget to initialize of build upon.
		require
			not_is_initialized: not is_initialized
			is_initializing: is_initializing
			not_a_widget_has_parent: not a_widget.has_parent
			not_a_widget_is_destroyed: not a_widget.is_destroyed
		deferred
		ensure
			is_initializing: is_initializing
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		local
			l_widget: ?CELL [SD_GENERIC_TOOL_BAR]
		do
			l_widget := internal_tool_bar_widget
			if l_widget /= Void and l_widget.item /= Void and then not l_widget.item.is_destroyed then
				l_widget.item.destroy
			end
			l_widget := internal_right_tool_bar_widget
			if l_widget /= Void and l_widget.item /= Void and then not l_widget.item.is_destroyed then
				l_widget.item.destroy
			end
			Precursor
		end

	internal_detach_entities
			-- <Precursor>
		do
			Precursor
			internal_tool_bar_widget := Void
			internal_right_tool_bar_widget := Void
		ensure then
			internal_tool_bar_widget_detached: internal_tool_bar_widget = Void
			internal_right_tool_bar_widget_detached: internal_right_tool_bar_widget = Void
		end

feature -- Access

	widget: !G
			-- Actual widget, used `widget' to access the top level widget.

feature {NONE} -- Access

	frozen tool_bar_widget: ?SD_GENERIC_TOOL_BAR
			-- Main tool tool bar
		local
			l_cell: like internal_tool_bar_widget
			l_items: DS_LINEAR [SD_TOOL_BAR_ITEM]
		do
			l_cell := internal_tool_bar_widget
			if l_cell = Void then
				create l_cell.put (Void)
				internal_tool_bar_widget := l_cell

				l_items := new_tool_bar_items
				if l_items /= Void then
					create {SD_WIDGET_TOOL_BAR} Result.make (create {SD_TOOL_BAR}.make)
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

	frozen right_tool_bar_widget: ?SD_GENERIC_TOOL_BAR
			-- Secondary right tool bar
		local
			l_cell: like internal_right_tool_bar_widget
			l_items: DS_LINEAR [SD_TOOL_BAR_ITEM]
		do
			l_cell := internal_right_tool_bar_widget
			if l_cell = Void then
				create l_cell.put (Void)
				internal_right_tool_bar_widget := l_cell

				l_items := new_right_tool_bar_items
				if l_items /= Void then
					create {SD_WIDGET_TOOL_BAR} Result.make (create {SD_TOOL_BAR}.make)
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

feature {NONE} -- Status report

	frozen has_tool_bar: BOOLEAN
			-- Indicates if tool has a tool bar
		do
			Result := tool_bar_widget /= Void or right_tool_bar_widget /= Void
		end

	is_tool_bar_separated: BOOLEAN
			-- Indicates if there should be a tool bar separator drawn on the UI to separate the tool bar
			-- from the user widget.
		do
			Result := False
		end

    is_tool_bar_bottom_aligned: BOOLEAN
            -- Indicates if the tool bar should be presented at the bottom of the tool
            --|Redefine to change this.
        do
            Result := False
        end

feature {NONE} -- Factory

	new_widget: !G
			-- Creates a new widget, which will be initialized when `build_interface' is called.
		require
			is_interface_usable: is_interface_usable
			not_is_initialized: not is_initialized
			is_initializing: is_initializing
		deferred
		ensure
			not_result_is_destroyed: not Result.is_destroyed
			not_result_has_parent: not Result.has_parent
		end

	new_tool_bar_items: ?DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items to display at the top of the tool.
		deferred
		ensure
			not_reuslt_is_empty: Result /= Void implies not Result.is_empty
			result_contains_attached_items: Result /= Void implies not Result.has (Void)
		end

	new_right_tool_bar_items: ?DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items that should be displayed at the top, but right aligned.
			-- Note: Redefine to add a right tool bar.
		do
		ensure
			not_reuslt_is_empty: Result /= Void implies not Result.is_empty
			result_contains_attached_items: Result /= Void implies not Result.has (Void)
		end

	frozen new_container_widget: !EV_VERTICAL_BOX
			-- <Precursor>
		do
			create Result
		end

feature {NONE} -- Internal implementation cache

	internal_tool_bar_widget: ?CELL [like tool_bar_widget]
			-- Cached version of `tool_bar_widget'

	internal_right_tool_bar_widget: ?CELL [like right_tool_bar_widget]
			-- Cached version of `right_tool_bar_widget'

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
