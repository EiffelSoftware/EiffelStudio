note
	description: "[
		Object store for interpreter
		]"
	author: "Andreas Leitner"
	date: "$Date$"
	revision: "$Revision$"

class ITP_STORE

inherit
	REFACTORING_HELPER

create

	make

feature {NONE} -- Initialization

	make
			-- Create new store
		do
			create storage.make_with_capacity (default_capacity)
			create storage_flag.make_with_capacity (default_capacity)
			storage.force_last (Void)
			storage_flag.force_last (False)
		end

feature -- Status report

	is_variable_defined (a_index: INTEGER): BOOLEAN
			-- Is the slot at position `a_index' used for store some (possibly Void) variable?
		require
			a_index_positive: a_index > 0
		do
			Result := a_index <= storage_flag.count and then storage_flag.item (a_index)
		ensure
			good_result: Result = (a_index <= storage_flag.count) and then storage_flag.item (a_index)
		end

	is_expression_defined (an_expression: ITP_EXPRESSION): BOOLEAN
			-- Is expression defined in the context of this store? An
			-- expression is defined iff it is a constant or a variable
			-- which is defined in this store.
		require
			an_expression_not_void: an_expression /= Void
		do
			if attached {ITP_VARIABLE} an_expression as l_variable then
				Result := is_variable_defined (l_variable.index)
			else
				Result := True
			end
		end

feature -- Access

	variable_value (a_index: INTEGER): detachable ANY
			-- Value of variable at index `a_index'
		require
			a_index_large_enough: a_index > 0
			a_index_valid: is_variable_defined (a_index)
		do
			Result := storage.item (a_index)
		ensure
			good_result: Result = storage.item (a_index)
		end

	expression_value (an_expression: ITP_EXPRESSION): detachable ANY
			-- Value of expression `an_expression' in the context of this store.
		require
			an_expression_not_void: an_expression /= Void
			an_expression_defined: is_expression_defined (an_expression)
		do
			if attached {ITP_VARIABLE} an_expression as l_variable then
				Result := variable_value (l_variable.index)
			elseif attached {ITP_CONSTANT} an_expression as l_constant then
				Result := l_constant.value
			else
				check
					type_not_supported: False
				end
			end
		end

feature -- Basic routines

	assign_value (a_value: detachable ANY; a_index: INTEGER)
			-- Assign the value `a_value' to variable named `a_name'.
		require
			a_index_large_enough: a_index > 0
		do
			storage.force_put (a_value, a_index)
			storage_flag.force_put (True, a_index)
		ensure
			a_value_assigned: storage.item (a_index) = a_value
			variable_defined: is_variable_defined (a_index)
		end

	assign_expression (an_expression: ITP_EXPRESSION; a_index: INTEGER)
			-- Assign the value of expression `an_expression' to variable at index `a_index'.
		require
			an_expression_not_void: an_expression /= Void
			an_expression_defined: is_expression_defined (an_expression)
			a_index_large_enough: a_index > 0
		do
			assign_value (expression_value (an_expression), a_index)
		ensure
			variable_defined: is_variable_defined (a_index)
		end

	arguments (an_expression_list: ERL_LIST [ITP_EXPRESSION]): detachable ARRAY [detachable ANY]
			-- Arguments with the values from `an_expression_list'
			-- using `variables' to lookup variable values or `Void'
			-- in case of an error
		require
			an_expression_list_not_void: an_expression_list /= Void
		local
			i: INTEGER
			count: INTEGER
			expression: detachable ITP_EXPRESSION
		do
			from
				count := an_expression_list.count
				create Result.make (1, count)
				i := 1
			until
				i > count or Result = Void
			loop
				expression := an_expression_list.item (i)
				if expression = Void or else not is_expression_defined (expression) then
					Result := Void
				else
					Result.put (expression_value (expression), i)
					i := i + 1
				end
			end
		end

feature {NONE} -- Implementation

	storage: ERL_LIST [ANY]
			-- Variables and their attached values

	storage_flag: ERL_LIST [BOOLEAN]
			-- Flag to decide if an object at index is defined.

	default_capacity: INTEGER = 1000
			-- Default capacity for `storage' and `storage_flag'.

invariant
	storage_attached: storage /= Void
	storage_flag_attached: storage_flag /= Void
	storage_count_same_as_storage_flag_count: storage.count = storage_flag.count

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
