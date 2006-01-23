indexing
	description: "EiffelStudio preference window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_PREFERENCES_WINDOW

inherit
	PREFERENCES_WINDOW
		rename
			preferences as view_preferences
		redefine
			make,
			on_close
		end

	GB_EIFFEL_ENV
		export
			{NONE} all
		undefine
			copy, default_create
		end

	GB_RECENT_PROJECTS
		undefine
			copy, default_create
		end

create
	make

feature -- Access

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make (a_preferences: like view_preferences; a_parent_window: like parent_window) is
			-- New window.  Redefined to register EiffelStudio specific resource widgets for
			-- special resource types.
		do
			set_root_icon (icon_preference_root)
			set_folder_icon (icon_preference_folder)
			Precursor {PREFERENCES_WINDOW} (a_preferences, a_parent_window)
			set_icon_pixmap (icon_preference_root)
			close_request_actions.extend (agent on_close)
		end

	on_close is
			-- Window was closed
		do
			clip_recent_projects
			Precursor
		end

feature {NONE} -- Implementation

	icon_preference_root: EV_PIXMAP is
			-- Icon for preferences root node
		local
			l_filename: FILE_NAME
		do
			create l_filename.make_from_string (bitmaps_path.twin)
			l_filename.extend ("png")
			l_filename.extend ("icon_preferences_root.png")
			create Result
			Result.set_with_named_file (l_filename.string)
		end

	icon_preference_folder: EV_PIXMAP is
			-- Icon for preferences folder node
		local
			l_filename: FILE_NAME
		do
			create l_filename.make_from_string (bitmaps_path.twin)
			l_filename.extend ("png")
			l_filename.extend ("icon_preferences_folder.png")
			create Result
			Result.set_with_named_file (l_filename.string)
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


end -- class GB_PREFERENCES_WINDOW
