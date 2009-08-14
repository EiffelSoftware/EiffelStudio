note
	description: "[
		Tool descriptor for the debugger's custom object watch tool.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

frozen class
	ES_WATCH_TOOL

inherit
	ES_DEBUGGER_STONABLE_TOOL [ES_WATCH_TOOL_PANEL]
		redefine
			on_tool_instantiated,
			is_multiple_edition
		end

create {NONE}
	default_create

feature {NONE} -- Initialization: User interface

	on_tool_instantiated
			-- <Precursor>
		do
			Precursor
			debugger_manager.update_all_debugging_tools_menu
		end

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- <Precursor>
		do
			Result := stock_pixmaps.tool_watch_icon_buffer
		end

	icon_pixmap: EV_PIXMAP
			-- <Precursor>
		do
			Result := stock_pixmaps.tool_watch_icon
		end

	title: attached STRING_32
			-- <Precursor>
		do
			Result := locale_formatter.translation (t_tool_title)
		end

feature -- Status report

	is_multiple_edition: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

feature {NONE} -- Status report

	is_stone_usable_internal (a_stone: attached like stone): BOOLEAN
			-- <Precursor>
		do
			Result := attached {CALL_STACK_STONE} a_stone
		end

feature -- Basic operations

	drop_stone (a_stone: CLASSC_STONE)
			-- Drop stone
		do
			if is_tool_instantiated	and a_stone /= Void then
				panel.on_element_drop (a_stone)
			end
		end

	drop_text (s: STRING_32)
			-- Drop text
		do
			if is_tool_instantiated	and s /= Void then
				panel.drop_text (s)
			end
		end

feature {DEBUGGER_MANAGER, ES_WATCH_TOOL_PANEL} -- Basic operations

	disable_refresh
			-- Disable refresh
		do
			if is_tool_instantiated then
				panel.disable_refresh
			end
		end

	enable_refresh
			-- Disable refresh
		do
			if is_tool_instantiated then
				panel.enable_refresh
			end
		end

	record_grid_layout
			-- Record grid's layout
		do
			if
				is_tool_instantiated and then
				panel.is_initialized
			then
				panel.record_grid_layout
			end
		end

	prepare_for_debug
			-- Remove obsolete expressions from `Current'.		
		do
			if
				is_tool_instantiated and then
				panel.is_initialized
			then
				panel.prepare_for_debug
			end
		end

feature {NONE} -- Factory

	new_tool: attached ES_WATCH_TOOL_PANEL
			-- <Precursor>
		do
			create Result.make (window, Current)
			Result.set_debugger_manager (debugger_manager)
		end

feature {NONE} -- Internationalization

	t_tool_title: STRING = "Watch"

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
