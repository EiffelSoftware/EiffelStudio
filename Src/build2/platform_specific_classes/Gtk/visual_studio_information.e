indexing
	description: "Objects that provide information about VisualStudio installation.%
		%As this is the Gtk version, will do nothing, but included for compilation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VISUAL_STUDIO_INFORMATION

feature -- Access

	wizard_installation_path: STRING  is
			-- Result is path of installation directory on local machine which
			-- contains the Wizards directory.
		do
			check
				not_applicable: FALSE
			end
		end
		
	is_visual_studio_wizard: BOOLEAN is
			-- Has Build been launched from
			-- VisualStudio in Wizard mode?
			-- This is a Once, as it will
			-- never change during the execution of
			-- the system.
		once
			-- Cannot be a visual studio wizard, as
			-- we are running on Linux.
			Result := False
		end
		
	visual_studio_pixmap_location: STRING is
			-- `Result' is location to icons used by Build.
			-- We only need the location to the icons, as
			-- none of the PNG's are needed in VisualStudio mode
			-- as we are always on Windows.
		once
			check
				not_applicable: FALSE
			end
		end

	clr_version: STRING
		-- Version of clr used in geenrated ace files.

feature -- Satus setting

	set_clr_version (a_version: STRING) is
			-- Assign `a_version' to `clr_version'.
		require
			a_version /= Void
		do
			clr_version := a_version
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


end -- class VISUAL_STUDIO_INFORMATION
