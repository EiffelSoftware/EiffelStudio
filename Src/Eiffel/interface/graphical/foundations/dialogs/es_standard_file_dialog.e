note
	description: "[
		ESF base dialog implemention for all standard file dialogs.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_STANDARD_FILE_DIALOG [G -> EV_FILE_DIALOG]

inherit
	ES_STANDARD_PATH_DIALOG [G]
		redefine
			on_after_initialized,
			on_before_shown,
			on_confirm,
			reset
		end

feature {NONE} -- Initialization

	on_after_initialized
			-- <Precursor>
		do
			create filters.make_default
			Precursor
		end

feature -- Access

	file_path: PATH
			-- Full path to the file.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			is_confirmed: is_confirmed
		local
			l_entry: detachable PATH
		do
			l_entry := dialog.full_file_path.entry
			if l_entry /= Void then
				Result := path.extended_path (l_entry)
				if attached selected_filter as l_filter then
					if not l_entry.has_extension (l_filter.extension) then
							-- There was either no extension or an extension that did not match `selected_filter'.
						Result := Result.appended_with_extension (l_filter.extension)
					end
				end
			else
				Result := path
			end
		end

	path: PATH
			-- <Precursor>
		do
			if is_confirmed then
				if attached dialog.full_file_path.parent as l_parent then
					Result := l_parent
				else
					create Result.make_empty
				end
			else
				Result := start_path
			end
		end

	selected_filter: detachable TUPLE [extension: attached STRING_32; description: attached STRING_32]
			-- The filter selected on confirmation.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			is_confirmed: is_confirmed
		local
			l_index: INTEGER
			l_filters: like filters
		do
			l_index := filter_index
			l_filters := filters
			if l_index > 0 then
				if l_index <= l_filters.count then
					Result := l_filters.item (l_index)
				else
						-- This should only happen with the all files filter because
						-- it does not actually exist in `filters'.
					check is_all_files_filter_supported: is_all_files_filter_supported end
				end
			end
		end

	start_file_name: detachable PATH assign set_start_file_name
			-- Initial file name used when showing the dialog.

feature {NONE} -- Access

	filters: attached DS_ARRAYED_LIST [TUPLE [extension: attached STRING_32; description: attached STRING_32]]
			-- Mutable version of `filters'.

	filter_index: NATURAL_16
			-- Index in `filters' of the selected filter

feature -- Element change

	set_start_file_name (a_file_name: like start_file_name)
			-- Set the selected start file name on the dialog.
			--
			-- `a_file_name': The start file name.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_a_file_name_is_empty: not a_file_name.is_empty
		do
			start_file_name := start_path.extended_path (a_file_name)
			dialog.set_full_file_path (start_file_name)
		end

feature {NONE} -- Element change

	set_start_path_on_dialog (a_path: like start_path; a_dialog: like dialog)
			-- <Precursor>
		do
			dialog.set_start_path (a_path)
		ensure then
			dialog_start_directory_set: dialog.start_path ~ a_path
		end

feature -- Status report

	is_all_files_filter_supported: BOOLEAN assign set_is_all_files_filter_supported
			-- Indicate if the dialog supports All Files (*.*) filter

	has_filter (a_extension: READABLE_STRING_GENERAL): BOOLEAN
			-- Determines if the dialog already has a filter set.
			--
			-- `a_extension': A filter extension to test for.
			-- `Result': True if a filter has been set; False otherwise.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_extension: STRING_32
			l_filters: like filters
			l_filter: TUPLE [extension: attached STRING_32; description: attached STRING_32]
		do
			l_extension := a_extension.as_string_32
			if {PLATFORM}.is_windows then
				l_extension := l_extension.as_lower
			end
			l_filters := filters
			from l_filters.start until l_filters.after or Result loop
				l_filter := l_filters.item_for_iteration
				check l_filter_attached: l_filter /= Void end
				Result := l_extension.same_string (l_filter.extension)
				l_filters.forth
			end
		end

feature -- Status setting

	set_is_all_files_filter_supported (a_supported: BOOLEAN)
			-- Sets All Files (*.*) filter option.
			--
			-- `a_supported': True to support All Files (*.*) filter; False otherwise.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			is_all_files_filter_supported := a_supported
		ensure
			is_all_files_filter_supported_set: is_all_files_filter_supported = a_supported
		end

feature -- Basic operations

	reset
			-- <Precursor>
		do
			Precursor
			filters.wipe_out
			filter_index := 0
			is_all_files_filter_supported := False
		ensure then
			filters_is_empty: filters.is_empty
			filter_index_reset: filter_index = 0
			not_is_all_files_filter_supported: not is_all_files_filter_supported
		end

	add_filter (a_extension: attached READABLE_STRING_GENERAL; a_description: attached READABLE_STRING_GENERAL; a_set: BOOLEAN)
			-- Adds a file name filter.
			--
			-- `a_extension': The file name extension, minus any wildcard or period.
			-- `a_description': A filter description.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_a_extension_is_empty: not a_extension.is_empty
			not_a_description_is_empty: not a_description.is_empty
			a_extension_has_no_wildcard: a_extension.as_string_32.item (1) /= '*'
			a_extension_has_no_period: a_extension.as_string_32.item (1) /= '.'
		local
			l_extension: STRING_32
		do
			l_extension := a_extension.as_string_32
			if {PLATFORM}.is_windows then
				l_extension := l_extension.as_lower
			end
			filters.force_last ([l_extension, a_description.as_string_32])
			if a_set then
				filter_index := filters.count.to_natural_16
			end
		ensure
			has_filter_a_extension: has_filter (a_extension)
		end

feature {NONE} -- Action handlers

	on_before_shown
			-- <Precursor>		
		local
			l_dialog_filters: like dialog.filters
			l_filters: like filters
			l_filter: TUPLE [extension, description: STRING_32]
			l_extension: STRING_32
			l_description: STRING_32
		do
			Precursor

				-- Set the dialog filters
			l_dialog_filters := dialog.filters
			l_dialog_filters.wipe_out

			l_filters := filters.twin
			if is_all_files_filter_supported or else l_filters.is_empty then
					-- Add the all files filters.
				l_filters.force_last ([all_files_filter.as_string_32, locale_formatter.translation (all_files_filter_description)])
			end
			if not l_filters.is_empty then
				from l_filters.start until l_filters.after loop
					l_filter := l_filters.item_for_iteration
					check l_filter_attached: l_filter /= Void end

						-- Build filter extension
					create l_extension.make (7)
					l_extension.append_string_general ("*.")
					l_extension.append_string (l_filter.extension)

						-- Build description
					l_description := l_filter.description.twin
					if not l_description.is_empty then
						if {PLATFORM}.is_windows then
								-- Add the extension as is usual on windows.
							l_description.right_adjust
							l_description.append (" (")
							l_description.append (l_extension)
							l_description.append_character (')')
						end
					else
							-- Use extension description
						l_description.append (l_extension)
					end

						-- Extend dialog filters
					l_dialog_filters.extend ([l_extension, l_description])

					l_filters.forth
				end
			end
		end

	on_confirm: BOOLEAN
			-- <Precursor>
		local
			l_index: NATURAL_16
		do
			l_index := dialog.selected_filter_index.as_natural_16
			if l_index < filters.count then
				filter_index := l_index
			else
					-- No selected filter, or all filters selected
				check is_all_files_filter_supported: is_all_files_filter_supported end
				filter_index := 0
			end
			Result := Precursor
		end

feature {NONE} -- Internationalization

	all_files_filter: STRING = "*"
	all_files_filter_description: STRING = "All Files"

invariant
	filter_index_is_valid: filter_index = 0 or else filters.valid_index (filter_index)

;note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
