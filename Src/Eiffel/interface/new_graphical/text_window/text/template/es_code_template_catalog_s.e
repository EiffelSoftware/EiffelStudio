note
	description: "Services for manipulating and querying the global code template catalog."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CODE_TEMPLATE_CATALOG_S

inherit

	SERVICE_I

	USABLE_I

	DISPOSABLE_I

	EVENT_CONNECTION_POINT_I [ES_CODE_TEMPLATE_CATALOG_OBSERVER, ES_CODE_TEMPLATE_CATALOG_S]
		rename
			connection as code_template_catalog_connection
		end

feature -- Access

	code_templates: DS_BILINEAR [ES_CODE_TEMPLATE_DEFINITION]
			-- Current collection of code templates in the catalog.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: attached Result
			result_consistent: Result = code_templates
		end

feature -- Status report

	is_cataloged (a_folder: PATH): BOOLEAN
			-- Determines if a folder is currently cataloged.
		require
			is_interface_usable: is_interface_usable
			a_folder_attached: attached a_folder
			not_a_folder_is_empty: not a_folder.is_empty
		deferred
		end

feature -- Query

	template_by_file_name (a_file_name: PATH): detachable ES_CODE_TEMPLATE_DEFINITION
			-- Retrieves the first code template defintion match by a specified file name.
			--
			-- `a_file_name': The full path to a code template definition file.
			-- `Result': A code template definition or Void if there was an error loading the code template.
		require
			is_interface_usable: is_interface_usable
			a_file_name_attached: attached a_file_name
			not_a_file_name_is_empty: not a_file_name.is_empty
		deferred
		end


feature -- Events

	catalog_changed_event: EVENT_TYPE_I [TUPLE]
			-- Events called when the catalog is modified in some way; templates added, templates removed
			-- or a rescan was performed.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: attached Result
			result_consistent: Result = catalog_changed_event
		end

feature -- Basic operations

	rescan (a_folder: PATH)
			-- Rescans an existing catalog and update the templates associated with the cataloged folder.
			--
			-- `a_folder': The cataloged folder to rescan and update the templates.
		require
			is_interface_usable: is_interface_usable
			a_folder_attached: attached a_folder
			not_a_folder_is_empty: not a_folder.is_empty
			is_cataloged: is_cataloged (a_folder)
		deferred
		ensure
			is_still_cataloged: is_cataloged (a_folder)
		end

	rescan_catalog
			-- Rescans all cataloged folders and update the templates accordingly.
		require
			is_interface_usable: is_interface_usable
		deferred
		end
feature -- Extension

	extend_catalog (a_folder: PATH)
			-- Extends the code template catalog with a folder full of templates.
			--
			-- `a_folder': The folder to add to the catalog.
		require
			is_interface_usable: is_interface_usable
			a_folder_attached: attached a_folder
			not_a_folder_is_empty: not a_folder.is_empty
			not_is_cataloged: not is_cataloged (a_folder)
		deferred
		ensure
			is_cataloged: is_cataloged (a_folder)
		end

feature -- Removal

	remove_catalog (a_folder: PATH)
			-- Removes a folder from the code template catalog, removing all templates.
			--
			-- `a_folder': The folder to remove from the catalog and all it's contained templates.
		require
			is_interface_usable: is_interface_usable
			a_folder_attached: attached a_folder
			not_a_folder_is_empty: not a_folder.is_empty
			is_cataloged: is_cataloged (a_folder)
		deferred
		ensure
			not_is_cataloged: not is_cataloged (a_folder)
		end

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
