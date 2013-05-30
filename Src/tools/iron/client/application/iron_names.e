note
	description: "Summary description for {IRON_NAMES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NAMES

feature -- List task

	m_warning_no_repository: STRING_32
		do Result := {STRING_32} "Warning: no repository is defined!" end

	m_available_packages: STRING_32
		do Result := {STRING_32} "Available packages:" end

	m_installed_packages: STRING_32
		do Result := {STRING_32} "Installed packages:" end

	m_no_installed_package: STRING_32
		do Result := {STRING_32} "No package is installed !" end

	tk_package: STRING_32
		do Result := {STRING_32} "Package" end

	m_repository (a_uri, a_version: READABLE_STRING_GENERAL): STRING_32
		do Result := string_with_args ("Repository [$1] version=$2", [a_uri, a_version]) end

	m_repository_without_package (a_uri, a_version: READABLE_STRING_GENERAL): STRING_32
		do Result := string_with_args ("Repository [$1] version=$2 has no package!", [a_uri, a_version]) end

feature -- Install task

	tk_simulated: STRING_32
		do Result := {STRING_32} "simulated" end

	tk_not_found: STRING_32
		do Result := {STRING_32} "not found" end

	tk_not_installed: STRING_32
		do Result := {STRING_32} "not installed !" end

	tk_already_installed: STRING_32
		do Result := {STRING_32} "already installed !" end

	tk_successfully_installed: STRING_32
		do Result := {STRING_32} "successfully installed !" end

	tk_successfully_removed: STRING_32
		do Result := {STRING_32} "successfully removed !" end

	tk_failed: STRING_32
		do Result := {STRING_32} "failed !" end

	m_installing (s: READABLE_STRING_GENERAL): STRING_32
		do Result := string_with_args ("Installing %"$1%" ", [s]) end

	m_removing (s: READABLE_STRING_GENERAL): STRING_32
		do Result := string_with_args ("Removing %"$1%" ", [s]) end

	m_searching (s: READABLE_STRING_GENERAL): STRING_32
		do Result := string_with_args ("Searching %"$1%" ", [s]) end

	m_several_packages_for_name (s: READABLE_STRING_GENERAL): STRING_32
		do Result := string_with_args ("several packages for name %"$1%"!", [s]) end

feature -- Info task

	tk_installation: STRING_32
		do Result := {STRING_32} "installation"	end

	tk_associated_uris: STRING_32
		do Result := {STRING_32} "associated URIs"	end

	m_title_information_for (s: READABLE_STRING_GENERAL): STRING_32
		do Result := string_with_args ("Information for %"$1%" ", [s]) end

	m_information_for (a_title, a_id, a_repo_url: READABLE_STRING_GENERAL): STRING_32
		do Result := string_with_args ("[ $1 ]%N%N  id: $2%N  repository: $3", [a_title, a_id, a_repo_url]) end

feature -- Repository task

	m_updating_repositories: STRING_32
		do Result := {STRING_32} "Updating repositories ..." end

	m_registering_repository (a_name: READABLE_STRING_GENERAL; a_url: READABLE_STRING_GENERAL): STRING_32
		do Result := string_with_args ("Registering repository %"$1%" [$2] ", [a_name, a_url]) end

	m_unregistering_repository (a_name_or_uri: READABLE_STRING_GENERAL): STRING_32
		do Result := string_with_args ("Un-Registering repository [$2] ", [a_name_or_uri]) end

feature {NONE} -- Implementation

	string_with_args (a_pattern: READABLE_STRING_GENERAL; a_values: detachable TUPLE): STRING_32
		local
			i,n: INTEGER
		do
			create Result.make_from_string_general (a_pattern)
			if a_values /= Void then
				n := a_values.count
				from
					i := 1
				until
					i > n
				loop
					if attached a_values.item (i) as a then
						Result.replace_substring_all ("$" + i.out, a.out)
					else
						Result.replace_substring_all ("$" + i.out, "")
					end
					i := i + 1
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
