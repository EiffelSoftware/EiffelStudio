note
	legal: "See notice at end of class."
	status: "See notice at end of class."

class CREATE_AS

inherit
	AST_EIFFEL

create
	initialize

feature {NONE} -- Initialization

	initialize (c: like clients; f: like feature_list; c_as: like create_creation_keyword)
			-- Create a new CREATION clause AST node.
		do
			clients := c
			feature_list := f
			if c_as /= Void then
				create_creation_keyword_index := c_as.index
			end
		ensure
			clients_set: clients = c
			feature_list_set: feature_list = f
			create_creation_keyword_set: c_as /= Void implies create_creation_keyword_index = c_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- Process current element.
		do
			v.process_create_as (Current)
		end

feature -- Roundtrip

	create_creation_keyword_index: INTEGER
			-- Index of keyword "create" or "creation" associated with this structure.

	create_creation_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "create" or "creation" associated with this structure.
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, create_creation_keyword_index)
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := create_creation_keyword_index
		end

feature -- Attributes

	clients: detachable CLIENT_AS
			-- Client list.

	feature_list: detachable EIFFEL_LIST [FEATURE_NAME]
			-- Feature list.

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list /= Void and create_creation_keyword_index /= 0 then
				Result := create_creation_keyword (a_list)
			elseif attached clients as l_clients then
				Result := l_clients.first_token (a_list)
			elseif attached feature_list as l_feature_list then
				Result := l_feature_list.first_token (a_list)
			else
				Result := Void
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if attached feature_list as l_feature_list then
				Result := l_feature_list.last_token (a_list)
			elseif attached clients as l_clients then
				Result := l_clients.last_token (a_list)
			elseif a_list /= Void and create_creation_keyword_index /= 0 then
				Result := create_creation_keyword (a_list)
			else
				Result := Void
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object?
		do
			Result := equivalent (clients, other.clients) and
				equivalent (feature_list, other.feature_list)
		end

feature -- Access

	has_feature_name (f: FEATURE_NAME): BOOLEAN
			-- Is `f' present in current creation?
		local
			cur: INTEGER
		do
			if attached feature_list as l_feature_list then
				cur := l_feature_list.index

				from
					l_feature_list.start
				until
					l_feature_list.after or else Result
				loop
					Result := l_feature_list.item <= f and l_feature_list.item >= f
					l_feature_list.forth
				end

				l_feature_list.go_i_th (cur)
			end
		end

feature {COMPILER_EXPORTER} -- Convenience

	set_feature_list (f: like feature_list)
		do
			feature_list := f
		end

	set_clients (c: like clients)
		do
			clients := c
		end

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
