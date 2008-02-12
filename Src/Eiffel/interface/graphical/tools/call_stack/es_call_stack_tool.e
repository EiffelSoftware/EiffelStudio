indexing
	description: "[
		Tool descriptor for the debugger's execution call stack tool.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

frozen class
	ES_CALL_STACK_TOOL

inherit
	ES_STONABLE_TOOL [ES_CALL_STACK_TOOL_PANEL]

create {NONE}
	default_create

feature {DEBUGGER_MANAGER} -- Debugger related

	frozen debugger_manager: EB_DEBUGGER_MANAGER
			-- Debugger manager to use for tool creation
		do
			Result ?= window.debugger_manager
		ensure
			result_attached: Result /= Void
		end

feature {DEBUGGER_MANAGER} -- Access

	force_update is
			-- Update now, no delay
		do
			if is_tool_instantiated then
				panel.update
			end
		end

	request_update is
			-- Request an update, this should call update only
			-- once per debugging "operation"
			-- This is to avoid computing twice the data
			-- on specific cases
		do
			if is_tool_instantiated then
				panel.request_update
			end
		end

	reset is
			-- Reset current's panel
		do
			if is_tool_instantiated then
				panel.reset_tool
			end
		end

	activate_execution_replay_mode (b: BOOLEAN; deplim: INTEGER_32)
			-- Activate or not the execution replay mode according to `b'
			-- and using `deplim' as depth limit
		do
			if is_tool_instantiated then
				panel.activate_execution_replay_mode (b, deplim)
				if b then
					show (False)
				end
			end
		end

	set_execution_replay_level (dep: INTEGER_32; deplim: INTEGER_32) is
			-- Set execution replay active level on the panel
		require
			app_is_stopped: debugger_manager.safe_application_is_stopped
			in_range: deplim > 0 implies dep <= deplim
		do
			if is_tool_instantiated then
				panel.set_execution_replay_level (dep, deplim)
			end
		end

feature -- Status

	shown: BOOLEAN is
			-- Is Current's panel shown on the screen?
		do
			if is_tool_instantiated then
				Result := panel.shown
			end
		end

feature -- Query

	is_stone_usable (a_stone: STONE): BOOLEAN
			-- Determines if a stone can be used by Current.
			--
			-- `a_stone': Stone to determine usablity.
			-- `Result': True if the stone can be used, False otherwise.
		do
			Result := {l_stone: !CALL_STACK_STONE} a_stone
		end

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- Tool icon
			-- Note: Do not call `tool.icon' as it will create the tool unnecessarly!
		do
			Result := stock_pixmaps.tool_call_stack_icon_buffer
		end

	icon_pixmap: EV_PIXMAP
			-- Tool icon pixmap
			-- Note: Do not call `tool.icon' as it will create the tool unnecessarly!
		do
			Result := stock_pixmaps.tool_call_stack_icon
		end

	title: STRING_32
			-- Tool title.
			-- Note: Do not call `tool.title' as it will create the tool unnecessarly!
		do
			Result := interface_names.t_call_stack_tool
		end

	shortcut_preference_name: STRING_32
			-- An optional shortcut preference name, for automatic preference binding.
			-- Note: The preference should be registered in the default.xml file
			--       as well as in the {EB_MISC_SHORTCUT_DATA} class.
		do
			Result := "show_call_stack_tool"
		end

feature {NONE} -- Factory

	create_tool: ES_CALL_STACK_TOOL_PANEL
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
