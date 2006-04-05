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

feature -- Scope

	scope (str: STRING): EB_METRIC_SCOPE is
			-- Return the scope object whose name is `str'.
		local
			cursor: CURSOR
		do
			cursor := scopes.cursor
			from
				scopes.start
			until
				scopes.after or Result /= Void
			loop
				if equal (scopes.item.name, str) then
					Result := scopes.item
				end
				scopes.forth
			end
			scopes.go_to (cursor)
		end

	scopes: ARRAYED_LIST [EB_METRIC_SCOPE] is
		-- List of all scopes already defined. They are not necessarily displayed in
		-- `scope_combobox' at any time.
		local
			a_scope: EB_METRIC_SCOPE
		once
			create a_scope
			Result := a_scope.list_of_scopes
		ensure
			result_not_void: Result /= Void
		end

feature -- Progress agent

	progress_changed_actions: ACTION_SEQUENCE [TUPLE [INTEGER, INTEGER, STRING]] is
			-- Actions performed when progress of current metric calculation changes
			-- The first parameter indicates current progress, the second parameter indicate whole progress,
			-- the third parameter gives a message.
		do
			if internal_progress_actions = Void then
				create internal_progress_actions
			end
			Result := internal_progress_actions
		ensure
			result_not_void: Result /= Void
		end

feature{NONE} -- Implementation

	internal_progress_actions: like progress_changed_actions;
			-- Internal actions for progress change

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

end -- class EB_METRIC
