note
	description: "Summary description for {IRON_NODE_DATABASE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_NODE_DATABASE

inherit
	IRON_NODE_EXPORTER

	IRON_NODE_FORWARD_OBSERVER

feature -- Initialization

	initialize
		deferred
		ensure
			is_available
		end

feature -- Status report

	is_available: BOOLEAN
		deferred
		end

feature -- Logs

	save_log (a_log: IRON_NODE_LOG)
			-- Save log `a_log'.
		deferred
		end

feature -- Credential

	is_valid_credential (u: READABLE_STRING_GENERAL; p: detachable READABLE_STRING_GENERAL): BOOLEAN
		deferred
		end

	user (u: READABLE_STRING_GENERAL): detachable IRON_NODE_USER
		deferred
		end

	user_by_email (a_email: READABLE_STRING_GENERAL): detachable IRON_NODE_USER
		deferred
		end

	update_user (u: IRON_NODE_USER)
		deferred
		end

feature -- Version

	versions: ITERABLE [IRON_NODE_VERSION]
		deferred
		end

feature -- Package

	package (a_id: READABLE_STRING_GENERAL): detachable IRON_NODE_PACKAGE
		deferred
		end

	package_by_name (a_name: READABLE_STRING_GENERAL): detachable IRON_NODE_PACKAGE
			-- Package named `a_name'.
		do
			if attached packages (1, 0) as lst then
				across
					lst as ic
				until
					Result /= Void
				loop
					if ic.item.is_named (a_name) then
						Result := ic.item
					end
				end
			end
		ensure
			Result /= Void implies Result.is_named (a_name)
		end

	packages (a_lower, a_upper: INTEGER): detachable LIST [IRON_NODE_PACKAGE]
			-- Range [a_lower:a_upper] of packages for version `v'
			-- if a_upper <= 0 then a_upper start from the end.
		require
			valid_index: a_lower >= 1
		deferred
		end

	force_package (a_package: IRON_NODE_PACKAGE)
		require
			has_id: a_package.has_id
			no_package_for_id: package (a_package.id) = Void
		deferred
		ensure
			has_id: a_package.has_id
		end

	update_package (a_package: IRON_NODE_PACKAGE)
		deferred
		ensure
			has_id: a_package.has_id
		end

	delete_package (a_package: IRON_NODE_PACKAGE)
		require
			has_id: a_package.has_id
		deferred
		ensure
			has_no_id: not a_package.has_id
			package (old a_package.id) = Void
		end

feature -- Version Package: Access

	version_package (v: IRON_NODE_VERSION; a_id: READABLE_STRING_GENERAL): detachable IRON_NODE_VERSION_PACKAGE
		deferred
		ensure
			Result /= Void implies Result.package ~ package (a_id)
		end

	version_packages_count (v: IRON_NODE_VERSION): INTEGER
			-- Total number of package for version `v'.
		deferred
		end

	version_packages (v: IRON_NODE_VERSION; a_lower, a_upper: INTEGER): detachable LIST [IRON_NODE_VERSION_PACKAGE]
			-- Range [a_lower:a_upper] of packages for version `v'
			-- if a_upper <= 0 then a_upper start from the end.
		require
			valid_index: a_lower >= 1
		deferred
		end

	package_by_path (v: IRON_NODE_VERSION; a_path: READABLE_STRING_GENERAL): detachable IRON_NODE_VERSION_PACKAGE
		deferred
		end

	path_associated_with_package (a_package: IRON_NODE_VERSION_PACKAGE): ITERABLE [READABLE_STRING_32]
		deferred
		end

	path_browse_index (v: IRON_NODE_VERSION; a_path: READABLE_STRING_GENERAL): detachable ITERABLE [READABLE_STRING_32]
		deferred
		end

	download_count (a_package: IRON_NODE_VERSION_PACKAGE): INTEGER
		deferred
		end

	increment_download_counter (a_package: IRON_NODE_VERSION_PACKAGE)
		deferred
		ensure
			count_incremented: a_package.download_count > old a_package.download_count
		end

	query_version_packages (q: READABLE_STRING_32; v: IRON_NODE_VERSION; a_lower, a_upper: INTEGER): LIST [IRON_NODE_VERSION_PACKAGE]
			-- Range [a_lower:a_upper] of packages for version `v' meeting the criteria expressed by `q'
			-- if a_upper <= 0 then a_upper start from the end.
		local
			i: INTEGER
		do
			create {ARRAYED_LIST [IRON_NODE_VERSION_PACKAGE]} Result.make (0)
			if attached version_packages (v, 1, 0) as lst then
				if attached version_package_criteria_factory.criteria_from_string (q) as crit then
					Result := crit.list (lst)
					if a_upper >= a_lower then
						from
							Result.start
							i := 1
						until
							i = a_lower or Result.after
						loop
							Result.remove
						end
						from
							Result.finish
							i := a_upper - a_lower
						until
							Result.count = i
						loop
							Result.remove
						end
					end
				end
			end
		end

feature -- Version Package: Criteria

	version_package_criteria_factory: CRITERIA_FACTORY [IRON_NODE_VERSION_PACKAGE]
		once
			create Result.make
			Result.register_builder ("name", agent (n,v: READABLE_STRING_GENERAL): detachable CRITERIA [IRON_NODE_VERSION_PACKAGE]
					do
						create {CRITERIA_AGENT [IRON_NODE_VERSION_PACKAGE]} Result.make (n + ":" + v,
							agent (obj: IRON_NODE_VERSION_PACKAGE; s: READABLE_STRING_GENERAL): BOOLEAN
								local
									kmp: KMP_WILD
								do
									if attached obj.name as l_name then
										if s.has ('*') or s.has ('?') then
											create kmp.make (s, l_name)
											kmp.disable_case_sensitive
											Result := kmp.pattern_matches
										else
											Result := l_name.as_lower.has_substring (s.as_lower)
										end
									end
								end(?, v)
							)
					end)
			Result.register_builder ("title", agent (n,v: READABLE_STRING_GENERAL): detachable CRITERIA [IRON_NODE_VERSION_PACKAGE]
					do
						create {CRITERIA_AGENT [IRON_NODE_VERSION_PACKAGE]} Result.make (n + ":" + v,
							agent (obj: IRON_NODE_VERSION_PACKAGE; s: READABLE_STRING_GENERAL): BOOLEAN
								local
									kmp: KMP_WILD
								do
									if attached obj.title as l_title then
										if s.has ('*') or s.has ('?') then
											create kmp.make (s, l_title)
											kmp.disable_case_sensitive
											Result := kmp.pattern_matches
										else
											Result := l_title.as_lower.has_substring (s.as_lower)
										end
									end
								end(?, v)
							)
					end)
			Result.register_builder ("tag", agent (n,v: READABLE_STRING_GENERAL): detachable CRITERIA [IRON_NODE_VERSION_PACKAGE]
					do
						create {CRITERIA_AGENT [IRON_NODE_VERSION_PACKAGE]} Result.make (n + ":" + v,
							agent (obj: IRON_NODE_VERSION_PACKAGE; s: READABLE_STRING_GENERAL): BOOLEAN
								do
									Result := attached obj.tags as l_tags and then
										across l_tags as ic some ic.item.is_case_insensitive_equal_general (s) end
								end(?, v)
							)
					end)
			Result.register_builder ("downloads", agent (n,v: READABLE_STRING_GENERAL): detachable CRITERIA [IRON_NODE_VERSION_PACKAGE]
					local
						i: INTEGER
					do
						if v.is_integer then
							i := v.to_integer
							create {CRITERIA_AGENT [IRON_NODE_VERSION_PACKAGE]} Result.make (n + ":" + v,
								agent (obj: IRON_NODE_VERSION_PACKAGE; nb: INTEGER): BOOLEAN
									do
										Result := obj.download_count >= nb
									end(?, i)
								)
						end
					end)
			Result.register_default_builder ("name")
			Result.set_builder_description ("name", "has package name (support wildcard)")
			Result.set_builder_description ("tag", "has tag")
			Result.set_builder_description ("downloads", "has at least N downloads")
		end

feature -- Version Package: change		

	force_version_package (a_package: IRON_NODE_VERSION_PACKAGE)
		require
			has_id: a_package.has_id
			no_package_for_id: version_package (a_package.version, a_package.id) = Void
		deferred
		ensure
			has_id: a_package.has_id
		end

	update_version_package (a_package: IRON_NODE_VERSION_PACKAGE)
		deferred
		ensure
			has_id: a_package.has_id
		end

	delete_version_package (a_package: IRON_NODE_VERSION_PACKAGE)
		require
			has_id: a_package.has_id
		deferred
		ensure
			has_no_id: not a_package.has_id
			version_package (a_package.version, old a_package.id) = Void
		end

feature -- Version Package/ archive: change	

	last_archive_revision (a_package: IRON_NODE_PACKAGE): NATURAL
		deferred
		end

	incremented_last_archive_revision (a_package: IRON_NODE_PACKAGE; a_min_rev: NATURAL): NATURAL
			-- Incremented value of last archive revision counter for package `a_package'
			-- with a minimum value of `a_min_rev'.
		deferred
		ensure
			Result > old last_archive_revision (a_package) and Result > a_min_rev
		end

	get_new_archive_revision (a_package: IRON_NODE_VERSION_PACKAGE)
			-- Get a new archive revision number for `a_package'.
		deferred
		ensure
			revision_incremented: a_package.archive_revision > old a_package.archive_revision
		end

	save_uploaded_package_archive (a_package: IRON_NODE_VERSION_PACKAGE; a_file: WSF_UPLOADED_FILE)
		require
			has_id: a_package.has_id
		deferred
		ensure
			has_archive: a_package.has_archive
		end

	save_package_archive (a_package: IRON_NODE_VERSION_PACKAGE; a_file: PATH; a_keep_source_file: BOOLEAN)
		require
			has_id: a_package.has_id
		deferred
		ensure
			has_archive: a_package.has_archive
		end

	delete_package_archive (a_package: IRON_NODE_VERSION_PACKAGE)
		require
			has_id: a_package.has_id
			has_archive: a_package.has_archive
		deferred
		ensure
			has_no_archive: not a_package.has_archive
		end

feature -- Version Package/ map,path: change						

	associate_package_with_path (a_package: IRON_NODE_VERSION_PACKAGE; a_path: READABLE_STRING_GENERAL)
		require
			a_package_with_id: a_package.has_id
			a_path_not_empty: not a_path.is_empty
			path_unassociated: package_by_path (a_package.version, a_path) = Void
		deferred
		ensure
			path_associated: package_by_path (a_package.version, a_path) ~ a_package
		end

	unassociate_package_with_path (a_package: IRON_NODE_VERSION_PACKAGE; a_path: READABLE_STRING_GENERAL)
		require
			a_package_with_id: a_package.has_id
			a_path_not_empty: not a_path.is_empty
			path_associated: package_by_path (a_package.version, a_path) ~ a_package
		deferred
		ensure
			path_unassociated: package_by_path (a_package.version, a_path) = Void
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
