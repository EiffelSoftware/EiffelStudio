note
	description: "Scopes in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_SHARED_SCOPES

feature -- Scopes

	quantity_scope: QL_QUANTITY_SCOPE
			-- Quantity scope
		once
			create Result.make
		ensure
			good_result: Result /= Void
		end

	target_scope: QL_TARGET_SCOPE
			-- Target scope
		once
			create Result.make
		ensure
			good_result: Result /= Void
		end

	group_scope: QL_GROUP_SCOPE
			-- Group scope
		once
			create Result.make
		ensure
			good_result: Result /= Void
		end

	class_scope: QL_CLASS_SCOPE
			-- Class scope
		once
			create Result.make
		ensure
			good_result: Result /= Void
		end

	feature_scope: QL_FEATURE_SCOPE
			-- Feature scope
		once
			create Result.make
		ensure
			good_result: Result /= Void
		end

	line_scope: QL_LINE_SCOPE
			-- Line scope
		once
			create Result.make
		ensure
			good_result: Result /= Void
		end

	generic_scope: QL_GENERIC_SCOPE
			-- Class generic scope
		once
			create Result.make
		ensure
			good_result: Result /= Void
		end

	local_scope: QL_LOCAL_SCOPE
			-- Feature local variable scope
		once
			create Result.make
		ensure
			good_result: Result /= Void
		end

	argument_scope: QL_ARGUMENT_SCOPE
			-- Feature argument scope
		once
			create Result.make
		ensure
			good_result: Result /= Void
		end

	assertion_scope: QL_ASSERTION_SCOPE
			-- Assertion scope
		once
			create Result.make
		ensure
			good_result: Result /= Void
		end

	scopes: LIST [QL_SCOPE]
			-- List of all supported scopes
		once
			create {ARRAYED_LIST [QL_SCOPE]} Result.make (10)
			Result.extend (target_scope)
			Result.extend (group_scope)
			Result.extend (class_scope)
			Result.extend (generic_scope)
			Result.extend (feature_scope)
			Result.extend (local_scope)
			Result.extend (argument_scope)
			Result.extend (line_scope)
			Result.extend (assertion_scope)
			Result.extend (quantity_scope)
		ensure
			result_attached: Result /= Void
		end

	scope_table: HASH_TABLE [QL_SCOPE, STRING]
			-- Table of all supported scopes
		local
			l_scopes: like scopes
		once
			create Result.make (10)
			l_scopes := scopes
			from
				l_scopes.start
			until
				l_scopes.after
			loop
				Result.put (l_scopes.item, l_scopes.item.name)
				l_scopes.forth
			end
		end

note
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
