note
	description: "[
			typedef enum CorDebugChainReason
			{
				// Note that the first five line up with CorDebugIntercept
				CHAIN_NONE              = 0x000,
				CHAIN_CLASS_INIT        = 0x001,
				CHAIN_EXCEPTION_FILTER  = 0x002,
				CHAIN_SECURITY          = 0x004,
				CHAIN_CONTEXT_POLICY    = 0x008,
				CHAIN_INTERCEPTION      = 0x010,
				CHAIN_PROCESS_START     = 0x020,
				CHAIN_THREAD_START      = 0x040,
				CHAIN_ENTER_MANAGED     = 0x080,
				CHAIN_ENTER_UNMANAGED   = 0x100,
				CHAIN_DEBUGGER_EVAL     = 0x200,
				CHAIN_CONTEXT_SWITCH    = 0x400,
				CHAIN_FUNC_EVAL         = 0x800,
			} CorDebugChainReason;

		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COR_DEBUG_CHAIN_REASON_ENUM

feature -- enum CorDebugChainReason

	frozen enum_cor_debug_chain_reason__CHAIN_NONE: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"CHAIN_NONE"
		end

	frozen enum_cor_debug_chain_reason__CHAIN_CLASS_INIT: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"CHAIN_CLASS_INIT"
		end

	frozen enum_cor_debug_chain_reason__CHAIN_EXCEPTION_FILTER: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"CHAIN_EXCEPTION_FILTER"
		end

	frozen enum_cor_debug_chain_reason__CHAIN_SECURITY: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"CHAIN_SECURITY"
		end

	frozen enum_cor_debug_chain_reason__CHAIN_CONTEXT_POLICY: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"CHAIN_CONTEXT_POLICY"
		end

	frozen enum_cor_debug_chain_reason__CHAIN_INTERCEPTION: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"CHAIN_INTERCEPTION"
		end

	frozen enum_cor_debug_chain_reason__CHAIN_PROCESS_START: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"CHAIN_PROCESS_START"
		end

	frozen enum_cor_debug_chain_reason__CHAIN_THREAD_START: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"CHAIN_THREAD_START"
		end

	frozen enum_cor_debug_chain_reason__CHAIN_ENTER_MANAGED: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"CHAIN_ENTER_MANAGED"
		end

	frozen enum_cor_debug_chain_reason__CHAIN_ENTER_UNMANAGED: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"CHAIN_ENTER_UNMANAGED"
		end

	frozen enum_cor_debug_chain_reason__CHAIN_DEBUGGER_EVAL: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"CHAIN_DEBUGGER_EVAL"
		end

	frozen enum_cor_debug_chain_reason__CHAIN_CONTEXT_SWITCH: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"CHAIN_CONTEXT_SWITCH"
		end

	frozen enum_cor_debug_chain_reason__CHAIN_FUNC_EVAL: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"CHAIN_FUNC_EVAL"
		end

	enum_cor_debug_chain_reason_to_string (e: INTEGER): STRING
			-- String representation for the enum entry `e'
		do
			if e = enum_cor_debug_chain_reason__CHAIN_NONE then
				Result := "CHAIN_NONE"
			elseif e = enum_cor_debug_chain_reason__CHAIN_CLASS_INIT then
				Result := "CHAIN_CLASS_INIT"
			elseif e = enum_cor_debug_chain_reason__CHAIN_EXCEPTION_FILTER then
				Result := "CHAIN_EXCEPTION_FILTER"
			elseif e = enum_cor_debug_chain_reason__CHAIN_SECURITY then
				Result := "CHAIN_SECURITY"
			elseif e = enum_cor_debug_chain_reason__CHAIN_CONTEXT_POLICY then
				Result := "CHAIN_CONTEXT_POLICY"
			elseif e = enum_cor_debug_chain_reason__CHAIN_INTERCEPTION then
				Result := "CHAIN_INTERCEPTION"
			elseif e = enum_cor_debug_chain_reason__CHAIN_PROCESS_START then
				Result := "CHAIN_PROCESS_START"
			elseif e = enum_cor_debug_chain_reason__CHAIN_THREAD_START then
				Result := "CHAIN_THREAD_START"
			elseif e = enum_cor_debug_chain_reason__CHAIN_ENTER_MANAGED then
				Result := "CHAIN_ENTER_MANAGED"
			elseif e = enum_cor_debug_chain_reason__CHAIN_ENTER_UNMANAGED then
				Result := "CHAIN_ENTER_UNMANAGED"
			elseif e = enum_cor_debug_chain_reason__CHAIN_DEBUGGER_EVAL then
				Result := "CHAIN_DEBUGGER_EVAL"
			elseif e = enum_cor_debug_chain_reason__CHAIN_CONTEXT_SWITCH then
				Result := "CHAIN_CONTEXT_SWITCH"
			elseif e = enum_cor_debug_chain_reason__CHAIN_FUNC_EVAL then
				Result := "CHAIN_FUNC_EVAL"
			else
				Result := "Unknown"
			end
		ensure
			Result_attached: Result /= Void
		end

note
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

end -- class ICOR_DEBUG_CHAIN

