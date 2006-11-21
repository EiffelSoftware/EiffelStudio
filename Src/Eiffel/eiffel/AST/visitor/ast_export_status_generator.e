indexing
	description: "Compute export status of a feature clause or an export clause"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_EXPORT_STATUS_GENERATOR

inherit
	AST_NULL_VISITOR
		redefine
			process_client_as,
			process_feature_clause_as
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	SHARED_EXPORT_STATUS
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

feature -- Status report

	feature_clause_export_status (a_class: CLASS_C; a_clause: FEATURE_CLAUSE_AS): EXPORT_I is
			-- Export status for `a_Client' in `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_clause_not_void: a_clause /= Void
		do
			current_class := a_class
			a_clause.process (Current)
			Result := last_export_status
			reset
		end

	export_status (a_class: CLASS_C; a_client: CLIENT_AS): EXPORT_I is
			-- Export status for `a_Client' in `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_client_not_void: a_client /= Void
		do
			current_class := a_class
			a_client.process (Current)
			Result := last_export_status
			reset
		end

feature {NONE} -- Implementation: Reset

	reset is
		do
			current_class := Void
			last_export_status := Void
		end

feature {NONE} -- Implementation: Access

	current_class: CLASS_C
			-- Class in which analysis is done

	last_export_status: EXPORT_I
			-- Last computed export status

feature {NONE} -- Implementation

	process_client_as (l_as: CLIENT_AS) is
		local
			l_export_set: EXPORT_SET_I
			l_client_i: CLIENT_I
			l_clients: CLASS_LIST_AS
			l_lst: ARRAYED_LIST [STRING]
		do
			if l_as.clients.count = 1 and then ("NONE").is_equal (l_as.clients.first.name) then
			   last_export_status := export_none
			else
				fixme ("temporary fix to get a string list")
				from
					l_clients := l_as.clients
					create l_lst.make (l_clients.count)
					l_clients.start
				until
					l_clients.after
				loop
					l_lst.extend (l_clients.item.name)
					l_clients.forth
				end
				create l_client_i.make (l_lst, current_class.class_id)
				create l_export_set.make
				l_export_set.compare_objects
				l_export_set.put (l_client_i)
				last_export_status := l_export_set
			end
		end

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS) is
		do
			if l_as.clients /= Void then
				l_as.clients.process (Current)
			else
				last_export_status := export_all
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end
