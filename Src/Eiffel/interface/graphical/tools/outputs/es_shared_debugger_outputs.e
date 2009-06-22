note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_SHARED_DEBUGGER_OUTPUTS

inherit
	ES_SHARED_OUTPUTS

	ES_SHARED_LOCALE_FORMATTER
		export
			{NONE} all
		end

feature {NONE} -- Access: Outputs

	debugger_output: detachable OUTPUT_I
			-- An output window for the debugger, used to write debug output to.
		local
			l_output: OUTPUT_I
		do
			if attached internal_debugger_output as l_result then
				Result := l_result
			elseif output_manager.is_service_available then
					-- Query the output manager for the general output.
				l_output := output_manager.service.output_or_default ((create {OUTPUT_MANAGER_KINDS}).debugger, locale_formatter.translation (lb_debugger))
				if not l_output.is_interface_usable then
						-- The general output cannot be used, try the general output instead.
					l_output := output_manager.service.general_output
				end
				if l_output.is_interface_usable then
					Result := l_output
					internal_general_output := Result
				end
			end
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
			result_consistent: Result = debugger_output
		end

feature {NONE} -- Access: Output Windows

	debugger_formatter: TEXT_FORMATTER
			-- Debugger output window, used to write debugger information output to.
		do
			if attached internal_debugger_formatter as l_result then
				Result := l_result
			else
				if attached debugger_output as l_output then
					Result := l_output.formatter
				else
						-- The output service is not available, default to the terminal window.
					create {TERM_WINDOW} Result
					internal_debugger_formatter := Result
				end
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = debugger_formatter
		end

feature {NONE} -- Implementation: Internal cache

	internal_debugger_output: detachable like debugger_output
			-- Cached version of `debugger_output'.
			-- Note: Do not use directly!

	internal_debugger_formatter: detachable like debugger_formatter
			-- Cached version of `debugger_formatter'.
			-- Note: Do not use directly!

feature {NONE} -- Internationalization

	lb_debugger: STRING = "Debugger"

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
