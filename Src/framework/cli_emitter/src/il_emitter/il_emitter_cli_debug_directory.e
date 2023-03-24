note
	description: "Data regarding debugger info in PE file, this class is just a workaround with NULL operations."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_EMITTER_CLI_DEBUG_DIRECTORY

inherit
	CLI_DEBUG_DIRECTORY

	REFACTORING_HELPER
		export {NONE} all end

create
	make

feature {NONE} -- Initialization

	make
			-- Allocate `item'
		do
			to_implement ("TODO add implementation")
		end

feature -- Settings

	set_size (a_size: INTEGER)
			--
		require
			valid_size: a_size >= 0
		do
			to_implement ("TODO add implementation")
		end

	set_address_of_data (a_rva: INTEGER)
			-- Set RVA of debug info into PE file.
		require
			valid_rva: a_rva /= 0
		do
			to_implement ("TODO add implementation")
		end

	set_pointer_to_data (a_pos: INTEGER)
			-- Set position of debug info in PE file.
		require
			valid_rva: a_pos /= 0
		do
			to_implement ("TODO add implementation")
		end


note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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

end -- class CLI_DEBUG_DIRECTORY
