
			indexing
	description	: "A tool that displays a text."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_TEXTABLE_TOOL

inherit
	EB_TOOL
		redefine
			make
		end

	EB_STONABLE

	EB_TEXTABLE

feature -- Initialization

	make (a_manager: EB_DEVELOPMENT_WINDOW) is
			-- Create a new tool with `a_manager' as manager.
		do
			Precursor (a_manager)
			text_area.drop_actions.extend (agent a_manager.set_stone)
		end

feature -- Access

	stone: STONE is
			-- Stone for Current
		local
			stonable_manager: EB_STONABLE
		do
			stonable_manager ?= manager
			if stonable_manager /= Void then
				Result := stonable_manager.stone
			end
		end

feature -- Element change

	set_stone (new_stone: STONE) is
			-- Set `stone' to `new_stone'
		local
			stonable_manager: EB_STONABLE
		do
			stonable_manager ?= manager
			if stonable_manager /= Void then
				stonable_manager.set_stone (new_stone)
					-- `refresh' will be called by the manager.
			end
		end

feature -- Update

	refresh is
			-- Update screen according to `stone'.
			-- do not touch history.
			-- Nothing to do in default case.
		do
		end

	update_graphical_resources is
			-- Synchronize clickable elements with text, if possible
			-- and update the graphical values in text area.
		do
			refresh
		end

feature -- Pick and Throw Implementation

	drop_stone (s: STONE) is
			-- Drop a stone in Current.
		do
			if s /= Void then
				set_stone (s)
			end
		end

	reset is
			-- Reset the window contents.
		do
			text_area.clear_window
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_TEXT_TOOL
