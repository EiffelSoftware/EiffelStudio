note

	description:

		"Testing strategy for automated random testing"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_RANDOM_STRATEGY

inherit

	AUT_STRATEGY
		redefine
			make,
			start,
			cancel
		end

	ERL_G_TYPE_ROUTINES
		export
			{NONE} all
		end

	AUT_SHARED_INTERPRETER_INFO
		export
			{NONE} all
		end

create

	make

feature {NONE} -- Initialization

	make (a_interpreter: like interpreter; a_system: like system; an_error_handler: like error_handler)
			-- Create new strategy.
		do
			Precursor (a_interpreter, a_system, an_error_handler)
			create queue.make (system)
			create types_under_test.make_default
			create classes_under_test.make_default
			classes_under_test.set_equality_tester (create {AUT_CLASS_EQUALITY_TESTER}.make)
		end

feature -- Status

	has_next_step: BOOLEAN
		do
			Result := sub_task /= Void and then sub_task.has_next_step
		end

feature -- Access

	queue: AUT_DYNAMIC_PRIORITY_QUEUE
			-- Feature queue

	selected_feature: AUT_FEATURE_OF_TYPE
			-- Currently selected feature;
			-- `Void' if none is selected.

	types_under_test: DS_ARRAYED_LIST [CL_TYPE_A]
			-- Types under test

	classes_under_test: DS_ARRAYED_LIST [CLASS_C]
			-- Classes under test

feature -- Element change

	add_class_names (a_list: detachable DS_LIST [STRING_8])
			-- Add class/type names which shall be tested to `queue', `types_under_test' and
			-- `classes_under_test' with list of class names.
			--
			-- `a_list': List of class/type names, can be void or empty to indicate that all classes in the
			--           system should be tested.
		require
			not_has_next_step: not has_next_step
		local
			l_tester: KL_STRING_EQUALITY_TESTER_A [STRING]
			l_class_set: DS_HASH_SET [CLASS_I]
			l_class_cur: DS_HASH_SET_CURSOR [CLASS_I]
			l_type: TYPE_A
			l_class_name_set: DS_HASH_SET [STRING]
			l_name_cur: DS_HASH_SET_CURSOR [STRING]
			l_name: STRING
		do

			create l_tester
			if a_list /= Void and then not a_list.is_empty then
				create l_class_name_set.make (a_list.count)
				l_class_name_set.set_equality_tester (l_tester)
				l_class_name_set.append (a_list)
			else
					-- If no type name is given explictly, we test all compiled classes in the system.
				l_class_set := system.universe.all_classes
				create l_class_name_set.make (l_class_set.count)
				l_class_name_set.set_equality_tester (l_tester)
				from
					l_class_cur := l_class_set.new_cursor
					l_class_cur.start
				until
					l_class_cur.after
				loop
					l_name := l_class_cur.item.name
					check l_name /= Void end
					l_class_name_set.force_last (l_name)
					l_class_cur.forth
				end
			end

			from
				l_name_cur := l_class_name_set.new_cursor
				l_name_cur.start
			until
				l_name_cur.after
			loop
				l_type := base_type (l_name_cur.item)
				if l_type /= Void then
					if l_type.associated_class.is_generic then
						if not attached {GEN_TYPE_A} l_type as l_gen_type then
							if attached {GEN_TYPE_A} l_type.associated_class.actual_type as l_gen_type2 then
								l_type := generic_derivation_of_type (l_gen_type2, l_gen_type2.associated_class)
							else
								check
									dead_end: False
								end
							end
						end
					end
					if attached {CL_TYPE_A} l_type as l_class_type then
							-- Only compiled classes are taken into consideration.
						if l_class_type.associated_class /= Void then
							if not interpreter_related_classes.has (l_class_type.name) then
								types_under_test.force_last (l_class_type)
								queue.set_static_priority_of_type (l_class_type, 10)
								if l_class_type.has_associated_class then
									classes_under_test.force_last (l_class_type.associated_class)
								end
							end
						end
					else
						check
							dead_end: False
						end
					end
				end
				l_name_cur.forth
			end
		end

feature -- Execution

	start
			-- <Precursor>
		do
			Precursor
			interpreter.set_is_in_replay_mode (False)
			assign_void
			if queue.highest_dynamic_priority > 0 then
				select_new_sub_task
			end
		end

	cancel
		do
			sub_task := Void
			interpreter.stop
		end

	step
		do
			if interpreter.is_running and interpreter.is_ready then
				sub_task.step
			end
			if interpreter.is_running and not interpreter.is_ready then
				interpreter.stop
			end
			if not interpreter.is_running then
				if sub_task /= Void then
					sub_task.cancel
				end
				interpreter.start
				assign_void
			end
			if not sub_task.has_next_step then
				if queue.highest_dynamic_priority > 0 then
					select_new_sub_task
				else
					sub_task := Void
				end
			end
		end

feature {NONE} -- Implementation

	select_new_sub_task
			-- Select new task and make it available via `sub_task'.
		require
			positive_priority: queue.highest_dynamic_priority > 0
		local
			caller: AUT_RANDOM_FEATURE_CALLER
			creator: AUT_RANDOM_OBJECT_CREATOR
			l_selected_type: TYPE_A
			l_selected_feature: FEATURE_I
		do
			queue.select_next

			selected_feature := queue.last_feature
			l_selected_feature := selected_feature.feature_
			l_selected_type := selected_feature.type

			if selected_feature.is_creator then
				create creator.make_with_queue (system, interpreter, l_selected_type, feature_table, queue)
				creator.set_creation_procedure (l_selected_feature)
				sub_task := creator
			else
				create caller.make (system, interpreter, queue, error_handler, feature_table)
				caller.set_feature_and_type (l_selected_feature, l_selected_type)
				sub_task := caller
			end

				-- Start sub task.
			sub_task.start
			error_handler.report_feature_selection (l_selected_type, l_selected_feature)
		end

	sub_task: AUT_TASK
			-- Current sub task

	feature_table: HASH_TABLE [ARRAY [FEATURE_I], CLASS_C]
			-- Table to store features in a class (Used for cache)
			-- [List of a feature in a class, class]
		do
			if feature_table_internal = Void then
				create feature_table_internal.make (10)
			end
			Result := feature_table_internal
		ensure
			result_attached: Result /= Void
		end

	feature_table_internal: like feature_table
			-- Implementation of `feature_table'

	assign_void
			-- Assign void to the next free variable.
		local
			void_constant: ITP_CONSTANT
		do
			if interpreter.is_running and interpreter.is_ready then
				create void_constant.make (Void)
				interpreter.assign_expression (interpreter.variable_table.new_variable, void_constant)
			end
		end

invariant
	queue_not_void: queue /= Void
	error_handler_not_void: error_handler /= Void
	interpreter_not_in_replay_mode: not interpreter.is_replaying

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
