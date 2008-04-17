indexing
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

	last_entry: ?EIS_ENTRY
			-- Last shown entry.

	context_variables: !HASH_TABLE [STRING_8, STRING_8] is
			-- A table of context variables, indexed by a variable name
		local
			l_type: NATURAL
			l_target: CONF_TARGET
			l_group: CONF_GROUP
			l_folder: EB_FOLDER
			l_class: CONF_CLASS
			l_feature: E_FEATURE
		do
			if {entry: EIS_ENTRY}last_entry then
				create Result.make (5)
				if {l_id: STRING}entry.id then
					l_type := id_solution.most_possible_type_of_id (l_id)
					if l_type = id_solution.feature_type then
						l_feature := id_solution.feature_of_id (l_id)
					elseif l_type = id_solution.class_type then
						l_class := id_solution.class_of_id (l_id)
					elseif l_type = id_solution.folder_type then
						l_folder := id_solution.folder_of_id (l_id)
					elseif l_type = id_solution.group_type then
						l_group := id_solution.group_of_id (l_id)
					elseif l_type = id_solution.target_type then
						l_target := id_solution.target_of_id (l_id)
					end

					if {lt_target: STRING}id_solution.last_target_name then
						Result.force (lt_target, {ES_EIS_TOKENS}.target_name_var_name)
					end
					if {lt_group: STRING}id_solution.last_group_name then
						Result.force (lt_group, {ES_EIS_TOKENS}.group_name_var_name)
					end
					if {lt_class: STRING}id_solution.last_class_name then
						Result.force (lt_class, {ES_EIS_TOKENS}.class_name_var_name)
					end
					if {lt_feature: STRING}id_solution.last_feature_name then
						Result.force (lt_feature, {ES_EIS_TOKENS}.feature_name_var_name)
					end
				end
				Result.merge (Precursor)
			else
				Result := Precursor
			end
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
