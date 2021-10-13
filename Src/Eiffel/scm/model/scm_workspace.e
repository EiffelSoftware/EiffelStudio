note
	description: "Summary description for {SCM_WORKSPACE}."
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_WORKSPACE

inherit
	LIBRARY_INDEXER_OBSERVER
		redefine
			on_cluster,
			on_library
		end

create
	make_with_target

feature {NONE} -- Initialization

	make_with_target (a_target: CONF_TARGET)
		do
			target := a_target
			location := a_target.system.directory.absolute_path.canonical_path
			create locations.make_equal (0)
			create locations_by_root.make_equal (0)
			create change_actions
		end

feature -- Access

	target: CONF_TARGET

	location: PATH

	inside_directory: detachable PATH

feature -- Status

	is_included (loc: PATH): BOOLEAN
		do
			if attached inside_directory as d then
				Result := loc.absolute_path.canonical_path.name.starts_with (d.name)
			else
				Result := True
			end
		end

feature -- Access

	locations: STRING_TABLE [SCM_GROUP]
			-- Location groups indexed by group's name

	locations_by_root: HASH_TABLE [TUPLE [root: SCM_LOCATION; groups: STRING_TABLE [SCM_GROUP]], PATH]
		-- List of location groups indexed by root location path.

	sorted_locations: ARRAYED_LIST [TUPLE [name: READABLE_STRING_GENERAL; group: SCM_GROUP]]
		local
			l_sorter: QUICK_SORTER [TUPLE [name: READABLE_STRING_GENERAL; group: SCM_GROUP]]
		do
			create Result.make (locations.count)
			across
				locations as ic
			loop
				Result.force ([ic.key, ic.item])
			end
			create l_sorter.make (create {AGENT_EQUALITY_TESTER [TUPLE [name: READABLE_STRING_GENERAL; group: SCM_GROUP]]}.make (agent (d1,d2: TUPLE [name: READABLE_STRING_GENERAL; group: SCM_GROUP]): BOOLEAN
						-- Is `d1` less than `d2` ?
					local
						p1,p2: PATH
						l_continue: BOOLEAN
					do
						if d1.group.generating_type = d2.group.generating_type then
							l_continue := True
						elseif attached {SCM_DIRECTORY} d1.group then
							Result := True -- can be cluster or lib
						elseif attached {SCM_CLUSTER} d1.group then
								-- d2.group can not be a cluster
								-- it can be either dir or lib
								--   if a dir, then d1 is greater
								--   if a lib, then d1 is less
							Result := not attached {SCM_DIRECTORY} d2.group
						else
							check attached {SCM_LIBRARY} d1.group end
							if attached {SCM_LIBRARY} d2.group then
								l_continue := True
							else
								Result := False
							end
						end
						if l_continue then
							p1 := d1.group.location
							p2 := d2.group.location
							if p1.same_as (p2) then
								Result := d1.name < d2.name
							else
								Result := p1 < p2
							end
						end
					end))
			l_sorter.sort (Result)
		end

	scm_root (loc: detachable PATH): detachable SCM_LOCATION
		local
			p: PATH
			l_git_fn: PATH
			l_svn_fn: PATH
			fut: FILE_UTILITIES
		do
			if loc /= Void then
				l_git_fn := loc.extended (".git")
				if fut.directory_path_exists (l_git_fn) then
					create {SCM_GIT_LOCATION} Result.make (loc)
				else
					l_svn_fn := loc.extended (".svn")
					if fut.directory_path_exists (l_svn_fn) then
						create {SCM_SVN_LOCATION} Result.make (loc)
					else
						p := loc.parent
						if p.same_as (loc) then
								-- Reach bottom
						else
							Result := scm_root (p)
						end
					end
				end
			end
		end

feature -- Event

	change_actions: ACTION_SEQUENCE

feature -- Element change

	limit_to_inside_directory (loc: detachable PATH)
		do
			if loc = Void then
				inside_directory := Void
			else
				inside_directory := loc.absolute_path.canonical_path
			end
		end

	limit_to_application_location
		do
			limit_to_inside_directory (target.system.directory)
		end

	restore (a_other: SCM_WORKSPACE)
		local
			grp: SCM_GROUP
		do
			across
				locations as ic
			loop
				grp := ic.item
				if
				 	attached a_other.locations [grp.name] as l_other_group and then
				 	not l_other_group.is_default_state
				then
					if l_other_group.is_included then
						grp.include
					else
						grp.exclude
					end
				end
			end
		end

feature -- Analyze

	analyze
		local
			idx: TARGET_INDEXER
			obs: LIBRARY_INDEXER_OBSERVER
			lst: ARRAYED_LIST [SCM_GROUP]
			l_groups: STRING_TABLE [SCM_GROUP]
			g: SCM_GROUP
		do
			create idx.make (Void)
			idx.set_is_stopping_at_library (False)
			idx.set_is_stopping_at_readonly_library (True)
			idx.set_is_indexing_class (False)
			idx.set_is_visiting_same_ecf_library_once (True)
			obs := Current
			idx.register_observer (obs)

			locations.wipe_out
			locations_by_root.wipe_out

			if attached scm_root (location) as r then
				record_group (create {SCM_DIRECTORY}.make ("Root directory", location, r))
			end

			idx.visit_target (target)
			idx.reset

			across
				locations_by_root as ic
			loop
				if attached ic.item as l_data then
					l_groups := l_data.groups
					create lst.make (0)
					across
						l_groups as g_ic
					loop
						g := g_ic.item
						if across l_groups as gg some g /= gg.item and then gg.item.is_parent_of (g) end then
							lst.force (g)
						end
					end

					across
						lst as g_ic
					loop
						l_groups.start
						l_groups.prune_all (g_ic.item)
					end
				end
			end
		end

feature {NONE} -- Implementation		

	record_group (g: SCM_GROUP)
		local
			l_root_dirname: PATH
			l_data: TUPLE [root: SCM_LOCATION; groups: STRING_TABLE [SCM_GROUP]]
			tb: STRING_TABLE [SCM_GROUP]
		do
			locations[g.name] := g

			l_root_dirname := g.root.location
			l_data := locations_by_root [l_root_dirname]
			if l_data = Void then
				create tb.make_equal (1)
				locations_by_root [l_root_dirname] := [g.root, tb]
			else
				tb := l_data.groups
			end
			tb [g.name] := g
			g.record_default_state
		end

feature -- Visitor

	on_cluster (clu: CONF_CLUSTER)
		do
			Precursor (clu)
			if
				attached clu.location.evaluated_path as p and then
				is_included (p) and then
				attached scm_root (p) as r
			then
				record_group (create {SCM_CLUSTER}.make (clu.name, p, r))
			end
		end

	on_library (lib: CONF_LIBRARY)
		local
			l_scm_lib: SCM_LIBRARY
		do
			Precursor (lib)
			if
				attached lib.location.evaluated_path as p and then
				is_included (p) and then
				attached scm_root (p) as r
			then
				create l_scm_lib.make (lib.name, p.parent, r)
				if lib.is_readonly then
					l_scm_lib.set_is_readonly (True)
					l_scm_lib.exclude
				end
				record_group (l_scm_lib)
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
