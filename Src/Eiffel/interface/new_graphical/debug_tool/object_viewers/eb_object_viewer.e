indexing
	description: "Box containing expanded viewer ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_OBJECT_VIEWER

feature

	make (m: EB_OBJECT_VIEWERS_MANAGER) is
			--
		do
			viewers_manager := m
			create subviewers.make
			build_widget
		end

	build_widget is
		deferred
		end

feature {EB_OBJECT_VIEWERS_MANAGER} -- Properties

	subviewers: LINKED_LIST [like Current]

feature -- Access

	debugger_manager: DEBUGGER_MANAGER is
		deferred
		end

	widget: EV_WIDGET is
		deferred
		end

	is_valid_stone (ost: OBJECT_STONE): BOOLEAN is
		deferred
		end

	name: STRING_GENERAL is
		deferred
		end

	title: STRING_GENERAL

feature -- Contextual widget

	build_mini_tool_bar is
			-- If `mini_tool_bar' is Void, build it otherwise do nothing
		do
		end

	mini_tool_bar: EV_TOOL_BAR

	build_tool_bar is
			-- If `tool_bar' is Void, build it otherwise do nothing
		do
		end

	tool_bar: EV_TOOL_BAR

feature -- Change

	set_title (t: STRING_GENERAL) is
		do
			title := t
		end

	set_stone (st: OBJECT_STONE) is
			--
		require
			stone_valid: is_valid_stone (st)
			is_running: debugger_manager.application_is_executing
		do
			clear
			viewers_manager.set_stone (st)
			refresh
		end

	refresh is
			--
		deferred
		end

	clear is
			--
		deferred
		end

	reset is
			-- Reset current viewer
		do
			clear
		end

feature -- Data

	current_object: OBJECT_STONE is
			-- Object `Current' is displaying.
		do
			Result := viewers_manager.current_object
		end

	has_object: BOOLEAN is
			-- Has an object been assigned to current?
		do
			Result := viewers_manager.has_object
		end

	retrieve_dump_value	is
		do
			viewers_manager.retrieve_dump_value
		end

	current_dump_value: DUMP_VALUE is
			-- DUMP_VALUE `Current' is displaying.		
		do
			Result := viewers_manager.current_dump_value
		end

feature -- Properties

	viewers_manager: EB_OBJECT_VIEWERS_MANAGER;

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
