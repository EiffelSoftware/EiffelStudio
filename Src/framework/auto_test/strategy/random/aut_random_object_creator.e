indexing

	description:

		"Objects that instruct interpreter to create an object"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_RANDOM_OBJECT_CREATOR

inherit

	AUT_TASK

	AUT_SHARED_RANDOM
		export {NONE} all end

	ERL_G_TYPE_ROUTINES
		export {NONE} all end

	KL_SHARED_STRING_EQUALITY_TESTER
		export {NONE} all end

	REFACTORING_HELPER

create

	make

feature {NONE} -- Initialization

	make (a_system: like system; an_interpreter: like interpreter; a_type: like type; a_feature_table: like feature_table) is
			-- Create new feature caller.
		require
			a_system_not_void: a_system /= Void
			a_interpreter_not_void: an_interpreter /= Void
			a_type_not_void: a_type /= Void
			a_type_associated_with_class: a_type.has_associated_class
			creation_procedure_exists: not exported_creators (a_type.associated_class, a_system).is_empty
			a_feature_table_attached: a_feature_table /= Void
		do
			system := a_system
			interpreter := an_interpreter
			type := a_type
			steps_completed := True
			feature_table := a_feature_table
		ensure
			system_set: system = a_system
			interpreter_set: interpreter = an_interpreter
			type_set: type = a_type
			steps_completed: steps_completed
		end

feature -- Status

	has_next_step: BOOLEAN is
			-- Is there a next step to execute?
		do
			Result := interpreter.is_running and interpreter.is_ready and not steps_completed
		end

feature -- Access

	creation_procedure: FEATURE_I
			-- Creation procedure used to create object

	use_default_creation_procedure: BOOLEAN
			-- Should the default creation procedure be used

	type: TYPE_A
			-- Type of object to create
			-- Should be a resolved type

	receiver: ITP_VARIABLE
			-- Variable that will reference created object in interpreter;
			-- Void if and error occured during creation

	input_creator: AUT_RANDOM_INPUT_CREATOR
			-- Input creator used to create arguments for creation procedure call

	system: SYSTEM_I
			-- system

	interpreter: AUT_INTERPRETER_PROXY
			-- Proxy to the interpreter used to execute call

feature -- Change

	set_creation_procedure (a_creation_procedure: like creation_procedure) is
				-- Set `creation_procedure' to `a_creation_procedure'.
		require
			a_creation_procedure_not_void: a_creation_procedure /= Void
		do
			creation_procedure := a_creation_procedure
		ensure
			creation_procedure_set: creation_procedure = a_creation_procedure
		end

feature -- Execution

	start is
		do
			steps_completed := False
			input_creator := Void
			receiver := Void
		ensure then
			input_creator_void: input_creator = Void
			receiver_void: receiver = Void
		end

	step is
		do
			if type.is_expanded then
				choose_expanded_receiver
				if not interpreter.variable_table.is_variable_defined (receiver) then
					receiver := Void
				end
				steps_completed := True
			elseif creation_procedure = Void then
				choose_creation_procedure
			elseif input_creator = Void then
				create_input_creator
			elseif input_creator.has_next_step then
				input_creator.step
			elseif input_creator.has_error then
				cancel
			else
				receiver := interpreter.variable_table.new_variable
				interpreter.create_object (receiver, type, creation_procedure, input_creator.receivers)
				if not interpreter.variable_table.is_variable_defined (receiver) then
					-- There was an error creating the object.
					receiver := Void
				end
				steps_completed := True
			end
		end

	cancel is
		do
			steps_completed := True
		end

feature {NONE} -- Implementation

	steps_completed: BOOLEAN
			-- Should there be no more steps for reasons other than a bad interpeter?

feature {NONE} -- Steps

	create_input_creator is
			-- Create `input_creator'.
		require
			has_creation_procedure: creation_procedure /= Void
		do
			create input_creator.make (system, interpreter, feature_table)
			if creation_procedure.arguments /= Void then
				add_feature_argument_type_in_input_creator (creation_procedure, type, input_creator)
			end
			input_creator.start
		end

	choose_creation_procedure is
			-- Choose a creation procedure (including default creation procedure)
			-- of `type' and set `creation_procedure' to it. Note that
			-- instead of choosing a creation procedure
			-- also `Void' can be choosen.
		require
			type_not_expanded: not type.is_expanded
			type_is_associated_with_class: type.has_associated_class
			creation_procedure_exists: creation_procedure_count (type, system) > 0
		local
			count: INTEGER
			i: INTEGER
			class_: CLASS_C
			l_exported_creators: LINKED_LIST [STRING]
		do
			class_ := type.associated_class
			l_exported_creators := exported_creators (class_, system)
			count := l_exported_creators.count
			random.forth
			i := (random.item  \\ count) + 1
			creation_procedure := class_.feature_named (l_exported_creators.i_th (i))
		ensure
			has_creation_procedure: creation_procedure /= Void
		end

	choose_expanded_receiver is
			-- Choose an expanded receiver, assign it to a new variable
			-- and make variable available via `receiver'.
		require
			type_is_expanded: type.is_expanded
			is_basic_type: True -- TODO: correct assertion
		local
			class_: CLASS_C
		do
			class_ := type.associated_class
			if string_equality_tester.test (class_.name_in_upper, "BOOLEAN") then
				choose_boolean_constant
			elseif string_equality_tester.test (class_.name_in_upper, "CHARACTER_8") then
				choose_character_8_constant
			elseif string_equality_tester.test (class_.name_in_upper, "CHARACTER_32") then
				choose_character_32_constant
			elseif string_equality_tester.test (class_.name_in_upper, "REAL_32") then
				choose_real_constant
			elseif string_equality_tester.test (class_.name_in_upper, "REAL_64") then
				choose_double_constant
			elseif string_equality_tester.test (class_.name_in_upper, "INTEGER_8") then
				choose_integer_8_constant
			elseif string_equality_tester.test (class_.name_in_upper, "INTEGER_16") then
				choose_integer_16_constant
			elseif string_equality_tester.test (class_.name_in_upper, "INTEGER_32") then
				choose_integer_constant
			elseif string_equality_tester.test (class_.name_in_upper, "INTEGER_64") then
				choose_integer_64_constant
			elseif string_equality_tester.test (class_.name_in_upper, "NATURAL_8") then
				choose_natural_8_constant
			elseif string_equality_tester.test (class_.name_in_upper, "NATURAL_16") then
				choose_natural_16_constant
			elseif string_equality_tester.test (class_.name_in_upper, "NATURAL_32") then
				choose_natural_32_constant
			elseif string_equality_tester.test (class_.name_in_upper, "NATURAL_64") then
				choose_natural_64_constant
			elseif string_equality_tester.test (class_.name_in_upper, "POINTER") then
				choose_pointer_constant
			elseif string_equality_tester.test (class_.name_in_upper, "TYPED_POINTER") then
				choose_pointer_constant
			else
				check
					todo: False -- TODO: custom expanded types not yet implemented
				end
			end
			receiver := interpreter.variable_table.new_variable
			interpreter.assign_expression (receiver, last_constant)
		end

	last_constant: ITP_CONSTANT
			-- Last chosen constant

	choose_boolean_constant is
			-- Choose boolean constant and set it to
			-- `last_constant'.
		local
			i: INTEGER
		do
			random.forth
			i := (random.item  \\ 2)
			if i = 0 then
				create {ITP_CONSTANT} last_constant.make (False)
			else
				create {ITP_CONSTANT} last_constant.make (True)
			end
		ensure
			last_constant_not_void: last_constant /= Void
		end

	choose_character_8_constant is
			-- Choose CHARACTER_8 constant and set it to
			-- `last_constant'.
		local
			i: INTEGER
		do
			random.forth
			i := (random.item  \\ 255)
			create last_constant.make (i.to_character_8)
		ensure
			last_constant_not_void: last_constant /= Void
		end

	choose_character_32_constant is
			-- Choose CHARACTER_32 constant and set it to
			-- `last_constant'.
		local
			i: INTEGER
		do
			random.forth
			i := (random.item  \\ 600)
			create last_constant.make (i.to_character_32)
		ensure
			last_constant_not_void: last_constant /= Void
		end

	choose_double_constant is
			-- Choose double constant and set it to
			-- `last_constant'.
		local
			i: INTEGER
		do
			random.forth
			i := (random.item  \\ 10)
			inspect i
			when 0 then
				create last_constant.make (-1.0)
			when 1 then
				create last_constant.make (1.0)
			when 2 then
				create last_constant.make (0.0)
			when 3 then
				create last_constant.make (-2.0)
			when 4 then
				create last_constant.make (2.0)
			when 5 then
				create last_constant.make (3.14159265358979323846)
			when 6 then
				create last_constant.make (-2.7182818284590452354)
			when 7 then
				create last_constant.make (1.7976931348623157e+308)
			when 8 then
				create last_constant.make (2.2250738585072014e-308)
			when 9 then
				create last_constant.make (2.2204460492503131e-16)
			else
				check
					dead_end: False
				end
			end
		ensure
			last_constant_not_void: last_constant /= Void
		end

	choose_integer_8_constant is
			-- Choose integer constant and set it to
			-- `last_constant'.
		local
			i: INTEGER
		do
			random.forth
			i := (random.item  \\ 18)
			if i = 0 then
				create last_constant.make ((-1).to_integer_8)
			elseif i = 1 then
				create last_constant.make ((0).to_integer_8)
			elseif i = 2 then
				create last_constant.make ((1).to_integer_8)
			elseif i = 3 then
				create last_constant.make ((2).to_integer_8)
			elseif i = 4 then
				create last_constant.make ((3).to_integer_8)
			elseif i = 5 then
				create last_constant.make ((4).to_integer_8)
			elseif i = 6 then
				create last_constant.make ((5).to_integer_8)
			elseif i = 7 then
				create last_constant.make ((6).to_integer_8)
			elseif i = 8 then
				create last_constant.make ((7).to_integer_8)
			elseif i = 9 then
				create last_constant.make ((8).to_integer_8)
			elseif i = 10 then
				create last_constant.make ((9).to_integer_8)
			elseif i = 11 then
				create last_constant.make ((-2).to_integer_8)
			elseif i = 12 then
				create last_constant.make ((10).to_integer_8)
			elseif i = 13 then
				create last_constant.make ((-10).to_integer_8)
			elseif i = 14 then
				create last_constant.make ((100).to_integer_8)
			elseif i = 15 then
				create last_constant.make ((-100).to_integer_8)
			elseif i = 16 then
				create last_constant.make ({INTEGER_8}.Min_value)
			elseif i = 17 then
				create last_constant.make ({INTEGER_8}.Max_value)
			end
		ensure
			last_constant_not_void: last_constant /= Void
		end

	choose_integer_16_constant is
			-- Choose integer constant and set it to
			-- `last_constant'.
		local
			i: INTEGER
		do
			random.forth
			i := (random.item  \\ 18)
			if i = 0 then
				create last_constant.make ((-1).to_integer_16)
			elseif i = 1 then
				create last_constant.make ((0).to_integer_16)
			elseif i = 2 then
				create last_constant.make ((1).to_integer_16)
			elseif i = 3 then
				create last_constant.make ((2).to_integer_16)
			elseif i = 4 then
				create last_constant.make ((3).to_integer_16)
			elseif i = 5 then
				create last_constant.make ((4).to_integer_16)
			elseif i = 6 then
				create last_constant.make ((5).to_integer_16)
			elseif i = 7 then
				create last_constant.make ((6).to_integer_16)
			elseif i = 8 then
				create last_constant.make ((7).to_integer_16)
			elseif i = 9 then
				create last_constant.make ((8).to_integer_16)
			elseif i = 10 then
				create last_constant.make ((9).to_integer_16)
			elseif i = 11 then
				create last_constant.make ((-2).to_integer_16)
			elseif i = 12 then
				create last_constant.make ((10).to_integer_16)
			elseif i = 13 then
				create last_constant.make ((-10).to_integer_16)
			elseif i = 14 then
				create last_constant.make ((100).to_integer_16)
			elseif i = 15 then
				create last_constant.make ((-100).to_integer_16)
			elseif i = 16 then
				create last_constant.make ({INTEGER_16}.Min_value)
			elseif i = 17 then
				create last_constant.make ({INTEGER_16}.Max_value)
			end
		ensure
			last_constant_not_void: last_constant /= Void
		end

	choose_integer_constant is
			-- Choose integer constant and set it to
			-- `last_constant'.
		local
			i: INTEGER
		do
			random.forth
			i := (random.item  \\ 17)
			if i = 0 then
				create last_constant.make (-1)
			elseif i = 1 then
				create last_constant.make (0)
			elseif i = 2 then
				create last_constant.make (1)
			elseif i = 3 then
				create last_constant.make (2)
			elseif i = 4 then
				create last_constant.make (3)
			elseif i = 5 then
				create last_constant.make (4)
			elseif i = 6 then
				create last_constant.make (5)
			elseif i = 7 then
				create last_constant.make (6)
			elseif i = 8 then
				create last_constant.make (7)
			elseif i = 9 then
				create last_constant.make (8)
			elseif i = 10 then
				create last_constant.make (9)
			elseif i = 11 then
				create last_constant.make (-1)
			elseif i = 12 then
				create last_constant.make (-2)
			elseif i = 13 then
				create last_constant.make (-3)
			elseif i = 14 then
				create last_constant.make (-4)
			elseif i = 15 then
				create last_constant.make (-5)
			elseif i = 16 then
				create last_constant.make (-6)
			elseif i = 17 then
				create last_constant.make (-7)
			elseif i = 18 then
				create last_constant.make (-8)
			elseif i = 19 then
				create last_constant.make (-9)
			elseif i = 20 then
				create last_constant.make (-2)
			elseif i = 21 then
				create last_constant.make (10)
			elseif i = 22 then
				create last_constant.make (-10)
			elseif i = 23 then
				create last_constant.make (100)
			elseif i = 24 then
				create last_constant.make (-100)
			elseif i = 25 then
				create last_constant.make ({INTEGER}.Min_value)
			elseif i = 26 then
				create last_constant.make ({INTEGER}.Max_value)
			end
		ensure
			last_constant_not_void: last_constant /= Void
		end

	choose_integer_64_constant is
			-- Choose integer constant and set it to
			-- `last_constant'.
		local
			i: INTEGER
		do
			random.forth
			i := (random.item  \\ 18)
			if i = 0 then
				create last_constant.make ((-1).to_integer_64)
			elseif i = 1 then
				create last_constant.make ((0).to_integer_64)
			elseif i = 2 then
				create last_constant.make ((1).to_integer_64)
			elseif i = 3 then
				create last_constant.make ((2).to_integer_64)
			elseif i = 4 then
				create last_constant.make ((3).to_integer_64)
			elseif i = 5 then
				create last_constant.make ((4).to_integer_64)
			elseif i = 6 then
				create last_constant.make ((5).to_integer_64)
			elseif i = 7 then
				create last_constant.make ((6).to_integer_64)
			elseif i = 8 then
				create last_constant.make ((7).to_integer_64)
			elseif i = 9 then
				create last_constant.make ((8).to_integer_64)
			elseif i = 10 then
				create last_constant.make ((9).to_integer_64)
			elseif i = 11 then
				create last_constant.make ((-2).to_integer_64)
			elseif i = 12 then
				create last_constant.make ((10).to_integer_64)
			elseif i = 13 then
				create last_constant.make ((-10).to_integer_64)
			elseif i = 14 then
				create last_constant.make ((100).to_integer_64)
			elseif i = 15 then
				create last_constant.make ((-100).to_integer_64)
			elseif i = 16 then
				create last_constant.make ({INTEGER_64}.Min_value)
			elseif i = 17 then
				create last_constant.make ({INTEGER_64}.Max_value)
			end
		ensure
			last_constant_not_void: last_constant /= Void
		end

	choose_natural_8_constant is
			-- Choose integer constant and set it to
			-- `last_constant'.
		local
			i: INTEGER
		do
			random.forth
			i := (random.item  \\ 18)
			if i = 0 then
				create last_constant.make ((0).to_natural_8)
			elseif i = 1 then
				create last_constant.make ((1).to_natural_8)
			elseif i = 2 then
				create last_constant.make ((2).to_natural_8)
			elseif i = 3 then
				create last_constant.make ((3).to_natural_8)
			elseif i = 4 then
				create last_constant.make ((4).to_natural_8)
			elseif i = 5 then
				create last_constant.make ((5).to_natural_8)
			elseif i = 6 then
				create last_constant.make ((6).to_natural_8)
			elseif i = 7 then
				create last_constant.make ((7).to_natural_8)
			elseif i = 8 then
				create last_constant.make ((8).to_natural_8)
			elseif i = 9 then
				create last_constant.make ((9).to_natural_8)
			elseif i = 10 then
				create last_constant.make ((10).to_natural_8)
			elseif i = 11 then
				create last_constant.make ((20).to_natural_8)
			elseif i = 12 then
				create last_constant.make ((126).to_natural_8)
			elseif i = 13 then
				create last_constant.make ((127).to_natural_8)
			elseif i = 14 then
				create last_constant.make ((128).to_natural_8)
			elseif i = 15 then
				create last_constant.make ((129).to_natural_8)
			elseif i = 16 then
				create last_constant.make ({NATURAL_8}.Min_value)
			elseif i = 17 then
				create last_constant.make ({NATURAL_8}.Max_value)
			end
		ensure
			last_constant_not_void: last_constant /= Void
		end

	choose_natural_16_constant is
			-- Choose integer constant and set it to
			-- `last_constant'.
		local
			i: INTEGER
		do
			random.forth
			i := (random.item  \\ 18)
			if i = 0 then
				create last_constant.make ((0).to_natural_16)
			elseif i = 1 then
				create last_constant.make ((1).to_natural_16)
			elseif i = 2 then
				create last_constant.make ((2).to_natural_16)
			elseif i = 3 then
				create last_constant.make ((3).to_natural_16)
			elseif i = 4 then
				create last_constant.make ((4).to_natural_16)
			elseif i = 5 then
				create last_constant.make ((5).to_natural_16)
			elseif i = 6 then
				create last_constant.make ((6).to_natural_16)
			elseif i = 7 then
				create last_constant.make ((7).to_natural_16)
			elseif i = 8 then
				create last_constant.make ((8).to_natural_16)
			elseif i = 9 then
				create last_constant.make ((9).to_natural_16)
			elseif i = 10 then
				create last_constant.make ((10).to_natural_16)
			elseif i = 11 then
				create last_constant.make ((20).to_natural_16)
			elseif i = 12 then
				create last_constant.make ((126).to_natural_16)
			elseif i = 13 then
				create last_constant.make ((127).to_natural_16)
			elseif i = 14 then
				create last_constant.make ((128).to_natural_16)
			elseif i = 15 then
				create last_constant.make ((129).to_natural_16)
			elseif i = 16 then
				create last_constant.make ({NATURAL_16}.Min_value)
			elseif i = 17 then
				create last_constant.make ({NATURAL_16}.Max_value)
			end
		ensure
			last_constant_not_void: last_constant /= Void
		end


	choose_natural_32_constant is
			-- Choose integer constant and set it to
			-- `last_constant'.
		local
			i: INTEGER
		do
			random.forth
			i := (random.item  \\ 18)
			if i = 0 then
				create last_constant.make ((0).as_natural_32)
			elseif i = 1 then
				create last_constant.make ((1).as_natural_32)
			elseif i = 2 then
				create last_constant.make ((2).as_natural_32)
			elseif i = 3 then
				create last_constant.make ((3).as_natural_32)
			elseif i = 4 then
				create last_constant.make ((4).as_natural_32)
			elseif i = 5 then
				create last_constant.make ((5).as_natural_32)
			elseif i = 6 then
				create last_constant.make ((6).as_natural_32)
			elseif i = 7 then
				create last_constant.make ((7).as_natural_32)
			elseif i = 8 then
				create last_constant.make ((8).as_natural_32)
			elseif i = 9 then
				create last_constant.make ((9).as_natural_32)
			elseif i = 10 then
				create last_constant.make ((10).as_natural_32)
			elseif i = 11 then
				create last_constant.make ((20).as_natural_32)
			elseif i = 12 then
				create last_constant.make ((126).as_natural_32)
			elseif i = 13 then
				create last_constant.make ((127).as_natural_32)
			elseif i = 14 then
				create last_constant.make ((128).as_natural_32)
			elseif i = 15 then
				create last_constant.make ((129).as_natural_32)
			elseif i = 16 then
				create last_constant.make ({NATURAL_32}.Min_value)
			elseif i = 17 then
				create last_constant.make ({NATURAL_32}.Max_value)
			end
		ensure
			last_constant_not_void: last_constant /= Void
		end

	choose_natural_64_constant is
			-- Choose integer constant and set it to
			-- `last_constant'.
		local
			i: INTEGER
		do
			random.forth
			i := (random.item  \\ 18)
			if i = 0 then
				create last_constant.make ((0).to_natural_64)
			elseif i = 1 then
				create last_constant.make ((1).to_natural_64)
			elseif i = 2 then
				create last_constant.make ((2).to_natural_64)
			elseif i = 3 then
				create last_constant.make ((3).to_natural_64)
			elseif i = 4 then
				create last_constant.make ((4).to_natural_64)
			elseif i = 5 then
				create last_constant.make ((5).to_natural_64)
			elseif i = 6 then
				create last_constant.make ((6).to_natural_64)
			elseif i = 7 then
				create last_constant.make ((7).to_natural_64)
			elseif i = 8 then
				create last_constant.make ((8).to_natural_64)
			elseif i = 9 then
				create last_constant.make ((9).to_natural_64)
			elseif i = 10 then
				create last_constant.make ((10).to_natural_64)
			elseif i = 11 then
				create last_constant.make ((20).to_natural_64)
			elseif i = 12 then
				create last_constant.make ((126).to_natural_64)
			elseif i = 13 then
				create last_constant.make ((127).to_natural_64)
			elseif i = 14 then
				create last_constant.make ((128).to_natural_64)
			elseif i = 15 then
				create last_constant.make ((129).to_natural_64)
			elseif i = 16 then
				create last_constant.make ({NATURAL_64}.Min_value)
			elseif i = 17 then
				create last_constant.make ({NATURAL_64}.Max_value)
			end
		ensure
			last_constant_not_void: last_constant /= Void
		end

	choose_pointer_constant is
			-- Choose boolean constant and set it to
			-- `last_constant'.
		do
			create last_constant.make (default_pointer)
		ensure
			last_constant_not_void: last_constant /= Void
		end

	choose_real_constant is
			-- Choose boolean constant and set it to
			-- `last_constant'.
		local
			i: INTEGER
		do
			random.forth
			i := (random.item  \\ 10)
			inspect i
			when 0 then
				create last_constant.make ((-1.0).truncated_to_real)
			when 1 then
				create last_constant.make ((1.0).truncated_to_real)
			when 2 then
				create last_constant.make ((0.0).truncated_to_real)
			when 3 then
				create last_constant.make ((-2.0).truncated_to_real)
			when 4 then
				create last_constant.make ((2.0).truncated_to_real)
			when 5 then
				create last_constant.make ((-100.0).truncated_to_real)
			when 6 then
				create last_constant.make ((100.0).truncated_to_real)
			when 7 then
				create last_constant.make ((3.40282e+38).truncated_to_real)
			when 8 then
				create last_constant.make ((1.17549e-38).truncated_to_real)
			when 9 then
				create last_constant.make ((1.19209e-07).truncated_to_real)
			else
				check
					dead_end: False
				end
			end
		ensure
			last_constant_not_void: last_constant /= Void
		end

	feature_table: HASH_TABLE [ARRAY [FEATURE_I], CLASS_C]
		-- Table used to store features in a class

invariant
	system_not_void: system /= Void
	interpreter_not_void: interpreter /= Void
	type_not_void: type /= Void
	type_has_associated_class: type.has_associated_class
	receiver_defined: receiver /= Void implies interpreter.variable_table.is_variable_defined (receiver)

end
