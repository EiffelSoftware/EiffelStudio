note
	description: "EIS variables"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_VARIABLES

inherit
	ES_EIS_SHARED

feature -- Access

	all_supported_variables_from_entry (a_entry: EIS_ENTRY): STRING_TABLE [READABLE_STRING_32]
			-- All variables
		require
			a_entry_not_void: a_entry /= Void
		do
			Result := eis_variables_from_entry (a_entry)
			Result.merge (es_built_in_variables)
			Result.merge (environment_variables)
		ensure
			Result_not_void: Result /= Void
		end

	all_supported_variables_for_auto_entry (a_target: CONF_TARGET): STRING_TABLE [READABLE_STRING_32]
			-- All variables available for auto entry.
			-- If that variable needs specific information from the context,
			-- an empty string is put.
		require
			a_target_not_void: a_target /= Void
		do
			create Result.make (10)
			Result.force (a_target.name, {ES_EIS_TOKENS}.target_name_var_name)
			Result.force (once "", {ES_EIS_TOKENS}.group_name_var_name)
			Result.force (once "", {ES_EIS_TOKENS}.class_name_var_name)
			Result.force (once "", {ES_EIS_TOKENS}.feature_name_var_name)

				-- Add `unique_id'.
			Result.force (once "", {ES_EIS_TOKENS}.unique_id_var_name)
				-- Add `system_path'
			if attached a_target.system.directory as l_directory then
				Result.force (l_directory.name, {ES_EIS_TOKENS}.system_path_var_name)
			end
				-- Add variables defined in the target.
			Result.merge (a_target.variables)

				-- Built-in variables
			Result.merge (es_built_in_variables)
				-- Environment variables
			Result.merge (environment_variables)
		ensure
			Result_not_void: Result /= Void
		end

	eis_variables_from_entry (a_entry: EIS_ENTRY): STRING_TABLE [READABLE_STRING_32]
			-- Variables
			--
			-- component names
			-- unique id
			-- system path
			-- target defined variables
		require
			a_entry_not_void: a_entry /= Void
		local
			l_type: NATURAL
			l_target: CONF_TARGET
			l_group: CONF_GROUP
			l_folder: EB_FOLDER
			l_class: CONF_CLASS
			l_feature: E_FEATURE
		do
			create Result.make (10)
			if attached a_entry.target_id as l_id then
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
						Result.force (l_directory.name, {ES_EIS_TOKENS}.system_path_var_name)
					end

						-- Add variables defined in the target.
					Result.merge (l_target.variables)
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	es_built_in_variables: STRING_TABLE [READABLE_STRING_32]
			-- ES built-in variables.
			-- These variables should ideally be built into a configure file.
		once
			create Result.make (5)
			Result.put ({STRING_32} "http://dev.eiffel.com", "ISE_WIKI")
			Result.put ({STRING_32} "http://www.eiffelroom.com", "EIFFELROOM")
			Result.put ({STRING_32} "http://doc.eiffel.com", "ISE_DOC")
			Result.put ({STRING_32} "http://doc.eiffel.com/isedoc/uuid", "ISE_DOC_UUID")
			Result.put ({STRING_32} "http://doc.eiffel.com/isedoc/eis", "ISE_DOC_REF")
		ensure
			result_attached: Result /= Void
		end

	environment_variables: HASH_TABLE [STRING_32, READABLE_STRING_32]
			-- Environment variables
		do
			if attached environment.service as l_service and then attached l_service.variables as l_vars then
				create Result.make (10)
				from
					l_vars.start
				until
					l_vars.after
				loop
					if attached l_service.variable (l_vars.item) as l_value then
						Result.force (l_value, l_vars.item)
					end
					l_vars.forth
				end
			else
				create Result.make (0)
			end
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	environment: SERVICE_CONSUMER [ENVIRONMENT_S]
			-- Access to the environment service
		once
			create Result
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
