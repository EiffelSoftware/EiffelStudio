indexing
	description: "[
		The file notifier service's {FILE_NOTIFIER_S} modification type flags, indicating the detected type of modifications
		of a monitored file record.
	]"
	doc: "wiki://File Notifier Service"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	FILE_NOTIFIER_MODIFICATION_TYPES

feature -- Access

	file_changed: NATURAL_8 = 0x1
			-- File was changed

	file_deleted: NATURAL_8 = 0x2
			-- File was removed from disk

	file_resurected: NATURAL_8 = 0x4
			-- File was recreated after being delete.
			-- Note: This will never be used by itself, it only used to bit operations to determine
			--       types of file modifications

	file_resurected_and_changed: NATURAL_8 = 0x5
			-- File was recreated after being delete.
			-- Flag logically OR-ed with `file_changed'

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
