indexing
	description: "[
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_FRAME

--inherit
--	ICOR_OBJECT
--
--create 
--	make_by_pointer
--	
--
--feature {ICOR_EXPORTER} -- QueryInterface
--
--	query_interface_icor_debug_il_frame: ICOR_DEBUG_IL_FRAME is
--		local
--			p: POINTER
--		do
--			last_call_success := cpp_query_interface_ICorDebugILFrame (item, $p)
--			if p /= default_pointer then
--				create Result.make_by_pointer (p)
--				Result.add_ref
--			end
--		ensure
----			success: last_call_success = 0
--		end
--
--	query_interface_icor_debug_native_frame: ICOR_DEBUG_NATIVE_FRAME is
--		local
--			p: POINTER
--		do
--			last_call_success := cpp_query_interface_ICorDebugNativeFrame (item, $p)
--			if p /= default_pointer then
--				create Result.make_by_pointer (p)
--				Result.add_ref
--			end
--		ensure
----			success: last_call_success = 0
--		end
--
--feature {ICOR_EXPORTER} -- Access
--
--	get_chain: ICOR_DEBUG_CHAIN is
--		local
--			p: POINTER
--		do
--			last_call_success := cpp_get_chain (item, $p)
--			if p /= default_pointer then
--				create Result.make_by_pointer (p)
--			end
--		ensure
--			success: last_call_success = 0
--		end
--
--	get_code: ICOR_DEBUG_CODE is
--		local
--			p: POINTER
--		do
--			last_call_success := cpp_get_code (item, $p)
--			if p /= default_pointer then
--				create Result.make_by_pointer (p)
--			end
--		ensure
--			success: last_call_success = 0
--		end
--
--	get_function: ICOR_DEBUG_FUNCTION is
--		local
--			p: POINTER
--		do
--			last_call_success := cpp_get_function (item, $p)
--			if p /= default_pointer then
--				create Result.make_by_pointer (p)
--			end
--		ensure
--			success: last_call_success = 0
--		end
--
--	get_function_token: INTEGER is
--		do
--		end
--
--	get_caller: ICOR_DEBUG_FRAME is
--		do
--		end
--
--	get_callee: ICOR_DEBUG_FRAME is
--		do
--		end
--
--	create_stepper: ICOR_DEBUG_STEPPER is
--		do
--		end

end -- class ICOR_DEBUG_FRAME


