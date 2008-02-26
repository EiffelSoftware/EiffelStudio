indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class CREATE_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (c: like clients; f: like feature_list; c_as: like create_creation_keyword) is
			-- Create a new CREATION clause AST node.
		do
			clients := c
			feature_list := f
			create_creation_keyword := c_as
		ensure
			clients_set: clients = c
			feature_list_set: feature_list = f
			create_creation_keyword_set: create_creation_keyword = c_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_create_as (Current)
		end

feature -- Roundtrip

	create_creation_keyword: KEYWORD_AS
			-- Keyword "create" or "creation" associated with this structure

feature -- Attributes

	clients: CLIENT_AS
			-- Client list

	feature_list: EIFFEL_LIST [FEATURE_NAME]
			-- Feature list

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				if clients /= Void then
					Result := clients.first_token (a_list)
				elseif feature_list /= Void then
					Result := feature_list.first_token (a_list)
				else
					Result := Void
				end
			else
				Result := create_creation_keyword.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if feature_list /= Void then
				Result := feature_list.last_token (a_list)
			elseif clients /= Void then
				Result := clients.last_token (a_list)
			elseif a_list = Void then
					-- Non-roundtrip mode
				Result := Void
			else
					-- Roundtrip mode
				Result := create_creation_keyword.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (clients, other.clients) and
				equivalent (feature_list, other.feature_list)
		end

feature -- Access

	has_feature_name (f: FEATURE_NAME): BOOLEAN is
			-- Is `f' present in current creation?
		local
			cur: INTEGER
		do
			cur := feature_list.index

			from
				feature_list.start
			until
				feature_list.after or else Result
			loop
				Result := feature_list.item <= f and feature_list.item >= f
				feature_list.forth
			end

			feature_list.go_i_th (cur)
		end

feature {COMPILER_EXPORTER} -- Convenience

	set_feature_list (f: like feature_list) is
		do
			feature_list := f
		end

	set_clients (c: like clients) is
		do
			clients := c
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

end -- class CREATE_AS
