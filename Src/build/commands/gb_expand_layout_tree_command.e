indexing
	description: "Objects that expand the layout tree."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EXPAND_LAYOUT_TREE_COMMAND

inherit

	GB_STANDARD_CMD
		redefine
			execute
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end

create
	make_with_components

feature {NONE} -- Initialization

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		do
			components := a_components
			make
				-- Retrieve top level window of `layout_constructor'.
			set_menu_name ("Expand layout tree")
			add_agent (agent execute)
			enable_sensitive
		end

feature -- Access

	tool_bar_button: EV_TOOL_BAR_BUTTON is
			-- `Result' is a tool bar button that when selected, expands `layout_constructor'.
		do
			create Result
			Result.select_actions.extend (agent execute)
			Result.set_tooltip ("Expand all")
			Result.set_pixmap ((create {GB_SHARED_PIXMAPS}).pixmap_by_name ("icon_expand_all_small_color"))
		ensure
			result_not_void: Result /= Void
		end


feature -- Execution

	execute is
			-- Execute command.
		local
			top_window: EV_WINDOW
		do
			top_window := parent_window (components.tools.layout_constructor)
			top_window.lock_update
			expand_tree_recursive (components.tools.layout_constructor)
			top_window.unlock_update
		end

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


end -- class GB_EXPAND_LAYOUT_TREE_COMMAND
