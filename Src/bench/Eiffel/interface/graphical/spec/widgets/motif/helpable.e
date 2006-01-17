indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
deferred class HELPABLE

feature -- Access

	associated_help_widget: WIDGET is
		deferred
		end;

	help_index: INTEGER is
			-- Index within help file
		deferred
		end;

	help_file_name: FILE_NAME is
		deferred
		ensure
			not_void: Result /= Void
		end

feature -- Update

	invoke_help is
			-- Invoke help window for Current helpable object.
		--local
			--wel_win: WEL_WINDOW
		do
			--wel_win ?= associated_help_widget.implementation;
			--wel_win.help_file (help_file_name, 0, 0) 
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

end -- class HELPABLE
