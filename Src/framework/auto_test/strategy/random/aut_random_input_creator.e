indexing

	description:

		"Objects that create a list of objects"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_RANDOM_INPUT_CREATOR

inherit

	AUT_TASK

	AUT_SHARED_RANDOM
		export {NONE} all end

	ERL_G_TYPE_ROUTINES
		export {NONE} all end

	REFACTORING_HELPER

	AUT_SHARED_INTERPRETER_INFO

create

	make

feature {NONE} -- Initialization

	make (a_system: like system; an_interpreter: like interpreter; a_feature_table: like feature_table) is
			-- Create new feature caller.
		require
			a_system_not_void: a_system /= Void
			a_interpreter_not_void: an_interpreter /= Void
			a_feature_table_attached: a_feature_table /= Void
		do
			system := a_system
			interpreter := an_interpreter
			feature_table := a_feature_table
			create {DS_ARRAYED_LIST [CL_TYPE_A]} types.make_default
			create {DS_ARRAYED_LIST [ITP_VARIABLE]} receivers.make_default
		ensure
			system_set: system = a_system
			interpreter_set: interpreter = an_interpreter
		end

feature -- Status

	has_next_step: BOOLEAN
			-- Is there a next step to execute?

	has_error: BOOLEAN
			-- Did an error occur?

feature -- Access

	object_creator: AUT_RANDOM_OBJECT_CREATOR
			-- Task that will be used to create the individual objects

	types: DS_LIST [TYPE_A]
			-- List containing the types that the objects
			-- in `constants' will conform to;
			-- For each type one object will be created and put in
			-- the corresponding slot in `constants'

	receivers: DS_LIST [ITP_VARIABLE]
			-- Receivers created as part of this task

	system: SYSTEM_I
			-- system

	interpreter: AUT_INTERPRETER_PROXY
			-- Proxy to the interpreter used to execute call

feature -- Change

	add_type (a_type: TYPE_A) is
			-- Add `a_type' to `types'.
		require
			a_type_not_void: a_type /= Void
		do
			types.force_last (a_type)
		ensure
			added: types.last = a_type
		end

feature -- Execution

	start is
		do
			has_next_step := True
			receivers.wipe_out
			object_creator := Void
			has_error := False
		ensure then
			no_receivers: receivers.count = 0
			object_creator_void: object_creator = Void
		end

	step is
		local
			i: INTEGER
			receiver: ITP_VARIABLE
		do
			if object_creator /= Void then
				object_creator.step
				if not object_creator.has_next_step then
					if object_creator.receiver /= Void then
						receivers.force_last (object_creator.receiver)
					else
						cancel
					end
					object_creator := Void
				end
			elseif receivers.count < types.count then
				random.forth
				i := (random.item  \\ 5)
				if i = 0 or types.item (receivers.count + 1).is_expanded then
					create_object_creator
				else
					receiver := interpreter.variable_table.random_conforming_variable (types.item (receivers.count + 1))
					if receiver /= Void then
						receivers.force_last (receiver)
					else
						cancel
					end
				end
			else
				has_next_step := False
			end
		end

	cancel is
		do
			has_next_step := False
			has_error := True
		end

feature {NONE} -- Steps

	create_object_creator is
			-- Create object creator for next receiver.
		require
			receivers.count < types.count
		local
			type: TYPE_A
			receiver: ITP_VARIABLE
		do
			type := types.item (receivers.count + 1)
			if not type.is_expanded then
				if creation_procedure_count (type, system) = 0 then
					-- Try to look for a creatable descendant
					type := random_creatable_descendant (type)
				end
			end
			if type = Void then
					-- No creatable descendant exists
				receiver := interpreter.variable_table.random_conforming_variable (types.item (receivers.count + 1))
				if receiver /= Void then
					receivers.force_last (receiver)
				else
					cancel
				end
			else
				create object_creator.make (system, interpreter,type, feature_table)
				object_creator.start
			end
		end

	descendants (a_class: CLASS_C): DS_HASH_SET [CLASS_C] is
			-- Descendants of `a_class'.
		require
			a_class_attached: a_class /= Void
		local
			l_recursive_descendants: DS_HASH_SET [CLASS_C]
		do
			create l_recursive_descendants.make (20)
			compute_recursive_descendants (a_class, l_recursive_descendants)
			Result := l_recursive_descendants
		ensure
			result_attached: Result /= Void
		end

	compute_recursive_descendants (a_class: CLASS_C; a_descendants: DS_HASH_SET [CLASS_C]) is
			-- Compute all the recursive descendants for `a_class' and store result in `a_descendants'.
		require
			a_class_not_void: a_class /= Void
		local
			l_classes: LIST [CLASS_C]
		do
			a_descendants.force_last (a_class)
			from
				l_classes := a_class.direct_descendants
				l_classes.start
			until
				l_classes.after
			loop
				compute_recursive_descendants (l_classes.item, a_descendants)
				l_classes.forth
			end
		end

	random_creatable_descendant (a_type: TYPE_A): TYPE_A is
			-- Arbitrary creatable descendant of `a_type; Void if none exists.
			-- TODO: Always takes the first one. Pick an random one.
			-- TODO: Cache results.
		require
			a_type_not_void: a_type /= Void
		local
			class_: CLASS_C
			cs: DS_LINEAR_CURSOR [CLASS_C]
			t: TYPE_A
			l_interp_classes: like interpreter_related_classes
		do
			from
				l_interp_classes := interpreter_related_classes
				class_ := a_type.associated_class
				cs := descendants (class_).new_cursor
				cs.start
			until
				cs.off or Result /= Void
			loop
				if cs.item.is_generic then
					t := generic_derivation (cs.item, system)
				else
					t := cs.item.actual_type
				end
				if
					not l_interp_classes.has (t.name) and then
					(t.is_expanded or creation_procedure_count (t, system) > 0)
				 then
					Result := t
				end
				cs.forth
			end
			cs.go_after
		end

feature{NONE} -- Implementation

	feature_table: HASH_TABLE [ARRAY [FEATURE_I], CLASS_C]
			-- Table used to store features in a class

invariant

	system_not_void: system /= Void
	interpreter_not_void: interpreter /= Void
	types_not_void: types /= Void
	types_doesnt_have_void: not types.has (Void)
	receivers_not_void: receivers /= Void
	receivers_doesnt_have_void: not receivers.has (Void)
	receivers_defined: receivers.for_all (agent (interpreter.variable_table).is_variable_defined)
	counts_valid: receivers.count <= types.count
	has_error_implies_over: has_error implies not has_next_step

end
