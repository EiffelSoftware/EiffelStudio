note
	description: "[
			typedef enum CorDebugMappingResult
			{
				MAPPING_PROLOG              = 0x1,
				MAPPING_EPILOG              = 0x2,
				MAPPING_NO_INFO             = 0x4,
				MAPPING_UNMAPPED_ADDRESS    = 0x8,
				MAPPING_EXACT               = 0x10,
				MAPPING_APPROXIMATE         = 0x20,
			} CorDebugMappingResult;
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	COR_DEBUG_MAPPING_RESULT_ENUM

feature -- enum CorDebugStepReason

	frozen enum_cor_debug_mapping_result__MAPPING_PROLOG: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"MAPPING_PROLOG"
		end

	frozen enum_cor_debug_mapping_result__MAPPING_EPILOG: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"MAPPING_EPILOG"
		end

	frozen enum_cor_debug_mapping_result__MAPPING_NO_INFO: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"MAPPING_NO_INFO"
		end

	frozen enum_cor_debug_mapping_result__MAPPING_UNMAPPED_ADDRESS: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"MAPPING_UNMAPPED_ADDRESS"
		end

	frozen enum_cor_debug_mapping_result__MAPPING_EXACT: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"MAPPING_EXACT"
		end

	frozen enum_cor_debug_mapping_result__MAPPING_APPROXIMATE: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"MAPPING_APPROXIMATE"
		end

feature -- To String

	enum_cor_debug_mapping_result_to_string (e: INTEGER): STRING
			-- String representation for the enum entry `e'
		do
			if e = enum_cor_debug_mapping_result__MAPPING_PROLOG then
				Result := "MAPPING_PROLOG"
			elseif e = enum_cor_debug_mapping_result__MAPPING_EPILOG then
				Result := "MAPPING_EPILOG"
			elseif e = enum_cor_debug_mapping_result__MAPPING_NO_INFO then
				Result := "MAPPING_NO_INFO"
			elseif e = enum_cor_debug_mapping_result__MAPPING_UNMAPPED_ADDRESS then
				Result := "MAPPING_UNMAPPED_ADDRESS"
			elseif e = enum_cor_debug_mapping_result__MAPPING_EXACT then
				Result := "MAPPING_EXACT"
			elseif e = enum_cor_debug_mapping_result__MAPPING_APPROXIMATE then
				Result := "MAPPING_APPROXIMATE"
			else
				Result := "Unknown"
			end
		ensure
			Result_attached: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end -- class EIFNET_STEP_REASON_CONSTANTS
