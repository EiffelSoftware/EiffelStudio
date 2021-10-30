note
	description: ".NET breakpoint management"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFNET_DEBUGGER_BREAKPOINT_INFO

inherit
	ICOR_EXPORTER

feature {EIFNET_DEBUGGER_INFO_ACCESSOR} -- Access

	eifnet_breakpoint (a_module_name: READABLE_STRING_32; a_class_token, a_feature_token: NATURAL_32 a_line: INTEGER): EIFNET_BREAKPOINT
			-- EIFNET_BREAKPOINT corresponding to module,class,feature and line parameters
		local
			l_bp: EIFNET_BREAKPOINT
		do
			create l_bp.make (Void, resolved_module_key (a_module_name), a_class_token, a_feature_token, a_line)
			if breakpoints.has (l_bp) then
				Result := breakpoints.item (l_bp)
			end
		end

	request_breakpoint_add (a_bp_loc: BREAKPOINT_LOCATION; a_module_name: READABLE_STRING_GENERAL; a_class_token, a_feature_token: NATURAL_32; a_line: INTEGER)
			-- request a new breakpoint addition
		local
			l_bp: EIFNET_BREAKPOINT
			l_succeed: BOOLEAN
		do
			debug ("debugger_trace_breakpoint")
				io.error.put_string ("Request Add BP - line=" + a_line.to_hex_string+ "%N")
				io.error.put_string ("%T Module = " + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (a_module_name) + " %N")
				io.error.put_string ("%T ClassToken = "+ a_class_token.out + "~0x" + a_class_token.to_hex_string+" %N")
				io.error.put_string ("%T FeatureTok = "+ a_feature_token.out + "~0x" + a_feature_token.to_hex_string+" %N")
				io.error.put_string ("%N")
			end
			create l_bp.make (a_bp_loc, resolved_module_key (a_module_name.as_string_32), a_class_token, a_feature_token, a_line)
			l_bp.activate

			register_bp_for_addition (l_bp)
			l_succeed := process_breakpoint_addition (l_bp)
			if l_succeed then
				move_bp_to_active_breakpoints (l_bp)
			end
		end

	request_breakpoint_remove (a_bp_loc: BREAKPOINT_LOCATION; a_module_name: READABLE_STRING_GENERAL; a_class_token, a_feature_token: NATURAL_32; a_line: INTEGER)
			-- request a breakpoint removal
		local
			l_bp: EIFNET_BREAKPOINT
			l_icd_bp: ICOR_DEBUG_BREAKPOINT
		do
			debug ("debugger_trace_breakpoint")
				io.error.put_string ("Request Remove BP - line=" + a_line.to_hex_string + "%N")
				io.error.put_string ("%T Module = "+ a_module_name.to_string_8 +" %N")
				io.error.put_string ("%T ClassToken = "+ a_class_token.out + "~0x" + a_class_token.to_hex_string +" %N")
				io.error.put_string ("%T FeatureTok = "+ a_feature_token.out + "~0x" + a_feature_token.to_hex_string +" %N")
				io.error.put_string ("%N")
			end
			create l_bp.make (a_bp_loc, resolved_module_key (a_module_name.to_string_32), a_class_token, a_feature_token, a_line)

			if is_bp_waiting_for_addition (l_bp) then
				--| The breakpoint has not yet been enabled on the dotnet side
				--| so we can remove it from safely from the "to_add" list
				unregister_bp_for_addition (l_bp)
				check
					bp_removed: not is_bp_waiting_for_addition (l_bp)
				end
			elseif breakpoints.has (l_bp) then
				--| The breakpoint has been enabled on the dotnet side
				--| so we have to remove it from the list
				--| and also unactivate and release the `ICorDebugBreakpoint'

				l_bp := breakpoints.item (l_bp)

				l_icd_bp := l_bp.icor_breakpoint
				l_icd_bp.activate (False) --| FIXME: should be ok ... but to check

				breakpoints.remove (l_bp)
				check
					bp_removed: not breakpoints.has (l_bp)
				end

				debug ("debugger_trace_breakpoint") io.error.put_string ("BreakPoint REMOVED ! %N") end
			end
		end

feature {NONE} -- Initialization

	init
			-- Init the Current data containers.
		do
			create breakpoints_for_addition_by_module.make (10)
			breakpoints_for_addition_by_module.compare_objects

			create breakpoints.make	 (10)
			breakpoints.compare_objects
		end

	reset
			-- Reset the Current data containers.
		do
			breakpoints_for_addition_by_module.wipe_out
			breakpoints.wipe_out
		end

feature {NONE} -- List operation

	is_module_waiting_for_addition (a_module: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_module' on the waiting queue for breakpoints addition ?
		require
			a_module /= Void and then not a_module.is_empty
		do
			Result := breakpoints_for_addition_by_module.has (a_module)
		end

	is_bp_waiting_for_addition (a_bp: EIFNET_BREAKPOINT): BOOLEAN
			-- Is `a_bp' waiting for being added ?
		require
			a_bp /= Void
		local
			l_bp_for_addition: ARRAYED_LIST [EIFNET_BREAKPOINT]
			l_module_key: STRING_32
		do
			l_module_key := a_bp.module_key
			if is_module_waiting_for_addition (l_module_key) then
				l_bp_for_addition := breakpoints_for_addition_by_module.item (l_module_key)
				Result := l_bp_for_addition.has (a_bp)
			end
			Result := is_module_waiting_for_addition (l_module_key)
					and then breakpoints_for_addition_by_module.item (l_module_key).has (a_bp)
		end

	register_bp_for_addition (a_bp: EIFNET_BREAKPOINT)
			-- Register `a_bp' to be added.
		require
			a_bp /= Void
		local
			l_bp_for_addition: ARRAYED_LIST [EIFNET_BREAKPOINT]
			l_module_key: STRING_32
		do
			l_module_key := a_bp.module_key
			if is_module_waiting_for_addition (l_module_key) then
				l_bp_for_addition := breakpoints_for_addition_by_module.item (l_module_key)
			else
				create l_bp_for_addition.make (16)
				breakpoints_for_addition_by_module.put (l_bp_for_addition, l_module_key)
			end
			if not l_bp_for_addition.has (a_bp) then
				l_bp_for_addition.extend (a_bp)
			end
		end

	unregister_bp_for_addition (a_bp: EIFNET_BREAKPOINT)
			-- Remove `a_bp' from the breakpoints to be added.
		require
			a_bp /= Void
		local
			l_bp_for_addition: ARRAYED_LIST [EIFNET_BREAKPOINT]
			l_module_key: STRING_32
		do
			l_module_key := a_bp.module_key
			if is_module_waiting_for_addition (l_module_key) then
				l_bp_for_addition := breakpoints_for_addition_by_module.item (l_module_key)
				l_bp_for_addition.search (a_bp)
				l_bp_for_addition.remove
				if l_bp_for_addition.is_empty then
					breakpoints_for_addition_by_module.remove (l_module_key)
				end
			end
		end

	register_bp_as_active (a_bp: EIFNET_BREAKPOINT)
			-- Register `a_bp' as active.
		require
			a_bp /= Void
		do
			breakpoints.put (a_bp, a_bp)
		end

	move_bp_to_active_breakpoints (a_bp: EIFNET_BREAKPOINT)
			-- Move `a_bp' to active breakpoints group.
		do
			register_bp_as_active (a_bp)
			unregister_bp_for_addition (a_bp)
		end

feature {NONE} -- Notification

	notify_new_module (a_mod_key: READABLE_STRING_GENERAL)
			-- Notify system a new module is loaded
		require
			a_mod_key /= Void
		local
			l_bp: EIFNET_BREAKPOINT
			l_succeed: BOOLEAN
			l_bp_for_addition: ARRAYED_LIST [EIFNET_BREAKPOINT]
		do
			if is_module_waiting_for_addition (a_mod_key) then
				l_bp_for_addition := breakpoints_for_addition_by_module.item (a_mod_key)
				debug ("debugger_trace_breakpoint")
					io.error.put_string (" - EifnetBreakPoint: " + l_bp_for_addition.count.out + " to be added for this module.%N")
				end
				from
					l_bp_for_addition.start
				until
					l_bp_for_addition.after
				loop
					l_bp := l_bp_for_addition.item
					l_succeed := process_breakpoint_addition (l_bp)
					if l_succeed then
						l_bp_for_addition.remove
						register_bp_as_active (l_bp)
					else
						l_bp_for_addition.forth
					end
				end

				if l_bp_for_addition.is_empty then
					breakpoints_for_addition_by_module.remove (a_mod_key)
				end

				debug ("debugger_trace_breakpoint")
					debug_display_bp_list_status
				end
			end
		end

	refresh_module_for_breakpoints (a_module: ICOR_DEBUG_MODULE; a_mod_key: STRING_32)
			--
		local
			l_bp: EIFNET_BREAKPOINT
			l_icd_module: ICOR_DEBUG_MODULE
			l_success: BOOLEAN
		do
			from
				breakpoints.start
			until
				breakpoints.after
			loop
				l_bp := breakpoints.item_for_iteration
				if l_bp.module_key.is_equal (a_mod_key) then
-- NOTA jfiat [2004/07/20] : check how we should handle (better) loaded modules
--					l_icd_module := loaded_modules.item (a_mod_key)
					l_icd_module := a_module
					l_success := process_breakpoint_addition_on_module (l_bp, l_icd_module)
				end
				breakpoints.forth
			end
		end

feature -- module utils

	resolved_module_key (a_module_name: READABLE_STRING_32): STRING_32
			-- Key for module_name
		deferred
		ensure
			Result_valid: Result /= Void and then not Result.is_empty
		end

feature {NONE} -- Implementation

	process_breakpoint_addition (a_bp: EIFNET_BREAKPOINT): BOOLEAN
			-- Addition of `a_bp' successful ?
		require
			a_bp /= Void
		local
			l_icd_module: ICOR_DEBUG_MODULE
			l_icd_class: ICOR_DEBUG_CLASS
			l_module_key_name: READABLE_STRING_32
		do
			l_module_key_name := a_bp.module_key
				--| Get CLASS or MODULE info to manage the BreakPoint
			if loaded_modules.has (l_module_key_name) then
				l_icd_module := loaded_modules.item (l_module_key_name)
				l_icd_class := l_icd_module.get_class_from_token (a_bp.class_token)
				if not l_icd_module.last_call_succeed or else l_icd_class = Void then
					debug ("debugger_trace_breakpoint")
						io.error.put_string ("[ERROR] During Breakpoint addition, eStudio got confused with Module ...%N")
						io.error.put_string ("        class_token 0x" + a_bp.class_token.to_hex_string + " is not inside module %N")
						io.error.put_string_32 ({STRING_32} "        " + l_icd_module.module_name + "%N")
					end
					l_icd_module := Void
				end
			end

				--| Let set the BP now we have all the information access we need
			if l_icd_module /= Void then
				Result := process_breakpoint_addition_on_module (a_bp, l_icd_module)
			else
				debug ("debugger_trace_breakpoint")
					io.error.put_string ("Information not yet available, wait for class loading during JIT execution ("
							+ a_bp.class_token.out
							+ "."
							+ a_bp.feature_token.out
							+ " @ module "
							+ {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (l_module_key_name)
							+ ")%N"
						)
				end
			end
		end

	process_breakpoint_addition_on_module (a_bp: EIFNET_BREAKPOINT; a_icd_module: ICOR_DEBUG_MODULE): BOOLEAN
		local
			l_icd_func: ICOR_DEBUG_FUNCTION
 			l_icd_code: ICOR_DEBUG_CODE
			l_icd_bp: ICOR_DEBUG_BREAKPOINT
		do
			l_icd_func := a_icd_module.get_function_from_token (a_bp.feature_token)
			if l_icd_func /= Void  and then a_icd_module.last_call_succeed then
				l_icd_code := l_icd_func.get_il_code
				if l_icd_code = Void then
					l_icd_code := l_icd_func.get_native_code
				end
				if l_icd_code /= Void then
					--| Let create the BreakPoint with offset
					l_icd_bp := l_icd_code.create_breakpoint (a_bp.break_index.as_natural_32)
					if l_icd_bp /= Void and then l_icd_code.last_call_succeed then
						a_bp.set_icor_breakpoint (l_icd_bp)
						l_icd_bp.activate (True) -- not useful ... by default, but .. just to be sure ;)
						Result := True

						debug ("debugger_trace_breakpoint") io.error.put_string ("BreakPoint ADDED ! %N") end
					else
						debug ("debugger_trace_breakpoint")
							io.error.put_string ("Error[" + l_icd_code.last_error_code_id
									+ "] in ICorDebugCode->CreateBreakpoint for ("
									+ a_bp.feature_token.out + ")%N")
						end
					end
				end
			else
				debug ("debugger_trace_breakpoint")
					io.error.put_string ("Error while retrieving function_by_token (" + a_bp.feature_token.out + ")%N")
				end
			end
		end

feature {NONE} -- Classes informations

	loaded_modules: STRING_TABLE [ICOR_DEBUG_MODULE]
			-- ICorDebugModule loaded so far.
		deferred
		end

feature {NONE} -- Breakpoints informations

	breakpoints_for_addition_by_module: STRING_TABLE [ARRAYED_LIST [EIFNET_BREAKPOINT]]
			-- Container for Breakpoint waiting to be added

	breakpoints: HASH_TABLE [EIFNET_BREAKPOINT, EIFNET_BREAKPOINT]
			-- Container for concrete Breakpoint

feature -- debug purpose only

	debug_display_bp_list_status
			-- Display list of BP showing their status.
		local
			l_output: STRING
			l_bp: EIFNET_BREAKPOINT
			l_bp_for_addition: ARRAYED_LIST [EIFNET_BREAKPOINT]
		do
			l_output := "%N  #===================================%N"

			l_output.append_string ("  *** BP TO ADD *** %N")
			across
				breakpoints_for_addition_by_module as ic
			loop
				l_output.append_string ("  + " + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (ic.key) + "%N")
				l_bp_for_addition := ic.item

				across
					l_bp_for_addition as bp_ic
				loop
					l_bp := bp_ic.item
					l_output.append_string ("    - "
							+ l_bp.class_token.to_hex_string
							+ "::"
							+ l_bp.feature_token.to_hex_string
							+ " [" + l_bp.break_index.out + "] "
						)
					if l_bp.is_active and then l_bp.icor_breakpoint /= Void then
						l_output.append_string (" IsActive=" + l_bp.icor_breakpoint.is_active.out)
					else
						l_output.append_string (" NO DOTNET ")
					end
					l_output.append_string ("%N")
				end
			end

			l_output.append_string ("  *** BP -- OK  *** %N")
			from
				breakpoints.start
			until
				breakpoints.after
			loop
				l_bp := breakpoints.item_for_iteration
				l_output.append_string ("    - "
						+ l_bp.class_token.to_hex_string
						+ "::"
						+ l_bp.feature_token.to_hex_string
						+ " [" + l_bp.break_index.out + "] "
					)
				if l_bp.is_active and then l_bp.icor_breakpoint /= Void then
					l_output.append_string (" IsActive=" + l_bp.icor_breakpoint.is_active.out)
				else
					l_output.append_string (" NO DOTNET ")
				end

				l_output.append_string ("%N")
				breakpoints.forth
			end

			l_output.append_string ("  #===================================%N")
			io.error.put_string (l_output + "%N")
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
