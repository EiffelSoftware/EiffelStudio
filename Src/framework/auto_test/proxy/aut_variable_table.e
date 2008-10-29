indexing
	description:

		"Maps variables to their type"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_VARIABLE_TABLE

inherit

	AUT_SHARED_RANDOM
		export {NONE} all end

	ITP_VARIABLE_CONSTANTS

	THREAD_CONTROL

create

	make

feature {NONE} -- Initialization

	make (a_system: like system) is
			-- Create new handler.
		require
			a_system_not_void: a_system /= Void
		local
			tester: AUT_VARIABLE_EQUALITY_TESTER
		do
			create name_generator.make_with_string_stream (variable_name_prefix)
			create tester.make
			create variable_type_table.make_default
			variable_type_table.set_key_equality_tester (tester)
			system := a_system
		ensure
			system_set: system = a_system
		end

feature -- Status report

	is_variable_defined (a_variable: ITP_VARIABLE): BOOLEAN is
			-- Is variable `a_variable' defined in interpreter?
		require
			a_variable_not_void: a_variable /= Void
		do
			Result := variable_type_table.has (a_variable)
		end

	are_expressions_valid (a_list: DS_LINEAR [ITP_EXPRESSION]): BOOLEAN is
			-- Are the expressions in `a_list' valid? I.e. are the variables in `a_list' defined?
		require
			a_list_not_void: a_list /= Void
			a_list_doesnt_have_void: not a_list.has (Void)
		local
			cs: DS_LINEAR_CURSOR [ITP_EXPRESSION]
			v: ITP_VARIABLE
		do
			from
				cs := a_list.new_cursor
				cs.start
				Result := True
			until
				cs.off or not Result
			loop
				v ?= cs.item
				if v /= Void and then not is_variable_defined (v) then
					Result := False
				else
					cs.forth
				end
			end
			cs.go_after
		end

feature -- Access

	system: SYSTEM_I
			-- system

	variable_type (a_variable: ITP_VARIABLE): TYPE_A is
			-- Type of `a_variable'
			-- Void of the value of `a_variable' is Void so we don't know the exact type of `a_variable' from the proxy side.
		require
			a_variable_not_void: a_variable /= Void
			variable_defined: is_variable_defined (a_variable)
		do
			Result := variable_type_table.item (a_variable)
		ensure
			result_attached: Result /= Void
		end

	random_variable: ITP_VARIABLE is
			-- Random variable from interpreter or `Void' if none
			-- defined
		local
			i: INTEGER
			j: INTEGER
			cs: DS_HASH_TABLE_CURSOR [TYPE_A, ITP_VARIABLE]
		do
			if variable_type_table.count > 0 then
				random.forth
				i := (random.item  \\ variable_type_table.count) + 1
				from
					j := 1
					cs := variable_type_table.new_cursor
					cs.start
				until
					i = j
				loop
					cs.forth
					j := j + 1
				end
				Result := cs.key
				cs.go_after
			end
		ensure
			variable_defined: Result /= Void implies is_variable_defined (Result)
		end

	random_conforming_variable (a_type: TYPE_A): ITP_VARIABLE is
			-- Random variable of `conforming_variables (a_type)' or Void if list
			-- is emtpy
		require
			a_type_not_void: a_type /= Void
		local
			list: like conforming_variables
			cs: DS_LINEAR_CURSOR [ITP_VARIABLE]
			i: INTEGER
			j: INTEGER
		do
			list := conforming_variables (a_type)
			if list.count > 0 then
				random.forth
				i := (random.item  \\ list.count) + 1
				from
					j := 1
					cs := list.new_cursor
					cs.start
				until
					i = j
				loop
					cs.forth
					j := j + 1
				end
				Result := cs.item
				cs.go_after
			end
		ensure
			variable_defined: Result /= Void implies is_variable_defined (Result)
		end

	conforming_variables (a_type: TYPE_A): DS_LIST [ITP_VARIABLE] is
			-- All defeined variables conforming to `a_type'
		require
			a_type_not_void: a_type /= Void
		local
			cs: DS_HASH_TABLE_CURSOR [TYPE_A, ITP_VARIABLE]
		do
			create {DS_ARRAYED_LIST [ITP_VARIABLE]} Result.make (variable_type_table.count)
			from
				cs := variable_type_table.new_cursor
				cs.start
			until
				cs.off
			loop
				if cs.item = Void or else cs.item.actual_type.is_conformant_to (a_type) then
					Result.force_last (cs.key)
				end
				cs.forth
			end
		ensure
			variables_not_void: Result /= Void
			variables_doesnt_have_void: not Result.has (Void)
		end

	new_variable: ITP_VARIABLE is
			-- Variable not yet defined
		do
			name_generator.generate_new_name
			create Result.make (name_generator.index)
			name_generator.output_string.wipe_out
		ensure
			variable_not_void: Result /= Void
			variable_not_defined: not is_variable_defined (Result)
		end

feature -- Element change

	define_variable (a_variable: ITP_VARIABLE; a_type: TYPE_A) is
			-- Define variable `a_variable' to be of type `a_type'.
			-- `a_type' is Void means that the value of `a_variable' is Void so we don't know the exact type of it
			-- from the proxy side.
		require
			a_variable_not_void: a_variable /= Void
			a_type_attached: a_type /= Void
		do
			variable_type_table.force (a_type, a_variable)
		ensure
			variable_defined: is_variable_defined (a_variable)
			variable_has_valid_type: variable_type (a_variable) = a_type
		end

feature -- Removal

	wipe_out is
			-- Remove all variable mappings.
		do
			create name_generator.make_with_string_stream (variable_name_prefix)
			variable_type_table.wipe_out
		ensure
			variable_type_table_empty: variable_type_table.is_empty
		end

	name_generator: AUT_UNIQUE_NAME_GENERATOR
			-- Name generator for variable names

	variable_type_table: DS_HASH_TABLE [TYPE_A, ITP_VARIABLE]
			-- Table mapping interprteter variables to their type

invariant

	system_not_void: system /= Void
	name_generator_not_void: name_generator /= Void
	variable_type_table_not_void: variable_type_table /= Void
	all_variables_have_type: not variable_type_table.has (Void)

end
