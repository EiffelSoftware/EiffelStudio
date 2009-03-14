note
	description : "Runns the xebra translator"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ERROR_SHARED_ERROR_MANAGER
	KL_SHARED_ARGUMENTS


create
	make

feature {NONE} -- Initialization

	make
			-- Make the application.
		local
			l_printer: ERROR_CUI_PRINTER
			l_translator: XB_TRANSLATOR
		do
			if false then --if Arguments.argument_count /= 3 then
				print ("usage: translator project_name input_file output_path%N")
			else
				print ("%N============================%NTranslator started...%N")

				create l_translator.make ("testapp") --Arguments.argument (1))

				l_translator.set_output_path ("../../websites/testapp/") --Arguments.argument (2)) --
				l_translator.process_with_file ("../../websites/testapp/testapp.xeb") --Arguments.argument (3)) --"../../websites/testapp/testapp.xeb")


				create l_printer.default_create
				if error_manager.has_warnings then
					error_manager.trace_warnings (l_printer)
				end

				if not error_manager.is_successful then
					error_manager.trace_last_error (l_printer)
				else
					print ("Output file generated to '")
					print (l_translator.output_path)
					print ("'.")
				end
			end
		end

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



