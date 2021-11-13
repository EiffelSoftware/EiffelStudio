note
	description: "Object that represents a rename inherit clause"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RENAME_CLAUSE_AS

inherit
	INHERIT_CLAUSE_AS [EIFFEL_LIST [RENAME_AS]]
		rename
			clause_keyword as rename_keyword,
			clause_keyword_index as rename_keyword_index
		end

create
	make

feature -- Visitor

	process (v: AST_VISITOR)
			-- Visitor feature.
		do
			v.process_rename_clause_as (Current)
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Output

	dump: STRING
			-- Output as STRING.
		do
			Result := "rename "
			from
				content.start
			until
				content.after
			loop
				Result.append (content.item.old_name.feature_name.name + " as " + content.item.new_name.feature_name.name)
				content.forth
				if not content.after then
					Result.append (", ")
				end
			end
			Result.append (" end")
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Access

	new_names (a_original_name: STRING): detachable LIST [STRING]
			-- Computes list of new names of `a_original_name' if any or Void
			--
			-- `a_original_name': Old name of a feature for which the list of new names will be computed.
		require
			a_original_name_not_void: a_original_name /= Void
		do
			if content /= Void and then not content.is_empty then
				create {LINKED_LIST [STRING]} Result.make
				from
					content.start
				until
					content.after
				loop
					if
						content.item.old_name.feature_name.name.is_equal (a_original_name)
					then
						Result.extend (content.item.new_name.feature_name.name)
					end
					content.forth
				end
			end
			if Result /= Void and then Result.is_empty then
				Result := Void
			end
		ensure
			result_not_void_implies_not_empty: Result /= Void implies not Result.is_empty
		end

	original_names (a_new_name: STRING): detachable LIST [STRING]
			-- Computes list of original names for `a_new_name' if any or Void
			--
			-- `a_new_name': New name for which a list of old/original names will be computed.
		require
			a_new_name_not_void: a_new_name /= Void
		do
			if content /= Void and then not content.is_empty then
				create {LINKED_LIST [STRING]} Result.make
				from
					content.start
				until
					content.after
				loop
					if
						content.item.new_name.feature_name.name.is_equal (a_new_name)
					then
						Result.extend (content.item.old_name.feature_name.name)
					end
					content.forth
				end
				if Result.is_empty then
					Result := Void
				end
			end
		ensure
			result_not_void_implies_not_empty: Result /= Void implies not Result.is_empty
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
