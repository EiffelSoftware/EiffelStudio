indexing
	description: "Shared class relation types"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_SHARED_CLASS_RELATION

inherit
	QL_SHARED_NAMES

feature -- Inheritance relationship

	class_ancestor_relation: QL_CLASS_INHERITANCE_RELATION is
			-- Ancestor relation.
		once
			create Result.make (query_language_names.ql_class_ancestor_relation)
		ensure
			result_attached: Result /= Void
		end

	class_proper_ancestor_relation: QL_CLASS_INHERITANCE_RELATION is
			-- Proper ancestor relation.
		once
			create Result.make (query_language_names.ql_class_proper_ancestor_relation)
		ensure
			result_attached: Result /= Void
		end

	class_descendant_relation: QL_CLASS_INHERITANCE_RELATION is
			-- Descendant relation.
		once
			create Result.make (query_language_names.ql_class_descendant_relation)
		ensure
			result_attached: Result /= Void
		end

	class_proper_descendant_relation: QL_CLASS_INHERITANCE_RELATION is
			-- Proper descendant relation.
		once
			create Result.make (query_language_names.ql_class_proper_descendant_relation)
		ensure
			result_attached: Result /= Void
		end

	class_parent_relation: QL_CLASS_INHERITANCE_RELATION is
			-- Parent relation.
		once
			create Result.make (query_language_names.ql_class_parent_relation)
		ensure
			result_attached: Result /= Void
		end

	class_indirect_parent_relation: QL_CLASS_INHERITANCE_RELATION is
			-- Indirect parent relation.
		once
			create Result.make (query_language_names.ql_class_indirect_parent_relation)
		ensure
			result_attached: Result /= Void
		end

	class_heir_relation: QL_CLASS_INHERITANCE_RELATION is
			-- Heir relation.
		once
			create Result.make (query_language_names.ql_class_heir_relation)
		ensure
			result_attached: Result /= Void
		end

	class_indirect_heir_relation: QL_CLASS_INHERITANCE_RELATION is
			-- Indirect heir relation.
		once
			create Result.make (query_language_names.ql_class_indirect_heir_relation)
		ensure
			result_attached: Result /= Void
		end

feature -- Client relationship

	class_client_relation: QL_CLASS_CLIENT_RELATION is
			-- Client relation.
		once
			create Result.make (query_language_names.ql_class_client_relation)
		ensure
			result_attached: Result /= Void
		end

	class_indirect_client_relation: QL_CLASS_CLIENT_RELATION is
			-- Indirect client relation.
		once
			create Result.make (query_language_names.ql_class_indirect_client_relation)
		ensure
			result_attached: Result /= Void
		end

	class_supplier_relation: QL_CLASS_CLIENT_RELATION is
			-- Supplier relation.
		once
			create Result.make (query_language_names.ql_class_supplier_relation)
		ensure
			result_attached: Result /= Void
		end

	class_indirect_supplier_relation: QL_CLASS_CLIENT_RELATION is
			-- Indirect supplier relation.
		once
			create Result.make (query_language_names.ql_class_indirect_supplier_relation)
		ensure
			result_attached: Result /= Void
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
