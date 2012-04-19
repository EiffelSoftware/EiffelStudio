note
	description: "EIS entry help provider. Information is retrieved from given EIS entry to launch actual resources."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_EIS_ENTRY_HELP_PROVIDER

inherit
	RAW_URI_HELP_PROVIDER
		undefine
			document_protocol,
			document_description
		redefine
			context_variables
		end

	ES_EIS_SHARED
		export
			{NONE} all
		end

feature {NONE} -- Variable expansion

	last_entry: detachable EIS_ENTRY
			-- Last shown entry.

	context_variables: HASH_TABLE [STRING, READABLE_STRING_8]
			-- A table of context variables, indexed by a variable name
		local
			l_type: NATURAL
			l_target: CONF_TARGET
			l_group: CONF_GROUP
			l_folder: EB_FOLDER
			l_class: CONF_CLASS
			l_feature: E_FEATURE
		do
			if attached last_entry as entry then
				create Result.make (5)
				if attached entry.id as l_id then
					l_target := id_solution.target_of_id (l_id)
					l_type := id_solution.most_possible_type_of_id (l_id)
					if l_type = id_solution.feature_type then
						l_feature := id_solution.feature_of_id (l_id)
					elseif l_type = id_solution.class_type then
						l_class := id_solution.class_of_id (l_id)
					elseif l_type = id_solution.folder_type then
						l_folder := id_solution.folder_of_id (l_id)
					elseif l_type = id_solution.group_type then
						l_group := id_solution.group_of_id (l_id)
					end

					if attached id_solution.last_target_name as lt_target then
						Result.force (lt_target, {ES_EIS_TOKENS}.target_name_var_name)
					end
					if attached id_solution.last_group_name as lt_group then
						Result.force (lt_group, {ES_EIS_TOKENS}.group_name_var_name)
					end
					if attached id_solution.last_class_name as lt_class then
						Result.force (lt_class, {ES_EIS_TOKENS}.class_name_var_name)
					end
					if attached id_solution.last_feature_name as lt_feature then
						Result.force (lt_feature, {ES_EIS_TOKENS}.feature_name_var_name)
					end

						-- Add `unique_id'.
					Result.force (id_solution.url_id (l_id), {ES_EIS_TOKENS}.unique_id_var_name)


					if l_target /= Void then
							-- Add `system_path'
						if attached l_target.system.directory as l_directory then
							Result.force (l_directory, {ES_EIS_TOKENS}.system_path_var_name)
						end

							-- Add variables defined in the target.
						Result.merge (l_target.variables)
					end
				end
				Result.merge (Precursor)
			else
				Result := Precursor
			end
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
