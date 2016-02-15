note
	description: "Summary description for {ES_LIBRARY_PROVIDER}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_LIBRARY_PROVIDER

inherit
	ES_CACHE_UTILITIES

feature -- Access

	identifier: STRING
			-- Provider identifier.
		deferred
		end

	description: detachable READABLE_STRING_32
			-- Optional description
		deferred
		end

	filtered_libraries (a_filter: READABLE_STRING_GENERAL; a_target: CONF_TARGET): STRING_TABLE [CONF_SYSTEM_VIEW]
		do
			Result := filtered_table (a_filter, libraries (a_target))
		end

	libraries (a_target: CONF_TARGET): STRING_TABLE [CONF_SYSTEM_VIEW]
		local
			l_cache_id: READABLE_STRING_8
		do
			l_cache_id := cache_name (a_target)
			if
				is_eiffel_layout_defined and then
				attached {like no_cached_libraries} cached_data (l_cache_id) as cfg_libs
			then
				Result := cfg_libs
			else
				Result := no_cached_libraries (a_target)
				if is_eiffel_layout_defined then
					cache_data (Result, l_cache_id)
				end
			end
		ensure
			result_attached: attached Result
		end

	no_cached_libraries (a_target: CONF_TARGET): STRING_TABLE [CONF_SYSTEM_VIEW]
		deferred
		ensure
			result_attached: attached Result
		end

	updated_date (a_target: CONF_TARGET): detachable DATE_TIME
			-- Date of last update.
		do
			Result := cache_date (cache_name (a_target))
		end

feature -- Reset

	clear_cache (a_target: CONF_TARGET)
		do
			if is_eiffel_layout_defined then
				cache_data (Void, cache_name (a_target))
			end
		end

	update (a_target: CONF_TARGET)
		do
			clear_cache (a_target)
		end

feature -- Filter

	filter_factory: CRITERIA_FACTORY [CONF_SYSTEM_VIEW]
		local
			l_name_crit: CRITERIA_AGENT [CONF_SYSTEM_VIEW]
		once
			create Result.make
			Result.register_builder ("name", agent (n,v: READABLE_STRING_GENERAL): detachable CRITERIA [CONF_SYSTEM_VIEW]
					do
						create {CRITERIA_AGENT [CONF_SYSTEM_VIEW]} Result.make (n + ":" + v, agent meet_name (?, v))
					end
				)
			Result.register_builder ("title", agent (n,v: READABLE_STRING_GENERAL): detachable CRITERIA [CONF_SYSTEM_VIEW]
					do
						create {CRITERIA_AGENT [CONF_SYSTEM_VIEW]} Result.make (n + ":" + v, agent meet_title (?, v))
					end
				)
			Result.register_builder ("description", agent (n,v: READABLE_STRING_GENERAL): detachable CRITERIA [CONF_SYSTEM_VIEW]
					do
						create {CRITERIA_AGENT [CONF_SYSTEM_VIEW]} Result.make (n + ":" + v, agent meet_description (?, v))
					end
				)
			Result.register_builder ("tag", agent (n,v: READABLE_STRING_GENERAL): detachable CRITERIA [CONF_SYSTEM_VIEW]
					do
						create {CRITERIA_AGENT [CONF_SYSTEM_VIEW]} Result.make (n + ":" + v, agent meet_tag (?, v))
					end
				)
			Result.register_builder ("any", agent (n,v: READABLE_STRING_GENERAL): detachable CRITERIA [CONF_SYSTEM_VIEW]
					do
						create {CRITERIA_AGENT [CONF_SYSTEM_VIEW]} Result.make (n + ":" + v, agent meet_any (?, v))
					end
				)
			Result.register_default_builder ("any")
		end

	meet_any (obj: CONF_SYSTEM_VIEW; s: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result :=  meet_name (obj, s)
					or meet_title (obj, s)
					or meet_tag (obj, s)
		end

	meet_name (obj: CONF_SYSTEM_VIEW; s: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := meet_text (obj.system_name, s)
		end

	meet_title (obj: CONF_SYSTEM_VIEW; s: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := meet_text (obj.title, s) or meet_text (obj.info ("title"), s)
		end

	meet_description (obj: CONF_SYSTEM_VIEW; s: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := meet_text (obj.description, s) or meet_text (obj.info ("description"), s)
		end

	meet_tag (obj: CONF_SYSTEM_VIEW; s: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := meet_text (obj.info ("tags"), s)
		end

	meet_text (a_text: detachable READABLE_STRING_GENERAL; s: READABLE_STRING_GENERAL): BOOLEAN
		local
			kmp: KMP_WILD
		do
			if a_text /= Void then
				if s.has ('*') or s.has ('?') then
					create kmp.make (s, a_text)
					kmp.disable_case_sensitive
					Result := kmp.pattern_matches
				else
					Result := a_text.as_lower.has_substring (s.as_lower)
				end
			end
		end

feature {NONE} -- Implementation		

	filtered_table (a_filter: READABLE_STRING_GENERAL; a_libs: STRING_TABLE [CONF_SYSTEM_VIEW]): STRING_TABLE [CONF_SYSTEM_VIEW]
		local
			l_filter_engine: detachable KMP_WILD
			f: STRING_32
			cfg: CONF_SYSTEM_VIEW
		do
			create Result.make (a_libs.count)
			if not a_libs.is_empty then
				if attached filter_factory.criteria_from_string (a_filter) as crit then
					from
						a_libs.start
					until
						a_libs.after
					loop
						cfg := a_libs.item_for_iteration
						if crit.meet (cfg) then
							Result.put (cfg, a_libs.key_for_iteration)
						end
						a_libs.forth
					end
				else
					create f.make_from_string_general (a_filter)
					f.adjust
					if f.item (1) /= '*' then
						f.prepend_character ('*')
					end
					if f.item (f.count) /= '*' then
						f.append_character ('*')
					end
					create l_filter_engine.make_empty
					l_filter_engine.set_pattern (f)
					l_filter_engine.disable_case_sensitive
					from
						a_libs.start
					until
						a_libs.after
					loop
						cfg := a_libs.item_for_iteration
						l_filter_engine.set_text (cfg.library_target_name)
						if l_filter_engine.pattern_matches then
							Result.put (cfg, a_libs.key_for_iteration)
						end
						a_libs.forth
					end
				end
			end
		end

	cache_name (a_target: CONF_TARGET): STRING
			-- Cache name depending on `a_target' setting.
		deferred
		end

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
			create Result.make_from_path (fn)
			if Result.has_library_target then
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
							cfg.set_info (ic.item, ic.key)
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
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
