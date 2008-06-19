indexing
	description: "[
		Tool descriptor for the debugger's object analyer tool.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

frozen class
	ES_OBJECTS_TOOL

inherit
	ES_DEBUGGER_STONABLE_TOOL [ES_OBJECTS_TOOL_PANEL]

create {NONE}
	default_create

feature {DEBUGGER_MANAGER} -- Access

	disable_refresh is
			-- Disable refresh
		do
			if is_tool_instantiated	then
				panel.disable_refresh
			end
		end

	enable_refresh is
			-- Disable refresh
		do
			if is_tool_instantiated then
				panel.enable_refresh
			end
		end

	record_grids_layout is
			-- Record grid's layout
		do
			if
				is_tool_instantiated and then
				panel.is_initialized
			then
				panel.record_grids_layout
			end
		end

	update_cleaning_delay (ms: INTEGER_32) is
			-- Set cleaning delay to object grids
		do
			if
				is_tool_instantiated and then
				panel.is_initialized
			then
				panel.update_cleaning_delay (ms)
			end
		end

feature -- Query

	is_stone_usable (a_stone: STONE): BOOLEAN
			-- Determines if a stone can be used by Current.
			--
			-- `a_stone': Stone to determine usablity.
			-- `Result': True if the stone can be used, False otherwise.
		do
			Result := {l_stone: CALL_STACK_STONE} a_stone
		end

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- Tool icon
			-- Note: Do not call `tool.icon' as it will create the tool unnecessarly!
		do
			Result := stock_pixmaps.tool_objects_icon_buffer
		end

	icon_pixmap: EV_PIXMAP
			-- Tool icon pixmap
			-- Note: Do not call `tool.icon' as it will create the tool unnecessarly!
		do
			Result := stock_pixmaps.tool_objects_icon
		end

	title: STRING_32
			-- Tool title.
			-- Note: Do not call `tool.title' as it will create the tool unnecessarly!
		do
			Result := interface_names.t_object_tool
		end

feature {NONE} -- Factory

	create_tool: ES_OBJECTS_TOOL_PANEL
			-- Creates the tool for first use on the development `window'
		do
			create Result.make (window, Current)
			Result.set_debugger_manager (debugger_manager)
		end

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
