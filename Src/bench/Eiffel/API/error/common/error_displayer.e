indexing

	description: 
		"Displays warning and error messages from Error handler%
		%during a compilation."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class ERROR_DISPLAYER

feature -- Output

	trace_warnings (handler: ERROR_HANDLER) is
			-- Display warnings messages from `handler'.
		require
			non_void_handler: handler /= Void;
			not_empty_warnings: not handler.warning_list.is_empty
		deferred
		end;

	trace_errors (handler: ERROR_HANDLER) is
			-- Display error messages from `handler'.
		require
			non_void_handler: handler /= Void;
			not_empty_errors: not handler.error_list.is_empty
		deferred
		end;

	force_display is
			-- Make sure the user can see the messages we send.
		deferred
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

end -- class ERROR_DISPLAYER
