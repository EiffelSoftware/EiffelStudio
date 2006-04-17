indexing
	description: "[
					Object that represents a feature with its clients in an export clause.
					This class is used for roundtrip text modification, not by compiler.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_EXPORT_FEATURE

create
	make

feature{NONE} -- Implementation

	make (a_name: like feature_name; a_clients: like clients) is
			-- Initialize instance.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
			a_clients_not_void: a_clients /= Void
		do
			feature_name := a_name.twin
			clients := a_clients
		ensure
			feature_name_set: feature_name.is_equal (a_name)
			clients_set: clients = a_clients
		end

feature -- Status reporting

	is_all: BOOLEAN is
			-- Does current represent "all" features?
		do
			Result := feature_name.is_case_insensitive_equal (once "all")
		ensure
			Result_set: feature_name.is_case_insensitive_equal (once "all") implies Result
		end

feature -- Access

	feature_name: STRING
			-- Feature name

	clients: ERT_CLIENT_SET
			-- Clients to which `feature_name' is exported

invariant
	feature_name_not_void: feature_name /= Void
	feature_name_not_empty: not feature_name.is_empty
	clients_not_void: clients /= Void

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
