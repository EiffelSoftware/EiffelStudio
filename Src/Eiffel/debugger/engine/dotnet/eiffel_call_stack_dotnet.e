note
	description: "Eiffel call stack for the stopped application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class EIFFEL_CALL_STACK_DOTNET

inherit
	EIFFEL_CALL_STACK
		undefine
			is_equal, copy
		end

	TWO_WAY_LIST [CALL_STACK_ELEMENT]
		rename
			make as list_make
		export
			{NONE} list_make
		end
	SHARED_CONFIGURE_RESOURCES
		export
			{NONE} all
		undefine
			is_equal, copy
		end;

	EIFNET_EXPORTER
		undefine
			is_equal, copy
		end

	ICOR_EXPORTER
		undefine
			is_equal, copy
		end

	SHARED_IL_DEBUG_INFO_RECORDER
		export
			{NONE} all
		undefine
			is_equal, copy
		end

	SHARED_EIFNET_DEBUGGER
		export
			{NONE} all
		undefine
			is_equal, copy
		end

	SHARED_EIFNET_DEBUG_VALUE_FACTORY
		export
			{NONE} all
		undefine
			is_equal, copy
		end

create {APPLICATION_STATUS_DOTNET}
	make

create {EIFFEL_CALL_STACK_DOTNET}
	list_make, make_sublist

feature -- Properties

	stack_depth: INTEGER
			-- Current call stack depth.
		do
			-- FIXME jfiat: this is count for now ... but fix this !
			Result := count
		end

	error_occurred: BOOLEAN;
			-- Did an error occurred when retrieving the eiffel stack?

feature {NONE} -- Initialization

	make (n: INTEGER; tid: like thread_id)
			-- Fill `where' with the `n' first call stack elements.
			-- `where' is left empty if there is an error.
			-- Retrieve the whole call stack if `n' = -1.
		do
			debug ("DEBUGGER_TRACE_CALLBACK")
				io.error.put_string ("  @-> " + generator + ".make : starting%N")
			end
			make_empty (tid)
			reload (n)
		end

	make_empty (tid: like thread_id)
			-- Initialize only the first call stack element.
		do
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%TEIFFEL_CALL_STACK: Creating Empty Eiffel Stack%N"); end
			thread_id := tid
			error_occurred := False
			list_make
		end

feature -- Properties

	thread_id: POINTER
			-- Thread ID related to `Current'.

feature {APPLICATION_STATUS} -- Restricted access

	reload (n: INTEGER)
			--
		local
			call: CALL_STACK_ELEMENT
			eiffel_cse: CALL_STACK_ELEMENT_DOTNET
			external_cse: EXTERNAL_CALL_STACK_ELEMENT
			level: INTEGER

			l_thread: ICOR_DEBUG_THREAD
			l_enum_chain: ICOR_DEBUG_CHAIN_ENUM
			l_chain: ICOR_DEBUG_CHAIN
			l_enum_frames: ICOR_DEBUG_FRAME_ENUM
			l_chains: ARRAY [ICOR_DEBUG_CHAIN]
			l_frames: ARRAY [ICOR_DEBUG_FRAME]
			l_frame: ICOR_DEBUG_FRAME
			l_frame_il: ICOR_DEBUG_IL_FRAME

			c: INTEGER
			i: INTEGER

			l_func: ICOR_DEBUG_FUNCTION
			l_class: ICOR_DEBUG_CLASS
			l_module: ICOR_DEBUG_MODULE
			l_class_token: NATURAL_32
			l_feature_token: NATURAL_32
			l_module_name: STRING_32

			l_class_type: CLASS_TYPE

			l_feature_i: FEATURE_I
			l_line_number: INTEGER
			l_il_offset: INTEGER

			l_stack_object: ICOR_DEBUG_VALUE
			l_stack_adv: EIFNET_ABSTRACT_DEBUG_VALUE
			l_stack_drv: EIFNET_DEBUG_REFERENCE_VALUE
			l_extra_info: STRING_32
			addr: DBG_ADDRESS
			tid: like thread_id
		do
			clean
			wipe_out

			tid := thread_id
			level := 1
			l_thread := Eifnet_debugger.icor_debug_thread_by_id (tid)
			if l_thread /= Void then
				l_enum_chain := l_thread.enumerate_chains
				if l_thread.last_call_succeed and then l_enum_chain.get_count > 0 then
					l_enum_chain.reset
					l_chains := l_enum_chain.next (l_enum_chain.get_count)
					from
						c := l_chains.lower
					until
						c > l_chains.upper
					loop
						--| Let's iterate on each frame of the chain to determine the call stack items |--
						l_chain := l_chains.item (c)
						if l_chain /= Void then
							l_enum_frames := l_chain.enumerate_frames
							if l_chain.last_call_succeed and then l_enum_frames.get_count > 0 then
								l_enum_frames.reset
								l_frames := l_enum_frames.next (l_enum_frames.get_count)
								from
									i := l_frames.lower
								until
									i > l_frames.upper or else (n > 0 and level > n)
								loop
									l_frame := l_frames [i]
									l_frame_il := l_frame.query_interface_icor_debug_il_frame
									if l_frame.last_call_succeed and then l_frame_il /= Void then
											--| AT THIS POINT WE HAVE A VALID CALL STACK ELEMENT
											--| Let's see if this is a valid Eiffel CallStack Element

											-- Reset data for next call stack
										call := Void

										--| FIXME jfiat 2004-07-08 : maybe optimize by using external on pointer
										l_func := l_frame.get_function
										l_feature_token := l_func.token
										l_class         := l_func.get_class
										l_module        := l_func.get_module
										l_class_token   := l_class.token
										l_module_name   := l_module.name

										l_il_offset := l_frame_il.get_ip_as_integer_32
										l_stack_object := l_frame_il.get_argument (0)
										if l_stack_object /= Void then
											check
												stack_object_not_void: l_stack_object /= Void
											end

											if il_debug_info_recorder.has_info_about_module (l_module_name) then
												l_class_type := Il_debug_info_recorder.class_type_for_module_class_token (l_module_name, l_class_token)
												l_feature_i := Il_debug_info_recorder.feature_i_by_module_feature_token (l_module_name, l_feature_token)

												if l_class_type /= Void and then l_feature_i /= Void then
														--| FIXME jfiat 2004/06/03 : why Current may be Void ?
														--| If JITdebugging is enabled (badly), this may cause problem
														--| resulting in Void l_stack_object
														--| We may require to check this and fix this potential bug
														--| but this seems to be fixed by doing in the good way
														--| the JITdebugging settings
														--| Nota: we leave this comment, just in case this occurs again...

														--| Here we have a valid Eiffel callstack point

														--| Compute data to get address and co ...
													l_line_number := Il_debug_info_recorder.feature_eiffel_breakable_line_for_il_offset (l_class_type, l_feature_i, l_il_offset)
													l_stack_adv := debug_value_from_icdv (l_stack_object, l_class_type.associated_class)
													if l_stack_adv /= Void then
														addr := l_stack_adv.address
													else
														addr := Void
													end
													if addr /= Void then
														l_stack_drv ?= l_stack_adv
														if l_stack_drv /= Void then
															l_class_type := l_stack_drv.dynamic_class_type
														else
															l_class_type := l_stack_adv.dynamic_class.types.first
														end

														create eiffel_cse.make (level, tid, 0) -- 0: no SCOOP for dotnet
														eiffel_cse.set_private_current_object (l_stack_adv)
														eiffel_cse.set_routine (
															l_chain,
															l_frame,
															l_frame_il,
															False, 			-- is_melted (No since this is a dotnet system)
															addr,
															l_class_type, 	-- dynmic class type
															l_feature_i, 	-- routine, routine_name ...
															l_il_offset,
															l_line_number, 	-- break_index / line number
															0 -- FIXME: find a way to provide nested index .. if possible.
															)
														eiffel_cse.set_chain_frame_indexes (c, i)
														call := eiffel_cse
														extend (call)
														level := level + 1
													end

													eiffel_cse := Void
													l_stack_adv := Void
													l_stack_drv := Void

												end
											end
											if call = Void then
													-- Here we have an External CallStack
												create external_cse.make (level, tid, 0)  -- 0: no SCOOP for dotnet
												if l_stack_object /= Void then
													create addr.make_from_natural_64 (l_stack_object.get_address)
												else
													create addr.make_void
												end
												if attached l_module_name then
													l_extra_info := {STRING_32} "Module : " + l_module_name
												else
													l_extra_info := "no debug information"
												end
												external_cse.set_info (
														addr,
														thread_id,
														l_module.md_type_name (l_class_token),
														l_module.md_member_name (l_feature_token),
														l_il_offset, 0, -- FIXME: find a way to provide a nested index
														l_extra_info
													)
												call := external_cse
												external_cse := Void
												extend (call)
												level := level + 1
											end
										end

										l_class := Void
										l_func := Void
										l_module := Void
									end
									i := i + 1
								end
								l_enum_frames.clean_on_dispose
							end
						end
						c := c + 1
					end
					l_enum_chain.clean_on_dispose
				end
			end

			is_loaded := True
			debug ("DEBUGGER_TRACE_CALLBACK")
				io.error.put_string ("  @-> " + generator + ".make : finished%N")
			end
		end

feature -- cleaning

	clean
			-- Clean stored data
		local
			cse_d: CALL_STACK_ELEMENT_DOTNET
		do
			if not is_empty then
				from
					start
				until
					after
				loop
					cse_d ?= item
					if cse_d /= Void then
						cse_d.clean
					end
					forth
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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

end
