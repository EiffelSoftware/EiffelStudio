indexing
	description: "Representation of metric objects which are combination%N%
				%of previously recorded metrics (either basic or composite)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_COMPOSITE

inherit
	EB_METRIC

	SHARED_WORKBENCH

	EB_METRIC_SCOPE_INFO

create
	make

feature -- Initialization

	make (a_name, a_unit: STRING; an_operator: EB_METRIC_VALUE; minimal: INTEGER) is
			-- Assign an operator to `Current'
		require
			correct_name: a_name /= Void and then not a_name.is_empty
			correct_unit: a_unit /= Void and then not a_unit.is_empty
			correct_scope: minimal >= Feature_scope and minimal <= Archive_scope
			correct_operator: an_operator /= Void
		do
			name := a_name
			unit := a_unit
			operator := an_operator
			min_scope := minimal
		end

feature -- Access

	operator: EB_METRIC_VALUE
		-- Mathematical combination of avilable metrics (either basics or composite).

feature -- Nature

	is_linear: BOOLEAN
		-- Is `Current' a linear combination of available metrics?

	set_linear (bool: BOOLEAN) is
			-- Assign `bool' to `is_linear'.
		do
			is_linear := bool
		end

	is_metric_ratio: BOOLEAN
		-- Is `Current' a ratio of two available metrics?

	set_metric_ratio (bool: BOOLEAN) is
			-- Assign `bool' to `is_metric_ratio'.
		do
			is_metric_ratio := bool
		end

	is_scope_ratio: BOOLEAN
			-- Is `Current' a ratio of an available metrics over two different scopes?

	set_scope_ratio (bool: BOOLEAN) is
			-- Assign `bool' to `is_scope_ratio'.
		do
			is_scope_ratio := bool
		end

feature -- When metric needs several scopes

	scope_num: EB_METRIC_SCOPE
		-- Numerator scope for scope ratio metrics.

	set_scope_num (s: EB_METRIC_SCOPE) is
			-- Assign `s' to `scope_num'.
		require
			scope_not_void: s /= Void
		do
			scope_num := s
		end

	scope_den: EB_METRIC_SCOPE
		-- Denominator scope for scope ratio metrics.

	set_scope_den (s: EB_METRIC_SCOPE) is
			-- Assign `s' to `scope_den'.
		require
			scope_not_void: s /= Void
		do
			scope_den := s
		end

feature -- Application to scope.

	value (s:EB_METRIC_SCOPE): DOUBLE is
			-- Evaluate current metric using its `operator'.
		do
			Result := operator.value (s)
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

end -- class EB_METRIC_COMPOSITE
