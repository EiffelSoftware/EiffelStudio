indexing
	description: "Help engine, displays help context"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	EB_HELP_ENGINE

inherit
	EV_HELP_ENGINE

create
	make

feature {NONE} -- Initialization

	make is
			-- Create implemetation object.
		do
			create {EB_HELP_ENGINE_IMP} implementation.make
		end

feature -- Status Report

	last_show_successful: BOOLEAN is
			-- Was last call to `show' successful?
		do
			Result := implementation.last_show_successful
		ensure
			message_if_failed: not Result implies (last_error_message /= Void and then not last_error_message.is_empty)
			bridge_ok: Result = implementation.last_show_successful
		end

	last_error_message: STRING_GENERAL is
			-- Last error message, if any
		do
			Result := implementation.last_error_message
		ensure
			bridge_ok: equal (Result, implementation.last_error_message)
		end

feature -- Basic Operations

	show (a_help_context: EB_HELP_CONTEXT) is
			-- Show help with context `a_help_context'.
		do
			implementation.show (a_help_context)
		end

feature {NONE} -- Implementation

	implementation: EB_HELP_ENGINE_I;
			-- Platform specific implementation

indexing
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

end -- class EB_HELP_ENGINE
