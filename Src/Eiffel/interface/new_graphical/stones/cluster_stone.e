﻿note
	description: "[
		Stone representing a group.
		
		Warning: it could be a cluster, a library, ...
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	CLUSTER_STONE

inherit
	SHARED_EIFFEL_PROJECT

	STONE
		redefine
			is_valid,
			synchronized_stone,
			same_as,
			stone_name
		end

	EB_SHARED_ID_SOLUTION
		export
			{NONE} all
		end

create
	make,
	make_subfolder

feature {NONE} -- Initialization

	make (clu: CONF_GROUP)
		require
			valid_cluster: clu /= Void
		do
			group := clu
			create {STRING_32} path.make_empty
		ensure
			group_set: group = clu
		end

	make_subfolder (clu: CONF_GROUP; a_path: READABLE_STRING_GENERAL; a_name: detachable READABLE_STRING_GENERAL)
			-- Create for a subfolder `path' of `clu'.
		require
			valid_cluster: clu /= Void
			valid_path: a_path /= Void
			path_implies_recursive_cluster: not a_path.is_empty implies is_recursive_cluster (clu)
		do
			group := clu
			path := a_path.as_string_32
			if a_name /= Void then
				folder_name := a_name.as_string_32
			else
				folder_name := Void
			end
		ensure
			group_set: group = clu
			path_set: path.same_string_general (a_path)
			folder_name_unset: a_name = Void implies folder_name = Void
			folder_name_set: a_name /= Void implies attached folder_name as l_name and then l_name.same_string_general (a_name)
		end

feature -- Access

	cluster_i: CLUSTER_I
		require
			is_cluster: is_cluster
		do
			if attached {CLUSTER_I} group as r then
				Result := r
			else
				check
					from_precondition: False
				end
			end
		ensure
			cluster_i_not_void: Result /= Void
		end

	group: CONF_GROUP
			-- Underlying group for the stone.

	path: STRING_32
			-- Subfolder path in Unix format eg "/test/a/b"

	folder_name: STRING_32
			-- Subfolder name

	stone_signature: STRING_32
		do
			create Result.make_from_string (group.name)
		end

	header: STRING_GENERAL
		do
			Result := Interface_names.l_cluster_header (eiffel_system.name,
															eiffel_universe.target_name,
															stone_signature,
															group.location.evaluated_path.name)
		end

	history_name: STRING_32
			-- What represents `Current' in the history.
		do
			Result := {STRING_32} "[" + stone_signature + {STRING_32} "]"
		end

	stone_cursor: EV_POINTER_STYLE
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := Cursors.cur_Cluster
			if group.is_cluster then
				-- Already set.
			elseif group.is_library then
				Result := cursors.cur_library
			elseif group.is_assembly then
				Result := cursors.cur_assembly
			end
		ensure then
			result_attached: Result /= Void
		end

	x_stone_cursor: EV_POINTER_STYLE
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			Result := Cursors.cur_x_cluster
			if group.is_cluster then
				-- Already set.
			elseif group.is_library then
				Result := cursors.cur_x_library
			elseif group.is_assembly then
				Result := cursors.cur_x_assembly
			end
		ensure then
			result_attached: Result /= Void
		end

 	synchronized_stone: detachable STONE
 			-- Return a valid stone representing the same object after a recompilation.
 		local
 			l_group: like group
 		do
 			if is_valid then
 				Result := Current
 			else
 				if group /= Void then
 						-- Try to find a equivalent valid group.
 					l_group := group_of_id (id_of_group (group))
 					if l_group /= Void then
 						check
 							l_group_valid: l_group.is_valid
 						end
		 				if path /= Void then
		 					create {CLUSTER_STONE} Result.make_subfolder (l_group, path, folder_name)
		 				else
		 					create {CLUSTER_STONE} Result.make (l_group)
		 				end
 					end
 				end
 			end
 		end

	stone_name: READABLE_STRING_32
			-- Name of Current stone.
		do
			if is_valid then
				create {STRING_32} Result.make_from_string
					(if not path.is_empty and then attached folder_name as n then
							-- For a folder.
						n
					else
							-- For a group.
						group.name
					end)
			else
				Result := Precursor
			end
		end

feature -- Status report

 	same_as (other: STONE): BOOLEAN
 			-- Does `other' and `Current' represent the same cluster?
 		do
 			Result := attached {CLUSTER_STONE} other as conv_clu and then conv_clu.group = group
 		end

	is_cluster: BOOLEAN
			-- Does current represent an instance of CLUSTER_I?
		do
			Result := attached {CLUSTER_I} group
		end

 	is_valid: BOOLEAN
 			-- Does `Current' represent a valid cluster?
 		do
 			if Eiffel_project.initialized and then group /= Void then
 				Result := group.is_valid
 			end
 		end

feature {NONE} -- Implementation

	is_recursive_cluster (a_group: CONF_GROUP): BOOLEAN
			-- Is `a_grp' a recursive cluster?
		require
			a_group_not_void: a_group /= Void
		do
			if attached {CONF_CLUSTER} a_group as c then
				Result := c.is_recursive
			end
		end

invariant
	group_not_void: group /= Void
	path_not_void: path /= Void

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
