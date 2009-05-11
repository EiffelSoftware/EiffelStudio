note
	description : "Runs the xebra translator"
	date        : "$Date$"
	revision    : "$Revision$"

class
	XT_APPLICATION

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER
	KL_SHARED_ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Make the application.
		local
			l_printer: ERROR_CUI_PRINTER
			l_translator: XP_TRANSLATOR
			l_dir: DIRECTORY
		do
			if  Arguments.argument_count /= 5 then
				print ("Invalid arguments%N%NUsage: %N%Ttranslator project_name input_path output_path servlet_gen_path tag_lib_path%N")
			else
				create l_translator.make (Arguments.argument (1))
				create l_dir.make (Arguments.argument (2))

				l_translator.set_output_path (Arguments.argument (3))
				l_translator.set_servlet_gen_path (Arguments.argument (4))

				l_translator.process_with_files (l_dir.linear_representation, Arguments.argument (5))

				create l_printer.default_create
				if error_manager.has_warnings then
					error_manager.trace_warnings (l_printer)
				end

				if not error_manager.is_successful then
					error_manager.trace_last_error (l_printer)
				else
					print ("%NOutput generated to '")
					print (l_translator.output_path)
					print ("%NServlets generated to '")
					print (l_translator.servlet_gen_path)
					print ("'.%N")
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



