indexing
	description: "Stone representing a cluster"
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
			same_as
		end

	CONF_REFACTORING

create
	make

feature {NONE} -- Initialization

	make (clu: CONF_GROUP) is
		require
			valid_cluster: clu /= Void
		do
			group := clu
		ensure
			group_set: group = clu
		end

feature -- Access

	cluster_i: CLUSTER_I is
		require
			is_cluster: is_cluster
		do
			conf_todo_msg ("[
				There is nothing to be done here, what needs to be done is checking all callers that
			 	they can call this routine.
			  ]")
			Result ?= group
		ensure
			cluster_i_not_void: cluster_i /= Void
		end

	group: CONF_GROUP
			-- Underlying group for the stone.

	stone_signature: STRING is
		do
			Result := group.name.twin
		end

	header: STRING is
		do
			Result := history_name + Interface_names.l_Located_in + group.location.evaluated_path
		end

	history_name: STRING is
			-- What represents `Current' in the history.
		do
			Result := Interface_names.s_Cluster_stone + stone_signature
		end

	stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := Cursors.cur_Cluster
		end

	x_stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			Result := Cursors.cur_X_cluster
		end

 	is_valid: BOOLEAN is
 			-- Does `Current' represent a valid cluster?
 		do
 			if Eiffel_project.initialized and then group /= Void then
 				Result := group.is_valid
 			end
 		end

 	synchronized_stone: STONE is
 			-- Return a valid stone representing the same object after a recompilation.
 		do
 			if is_valid then
 				Result := Current
 			else
 				Result := Void
 			end
 		end

 	same_as (other: STONE): BOOLEAN is
 			-- Does `other' and `Current' represent the same cluster?
 		local
 			conv_clu: CLUSTER_STONE
 		do
 			conv_clu ?= other
 			Result := conv_clu /= Void and then conv_clu.group = group
 		end

	is_cluster: BOOLEAN is
			-- Does current represent an instance of CLUSTER_I?
		local
			l_clus: CLUSTER_I
		do
			l_clus ?= group
			Result := l_clus /= Void
		end

invariant
	group_not_void: group /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CLUSTER_STONE
