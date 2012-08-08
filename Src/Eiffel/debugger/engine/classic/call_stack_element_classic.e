note
	description	: "Information about a call in the calling stack."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision $"
	fixme: "Check retrieved arguments and locals validity"

class CALL_STACK_ELEMENT_CLASSIC

inherit
	EIFFEL_CALL_STACK_ELEMENT
		redefine
			make
		end

	OBJECT_ADDR

	RECV_VALUE
		export
			{NONE} all
			{EIFFEL_CALL_STACK} error
			{RECV_VALUE} reset_recv_value
		end

	COMPILER_EXPORTER

	DEBUG_VALUE_EXPORTER

	SHARED_EIFFEL_PROJECT

	SHARED_CONFIGURE_RESOURCES
		export
			{NONE} all
		end

	DEBUG_EXT
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	SHARED_INST_CONTEXT
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	INTERNAL_COMPILER_STRING_EXPORTER

	SHARED_ENCODING_CONVERTER

create {EIFFEL_CALL_STACK}
	make
create {STOPPED_HDLR, APPLICATION_EXECUTION_CLASSIC, APPLICATION_STATUS_CLASSIC}
	dummy_make

feature {NONE} -- Initialization

	make (level: INTEGER; tid: like thread_id)
		local
			retried: BOOLEAN
		do
			if not retried then
				Precursor (level, tid)

					-- set the private to a fake value
				private_body_index := -1

				debug ("DEBUGGER_TRACE")
					io.error.put_string ("%T%T" + generator + ": Creating item%N");
					io.error.put_string ("%T%T" + generator + ": init_recv_c%N");
				end
				Init_recv_c
				debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": init_rout_c%N"); end
				Init_rout_c
				debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": c_recv_rout_info%N"); end
				c_recv_rout_info (Current)

				debug ("DEBUGGER_TRACE")
					if is_exhausted then
						io.error.put_string("%T%TEXHAUSTED")
					else
						io.error.put_string("%T%T")
						io.error.put_string(routine_name)
					end
					io.error.put_new_line
				end
				debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": Finished creating%N"); end
			else
				is_not_valid := True
			end
		rescue
			retried := True
			retry
		end

	dummy_make (fe: E_FEATURE; lvl: INTEGER; mlt: BOOLEAN; a_bp, a_bp_nested: INTEGER; addr: DBG_ADDRESS;
				a_type: like dynamic_type; a_class: like dynamic_class; a_origin: like written_class)
			-- Initialize `Current' with no calls to the run-time.
		require
			addr_attached: addr /= Void
		do
			if fe /= Void then
				private_routine := fe
				routine_name := fe.name_8
				routine_name_for_display := fe.name_32
			else
				routine_name := "Unknown..."
				routine_name_for_display := routine_name
			end
			level_in_stack := lvl
			is_melted := mlt
			break_index := a_bp
			break_nested_index := a_bp_nested

				--| Dynamic type
			dynamic_type := a_type
				--| Dynamic Class
			if dynamic_type /= Void then
				dynamic_class := dynamic_type.associated_class
			end
			if dynamic_class = Void then
				dynamic_class := a_class
			end
			if dynamic_class /= Void then
				class_name := dynamic_class.name_in_upper
			end
				--| Written class (i.e: origin)
			written_class := a_origin

				--| Address and other

			object_address := addr
			object_address_to_string := object_address.output
				-- set the private body index to a fake value
			private_body_index := -1

			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": Creating item%N"); end
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": init_recv_c%N"); end
			init_recv_c
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": init_rout_c%N"); end
			init_rout_c
		end

feature -- Properties

	routine: E_FEATURE
			-- Routine being called
			-- Note: computation is deferred for optimization purpose
		do
			Result := private_routine
			if Result = Void then
				if not routine_name.is_empty then
					if written_class /= Void then
						Result := feature_from_runtime_data (dynamic_class, written_class, routine_name)
					end
				end
				private_routine := Result
			end
		end

	object_address: DBG_ADDRESS
			-- Hector address of associated object
			--| Because the debugger is already in communication with
			--| the application (retrieving information such as locals ...)
			--| it doesn't ask an hector address for that object until
			--| the "line" between the two processes is free.
			--| Initialially it is the physical address but is then
			--| protected in the `set_hector_addr_for_current_object' routine.

	current_object_value: ABSTRACT_DEBUG_VALUE
			-- Current object's value.
		local
			dobj: DEBUGGED_OBJECT
			ct: CLASS_TYPE
			add: DBG_ADDRESS
		do
			add := object_address
			if add /= Void and then not add.is_void then
				dobj := debugger_manager.object_manager.debugged_object (add, 0, 0)
				if dobj /= Void then
					ct := dobj.class_type
					if dobj.is_special then
						create {SPECIAL_VALUE} Result.make_set_ref (add, ct.type_id)
					else
						check not_expanded: not ct.is_expanded end
						create {REFERENCE_VALUE} Result.make (add, ct.type_id)
					end
				end
			end
		end

feature {EIFFEL_CALL_STACK} -- Implementation

	set_hector_addr (lst: SPECIAL [ABSTRACT_DEBUG_VALUE])
			-- Convert the physical addresses received from the application
			-- to hector addresses. (should be called only once just after
			-- all the information has been received from the application.)
		local
			i: INTEGER
		do
			check
				not_initialized: not initialized
				valid_values: lst /= Void
			end
			from
				i := 0
			until
				i >= lst.count
			loop
				lst[i].set_hector_addr
				i := i + 1
			end
		end

	set_hector_addr_for_current_object
			-- Convert the physical addresses received from the application
			-- to hector addresses. (should be called only once just after
			-- all the information has been received from the application.)
		do
			if object_address /= Void and then not object_address.is_void then
				object_address := keep_object_as_hector_address (object_address)
			end

				-- Now the address is correct and we can display it.
			object_address_to_string := object_address.output
		end

feature {NONE} -- Implementation

	retrieved_locals_and_arguments: TUPLE [args: detachable SPECIAL [ABSTRACT_DEBUG_VALUE]; locals: detachable SPECIAL [ABSTRACT_DEBUG_VALUE]]
		local
			l_values: ARRAYED_LIST [ABSTRACT_DEBUG_VALUE]
			l_args, l_locals: SPECIAL [ABSTRACT_DEBUG_VALUE]
		do
			debug ("DEBUGGER_TRACE");
				io.error.put_string (generator + ": receiving locals & arguments%N")
				io.error.put_string (generator + ": sending the request%N")
				io.error.put_string (generator + ": thread id = " + thread_id.out + ".%N")
			end

				-- Init
				--| note: this might be a nice enhancement to get first the number of arguments,locals,...
			create l_values.make (10)

				-- send the request			
			send_rqst_1 (Rqst_dump_variables, level_in_stack)

			--| ARGUMENTS |--

				-- Receive the arguments.
				-- (`item' is set to Void when no more values are expected.)
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": receiving the arguments%N"); end
			from
				debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": c_recv_value%N"); end
				if not error then
					recv_value (Current)
				end
			until
				error or item = Void
			loop
				debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": processing value : ARGUMENTS%N"); end
				l_values.extend (item)
				debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": c_recv_value%N"); end
				recv_value (Current)
			end
			if not l_values.is_empty then
				from
					create l_args.make_empty (l_values.count)
					l_values.start
				until
					l_values.after
				loop
					l_args.extend (l_values.item)
					l_values.forth
				end
			end


			--| LOCALS |--
			l_values.wipe_out

				-- Receive the local entities.
				-- user-defined, then loop variants and old expr, and finally the result if any.
				-- (`item' is set to Void when no more values are expected).
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": receiving the locals%N"); end
			from
				debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": c_recv_value%N"); end
				if not error then
					recv_value (Current)
				end
			until
				error or item = Void
			loop
				debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": processing value LOCALS%N"); end
				l_values.extend (item)
				debug ("DEBUGGER_TRACE"); io.error.put_string ("%T%T" + generator + ": c_recv_value%N"); end
				recv_value (Current)
			end
			reset_recv_value
			debug ("DEBUGGER_TRACE");
				io.error.put_string (generator + ": receiving locals & arguments COMPLETED %N")
			end
			if not l_values.is_empty then
				from
					create l_locals.make_empty (l_values.count)
					l_values.start
				until
					l_values.after
				loop
					l_locals.extend (l_values.item)
					l_values.forth
				end
			end

			Result := [l_args, l_locals]
		ensure
			result_attached: Result /= Void
		end

	initialize_stack
		local
			local_decl_grps: like local_decl_grps_from
			id_list: IDENTIFIER_LIST
			l_count: INTEGER
			value: ABSTRACT_DEBUG_VALUE
			args_locs_info: like retrieved_locals_and_arguments
			l_args, l_locals: detachable SPECIAL [ABSTRACT_DEBUG_VALUE]
			l_ot_locals: like private_object_test_locals_info
			l_type: detachable TYPE_A
			l_index, l_upper: detachable INTEGER
			locals_list: like private_locals
			args_list: like private_arguments
			arg_types: E_FEATURE_ARGUMENTS
			arg_names: LIST [STRING]
			rout_i: like routine_i
			counter: INTEGER
			l_names_heap: like Names_heap
			l_stat_class: CLASS_C
			l_old_group: CONF_GROUP
			l_old_class: CLASS_C
			l_wc: CLASS_C
			retried: BOOLEAN
			l_error_mesg: DUMMY_MESSAGE_DEBUG_VALUE
		do
			if not retried then
				debug ("DEBUGGER_TRACE_CALLSTACK")
					io.put_string (generator + ".initializing_stack: " + routine_name + " from "+ dynamic_class.name +"%N")
				end
				if is_melted and is_invariant_call_stack_element then
					l_args := Void
					create l_error_mesg.make_with_name ("Warning")
					l_error_mesg.set_message ("Unable to retrieve locals for melted invariant routine")
					create l_locals.make_filled (l_error_mesg, 1)
				else
					if not is_exhausted then
						if attached routine as r and then not r.is_attribute then
							args_locs_info := retrieved_locals_and_arguments -- get the values into `args_locs_info'							
							l_args := args_locs_info.args
							l_locals := args_locs_info.locals
						end
						if l_args /= Void then
							set_hector_addr (l_args)
						end
						if l_locals /= Void then
							set_hector_addr (l_locals)
						end
					end
				end
				debug ("DEBUGGER_TRACE_CALLSTACK"); io.put_string ("Finished retrieving locals and argument" + "%N"); end
				if attached routine as rout then
					if l_args /= Void then
						l_index := 0
						l_upper := l_args.count - 1
						counter := 1

						--l_count := feat.argument_count
						l_count := l_args.count
						if l_count > 0 then
							arg_types := rout.arguments
							if arg_types = Void then
								l_index := l_index + l_count
							else
								create args_list.make_filled (l_count)
								from
									arg_types.start
									arg_names := rout.argument_names
									arg_names.start
									args_list.start
								until
									args_list.after or l_index > l_upper
								loop
									value := l_args[l_index]
									value.set_item_number (counter)
									counter := counter + 1

									value.set_name (arg_names.item)
									if arg_types.item.has_associated_class then
										value.set_static_class (arg_types.item.base_class)
									end

									args_list.replace (value)
									args_list.forth
									arg_types.forth
									arg_names.forth
									l_index := l_index + 1
								end
							end
							check l_index > l_upper end
						end
						l_args := Void
					end

					if l_locals /= Void and then l_locals.count > 0 then

						l_old_group := inst_context.group
						inst_context.set_group (rout.associated_class.group)

						l_old_class := System.current_class
						System.set_current_class (dynamic_class)

						l_wc := rout.written_class
						--| check same_written_class: l_wc = written_class end
						--| FIXME IEK This check does not hold for unselected features or non-conforming features
						l_names_heap := Names_heap

						l_index := 0
						l_upper := l_locals.count - 1
						counter := 1

						create locals_list.make (l_locals.count)

						local_decl_grps := local_decl_grps_from (rout)
						rout_i := routine_i
							--| FIXME:jfiat: Could we have a more linear (1 level) list .. as object test locals?
						if local_decl_grps /= Void then
							from
								local_decl_grps.start
							until
								local_decl_grps.after or
								l_index > l_upper
							loop
								id_list := local_decl_grps.item.id_list
								if not id_list.is_empty then
									l_stat_class := static_class_for_local (local_decl_grps.item.type, rout_i, l_wc)
									from
										id_list.start
									until
										id_list.after or
										l_index > l_upper
									loop
										value := l_locals[l_index]
										value.set_item_number (counter)
										counter := counter + 1
										value.set_name (l_names_heap.item (id_list.item))
										if l_stat_class /= Void then
											value.set_static_class (l_stat_class)
										end

										locals_list.extend (value)
										id_list.forth
										l_index := l_index + 1
									end
								end
								local_decl_grps.forth
							end
						end
						if
							l_index <= l_upper and rout.has_return_value
						then
							private_result := l_locals[l_upper]
							l_upper := l_upper - 1
							private_result.set_name (once "Result")
							if rout.type.has_associated_class then
								private_result.set_static_class (rout.type.base_class)
							end
						end

						if l_index <= l_upper then
								--| Remaining locals, should be OT locals
							l_ot_locals := object_test_locals_info
							if l_ot_locals /= Void and then not l_ot_locals.is_empty then
								from
									l_ot_locals.start
								until
									l_index > l_upper or l_ot_locals.after
								loop
									value := l_locals[l_index]
									value.set_item_number (counter)
									counter := counter + 1
									value.set_name (l_names_heap.item (l_ot_locals.item_for_iteration.id.name_id))
									l_type := l_ot_locals.item.li.type
									if l_type /= Void then
										l_stat_class := static_class_for_local_from_type_a (l_type, rout_i, l_wc)
									else
										l_stat_class := Void
									end
									if l_stat_class /= Void then
										value.set_static_class (l_stat_class)
									end
									locals_list.extend (value)
									l_ot_locals.forth
									l_index := l_index + 1
								end
							end
						end

						if l_index <= l_upper then
								--| For some reason, there are remaining values on the stack
								--| let's considers them as locals
							from
							until
								l_index > l_upper
							loop
								value := l_locals[l_index]
								value.set_item_number (counter)
								value.set_name ("value #" + counter.out)
								counter := counter + 1
								locals_list.extend (value)
								l_index := l_index + 1
							end
						end
						check all_value_handled: l_index > l_upper end

						if l_old_group /= Void then
							inst_context.set_group (l_old_group)
						end
						if l_old_class /= Void then
							System.set_current_class (l_old_class)
						end

						check
							(rout.is_function implies locals_list.count = l_locals.count - 1 )
							or else locals_list.count = l_locals.count
						end
						l_locals := Void
					end
				end
				if args_list /= Void and then not args_list.is_empty then
					private_arguments := args_list
				end
				if locals_list /= Void and then not locals_list.is_empty then
					private_locals := locals_list
				end
				initialized := True
				debug ("DEBUGGER_TRACE_CALLSTACK"); io.put_string ("%TFinished initializating stack: " + routine_name + "%N"); end
			else
				set_error
				initialized := True
			end
		rescue
			set_error
			retried := True
			retry
		end

feature {NONE} -- Implementation Properties

	private_routine: like routine
			-- Associated routine

	object_address_to_string: STRING
			-- String representing the Address of the current
			-- Object for display purpose (may contain "Unavailable")

feature	{NONE} -- Initialization of the C/Eiffel interface

	init_rout_c
			-- Pass routine address to C.
		once
			c_pass_set_rout ($set_rout)
		end

	set_rout (melted, exhausted: BOOLEAN; object: STRING; origin: INTEGER; type: INTEGER; r_name: STRING; bp_index, bp_nested_index: INTEGER)
			-- See: C/ipc/ewb/ewb_dumper.c: c_recv_rout_info (..)
		local
			dt: like dynamic_type
		do
			if exhausted then
				is_exhausted := True
			else
				dt := Eiffel_system.type_of_dynamic_id (type + 1, False)
				dynamic_type := dt
				if dt /= Void then
					dynamic_class := dt.associated_class
					class_name := dynamic_class.name_in_upper
				end
				written_class := Eiffel_system.class_of_dynamic_id (origin + 1, False)

				break_index := bp_index
				break_nested_index := bp_nested_index
				object.to_upper
				object_address_to_string := "Unavailable"
				create object_address.make_from_string (object)
				is_melted := melted
				routine_name := r_name
				routine_name_for_display := encoding_converter.utf8_to_utf32 (r_name)
			end
		end

feature {EIFFEL_CALL_STACK} -- Implementation

	is_exhausted: BOOLEAN
			-- Has all the elements of the calling stack been
			-- received ?

feature {NONE} -- externals

	c_recv_rout_info (c: like Current)
		external
			"C"
		end

	c_pass_set_rout (d_rout: POINTER)
		external
			"C"
		end

invariant

	non_empty_args_if_exists: private_arguments /= Void implies
				not private_arguments.is_empty
	non_empty_locs_if_exists: private_locals /= Void implies
				not private_locals.is_empty
	valid_level: level_in_stack >= 1

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

end -- class CALL_STACK_ELEMENT_CLASSIC
