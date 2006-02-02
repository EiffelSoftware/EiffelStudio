indexing
	description: "AST representation of a feature clause structure."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FEATURE_CLAUSE_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (c: like clients; f: like features; l: like feature_keyword; ep: INTEGER) is
			-- Create a new FEATURE_CLAUSE AST node.
		require
			f_not_void: f /= Void
			l_not_void: l /= Void
		do
			clients := c
			features := f
			feature_keyword := l
			feature_clause_end_position := ep - 1
		ensure
			clients_set: clients = c
			features_set: features = f
			feature_keyword_set: feature_keyword = l
			feature_clause_end_position_set: feature_clause_end_position = ep - 1
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_feature_clause_as (Current)
		end

feature -- Roundtrip

	feature_clause_end_position: INTEGER

feature -- Attributes

	feature_keyword: KEYWORD_AS
			-- Position after `feature' keyword.

	clients: CLIENT_AS
			-- Client list

	features: EIFFEL_LIST [FEATURE_AS]
			-- Features

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- First token in current AST node
		do
			Result := feature_keyword.first_token (a_list)
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- Last token in current AST node
		do
			if a_list /= Void then
				Result := a_list.item_by_end_position (feature_clause_end_position)
			end
			if Result = Void or a_list = Void then
				if not features.is_empty then
					Result := features.last_token (a_list)
				elseif clients /= Void then
					Result := clients.last_token (a_list)
				else
					Result := feature_keyword.last_token (a_list)
				end
			end
		end

feature -- Roundtrip/Comments

	comment (a_list: LEAF_AS_LIST): EIFFEL_COMMENTS is
			-- First line of comments on `Current'
		require
			a_list_not_void: a_list /= Void
		local
			l_end_index: INTEGER
			l_leaf: LEAF_AS
		do
			if features = Void or else features.is_empty then
				l_leaf := a_list.item_by_end_position (feature_clause_end_position)
				check l_leaf /= Void end
				l_end_index := l_leaf.index
			else
				l_end_index := features.first_token (a_list).index - 1
			end
			check first_token (a_list).index + 1 <= l_end_index end
			Result := a_list.extract_comment (create{ERT_TOKEN_REGION}.make (first_token (a_list).index + 1, l_end_index))
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (clients, other.clients) and
				equivalent (features, other.features)
		end

feature -- Access

	feature_with_name (n: STRING): FEATURE_AS is
			-- Feature ast with internal name `n'
		local
			saved: INTEGER
		do
			saved := features.index
			from
				features.start
			until
				features.after or else Result /= Void
			loop
				Result := features.item.feature_with_name (n)
				features.forth
			end
			features.go_i_th (saved)
		end

	has_feature (f: FEATURE_AS): BOOLEAN is
			-- Does `f' appear in current feature clause?
			--| Based on `object_comparison' of EIFFEL_LIST,
			--| which is a reference comparison.
		local
			saved: INTEGER
			name: ID_AS
		do
			saved := features.index
			name := f.feature_name
			from
				features.start
			until
				features.after
			loop
				if features.item.feature_name.is_equal (name) then
					Result := True
					features.finish
				end
				features.forth
			end
			features.go_i_th (saved)
		end

	has_feature_name (n: FEATURE_NAME): BOOLEAN is
			-- Does `n' appear in current feature clause?
		local
			saved: INTEGER
		do
			saved := features.index
			from
				features.start
			until
				features.after or else Result
			loop
				Result := features.item.has_feature_name (n)
				features.forth
			end
			features.go_i_th (saved)
		end

	has_same_clients (other: like Current): BOOLEAN is
			-- Does this feature clause have the same clients
			-- as `other' feature clause?
		do
			Result := clients = Void and other.clients = Void

			if not Result then
				if clients /= Void then
					if other.clients /= Void then
						Result := clients.is_equiv (other.clients)
					else
						Result := False
					end
				end
			end
		end

	has_equiv_declaration (other: like Current): BOOLEAN is
			-- Has this feature clause a declaration equivalent to `other'
			-- feature clause? i.e. `feature {CLIENTS}'
			--| NB: The comments are NOT considered for the moment, since
			--| comments are not an attribute, but are to be retrieved from
			--| the file that contains the source code.
		do
			if other = Void then
				Result := False
			else
				Result := has_same_clients (other)
					--| To be fixed to take comments into account
			end
		end

	is_equiv (other: like Current): BOOLEAN is
			-- Is `other' feature clause equivalent to Current?
		require
			valid_other: other /= Void
		do
			Result :=
				equivalent (clients, other.clients) and then
				equivalent (features, other.features)
		end

feature -- Update

	assign_unique_values (counter: COUNTER; values: HASH_TABLE [INTEGER, STRING]) is
			-- Assign values to Unique features defined in the current class
		do
			from
				features.start
			until
				features.after
			loop
				features.item.assign_unique_values (counter, values)
				features.forth
			end
		end

feature {COMPILER_EXPORTER} -- Setting

	set_features (f: like features) is
			-- Set `features' to `f'
		do
			features := f
		end

	set_clients (c: like clients) is
			-- Set `clients' to `c'
		do
			clients := c
		end

invariant
	features_not_void: features /= Void
	feature_location_not_void: feature_keyword /= Void

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

end -- class FEATURE_CLAUSE_AS
