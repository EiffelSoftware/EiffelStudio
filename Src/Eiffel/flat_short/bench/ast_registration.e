indexing

	description:
		"Abstract class for registering AST structures."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class AST_REGISTRATION

feature -- Properties

	class_ast: CLASS_AS;
			-- Class AST being registered

feature {AST_EIFFEL} -- Element change

	register_class (a_class: CLASS_AS) is
			-- Register class `a_class'
		require
			a_class_not_void: a_class /= Void
		local
			l_clauses: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			l_fc: FEATURE_CLAUSE_AS
			l_count: INTEGER
			i: INTEGER
		do
			l_clauses := a_class.features
			if l_clauses /= Void then
				l_count := l_clauses.count;
				i := 1
				from
				until
					i > l_count
				loop
					l_fc := l_clauses.i_th (i)
						-- Register all the features.
					register_features_of_clause (l_fc)
						-- Now Register feature clause.
					register_feature_clause (l_fc)
					i := i + 1
				end
			end
			if a_class.invariant_part /= Void then
				register_invariant (a_class.invariant_part)
			end
		end

	register_features_of_clause (a_clause: FEATURE_CLAUSE_AS) is
			-- Register features in `ast_reg'.
		require
			a_clause_not_void: a_clause /= Void
		local
			l_features: EIFFEL_LIST [FEATURE_AS]
			i, l_count: INTEGER
		do
			l_features := a_clause.features
			i := 1
			l_count := l_features.count
			from
			until
				i > l_count
			loop
				register_feature (l_features.i_th (i))
				i := i + 1
			end
		end

	register_feature (feature_as: FEATURE_AS) is
			-- Register feature `feature_as'.
		require
			valid_feature_as: feature_as /= Void
		deferred
		end;

	register_feature_clause (feature_clause: FEATURE_CLAUSE_AS) is
			-- Register feature_clause `feature_clause' after registering
            -- features.
		require
			valid_feature_clause: feature_clause /= Void
		deferred
		end;

	register_invariant (invariant_part: INVARIANT_AS) is
			-- Register invariant `invariant_part'.
		require
			valid_invariant: invariant_part /= Void
		deferred
		end;

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

end -- class AST_REGISTRATION
