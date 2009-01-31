note
	description: "[
		An EiffelStudio command supporting exection with a pre-determine stone object.
		
		Note: This command should be implemented by all commands that appear as context menu items
		      in EiffelStudio.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_STONABLE_COMMAND

inherit
	E_CMD

feature -- Status report

	is_valid_stone (a_stone: STONE): BOOLEAN
			-- Inidicates if the stone is valid for execution with a context stone
		require
			is_interface_usable: {rl_usable: USABLE_I} Current implies rl_usable.is_interface_usable
			executable: executable
			a_stone_attached: a_stone /= Void
		deferred
		end

feature -- Basic operations

	execute_with_stone (a_stone: STONE)
			-- Execute with a context stone
		require
			is_interface_usable: {rl_usable: USABLE_I} Current implies rl_usable.is_interface_usable
			executable: executable
			a_stone_attached: a_stone /= Void
		deferred
		end

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
