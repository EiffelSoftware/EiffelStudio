note
	description: "Reset the IDE layout (mostly to recover from bad crash)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	EWB_RESET_IDE_LAYOUT

inherit
	EWB_CMD
		rename
			name as reset_ide_layout_cmd_name,
			help_message as reset_ide_layout_help,
			abbreviation as reset_ide_layout_abb
		end

	SHARED_ERROR_HANDLER

	EIFFEL_LAYOUT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		do
		end

feature {NONE} -- Execution

	execute
			-- Execute Current batch command.
		require else
			True -- We don't need a compiled workbench!
		local
			p: PATH
			dir: DIRECTORY
			retried: BOOLEAN
		do
			if not retried then
				if is_eiffel_layout_defined then
					p := eiffel_layout.docking_data_path
					create dir.make_with_path (p)
					if dir.exists then
						dir.recursive_delete
					end
				end
				io.put_new_line
				io.put_string ("IDE layout was reset.%N")
			else
				io.error.put_string ("Issue raised while resetting IDE layout!%N")
			end
		rescue
			retried := True
			retry
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

end -- class EWB_PRETTY
