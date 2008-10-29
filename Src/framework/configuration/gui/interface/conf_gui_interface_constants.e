indexing
	description: "Interface constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_GUI_INTERFACE_CONSTANTS

inherit
	CONF_INTERFACE_CONSTANTS

	FILE_DIALOG_CONSTANTS
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

	SHARED_BENCH_NAMES
		undefine
			copy,
			default_create
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

feature -- Update

	set_pixmaps (a_pixmaps: CONF_PIXMAPS)
		require
			a_pixmaps_not_void: a_pixmaps /= Void
		do
			Pixmap_cell.put (a_pixmaps)
		end

feature {NONE} -- Access

	Layout_constants: EV_LAYOUT_CONSTANTS is
			-- Constants for vision2 layout
		once
			create Result
		ensure
			Result_not_void: Result /= Void
		end

	Conf_pixmaps: CONF_PIXMAPS is
			-- Pixmaps.
		require
			Pixmap_cell_filled: Pixmap_cell /= Void
		once
			Result := pixmap_cell.item
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Onces

	Pixmap_cell: CELL [CONF_PIXMAPS] is
			-- Cell to hold the pixmap.
		once
			create Result.put (Void)
		end

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
