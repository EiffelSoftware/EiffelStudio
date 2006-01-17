indexing
	description: "Representation of metric objects"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC
	
inherit
	COMPARABLE
		undefine
			is_equal
		end

feature -- Access

	name: STRING
		-- `Current' name

	set_name (n: STRING) is
			-- Asign `n' to `name'.
		require
			name_correct: name /= Void and then not name.is_empty
		do
			name := n
		end

	unit: STRING
		-- `Current' unit.

	tool: EB_METRIC_TOOL
		-- Associated interface.

	min_scope: INTEGER
		-- Index of the minimum scope type `Current' applies to.

	percentage: BOOLEAN
		-- Display metric result as a percentage ?
		-- False for basic and linear metrics.

	set_percentage (bool: BOOLEAN) is
			-- Assign `bool' to `percentage'.
		do
			percentage := bool
		end

feature -- Comparison

	infix "<" (other: EB_METRIC): BOOLEAN is
			-- Is current metric less than `other' in the sense of alphabetic order?
		require else
			valid_object_comparison: other /= Void
		do
			Result := name.as_lower < other.name.as_lower
		end

feature -- Application to scope

	value (s: EB_METRIC_SCOPE): DOUBLE is
			-- Evaluate `Current' over `s'.
		require
			scope_not_void: s /= Void
		deferred
		end

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

end -- class EB_METRIC
