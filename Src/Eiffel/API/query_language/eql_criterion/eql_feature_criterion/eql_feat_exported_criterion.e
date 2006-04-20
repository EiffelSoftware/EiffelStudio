indexing
	description: "Criterion to test if a feature is exported to a client set"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_FEAT_EXPORTED_CRI

inherit
	EQL_CRITERION

feature -- Evaluation

	evaluate (a_context: EQL_CONTEXT): BOOLEAN is
		local
			l_feature: E_FEATURE
		do
			if a_context.is_e_feature_set then
				l_feature := a_context.e_feature
				if is_all or (clients = Void or else clients.is_empty) then
					Result := l_feature.export_status.is_all
				elseif is_none then
					Result := l_feature.export_status.is_none
				else
					Result := clients.for_all (agent (l_feature.export_status).is_exported_to)
				end
			end
		end

feature -- Status reporting

	is_none: BOOLEAN
			-- Does `class_c' in `a_context' export to NONE?

	is_all: BOOLEAN
			-- Does `class_c' in `a_context' export to ANY?	

	clients: LIST [CLASS_C]
			-- List of classes to which `class_c' in `a_context' exports			

feature -- Setting

	set_is_none (b: BOOLEAN) is
			-- Set `is_none' with `b'.
		do
			is_none := b
			clients := Void
		ensure
			is_none_set: is_none = b
			clients_set: clients = Void
			not_is_all: is_none implies not is_all
		end

	set_is_all (b: BOOLEAN) is
			-- Set `is_all' with `b'.
		do
			is_all := b
			clients := Void
		ensure
			is_all_set: is_all = b
			clients_set: clients = Void
			not_is_none: is_all implies not is_none
		end

	set_clients (a_clients: like clients) is
			-- Set `clients' with `a_clients'.
		require
			client_set_not_void: a_clients /= Void
		do
		ensure
			clients_set: clients = a_clients
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
