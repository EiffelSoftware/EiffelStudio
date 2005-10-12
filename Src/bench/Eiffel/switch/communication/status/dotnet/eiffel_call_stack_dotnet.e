indexing
	description: "Eiffel call stack for the stopped application."
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
	SHARED_APPLICATION_EXECUTION
		undefine
			is_equal, copy
		end

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

create {RUN_INFO, APPLICATION_STATUS_DOTNET}
	make

feature -- Properties

	stack_depth: INTEGER is
			-- 
		do
			-- FIXME jfiat: this is count for now ... but fix this !
			Result := count
		end

	error_occurred: BOOLEAN;
			-- Did an error occurred when retrieving the eiffel stack?

feature -- Output

	display_stack (st: STRUCTURED_TEXT) is
			-- Display callstack in `st'.
		local
			stack_num, i: INTEGER
			cs: CALL_STACK_ITEM
		do
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%TEIFFEL_CALL_STACK: Displaying stack %N"); end
			st.add_new_line;
			st.add_string ("Call stack:");
			st.add_new_line;
			st.add_new_line;
			create cs.do_nothing; -- For padding
			st.add (cs);
			st.add_string ("Object");
			st.add_column_number (14);
			st.add_string ("Class");
			st.add_column_number (26);
			st.add_string ("Routine");
			st.add_new_line;
			create cs.do_nothing; -- For padding
			st.add (cs);
			st.add_string ("------");
			st.add_column_number (14);
			st.add_string ("-----");
			st.add_column_number (26);
			st.add_string ("-------");
			st.add_new_line;

			debug ("DEBUGGER_TRACE"); io.error.put_string ("%TEIFFEL_CALL_STACK: getting stack number %N"); end
			stack_num := Application.current_execution_stack_number;

			debug ("DEBUGGER_TRACE"); io.error.put_string ("%TEIFFEL_CALL_STACK: processing %N"); end
			from
				start;
				i := 1
			until
				after
			loop
				if i = stack_num then
					create cs.make_selected (i);
				else
					create cs.make (i);
				end;
				st.add (cs)
				item.display_feature (st);
				st.add_new_line;
				forth;
				i := i + 1;
			end;
			st.add_new_line
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%TEIFFEL_CALL_STACK: end displaying call stack %N"); end
		end;

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Fill `where' with the `n' first call stack elements.
			-- `where' is left empty if there is an error.
			-- Retrieve the whole call stack if `n' = -1.
		local
			call	: CALL_STACK_ELEMENT
			eiffel_cse: CALL_STACK_ELEMENT_DOTNET
			external_cse: EXTERNAL_CALL_STACK_ELEMENT
			level	: INTEGER

			l_active_thread: ICOR_DEBUG_THREAD
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
			l_class_token: INTEGER
			l_feature_token: INTEGER
			l_module_name: STRING

			l_class_type: CLASS_TYPE

			l_feature_i : FEATURE_I
			l_line_number: INTEGER
			l_il_offset: INTEGER

			l_stack_object: ICOR_DEBUG_VALUE
			l_stack_adv: EIFNET_ABSTRACT_DEBUG_VALUE
			l_stack_drv: EIFNET_DEBUG_REFERENCE_VALUE
			l_hexaddress: STRING
			l_extra_info: STRING
		do
			debug ("DEBUGGER_TRACE_CALLBACK")
				io.error.put_string ("  @-> " + generator + ".make : starting%N")
			end
			error_occurred := False
			list_make

			level := 1

			l_active_thread := Eifnet_debugger.icor_debug_thread
			if l_active_thread /= Void then
				l_enum_chain := l_active_thread.enumerate_chains
				if l_active_thread.last_call_succeed and then l_enum_chain.get_count > 0 then
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
									l_frame := l_frames @ i
									l_frame_il := l_frame.query_interface_icor_debug_il_frame
									if l_frame.last_call_succeed and then l_frame_il /= Void then
											--| AT THIS POINT WE HAVE A VALID CALL STACK ELEMENT
											--| Let's see if this is a valid Eiffel CallStack Element

											-- Reset data for next call stack
										call := Void

	-- FIXME jfiat 2004-07-08 : maybe optimize by using external on pointer
										l_func := l_frame.get_function
										l_feature_token := l_func.get_token
										l_class         := l_func.get_class
										l_module        := l_func.get_module
										l_class_token   := l_class.get_token
										l_module_name   := l_module.get_name

										l_il_offset := l_frame_il.get_ip
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
													l_hexaddress := l_stack_adv.address
													if l_hexaddress /= Void then
														l_stack_drv ?= l_stack_adv
														if l_stack_drv /= Void then
															l_class_type := l_stack_drv.dynamic_class_type
														else
															l_class_type := l_stack_adv.dynamic_class.types.first
														end

														create eiffel_cse.make (level)
														eiffel_cse.set_private_current_object (l_stack_adv)
														eiffel_cse.set_routine (
															l_chain,
															l_frame,
															l_frame_il,
															False, 			-- is_melted (No since this is a dotnet system)
															l_hexaddress,
															l_class_type, 	-- dynmic class type
															l_feature_i, 	-- routine, routine_name ...
															l_il_offset,
															l_line_number 	-- break_index / line number
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
												create external_cse.make (level)
												if l_stack_object /= Void then
													l_hexaddress := "0x" + l_stack_object.get_address.to_integer.to_hex_string
												else
													l_hexaddress := "0x0"
												end
												if l_module_name /= Void then
													l_extra_info := "Module : " + l_module_name
												else
													l_extra_info := "no debug information"
												end
												external_cse.set_info (
														l_hexaddress,
														l_module.md_type_name (l_class_token),
														l_module.md_member_name (l_feature_token),
														l_il_offset,
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
			debug ("DEBUGGER_TRACE_CALLBACK")
				io.error.put_string ("  @-> " + generator + ".make : finished%N")
			end
		end

--	dummy_make is
--			-- Initialize only the first call stack element.
--		do
--			debug ("DEBUGGER_TRACE"); io.error.put_string ("%TEIFFEL_CALL_STACK: Creating dummy Eiffel Stack%N"); end
--			error_occurred := False
--			list_make
--		end

feature -- cleaning

	clean is
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

end -- class EIFFEL_CALL_STACK_DOTNET
