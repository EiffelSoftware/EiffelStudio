note
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
		redefine
			on_tool_instantiated
		end

create {NONE}
	default_create

feature {NONE} -- Events

	on_tool_instantiated
			-- Called when a tool panel is instatiated and has been built.
			-- (export status {NONE})
		do
			Precursor
			if delayed_split_proportion > 0 then
				set_split_proportion (delayed_split_proportion)
			end
		end

	delayed_split_proportion: like split_proportion
			-- Split proportion to set when tool instantiated			

feature {DEBUGGER_MANAGER} -- Status setting

	disable_refresh
			-- Disable refresh
		do
			if is_tool_instantiated	then
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

feature -- Access: split

	split_exists: BOOLEAN
		do
			if is_tool_instantiated then
				Result := panel.split_exists
			end
		end

	split_proportion: REAL
		require
			split_exists: split_exists
		do
			Result := panel.split_proportion
		end

	set_split_proportion (p: like split_proportion)
		do
			if is_tool_instantiated then
				delayed_split_proportion := 0
				panel.set_split_proportion (p)
			else
				delayed_split_proportion := p
			end
		end

feature -- Basic operations

	record_grids_layout
			-- Record grid's layout
		do
			if
				is_tool_instantiated and then
				panel.is_initialized
			then
				panel.record_grids_layout
			end
		end

	update_cleaning_delay (ms: INTEGER_32)
			-- Set cleaning delay to object grids
		do
			if
				is_tool_instantiated and then
				panel.is_initialized
			then
				panel.update_cleaning_delay (ms)
			end
		end

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- <Precursor>
		do
			Result := stock_pixmaps.tool_objects_icon_buffer
		end

	icon_pixmap: EV_PIXMAP
			-- <Precursor>
		do
			Result := stock_pixmaps.tool_objects_icon
		end

	title: attached STRING_32
			-- <Precursor>
		do
			Result := locale_formatter.translation (t_tool_title)
		end

feature {NONE} -- Status report

	internal_is_stone_usable (a_stone: attached like stone): BOOLEAN
			-- <Precursor>
		do
			Result := attached {CALL_STACK_STONE} a_stone as l_stone
		end

feature {NONE} -- Factory

	new_tool:attached  ES_OBJECTS_TOOL_PANEL
			-- <Precursor>
		do
			create Result.make (window, Current)
			Result.set_debugger_manager (debugger_manager)
		end

feature {NONE} -- Internationalization

	t_tool_title: STRING = "Objects"

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
