note
	description: "[
		Services for manipulating and querying the global code template catalog.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	CODE_TEMPLATE_CATALOG_S

inherit
	SERVICE_I

	USABLE_I

	DISPOSABLE_I

	EVENT_CONNECTION_POINT_I [CODE_TEMPLATE_CATALOG_OBSERVER, CODE_TEMPLATE_CATALOG_S]
		rename
			connection as code_template_catalog_connection
		end

feature -- Access

	code_templates: DS_BILINEAR [CODE_TEMPLATE_DEFINITION]
			-- Current collection of code templates in the catalog.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: attached Result
			result_consistent: Result = code_templates
		end

feature -- Status report

	is_cataloged (a_folder: READABLE_STRING_GENERAL): BOOLEAN
			-- Determines if a folder is currently cataloged
		require
			is_interface_usable: is_interface_usable
			a_folder_attached: attached a_folder
			not_a_folder_is_empty: not a_folder.is_empty
		deferred
		end

feature -- Query

	template_by_file_name (a_file_name: READABLE_STRING_GENERAL): detachable CODE_TEMPLATE_DEFINITION
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

	template_by_title (a_title: READABLE_STRING_GENERAL): detachable CODE_TEMPLATE_DEFINITION
			-- Retrieves the first code template defintion match by a specified title.
			--
			-- `a_title': The title to match a code template definition to in the catalog.
			-- `Result': A code template definition or Void if no match was made.
		require
			is_interface_usable: is_interface_usable
			a_title_attached: attached a_title
			not_a_title_is_empty: not a_title.is_empty
		deferred
		end

	template_by_shortcut (a_shortcut: READABLE_STRING_GENERAL): detachable CODE_TEMPLATE_DEFINITION
			-- Retrieves the first code template defintion match by a specified shortcut.
			--
			-- `a_shortcut': The shortcut to match a code template definition to in the catalog.
			-- `Result': A code template definition or Void if no match was made.
		require
			is_interface_usable: is_interface_usable
			a_shortcut_attached: attached a_shortcut
			not_a_shortcut_is_empty: not a_shortcut.is_empty
		deferred
		end

	templates_by_category (a_categories: DS_BILINEAR [READABLE_STRING_GENERAL]; a_conjunctive: BOOLEAN): DS_ARRAYED_LIST [CODE_TEMPLATE_DEFINITION]
			-- Retrieves a list of code template defintions by specifying a list of matching categories.
			--
			-- `a_categories': The categories to match code templates for in the catalog.
			-- `a_conjunctive': True to ensure the result list contains code template definitions that contain all the specified categories; False
			--                  to retrieve a list of code template definitions that match any category.
			-- `Result': A list of matched code template definitions.
		require
			is_interface_usable: is_interface_usable
			a_categories_attached: attached a_categories
			not_a_categories_is_empty: not a_categories.is_empty
			a_categories_contains_attached_items: not a_categories.has_void
		deferred
		ensure
			result_attached: attached Result
			result_contains_attached_items: not Result.has_void
		end

feature -- Events

	catalog_changed_event: EVENT_TYPE_I [TUPLE]
			-- Events called when the catalog is modified in some way; templates added, templates removed
			-- or a rescan was performed
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: attached Result
			result_consistent: Result = catalog_changed_event
		end

feature -- Basic operations

	rescan (a_folder: READABLE_STRING_GENERAL)
			-- Rescans an existing catalog and update the templates associated with the cataloged folder.
			--
			-- `a_folder': The cataloged folder to rescan and update the templates
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

feature {NONE} -- Basic operation

	sort_templates_by_title (a_list: DS_INDEXABLE [CODE_TEMPLATE_DEFINITION])
			-- Sorts a template list by title.
			--
			-- `a_list': A template list to sort by title.
		require
			is_interface_usable: is_interface_usable
			a_list_attached: attached a_list
			a_list_contains_attached_items:
				(attached {DS_INDEXABLE [detachable ANY]} a_list as l_list) and then
				not l_list.has (Void)
		local
			l_comparer: AGENT_BASED_EQUALITY_TESTER [CODE_TEMPLATE_DEFINITION]
			l_sorter: DS_QUICK_SORTER [CODE_TEMPLATE_DEFINITION]
		do
			create l_comparer.make (agent (ia_template: CODE_TEMPLATE_DEFINITION; ia_other_template: CODE_TEMPLATE_DEFINITION): BOOLEAN
				require
					ia_template_attached: attached ia_template
					ia_other_template_attached: attached ia_other_template
				do
					Result := ia_template.metadata.title < ia_other_template.metadata.title
				end)
			create l_sorter.make (l_comparer)
			l_sorter.sort (a_list)
		end

feature -- Extension

	extend_catalog (a_folder: READABLE_STRING_GENERAL)
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

	remove_catalog (a_folder: READABLE_STRING_GENERAL)
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
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
