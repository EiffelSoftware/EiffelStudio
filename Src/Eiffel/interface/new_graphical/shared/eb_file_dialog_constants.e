note
	description: "[
		Objects that contain constants used with EiffelVision2 file dialogs.
		To add a new file type for use in EiffelStudio, you must declare the two constants
		of the form "*_file_filter" and "*_files_description" and update both `supported_filters'
		and `file_description_from_filter'.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FILE_DIALOG_CONSTANTS

inherit
	FILE_DIALOG_CONSTANTS

feature -- Status setting

	set_dialog_filters (a_dialog: EV_FILE_DIALOG; filters: ARRAY [STRING])
			-- Add filters to `a_dialog' corresponding to all items in `filters'.
		require
			dialog_not_void: a_dialog /= Void
			filters_not_void: filters /= Void
			filters_not_empty: not filters.is_empty
		local
			i: INTEGER
			filter: STRING
		do
				-- Remove any existing filters from `a_dialog'.
			if not a_dialog.filters.is_empty then
				a_dialog.filters.wipe_out
			end

			from
				i := filters.lower
			until
				i > filters.upper
			loop
				filter := filters.item (i)
				a_dialog.filters.extend ([filter, file_description_from_filter (filter)])
				i := i + 1
			end
		ensure
			filters_set: a_dialog.filters.count = filters.count
		end

	set_dialog_filters_and_add_all (a_dialog: EV_FILE_DIALOG; filters: ARRAY [STRING])
			-- Add filters to `a_dialog' corresponding to all items in `filters' and also add a final `all_files' option.
		require
			dialog_not_void: a_dialog /= Void
			filters_not_void: filters /= Void
			filters_not_empty: not filters.is_empty
		do
			set_dialog_filters (a_dialog, filters)

				-- Add all files filter.
			a_dialog.filters.extend ([all_files_filter, file_description_from_filter (all_files_filter)])
		ensure
			filters_set: a_dialog.filters.count = filters.count + 1
		end

note
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

end -- class EB_FILE_DIALOG_CONSTANTS
