indexing
	description: "Stonable tool in ES."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_STONABLE_TOOL

inherit
	EB_TOOL
		redefine
			make,
			show
		end

feature {NONE} -- Initialization

	make (a_manager: like develop_window) is
			-- Initialization
		do
			Precursor {EB_TOOL} (a_manager)
			is_last_stone_processed := True
		end

feature -- Access

	stone: STONE is
			-- Stone representing Current
		deferred
		end

	last_stone: STONE
			-- Last stone set into Current view
			-- This is used as optimization.
			-- When a stone is set into current view through `set_stone', we store it here,
			-- until Current view is displayed on the screen, the stone is used to update related formatters
			-- by invoking `force_last_stone'.

feature -- Status setting

	show is
			-- Show the tool
		do
			Precursor {EB_TOOL}
			force_last_stone
		end

feature -- Status report

	is_last_stone_processed: BOOLEAN
			-- Is `last_stone' processed?
			-- i.e., has `last_stone' been displayed in formatters of Current tool?

	is_stone_valid (a_stone: STONE): BOOLEAN is
			-- Is `a_stone' valid to set?
		do
			Result := True
		end

feature -- Element change

	force_last_stone is
			-- Force that `last_stone' is displayed in formatters in Current view
		do
			if not is_last_stone_processed then
				set_is_last_stone_processed (True)
			end
		ensure
			last_stone_processed: is_last_stone_processed
		end

	set_stone (new_stone: STONE) is
			-- Make `new_stone' the new value of stone.
		require
			is_stone_valid: is_stone_valid (new_stone)
		deferred
		end

feature {NONE} -- Implementation

	set_last_stone (a_stone: like last_stone) is
			-- Set `last_stone' with `a_stone'.
		do
			last_stone := a_stone
			set_is_last_stone_processed (False)
		ensure
			last_stone_set: last_stone = a_stone
			last_stone_not_processed: not is_last_stone_processed
		end

	set_is_last_stone_processed (b: BOOLEAN) is
			-- Set `is_last_stone_processed' with `b'.
		do
			is_last_stone_processed := b
		ensure
			is_last_stone_processed_set: is_last_stone_processed = b
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
