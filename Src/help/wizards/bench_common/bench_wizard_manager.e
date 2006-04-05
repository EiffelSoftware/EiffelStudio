indexing
	description	: "Class which is launching the application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	BENCH_WIZARD_MANAGER

inherit
	WIZARD_PROJECT_MANAGER
		redefine
			prepare,
			make_and_launch
		end

feature {NONE} -- Initialization

	make_and_launch is
			-- Initialize and launch application
		local
			retried: BOOLEAN
		do
			if not retried then
				Precursor
			else
				write_bench_notification_cancel
			end
		rescue
			retried := true
			retry
		end

	prepare is
			-- Prepare the first window to be displayed.
		local
			icon_pixmap: EV_PIXMAP
			wizard_icon_filename: FILE_NAME
			retried: BOOLEAN
		do
			if not retried then
				Precursor
				
				create icon_pixmap
				wizard_icon_filename := clone (wizard_pixmaps_path)
				wizard_icon_filename.set_file_name ("wizard")
				wizard_icon_filename.add_extension ("png")
				icon_pixmap.set_with_named_file (wizard_icon_filename)
				first_window.set_icon_pixmap (icon_pixmap)
			end
		rescue
			retried := True
			retry
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
end -- class WIZARD_MANAGER
