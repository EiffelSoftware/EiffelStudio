indexing
	description: "Box containing expanded viewer ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_OBJECT_VIEWER

inherit
	ANY

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

feature

	make (m: EB_OBJECT_VIEWERS_MANAGER) is
			-- Instanciate Current
		do
			viewers_manager := m
			create subviewers.make
			build_widget
		end

	build_widget is
			-- Build widget representing Current viewer
		deferred
		end

feature {EB_OBJECT_VIEWERS_MANAGER} -- Properties

	subviewers: LINKED_LIST [EB_OBJECT_VIEWER]
			-- Sub viewers

feature -- Access

	debugger_manager: DEBUGGER_MANAGER is
			-- Related debugger manager
		deferred
		end

	widget: EV_WIDGET is
			-- Widget representing Current viewer component
		deferred
		end

	is_valid_stone (a_stone: ANY; is_strict: BOOLEAN): BOOLEAN is
			-- Is `ost' a valid stone for Current viewer
			-- if `is_strict' is False, check quickly the validity of the stone
			-- otherwise check with caution.
			--| note: `is_strict' False is used to quickly find
			--| the most adapted default viewer for `ost'
		deferred
		end

	name: STRING_GENERAL is
			-- Name of Current viewer
		deferred
		end

	title: STRING_GENERAL
			-- Title for Current viewer

feature -- Contextual widget

	build_mini_tool_bar is
			-- If `mini_tool_bar' is Void, build it otherwise do nothing
		do
		end

	mini_tool_bar: SD_TOOL_BAR
			-- Mini tool bar widget

	build_tool_bar is
			-- If `tool_bar' is Void, build it otherwise do nothing
		do
		end

	tool_bar: SD_TOOL_BAR
			-- Tool bar widget

feature -- Change

	set_title (t: STRING_GENERAL) is
			-- Set title
		do
			title := t
		end

	set_stone (st: OBJECT_STONE) is
			-- Set stone
		require
			stone_valid: is_valid_stone (st, False)
			is_running: debugger_manager.application_is_executing
		do
			clear
			viewers_manager.set_stone (st)
			refresh
		end

	refresh is
			-- Refresh output
		deferred
		end

	clear is
			-- Clear output
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
			-- Retrieve dump value
		do
			viewers_manager.retrieve_dump_value
		end

	current_dump_value: DUMP_VALUE is
			-- DUMP_VALUE `Current' is displaying.		
		do
			Result := viewers_manager.current_dump_value
		end

feature -- Properties

	viewers_manager: EB_OBJECT_VIEWERS_MANAGER
			-- Associated viewers manager

feature {NONE} -- Implementation

	begin_with (s,t: STRING_GENERAL; ignore_leading_blank: BOOLEAN): BOOLEAN is
			-- Does `s' beging with `t' ?
			-- if `ignore_leading_blank' is True, ignore leading blank character
		local
			i, j: INTEGER
			blank: ARRAY [NATURAL_32]
		do
			if t.count <= s.count then
					--| `s' should contains at least the length of `t'
					--| even with blank character
				if ignore_leading_blank then
					from
						create blank.make (0, 3)
						blank.put ((' ').natural_32_code, 0)
						blank.put (('%T').natural_32_code, 1)
						blank.put (('%N').natural_32_code, 2)
						blank.put (('%R').natural_32_code, 3)
						i := 1
					until
						not s.valid_index (i) or else not blank.has (s.code (i))
					loop
						i := i + 1
					end
				end
				if t.count <= s.count - (i - 1) then
					from
						j := 1
						Result := True
					until
						not Result or j > t.count
					loop
						Result := s.code (i) = t.code (j)
						i := i + 1
						j := j + 1
					end
				end
			end
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

end
