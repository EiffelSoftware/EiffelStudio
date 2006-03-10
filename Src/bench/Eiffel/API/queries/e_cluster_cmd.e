indexing
	description:
		"General notion of an eiffel query command (semantic unity)%
		%for a cluster. Display output for current command for%
		%associated cluster to output_window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	E_CLUSTER_CMD

inherit
	E_OUTPUT_CMD
		rename
			make as cmd_make
		export
			{NONE} cmd_make
		redefine
			executable, execute
		end

feature -- Initialization

	make (a_cluster: CLUSTER_I) is
			-- Make current command with current_cluster as
			-- `a_cluster'.
		require
			valid_a_cluster_i: a_cluster /= Void
		do
			current_cluster := a_cluster
			create text_formatter.make
		ensure
			cluster_set: current_cluster = a_cluster
			text_formatter_exists: text_formatter /= Void
		end

feature -- Property

	current_cluster: CLUSTER_I
			-- Class for current action

	executable: BOOLEAN is
			-- Is the Current able to be executed?
		do
			Result := current_cluster /= Void and then
				text_formatter /= Void
		ensure then
			good_result: Result implies current_cluster /= Void
		end

feature -- Execution

	execute is
			-- Execute the current command. Add a before and after
			-- declaration to `text_formatter'
			-- and invoke `work'.
		do
			text_formatter.add (ti_Before_cluster_declaration)
			work
			text_formatter.finish
			text_formatter.add (ti_After_cluster_declaration)
		end

	work is
			-- Perform the command only.
		deferred
		end

feature {NONE} -- Implementation

	sorted_list (list: LINKED_LIST [CLASS_C]): SORTED_TWO_WAY_LIST [CLASS_I] is
			-- Sorted `list' based on `class_name' from `CLASS_I'
		require
			valid_list: list /= Void
		do
			create Result.make
			from
				list.start
			until
				list.after
			loop
				Result.put_front (list.item.lace_class)
				list.forth
			end
			Result.sort
		ensure
			valid_Result: Result /= Void
			sorted: Result.sorted
		end
--| FIXME
--| christophe, 1 dec 1999
--| Is this feature useful? It has been copied from E_CLASS_CMD.

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

end -- class E_CLUSTER_CMD
