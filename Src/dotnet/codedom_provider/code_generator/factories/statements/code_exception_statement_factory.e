indexing
	description: "Code generator for exception statements"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_EXCEPTION_STATEMENT_FACTORY

inherit
	CODE_STATEMENT_FACTORY

feature {CODE_CONSUMER_FACTORY} -- Visitor features.

	generate_try_catch_finally_statement (a_source: SYSTEM_DLL_CODE_TRY_CATCH_FINALLY_STATEMENT) is
			-- | Create instance of `CODE_TRY_CATCH_FINALLY_STATEMENT'.
			-- | And iniatilize this instance with `a_source'
			-- | Set `last_statement'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_catch_clauses: ARRAYED_LIST [CODE_CATCH_CLAUSE]
			l_source_catch_clauses: SYSTEM_DLL_CODE_CATCH_CLAUSE_COLLECTION
			i, l_count: INTEGER
			l_catch_clause: SYSTEM_DLL_CODE_CATCH_CLAUSE
			l_name: STRING
		do
			if current_routine /= Void then
				l_source_catch_clauses := a_source.catch_clauses
				if l_source_catch_clauses /= Void then
					l_count := l_source_catch_clauses.count
					from
						create l_catch_clauses.make (l_count)
					until
						i = l_count
					loop
						l_catch_clause := l_source_catch_clauses.item (i)
						l_catch_clauses.extend (create {CODE_CATCH_CLAUSE}.make (create {CODE_VARIABLE_REFERENCE}.make (l_catch_clause.local_name, Type_reference_factory.type_reference_from_reference (l_catch_clause.catch_exception_type), Type_reference_factory.type_reference_from_code (current_type)), statements_from_collection (l_catch_clause.statements)))
						i := i + 1
					end
				end
				l_name := implementation_feature_name
				current_type.add_implementation_feature (create {CODE_TRY_CATCH_IMPLEMENTATION_FEATURE}.make (l_name, current_routine, l_catch_clauses, statements_from_collection (a_source.try_statements), statements_from_collection (a_source.finally_statements)))
				set_last_statement (create {CODE_TRY_CATCH_FINALLY_STATEMENT}.make (current_routine, l_name))
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_current_routine, ["Try/Catch statement generation in " + current_context])
			end
		ensure
			non_void_last_statement: last_statement /= Void
		end

feature {NONE} -- Implementation

	implementation_feature_name: STRING is
			-- Implementation feature name
		local
			l_features: HASH_TABLE [CODE_FEATURE, STRING]
			l_implementation_features: HASH_TABLE [CODE_TRY_CATCH_IMPLEMENTATION_FEATURE, STRING]
			i: INTEGER
			l_ok: BOOLEAN
		do
			create Result.make (current_feature.eiffel_name.count + 5)
			Result.append ("safe_")
			Result.append (current_feature.eiffel_name)
			l_features := current_type.features
			l_implementation_features := current_type.implementation_features
			from
				l_ok := not l_features.has (Result) and not l_implementation_features.has (Result)
				if not l_ok then
					Result.append ("_2")
					l_ok := not l_features.has (Result) and not l_implementation_features.has (Result)
				end
				i := 3
			until
				l_ok
			loop
				Result.keep_head (Result.last_index_of ('_', Result.count))
				Result.append (i.out)
				i := i + 1
				l_ok := not l_features.has (Result) and not l_implementation_features.has (Result)				
			end
		ensure
			non_void_feature_name: Result /= Void
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


end -- class CODE_EXCEPTION_STATEMENT_FACTORY

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------