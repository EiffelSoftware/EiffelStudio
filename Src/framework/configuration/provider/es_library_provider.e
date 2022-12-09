note
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_LIBRARY_PROVIDER

feature -- Access

	identifier: STRING
			-- Provider identifier.
		deferred
		end

	description: detachable READABLE_STRING_32
			-- Optional description
		deferred
		end

	libraries (a_query: detachable READABLE_STRING_GENERAL; a_target: CONF_TARGET): LIST [ES_LIBRARY_PROVIDER_ITEM]
			-- Configuration system view objects indexed by location.
		deferred
		end

	updated_date (a_target: CONF_TARGET): detachable DATE_TIME
			-- Date of last update.
		deferred
		end

feature -- Reset

	reset (a_target: CONF_TARGET)
		deferred
		end

	update (a_target: CONF_TARGET)
		do
			reset (a_target)
		end

feature {NONE} -- Implementation

	is_dotnet (a_target: CONF_TARGET): BOOLEAN
			-- Is dotnet?
		do
			Result := a_target.setting_msil_generation
		end

	real_directory_path (a_target: CONF_TARGET; a_path: READABLE_STRING_GENERAL): PATH
		local
			l_location: CONF_DIRECTORY_LOCATION
		do
			create l_location.make (a_path.as_string_32, a_target)
			Result := l_location.evaluated_path
		end

	conf_system_from (a_target: CONF_TARGET; a_path: READABLE_STRING_32; a_search_iron: BOOLEAN): detachable CONF_SYSTEM_VIEW
			-- Lib configuration from `a_path' path name.
		local
			fn: PATH
		do
			fn := real_directory_path (a_target, a_path)
			create Result.make (fn, a_path)
			if Result.has_library_target and then not Result.is_redirection then
				-- Exclude redirection!
				if a_search_iron then
					apply_iron_package_information_to (fn, Result)
				end
			else
				Result := Void
			end
		ensure
			result_attached: attached Result implies Result.has_library_target
		end

	apply_iron_package_information_to (a_ecf_path: PATH; cfg: CONF_SYSTEM_VIEW)
		local
			dn, ipn: PATH
			f: RAW_FILE
			pf: IRON_PACKAGE_FILE
			pfac: IRON_PACKAGE_FILE_FACTORY
		do
			dn := a_ecf_path.parent
			ipn := dn.extended ("package.iron")
			create f.make_with_path (ipn)
			if f.exists and then f.is_access_readable then
				create pfac
				pf := pfac.new_package_file (ipn)
				if not pf.has_error then
					if attached {IRON_PACKAGE_INFO_FILE} pf as pfinfo then
						across
							pfinfo.notes as ic
						loop
							cfg.set_info (ic, @ ic.key)
						end
					end
					if attached pf.title as pf_title then
						cfg.set_info (pf_title, "title")
					end
					if attached pf.description as pf_desc then
						cfg.set_info (pf_desc, "description")
					end
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
