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

	versions: IRON_NODE_VERSION_COLLECTION
		deferred
		end

	save_version (a_version: IRON_NODE_VERSION)
		deferred
		ensure
			created: versions.has (a_version.value)
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

	packages (a_lower, a_upper: INTEGER): detachable IRON_NODE_PACKAGE_COLLECTION
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

	version_packages (v: IRON_NODE_VERSION; a_lower, a_upper: INTEGER): detachable IRON_NODE_VERSION_PACKAGE_COLLECTION
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

	query_version_packages (q: READABLE_STRING_32; v: IRON_NODE_VERSION; a_lower, a_upper: INTEGER): IRON_NODE_VERSION_PACKAGE_COLLECTION
			-- Range [a_lower:a_upper] of packages for version `v' meeting the criteria expressed by `q'
			-- if a_upper <= 0 then a_upper start from the end.
		local
			i: INTEGER
			lst: LIST [IRON_NODE_VERSION_PACKAGE]
		do
			create Result.make (0)
			if attached version_packages (v, 1, 0) as coll then
				if attached version_package_criteria_factory.criteria_from_string (q) as crit then
					lst := crit.list (coll.items)
					if a_upper >= a_lower then
						from
							lst.start
							i := 1
						until
							i = a_lower or lst.after
						loop
							lst.remove
						end
						from
							lst.finish
							i := a_upper - a_lower
						until
							lst.count = i
						loop
							lst.remove
						end
					end
					across
						lst as ic
					loop
						Result.force (ic.item)
					end
				end
			end
--			Result.sort
		end

feature -- Version Package: Sorter

	version_package_sorter_factory: IRON_SORTER_FACTORY [IRON_NODE_VERSION_PACKAGE]
		local
			l_sorter: SORTER [IRON_NODE_VERSION_PACKAGE]
			eq: detachable AGENT_EQUALITY_TESTER [IRON_NODE_VERSION_PACKAGE]
		once
			create Result.make (4)

				-- by name
			create eq.make (agent version_package_is_less_than_by_name)
			create {QUICK_SORTER [IRON_NODE_VERSION_PACKAGE]} l_sorter.make (eq)
			Result.register_builder ("name", l_sorter, "Sort by short name")

				-- by title
			create eq.make (agent version_package_is_less_than_by_title)
			create {QUICK_SORTER [IRON_NODE_VERSION_PACKAGE]} l_sorter.make (eq)
			Result.register_builder ("title", l_sorter, "Sort by title (i.e full name)")

				-- by downloads
			create eq.make (agent version_package_is_less_than_by_downloads)
			create {QUICK_SORTER [IRON_NODE_VERSION_PACKAGE]} l_sorter.make (eq)
			Result.register_builder ("downloads", l_sorter, "Sort by downloads count")

				-- by date
			create eq.make (agent version_package_is_less_than_by_last_modified)
			create {QUICK_SORTER [IRON_NODE_VERSION_PACKAGE]} l_sorter.make (eq)
			Result.register_builder ("date", l_sorter, "Sort by last-modified date")
		end

feature {NONE} -- Version Package: Sorter

	version_package_is_less_than_by_string_value (s1, s2: detachable READABLE_STRING_GENERAL; p1, p2: IRON_NODE_VERSION_PACKAGE): BOOLEAN
		do
			if s1 = Void then
				if s2 = Void then
					Result := p1 < p2
				else
					Result := True
				end
			elseif s2 = Void then
				Result := False
			else
				Result := s1.as_lower < s2.as_lower
			end
		end

	version_package_is_less_than_by_value (v1, v2: detachable COMPARABLE; p1, p2: IRON_NODE_VERSION_PACKAGE): BOOLEAN
		do
			if v1 = Void then
				if v2 = Void then
					Result := p1 < p2
				else
					Result := True
				end
			elseif v2 = Void then
				Result := False
			else
				Result := v1 < v2
			end
		end

	version_package_is_less_than_by_name (p1, p2: IRON_NODE_VERSION_PACKAGE): BOOLEAN
		do
			Result := version_package_is_less_than_by_string_value (p1.name, p2.name, p1, p2)
		end

	version_package_is_less_than_by_title (p1, p2: IRON_NODE_VERSION_PACKAGE): BOOLEAN
		do
			Result := version_package_is_less_than_by_string_value (p1.title, p2.title, p1, p2)
		end

	version_package_is_less_than_by_downloads (p1, p2: IRON_NODE_VERSION_PACKAGE): BOOLEAN
		do
				-- Users expect to see packages with more download first.
			Result := version_package_is_less_than_by_value (p2.download_count, p1.download_count, p1, p2)
		end

	version_package_is_less_than_by_last_modified (p1, p2: IRON_NODE_VERSION_PACKAGE): BOOLEAN
		do
				-- Users expect to see by default, latest changes first.
			Result := version_package_is_less_than_by_value (p2.last_modified, p1.last_modified, p1, p2)
		end

feature -- Version Package: Criteria

	meet_text (a_text: detachable READABLE_STRING_GENERAL; s: READABLE_STRING_GENERAL): BOOLEAN
		local
			kmp: KMP_WILD
			tok: READABLE_STRING_GENERAL
			tok_len: INTEGER
			l_lower_text: READABLE_STRING_GENERAL
			c: CHARACTER_32
			i: INTEGER
		do
			if a_text /= Void then
				if s.has ('*') or s.has ('?') then
					create kmp.make (s, a_text)
					kmp.disable_case_sensitive
					Result := kmp.pattern_matches
				else
					from
						l_lower_text := a_text.as_lower
						tok := s.as_lower
						tok_len := tok.count
						i := 1
					until
						i = 0 or Result
					loop
						i := l_lower_text.substring_index (tok, i)
						if i > 0 then
							Result := True
							if i > 1 then
									-- Check lower boundary
								c := l_lower_text [i - 1]
								if c.is_alpha_numeric then
									Result := False
								end
							end
							if Result and i + tok_len <= l_lower_text.count then
									-- Check lower boundary
								c := l_lower_text [i + tok_len]
								if c.is_alpha_numeric then
									Result := False
								end
							end
							if not Result then
								i := i + 1
							end
						end
					end
				end
			end
		end

	score_for_name (obj: IRON_NODE_VERSION_PACKAGE; s: READABLE_STRING_GENERAL): REAL
		do
			Result := if meet_text (obj.identifier, s) then 1.0 else 0.0 end
		end

	score_for_title (obj: IRON_NODE_VERSION_PACKAGE; s: READABLE_STRING_GENERAL): REAL
		do
			Result := if meet_text (obj.title, s) then 1.0 else 0.0 end
		end

	score_for_description (obj: IRON_NODE_VERSION_PACKAGE; s: READABLE_STRING_GENERAL): REAL
		do
			Result := if meet_text (obj.description, s) then 1.0 else 0.0 end
		end

	score_for_tag (obj: IRON_NODE_VERSION_PACKAGE; s: READABLE_STRING_GENERAL): REAL
		do
			if attached obj.tags as l_tags then
				if across l_tags as ic some meet_text (ic.item, s) end then
					Result := 1.0
				end
			end
		end

	score_for_owner (obj: IRON_NODE_VERSION_PACKAGE; s: READABLE_STRING_GENERAL): REAL
		do
			if attached obj.owner as o then
				Result := if meet_text (o.name, s) then 1.0 else 0.0 end
			end
		end

	score_for_downloads (obj: IRON_NODE_VERSION_PACKAGE; s: READABLE_STRING_GENERAL): REAL
		local
			i: INTEGER
		do
			if s.is_integer then
				i := s.to_integer
				Result := if obj.download_count >= i then 1.0 else 0.0 end
			end
		end

	score_for_text (obj: IRON_NODE_VERSION_PACKAGE; s: READABLE_STRING_GENERAL): REAL
		do
			Result :=  score_for_name (obj, s) * score_weight_for_name
					+ score_for_title (obj, s) * score_weight_for_title
					+ score_for_tag (obj, s) * score_weight_for_tag
--					+ score_for_description (obj, s) * score_weight_for_description
		end

	score_weight_for_name: REAL = 0.25
	score_weight_for_title: REAL = 0.2
	score_weight_for_tag: REAL = 0.20
	score_weight_for_description: REAL = 0.15
	score_weight_for_owner: REAL = 0.1
	score_weight_for_downloads: REAL = 0.1
	score_weight_for_text: REAL
		do
			Result := score_weight_for_name + score_weight_for_title + score_weight_for_tag --+ score_weight_for_description
		end

	version_package_criteria_factory: SCORER_CRITERIA_FACTORY [IRON_NODE_VERSION_PACKAGE]
		once
			create Result.make

			Result.register_builder ("name", agent (n,v: READABLE_STRING_GENERAL): detachable SCORER_CRITERIA [IRON_NODE_VERSION_PACKAGE]
					local
						s: STRING_32
					do
						create s.make_from_string_general (n)
						s.append_character (':')
						s.append_string_general (v)
						create {SCORER_CRITERIA_AGENT [IRON_NODE_VERSION_PACKAGE]} Result.make (s, score_weight_for_name, agent score_for_name (?, v))
					end
				)
			Result.register_builder ("title", agent (n,v: READABLE_STRING_GENERAL): detachable SCORER_CRITERIA [IRON_NODE_VERSION_PACKAGE]
					local
						s: STRING_32
					do
						create s.make_from_string_general (n)
						s.append_character (':')
						s.append_string_general (v)
						create {SCORER_CRITERIA_AGENT [IRON_NODE_VERSION_PACKAGE]} Result.make (s, score_weight_for_title, agent score_for_title (?, v))
					end
				)
			Result.register_builder ("tag", agent (n,v: READABLE_STRING_GENERAL): detachable SCORER_CRITERIA [IRON_NODE_VERSION_PACKAGE]
					local
						s: STRING_32
					do
						create s.make_from_string_general (n)
						s.append_character (':')
						s.append_string_general (v)
						create {SCORER_CRITERIA_AGENT [IRON_NODE_VERSION_PACKAGE]} Result.make (s, score_weight_for_tag, agent score_for_tag (?, v))
					end
				)
			Result.register_builder ("description", agent (n,v: READABLE_STRING_GENERAL): detachable SCORER_CRITERIA [IRON_NODE_VERSION_PACKAGE]
					local
						s: STRING_32
					do
						create s.make_from_string_general (n)
						s.append_character (':')
						s.append_string_general (v)
						create {SCORER_CRITERIA_AGENT [IRON_NODE_VERSION_PACKAGE]} Result.make (s, score_weight_for_description, agent score_for_description (?, v))
					end
				)
			Result.register_builder ("owner", agent (n,v: READABLE_STRING_GENERAL): detachable SCORER_CRITERIA [IRON_NODE_VERSION_PACKAGE]
					local
						s: STRING_32
					do
						create s.make_from_string_general (n)
						s.append_character (':')
						s.append_string_general (v)
						create {SCORER_CRITERIA_AGENT [IRON_NODE_VERSION_PACKAGE]} Result.make (s, score_weight_for_owner, agent score_for_owner (?, v))
					end
				)
			Result.register_builder ("downloads", agent (n,v: READABLE_STRING_GENERAL): detachable SCORER_CRITERIA [IRON_NODE_VERSION_PACKAGE]
					local
						s: STRING_32
					do
						create s.make_from_string_general (n)
						s.append_character (':')
						s.append_string_general (v)
						create {SCORER_CRITERIA_AGENT [IRON_NODE_VERSION_PACKAGE]} Result.make (s, score_weight_for_downloads, agent score_for_downloads (?, v))
					end
				)
			Result.register_builder ("text", agent (n,v: READABLE_STRING_GENERAL): detachable SCORER_CRITERIA [IRON_NODE_VERSION_PACKAGE]
					local
						s: STRING_32
					do
						create s.make_from_string_general (n)
						s.append_character (':')
						s.append_string_general (v)
						create {SCORER_CRITERIA_AGENT [IRON_NODE_VERSION_PACKAGE]} Result.make (s, score_weight_for_text, agent score_for_text (?, v))
					end
				)

			Result.register_default_builder ("text")
			Result.set_builder_description ("text", "text:abc - equivalent to %"name:abc or title:abc or tag:abc%"")

			Result.set_builder_description ("name", "name:foo* - packages of short name matching %"foo*%" pattern")
			Result.set_builder_description ("title", "title:base - packages of title %"base%"")
			Result.set_builder_description ("description", "description:%"advanced usage%" - packages with phrase %"advanced usage%" in their description")
			Result.set_builder_description ("tag", "tag:web - packages tagged %"web%"")
			Result.set_builder_description ("owner", "owner:*Caesar - packages published by users with the user names matching %"*Caesar%"")
			Result.set_builder_description ("downloads", "downloads:10 - packages with at least 10 downloads")
		end

	version_package_criteria_factory_description: STRING_32
		once
			Result := version_package_criteria_factory.description
				+ "Criteria %"name%", %"title%", %"tag%" and %"description%" supports wildcards (*,?).%N"
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
			deleted: version_package (a_package.version, old a_package.id) = Void
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
