indexing
	description: "Shared metrics units used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_SHARED_UNIT

inherit
	QL_SHARED_NAMES

	QL_SHARED_SCOPES

feature -- Units

	target_unit: QL_METRIC_UNIT is
			-- Target unit
		once
			create Result.make (query_language_names.ql_target_unit)
			Result.set_scope (target_scope)
		ensure
			result_attached: Result /= Void
		end

	group_unit: QL_METRIC_UNIT is
			-- Group unit
		once
			create Result.make (query_language_names.ql_group_unit)
			Result.set_scope (group_scope)
		ensure
			result_attached: Result /= Void
		end

	class_unit: QL_METRIC_UNIT is
			-- Class unit
		once
			create Result.make (query_language_names.ql_class_unit)
			Result.set_scope (class_scope)
		ensure
			result_attached: Result /= Void
		end

	feature_unit: QL_METRIC_UNIT is
			-- Feature unit
		once
			create Result.make (query_language_names.ql_feature_unit)
			Result.set_scope (feature_scope)
		ensure
			result_attached: Result /= Void
		end

	local_unit: QL_METRIC_UNIT is
			-- Local unit
		once
			create Result.make (query_language_names.ql_local_unit)
			Result.set_scope (feature_scope)
		ensure
			result_attached: Result /= Void
		end

	argument_unit: QL_METRIC_UNIT is
			-- Argument unit
		once
			create Result.make (query_language_names.ql_argument_unit)
			Result.set_scope (feature_scope)
		ensure
			result_attached: Result /= Void
		end

	generic_unit: QL_METRIC_UNIT is
			-- Generic unit
		once
			create Result.make (query_language_names.ql_generic_unit)
			Result.set_scope (feature_scope)
		ensure
			result_attached: Result /= Void
		end

	line_unit: QL_METRIC_UNIT is
			-- Line unit
		once
			create Result.make (query_language_names.ql_line_unit)
		ensure
			result_attached: Result /= Void
		end

	ratio_unit: QL_METRIC_UNIT is
			-- Ratio unit
		once
			create Result.make (query_language_names.ql_ratio_unit)
		ensure
			result_attached: Result /= Void
		end

	compilation_unit: QL_METRIC_UNIT is
			-- Compilation unit
		once
			create Result.make (query_language_names.ql_compilation_unit)
		ensure
			result_attached: Result /= Void
		end

	assertion_unit: QL_METRIC_UNIT is
			-- Target unit
		once
			create Result.make (query_language_names.ql_assertion_unit)
		ensure
			result_attached: Result /= Void
		end

	no_unit: QL_METRIC_UNIT is
			-- Unit represents no unit
		once
			create Result.make (query_language_names.ql_no_unit)
		ensure
			result_attached: Result /= Void
		end

	unit_table: HASH_TABLE [QL_METRIC_UNIT, STRING] is
			-- Table of supported units
			-- Key is name in lower case, value is that unit
		once
			create Result.make (11)
			Result.put (target_unit,      query_language_names.ql_target_unit)
			Result.put (group_unit,       query_language_names.ql_group_unit)
			Result.put (class_unit,       query_language_names.ql_class_unit)
			Result.put (generic_unit,     query_language_names.ql_generic_unit)
			Result.put (feature_unit,     query_language_names.ql_feature_unit)
			Result.put (local_unit,       query_language_names.ql_local_unit)
			Result.put (argument_unit,    query_language_names.ql_argument_unit)
			Result.put (assertion_unit,   query_language_names.ql_assertion_unit)
			Result.put (line_unit,        query_language_names.ql_line_unit)
			Result.put (compilation_unit, query_language_names.ql_compilation_unit)
			Result.put (no_unit,          query_language_names.ql_no_unit)
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
