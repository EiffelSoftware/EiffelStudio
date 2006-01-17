indexing
	description: "Help engine, displays help context, Windows implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	EB_HELP_ENGINE_IMP

inherit
	EB_HELP_ENGINE_I
	
	EIFFEL_ENV
		export
			{NONE} all
		end

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create HTML Help handler.
		do
			create hh_handler
			internal_show_successful := True
		ensure
			hh_handler /= Void
			last_show_successful: last_show_successful
		end

feature -- Status Report

	last_show_successful: BOOLEAN is
			-- Was last call to `show' successful?
		do
			Result := internal_show_successful
		end
	
	last_error_message: STRING is
			-- Last error message, if any
		do
			Result := internal_error_message
		end
			
feature -- Basic Operations

	show (a_help_context: EB_HELP_CONTEXT) is
			-- Show help with context `a_help_context'.
		do
			hh_handler.show (Url_prefix + a_help_context.url)
			internal_show_successful := hh_handler.last_show_successful
			if not internal_show_successful then
				internal_error_message := Generic_error_message
			end
		end

feature {NONE} -- Implementation

	internal_show_successful: BOOLEAN
			-- Was last call to `show' successful?

	internal_error_message: STRING
			-- Last error message, if any

	hh_handler: EB_HTML_HELP_HANDLER
			-- Control content of Microsoft HTML Help

	Generic_error_message: STRING is "Could not display the help topic, please check your Eiffel installation."
			-- Error message displayed when topic could not be displayed

	Url_prefix: STRING is 
			-- URL prefix for $EiffelGraphicalCompiler$ help files
		once
			Result := Eiffel_installation_dir_name + "\docs\eiffel.chm::"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_HELP_ENGINE