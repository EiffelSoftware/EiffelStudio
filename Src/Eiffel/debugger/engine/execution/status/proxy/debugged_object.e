indexing
	description: "Object being debugged."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

deferred class DEBUGGED_OBJECT

inherit
	SHARED_ABSTRACT_DEBUG_VALUE_SORTER
		export
			{NONE} all
		end

	SHARED_DEBUGGER_MANAGER

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

feature {NONE} -- Creation

	make (addr: like object_address; sp_lower, sp_upper: INTEGER) is
			-- Make debugged object with hector address `addr'
			-- with upper and lower bounds `sp_lower' and `sp_upper'.
			-- (At this stage we do not know if addr is a special object
			-- and we don't want to retrieve all of the special object
			-- especially if it has thousands of entries).
			-- (-1 for `sp_upper' stands for the upper bound
			-- of the inspected special object)
		require
			non_void_addr: addr /= Void;
			valid_addr: is_valid_object_address (addr);
			valid_bounds: sp_lower >= 0 and (sp_upper >= sp_lower or else
					sp_upper = -1)
		deferred
		ensure
			set: addr = object_address
		end

feature -- Helpers

	is_valid_object_address (addr: STRING): BOOLEAN is
		require
			application_is_executing: debugger_manager.application_is_executing
		do
			Result := debugger_manager.application.is_valid_object_address (addr)
		end

feature {DEBUGGED_OBJECT_MANAGER} -- Refreshing

	reset is
			-- Reset internal data
		deferred
		end

	refresh (sp_lower, sp_upper: INTEGER) is
		require
			valid_bounds: sp_lower >= 0 and (sp_upper >= sp_lower or else
					sp_upper = -1)
		deferred
		end

feature -- Properties

	is_erroneous: BOOLEAN
			-- Is current erroneous ?
			--| For now only used for classic debugger (when dealing with bad object address)

	attributes: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- Attributes of object being inspected (sorted by name)
		 deferred
		 end

	is_special: BOOLEAN;
		-- Is the object being inspected SPECIAL?

	is_tuple: BOOLEAN;
		-- Is the object being inspected TUPLE?

	object_address: STRING;
			-- Hector address of object being inspected

	capacity: INTEGER;
			-- Capacity of the object in case it is SPECIAL

	max_capacity: INTEGER
			-- Maximum capacity if the object or its
			-- attributes are SPECIAL
			-- (negative means special objects were not found)

	dynamic_class: CLASS_C
			-- Dynamic type of `Current'.

	class_type: CLASS_TYPE
			-- Dynamic type of `Current', one per generic implementation.

feature -- Query

	sorted_attributes: like attributes is
			-- Sort and return `attributes'.
		do
			Result := attributes
			if
				Result /= Void and then (not is_special and not is_tuple)
			then
				sort_debug_values (Result)
			end
		end

	attribute_by_name (n: STRING): ABSTRACT_DEBUG_VALUE is
			-- Try to find an attribute named `n' in list `attributes'.
		require
			not_void: n /= Void
		local
			l_item: ABSTRACT_DEBUG_VALUE
			l_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
		do
			if attributes /= Void then
				from
					l_cursor := attributes.new_cursor
					l_cursor.start
				until
					l_cursor.after or Result /= Void
				loop
					l_item := l_cursor.item
					if l_item.name /= Void and then l_item.name.is_equal (n) then
						Result := l_item
					end
					l_cursor.forth
				end
			end
		ensure
			same_name_if_found: (Result /= Void) implies (Result.name.is_equal (n))
		end

invariant

	non_void_attributes: attributes /= Void;
	non_void_address: object_address /= Void

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
