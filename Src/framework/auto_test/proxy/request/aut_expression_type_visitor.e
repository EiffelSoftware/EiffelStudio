indexing
	description: "Summary description for {AUT_EXPRESSION_TYPE_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_EXPRESSION_TYPE_VISITOR

inherit
	ITP_EXPRESSION_PROCESSOR

	ERL_G_TYPE_ROUTINES

	AUT_SHARED_INTERPRETER_INFO

create
	make

feature{NONE} -- Initialization

	make (a_system: SYSTEM_I; a_variable_table: like variable_table) is
			-- Initialize.
		require
			a_system_attached: a_system /= Void
			a_variable_table_attached: a_variable_table /= Void
		do
			system := a_system
			variable_table := a_variable_table
		ensure
			variable_table_set: variable_table = a_variable_table
		end

feature -- Access

	type (a_expression: ITP_EXPRESSION): TYPE_A is
			-- Type of `a_expression'
		require
			a_expression_attached: a_expression /= Void
		do
			a_expression.process (Current)
			Result := last_type
		ensure
			result_attached: Result /= Void
		end

	types (a_expression_list: DS_LINEAR [ITP_EXPRESSION]): ARRAYED_LIST [TYPE_A] is
			-- List of type for each expression in `a_expression_list'
			-- Return an empty list if `a_expression_list' is Void or empty.
		local
			l_cursor: DS_LINEAR_CURSOR [ITP_EXPRESSION]
		do
			if a_expression_list /= Void and then not a_expression_list.is_empty then
				create Result.make (a_expression_list.count)
				from
					l_cursor := a_expression_list.new_cursor
					l_cursor.start
				until
					l_cursor.after
				loop
					Result.extend (type (l_cursor.item))
					l_cursor.forth
				end
			else
				create Result.make (0)
			end
		end

feature {ITP_EXPRESSION} -- Processing

	process_constant (a_value: ITP_CONSTANT) is
			-- Process `a_value', store type of `a_value' into `last_type'.
		do
			last_type := base_type (a_value.type_name)
		end

	process_variable (a_value: ITP_VARIABLE) is
			-- Process `a_value', store type of `a_value' into `last_type'.
		do
			last_type := variable_table.variable_type (a_value)
		end

feature{NONE} -- Implementation

	system: SYSTEM_I
			-- System

	variable_table: AUT_VARIABLE_TABLE
			-- Variable table

	last_type: TYPE_A
			-- Last type received by process features.

invariant
	variable_table_attached: variable_table /= Void

end
