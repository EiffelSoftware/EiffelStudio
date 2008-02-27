indexing
	description	: "Information about a call in the calling stack."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision $"

class CALL_STACK_ELEMENT_DOTNET

inherit
	EIFFEL_CALL_STACK_ELEMENT
		rename
			current_object_value as current_object
		redefine
			make
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	DEBUG_VALUE_EXPORTER
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_CONFIGURE_RESOURCES
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	SHARED_EIFNET_DEBUG_VALUE_FACTORY
		export
			{NONE} all
		undefine
			error_value
		end

	ICOR_EXPORTER -- debug trace purpose
		export
			{NONE} all
		end

	SHARED_EIFNET_DEBUGGER

	SHARED_INST_CONTEXT

	SHARED_WORKBENCH

create {EIFFEL_CALL_STACK}
	make
--create {APPLICATION_EXECUTION_DOTNET}
--	dummy_make

feature {NONE} -- Initialization

	make (level: INTEGER; tid: INTEGER) is
		do
			Precursor (level, tid)
			private_body_index := -1
		end

feature -- Filling

	set_routine (a_chain: ICOR_DEBUG_CHAIN;
			a_frame: ICOR_DEBUG_FRAME; a_il_frame: ICOR_DEBUG_IL_FRAME;
			melted: BOOLEAN; a_address: STRING;
			a_dyn_type: CLASS_TYPE;
			a_feature: FEATURE_I;
			a_il_offset: INTEGER; a_line_number: INTEGER) is
		local
			l_routine: E_FEATURE
		do
			icd_chain := a_chain
			icd_chain.add_ref

			icd_frame := a_frame
			icd_frame.add_ref

			icd_il_frame := a_il_frame
			icd_il_frame.add_ref

			il_offset := a_il_offset

			dynamic_type := a_dyn_type
			if dynamic_type /= Void then
				dynamic_class := dynamic_type.associated_class
				class_name := dynamic_class.name_in_upper
			end
			written_class := a_feature.written_class
			if a_line_number = 0 then
				break_index := 1
			else
				break_index := a_line_number
			end

			object_address := a_address
			object_address_to_string := object_address
			if object_address_to_string = Void or else object_address_to_string.is_equal ("0x00000000") then
				object_address_to_string := "Unavailable"
			end

			is_melted := melted
			routine_name := a_feature.feature_name
			routine := a_feature.e_feature

				-- Adapt `routine' to `dynamic_class' and handles precursor case.
			if dynamic_class /= written_class and then
				(not routine.is_inline_agent) and then
				dynamic_class.simple_conform_to (written_class)
			then
				l_routine := dynamic_class.feature_with_rout_id (a_feature.rout_id_set.first)
				if l_routine.written_in = written_class.class_id then
					-- Not the precursor case.
					routine := l_routine
				end
			end
			private_body_index := -1
		end

feature -- Cleaning

	clean is
			-- Clean stored data
		do
-- FIXME jfiat 2004-07-07 : seems to cause issue regarding ref
-- so for now we remove it, but please check deeper how to better handle ICorDebugFrame and so on
--					--| FIXME JFIAT: please check if it is safe ...
			icd_frame := Void
			icd_il_frame := Void
			icd_chain := Void
		end

feature -- Dotnet Properties

	icd_frame: ICOR_DEBUG_FRAME

	icd_il_frame: ICOR_DEBUG_IL_FRAME

	icd_chain: ICOR_DEBUG_CHAIN

	il_offset: INTEGER

feature {EIFFEL_CALL_STACK_DOTNET} -- Query

	chain_index, frame_index: INTEGER
			-- Chain and Frame index used to be able to refresh
			-- the icd_chain and icd_frame values

	set_chain_frame_indexes (vc, vf: INTEGER) is
		do
			chain_index := vc
			frame_index := vf
		end

	refresh_icd_data is
			-- Refresh the icd_chain and icd_frame values
		local
			l_active_thread: ICOR_DEBUG_THREAD
			l_enum_chain: ICOR_DEBUG_CHAIN_ENUM
			l_enum_frames: ICOR_DEBUG_FRAME_ENUM
			l_chain: ICOR_DEBUG_CHAIN
			l_frame: ICOR_DEBUG_FRAME
		do
			l_active_thread := Eifnet_debugger.icor_debug_thread
			if l_active_thread /= Void then
				l_enum_chain := l_active_thread.enumerate_chains
				if l_enum_chain /= Void then
					if l_enum_chain.get_count >= chain_index then
						l_chain := l_enum_chain.i_th (chain_index)
						if l_chain /= Void then
							l_chain.add_ref
							if icd_chain /= Void then
								icd_chain.clean_on_dispose
							end
							icd_chain := l_chain
							l_enum_frames := icd_chain.enumerate_frames
							if l_enum_frames /= Void then
								if l_enum_frames.get_count >= frame_index then
									l_frame := l_enum_frames.i_th (frame_index)
									if l_frame /= Void then
										l_frame.add_ref
										if icd_frame /= Void then
											icd_frame.clean_on_dispose
										end
										icd_frame := l_frame
										if icd_il_frame /= Void then
											icd_il_frame.clean_on_dispose
										end
										icd_il_frame := icd_frame.query_interface_icor_debug_il_frame
										check
											same_ip: il_offset = icd_il_frame.get_ip
										end
									end
								end
								l_enum_frames.clean_on_dispose
							end
						end
					end
					l_enum_chain.clean_on_dispose
				end
			end
		end

	fresh_icd_il_frame: ICOR_DEBUG_IL_FRAME is
			-- Fresh ICorDebugILFrame value.
		do
			Result := icd_frame.query_interface_icor_debug_il_frame
			if Result = Void then
				refresh_icd_data
				Result := icd_il_frame
			end
		end

feature -- Properties

	routine: E_FEATURE
			-- Routine being called
			-- Note from Arnaud: Computation has been deferred for optimisation purpose

	object_address: STRING
			-- Hector address of associated object
			--| Because the debugger is already in communication with
			--| the application (retrieving information such as locals ...)
			--| it doesn't ask an hector address for that object until
			--| the "line" between the two processes is free.
			--| Initialially it is the physical address but is then
			--| protected in the `set_hector_addr_for_current_object' routine.

feature -- Current object

	current_object: EIFNET_ABSTRACT_DEBUG_VALUE is
			-- Current object value
		do
			Result := private_current_object
			if Result = Void and then not initialized_current_object then
				initialize_stack_for_current_object
				Result := private_current_object
			end
		end

	set_private_current_object (c: like private_current_object) is
			-- Set current object value
			-- without initializing the full stack...
		do
			private_current_object := c
		end

feature -- Dotnet Properties

	dotnet_class_token: INTEGER is
			--
		do
			if not dotnet_initialized then
				initialize_dotnet_info
			end
			Result := private_dotnet_class_token
		end

	dotnet_feature_token: INTEGER is
			--
		do
			if not dotnet_initialized then
				initialize_dotnet_info
			end
			Result := private_dotnet_feature_token
		end

	dotnet_module_name: STRING is
			--
		do
			if not dotnet_initialized then
				initialize_dotnet_info
			end
			Result := private_dotnet_module_name
		end

	dotnet_module_filename: STRING is
			--
		do
			if not dotnet_initialized then
				initialize_dotnet_info
			end
			Result := private_dotnet_module_filename
		end

feature {NONE} -- Implementation Dotnet Properties

	dotnet_initialized: BOOLEAN
			-- Is the dotnet stack initialized

	initialized_current_object,
	initialized_arguments,
	initialized_locals: BOOLEAN

	private_dotnet_class_token: INTEGER

	private_dotnet_feature_token: INTEGER

	private_dotnet_module_name: STRING

	private_dotnet_module_filename: STRING

feature {NONE} -- Implementation Properties

	private_current_object: EIFNET_ABSTRACT_DEBUG_VALUE
			-- Current object value

	object_address_to_string:like object_address

feature {NONE} -- Implementation

	initialize_dotnet_info is
			--
		local
			l_function: ICOR_DEBUG_FUNCTION
			l_class: ICOR_DEBUG_CLASS
			l_module: ICOR_DEBUG_MODULE
			l_icd_th: ICOR_DEBUG_THREAD
			retried: BOOLEAN
			l_frame: ICOR_DEBUG_FRAME
			l_il_frame: ICOR_DEBUG_IL_FRAME
		do
			if not retried then
				l_il_frame := fresh_icd_il_frame
				if l_il_frame /= Void then
					l_il_frame.add_ref
					l_function := l_il_frame.get_function
					l_il_frame.clean_on_dispose
				end

				if l_function = Void then
						--| FIXME jfiat: Nasty fix, since we use the top level stack frame
					l_icd_th := Eifnet_debugger.icor_debug_thread
					l_frame := l_icd_th.get_active_frame
					if l_frame /= Void then
						l_il_frame := l_frame.query_interface_icor_debug_il_frame
						l_function := l_il_frame.get_function
						l_il_frame.clean_on_dispose
						l_frame.clean_on_dispose
					end
				end

				if l_function /= Void then
					private_dotnet_feature_token := l_function.get_token
					l_class := l_function.get_class
					l_module := l_function.get_module

					private_dotnet_class_token := l_class.get_token
					private_dotnet_module_name := l_module.module_name
					private_dotnet_module_filename := l_module.get_name
				end
				dotnet_initialized := True
			else
				dotnet_initialized := True
			end
		ensure
			dotnet_initialized
		rescue
			retried := True
			retry
		end

	initialize_stack_for_current_object is
		local
			cobj: EIFNET_ABSTRACT_DEBUG_VALUE
		do
			if Eifnet_debugger.exit_process_occurred then
				debug ("debugger_trace_callstack_data")
					print ("EXIT_PROCESS OCCURRED !!!%N")
				end
				initialized_current_object := True
			elseif not initialized_current_object then
				debug ("debugger_trace_callstack_data")
					io.put_string ("<start> " + generator + ".initialize_stack_for_current_object %N")
				end
					--| Current and Arguments |--
				cobj := internal_current_object
				if cobj= Void and private_current_object /= Void then
					cobj := private_current_object
				end
				set_private_current_object (cobj)
				if private_current_object /= Void then
					private_current_object.set_name ("Current")
					object_address := private_current_object.address
					object_address_to_string := object_address
				end
				initialized_current_object := True

				debug ("debugger_trace_callstack_data")
					io.put_string ("<stop> " + generator + ".initialize_stack_for_current_object %N")
				end
			end
		end

	initialize_stack_for_arguments is
		local
			l_count			: INTEGER
			value			: ABSTRACT_DEBUG_VALUE
			args_list		: like private_arguments
			arg_names		: LIST [STRING]
			arg_types		: E_FEATURE_ARGUMENTS
			rout			: like routine
			counter			: INTEGER
			l_list			: LIST [EIFNET_ABSTRACT_DEBUG_VALUE]
		do
			if Eifnet_debugger.exit_process_occurred then
				debug ("debugger_trace_callstack_data")
					print ("EXIT_PROCESS OCCURRED !!!%N")
				end
				initialized_arguments := True
			elseif not initialized_arguments then
				debug ("debugger_trace_callstack_data")
					io.put_string ("<start> " + generator + ".initialize_stack_for_arguments"
						+ " {" + dynamic_class.name_in_upper + "}." + routine_name	+ "%N")
				end
				rout := routine
				if rout /= Void then

					--| Current and Arguments |--
					l_list := internal_arg_list
					if l_list /= Void and then not l_list.is_empty then
						--| Get Arguments
						l_count := rout.argument_count
						if l_count > 0 and not l_list.is_empty then
--| FIXME jfiat [2004/08/24] : check why l_list could be empty at this point
							create args_list.make_filled (l_count)
							arg_names := rout.argument_names
							arg_types := rout.arguments
							from
								arg_names.start
								arg_types.start

								args_list.start
								l_list.start
							until
								args_list.after
							loop
								value := l_list.item
								value.set_name (arg_names.item)
								if arg_types.item.has_associated_class then
									value.set_static_class (arg_types.item.associated_class)
								end
								args_list.replace (value)
								args_list.forth
								arg_names.forth
								arg_types.forth
								l_list.forth
							end

								--| initialize item numbers for arguments
							if args_list /= Void then
								from
									args_list.start
									counter := 1
								until
									args_list.after
								loop
									args_list.item.set_item_number (counter)
									args_list.forth
									counter := counter + 1
								end
							end
						end
					end
				end

					--| Associate to private list |--
				private_arguments := args_list
				initialized_arguments := True

				debug ("debugger_trace_callstack_data")
					io.put_string ("<stop> " + generator + ".initialize_stack_for_arguments"
						+ " {" + dynamic_class.name_in_upper + "}." + routine_name	+ "%N")
				end
			end
		end

	initialize_stack_for_locals is
		require
			initialized_current_object
		local
			local_decl_grps: EIFFEL_LIST [TYPE_DEC_AS]
			l_ot_locals: like object_test_locals_from
			id_list: IDENTIFIER_LIST
			l_index: INTEGER
			l_count: INTEGER
			value: ABSTRACT_DEBUG_VALUE
			locals_list: like private_locals
			rout: like routine
			rout_i: like routine_i
			counter: INTEGER
			l_names_heap: like Names_heap
			l_list: LIST [EIFNET_ABSTRACT_DEBUG_VALUE]
			l_dotnet_ref_value: EIFNET_DEBUG_REFERENCE_VALUE
			l_stat_class: CLASS_C
			l_old_group: CONF_GROUP
			l_old_class: CLASS_C
			l_wc: CLASS_C
		do
			if Eifnet_debugger.exit_process_occurred then
				debug ("debugger_trace_callstack_data")
					print ("EXIT_PROCESS OCCURRED !!!%N")
				end
				initialized_locals := True
			elseif not initialized_locals then
				debug ("debugger_trace_callstack_data")
					io.put_string ("<start> " + generator + ".initialize_stack_for_locals"
						+ " {" + dynamic_class.name_in_upper + "}." + routine_name	+ "%N")
				end
				rout := routine
				if rout /= Void then
					l_list := internal_local_list

					--| Result |--
					private_result := Void
					if rout.is_function then
						if rout.is_once then
								--| In IL generated code .. for once function
								--| no local variable to store the Result
								--| using directly  "return value"

								--| However now (2006-05-12),
								--| there is a generated "unused" local variable
								--| thus we have to skip this local
								--| if the generated IL code is changed to get rid of this unused local
								--| Please let me know (jfiat)
							if l_list /= Void and then not l_list.is_empty then
								l_list.start
								l_list.remove
							end

								--| at this point, the private_current_object is known
							l_dotnet_ref_value ?= private_current_object
							if l_dotnet_ref_value /= Void then
								l_dotnet_ref_value.get_object_value
								if l_dotnet_ref_value.object_value /= Void then
									private_result := l_dotnet_ref_value.once_function_value (rout)
									l_dotnet_ref_value.release_object_value
								end
							end
						else -- not once
							-- First Local is the Result value, so we take it first
							if l_list /= Void and then not l_list.is_empty then
								l_list.start
								private_result := l_list.first
								l_list.remove
							end
						end
						if private_result /= Void then
							private_result.set_name (once "Result")
							if rout.type.has_associated_class then
								private_result.set_static_class (rout.type.associated_class)
							end
						end
					end
					--| now the result value has been removed
					--| let's get the real Local variables

					--| LOCAL |--
					if l_list /= Void and then not l_list.is_empty then
						l_old_group := inst_context.group
						Inst_context.set_group (rout.associated_class.group)

						l_old_class := System.current_class
						System.set_current_class (dynamic_class)

						rout_i := routine_i
						l_wc := rout_i.written_class
						l_names_heap := Names_heap

						l_count := l_list.count
						l_index := 0
						l_list.start
						counter := 1

						create locals_list.make (l_count)

						local_decl_grps := local_decl_grps_from (rout)
						if local_decl_grps /= Void then
							from
								local_decl_grps.start
							until
								local_decl_grps.after or
								l_index > l_count
							loop
								id_list := local_decl_grps.item.id_list
								if not id_list.is_empty then
									l_stat_class := static_class_for_local (local_decl_grps.item.type, rout_i, l_wc)
									from
										id_list.start
									until
										id_list.after or
										l_index > l_count
									loop
										value := l_list.item
										value.set_item_number (counter)
										counter := counter + 1
										value.set_name (l_names_heap.item (id_list.item))
										if l_stat_class /= Void then
											value.set_static_class (l_stat_class)
										end

										locals_list.extend (value)
										id_list.forth
										l_list.forth
										l_index := l_index + 1
									end
								end
								local_decl_grps.forth
							end
						end
						if not l_list.after then
								--| Remaining locals, should be OT locals
							l_ot_locals := object_test_locals_from (rout)
							if l_ot_locals /= Void and then not l_ot_locals.is_empty then
								from
									l_ot_locals.start
								until
									l_list.after or l_ot_locals.after
								loop
									value := l_list.item
									value.set_item_number (counter)
									counter := counter + 1
									value.set_name (l_names_heap.item (l_ot_locals.item.id.name_id))
									l_stat_class := static_class_for_local (l_ot_locals.item.type, rout_i, l_wc)
									if l_stat_class /= Void then
										value.set_static_class (l_stat_class)
									end
									locals_list.extend (value)
									l_ot_locals.forth
									l_list.forth
								end
							end
						end
						if l_old_group /= Void then
							inst_context.set_group (l_old_group)
						end
						if l_old_class /= Void then
							System.set_current_class (l_old_class)
						end
					end -- l_list not empty
				end

					--| Associate to private list |--
				private_locals := locals_list
				initialized_locals := True

				debug ("debugger_trace_callstack_data")
					io.put_string ("<stop> " + generator + ".initialize_stack_for_locals"
						+ " {" + dynamic_class.name_in_upper + "}." + routine_name	+ "%N")
				end
			end
		end

	initialize_stack is
		do
			initialize_stack_for_current_object
			initialize_stack_for_arguments
			initialize_stack_for_locals
			initialized := initialized_current_object
						and initialized_arguments
						and initialized_locals
		end

	internal_current_object: EIFNET_ABSTRACT_DEBUG_VALUE  is
		require
			icd_frame /= Void
		local
			l_il_frame: ICOR_DEBUG_IL_FRAME
			l_enum_args: ICOR_DEBUG_VALUE_ENUM
			l_array_objects: ARRAY [ICOR_DEBUG_VALUE]
		do
			l_il_frame := fresh_icd_il_frame
			if l_il_frame /= Void then
				l_il_frame.add_ref
				l_enum_args := l_il_frame.enumerate_arguments
				if l_enum_args /= Void then
					if l_enum_args.get_count > 0 then
						l_enum_args.reset
						l_array_objects := l_enum_args.next (1)
						Result := debug_value_from_icdv (l_array_objects @ (l_array_objects.lower), dynamic_class)
					end
					l_enum_args.clean_on_dispose
				end
				l_il_frame.clean_on_dispose
			end
		end

	internal_arg_list: LIST [EIFNET_ABSTRACT_DEBUG_VALUE]  is
		require
			icd_frame /= Void
		local
			l_il_frame: ICOR_DEBUG_IL_FRAME
			l_enum: ICOR_DEBUG_VALUE_ENUM
		do
			l_il_frame := fresh_icd_il_frame
			if l_il_frame /= Void then
				l_il_frame.add_ref
				l_enum := l_il_frame.enumerate_arguments
				if l_enum /= Void then
					l_enum.reset
						-- Ignore first element which is Current Object
					if l_enum.get_count > 0 then
						l_enum.skip (1)
							-- Then process the following values (arguments)
						Result := debug_value_list_from_enum (l_enum, l_enum.get_count - 1)
					end
					l_enum.clean_on_dispose
				end
				l_il_frame.clean_on_dispose
			end
		end

	internal_local_list: LIST [EIFNET_ABSTRACT_DEBUG_VALUE]  is
			-- Return list of Value for local var,
			-- including the Result if there is one, in this case
			-- this will be the first value
		require
			icd_frame /= Void
		local
			l_il_frame: ICOR_DEBUG_IL_FRAME
			l_enum: ICOR_DEBUG_VALUE_ENUM
		do
			l_il_frame := fresh_icd_il_frame
			if l_il_frame /= Void then
				l_il_frame.add_ref
				l_enum := l_il_frame.enumerate_local_variables
				if l_enum /= Void then
					l_enum.reset
					Result := debug_value_list_from_enum (l_enum, l_enum.get_count)
					l_enum.clean_on_dispose
				else
					create {LINKED_LIST [EIFNET_ABSTRACT_DEBUG_VALUE]} Result.make
				end
				l_il_frame.clean_on_dispose
			end
		end

	debug_value_list_from_enum (a_enum: ICOR_DEBUG_VALUE_ENUM; a_enum_elts: INTEGER): LIST [EIFNET_ABSTRACT_DEBUG_VALUE] is
		require
			a_enum /= Void
		local
			l_objects_count_to_get: INTEGER
			l_array_objects: ARRAY [ICOR_DEBUG_VALUE]
			l_object_index: INTEGER
			l_icd_val: ICOR_DEBUG_VALUE
			l_abstract_debug_value: EIFNET_ABSTRACT_DEBUG_VALUE
		do
			-- Nota: do not do any reset on a_enum here,
			-- since we may have move the index to start after the first item
			-- for instance to get only arguments (for eiffel feature)
			l_objects_count_to_get := a_enum_elts
			if l_objects_count_to_get > 0 then
				create {LINKED_LIST [EIFNET_ABSTRACT_DEBUG_VALUE]} Result.make
				l_array_objects := a_enum.next (l_objects_count_to_get)
				if a_enum.last_call_succeed then
					from
						l_object_index := l_array_objects.lower
					until
						l_object_index > l_array_objects.upper --| or else l_object_index > nb_object -- FIXME: JFIAT
					loop
						l_icd_val := l_array_objects @ l_object_index
						if l_icd_val /= Void then
							l_abstract_debug_value := debug_value_from_icdv (l_icd_val, Void)
							Result.extend (l_abstract_debug_value)
						end
						l_object_index := l_object_index + 1
					end
				end
			end
			--| NOTA: JFIAT : maybe return Empty List .. not Void ...
		end

invariant

--	non_empty_args_if_exists: private_arguments /= Void implies
--				not private_arguments.is_empty
--	non_empty_locs_if_exists: private_locals /= Void implies
--				not private_locals.is_empty
--	valid_level: level_in_stack >= 1

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

end -- class CALL_STACK_ELEMENT_DOTNET
