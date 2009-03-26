note
	description: "[
		Access to common output windows ({formatter}) and outputs ({OUTPUT_I}), which are always
		available in EiffelStudio.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_SHARED_OUTPUTS

feature {NONE} -- Access: Outputs

	general_output: detachable OUTPUT_I
			-- A general purpose output window, used to write general output to.
		local
			l_output: OUTPUT_I
		do
			if attached internal_general_output as l_result then
				Result := l_result
			elseif output_manager.is_service_available then
					-- Query the output manager for the general output.
				l_output := output_manager.service.output ((create {OUTPUT_MANAGER_KINDS}).general)
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
			result_consistent: Result = general_output
		end

	compiler_output: detachable OUTPUT_I
			-- Eiffel output window, used to write Eiffel compiler output to.
		local
			l_output: OUTPUT_I
		do
			if attached internal_compiler_output as l_result then
				Result := l_result
			elseif output_manager.is_service_available then
					-- Query the output manager for the Eiffel Compiler output.
				l_output := output_manager.service.output ((create {OUTPUT_MANAGER_KINDS}).eiffel_compiler)
				if not l_output.is_interface_usable then
						-- The Eiffel output cannot be used, try the general output instead.
					l_output := output_manager.service.general_output
				end
				if l_output.is_interface_usable then
					Result := l_output
					internal_compiler_output := Result
				end
			end
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
			result_consistent: Result = compiler_output
		end

	c_compiler_output: detachable OUTPUT_I
			-- C output window, used to write C compilation output to.
		local
			l_output: OUTPUT_I
		do
			if attached internal_c_compiler_output as l_result then
				Result := l_result
			elseif output_manager.is_service_available then
					-- Query the output manager for the C Compiler output.
				l_output := output_manager.service.output ((create {OUTPUT_MANAGER_KINDS}).c_compiler)
				if not l_output.is_interface_usable then
						-- The C output cannot be used, try the general output instead.
					l_output := output_manager.service.general_output
				end
				if l_output.is_interface_usable then
					Result := l_output
					internal_c_compiler_output := Result
				end
			end
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
			result_consistent: Result = c_compiler_output
		end

feature {NONE} -- Access: Output Windows

	general_formatter: TEXT_FORMATTER
			-- General output window, used to write general information output to.
		do
			if attached internal_general_formatter as l_result then
				Result := l_result
			else
				if attached general_output as l_output then
					Result := l_output.formatter
				else
						-- The output service is not available, default to the terminal window.
					create {TERM_WINDOW} Result
					internal_general_formatter := Result
				end
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = general_formatter
		end

	compiler_formatter: TEXT_FORMATTER
			-- Compiler output window, used to write Eiffel compilation output to.
		do
			if attached internal_compiler_formatter as l_result then
				Result := l_result
			else
				if attached compiler_output as l_output then
					Result := l_output.formatter
				else
						-- The output service is not available, default to the terminal window.
					create {TERM_WINDOW} Result
					internal_compiler_formatter := Result
				end
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = compiler_formatter
		end

	c_compiler_formatter: TEXT_FORMATTER
			-- C output window, used to write C compilation output to.
		do
			if attached internal_c_compiler_formatter as l_result then
				Result := l_result
			else
				if attached c_compiler_output as l_output then
					Result := l_output.formatter
				else
						-- The output service is not available, default to the terminal window.
					create {TERM_WINDOW} Result
					internal_c_compiler_formatter := Result
				end
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = c_compiler_formatter
		end

feature {NONE} -- Helpers

	output_manager: SERVICE_CONSUMER [OUTPUT_MANAGER_S]
			-- Output manager service to post output to.
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Implementation: Internal cache

	internal_general_output: detachable like general_output
			-- Cached version of `general_output'.
			-- Note: Do not use directly!

	internal_general_formatter: detachable like general_formatter
			-- Cached version of `general_formatter'.
			-- Note: Do not use directly!

	internal_compiler_output: detachable like compiler_output
			-- Cached version of `compiler_output'.
			-- Note: Do not use directly!

	internal_compiler_formatter: detachable like compiler_formatter
			-- Cached version of `compiler_formatter'.
			-- Note: Do not use directly!

	internal_c_compiler_output: detachable like c_compiler_output
			-- Cached version of `c_compiler_output'.
			-- Note: Do not use directly!

	internal_c_compiler_formatter: detachable like c_compiler_formatter
			-- Cached version of `c_compiler_formatter'.
			-- Note: Do not use directly!

;note
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

end
