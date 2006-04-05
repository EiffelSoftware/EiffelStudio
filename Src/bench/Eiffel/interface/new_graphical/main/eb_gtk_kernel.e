indexing
	description: "Core of the application for GTK application"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GTK_KERNEL

inherit
	EB_KERNEL

create
	make

feature

	io_watcher2: IO_WATCHER
			-- Request handler.

	listen_to: RAW_FILE
			-- File used to listen.

	create_handler is
		do
			create listen_to.make ("toto")
			listen_to.fd_open_read (Listen_to_const)

			create io_watcher2.make_with_medium (listen_to)
			io_watcher2.read_actions.wipe_out
			io_watcher2.error_actions.wipe_out
			io_watcher2.exception_actions.wipe_out
			io_watcher2.read_actions.extend (agent execute (Void))
			io_watcher2.error_actions.extend (agent execute (Void))
			io_watcher2.exception_actions.extend (agent execute (Void))

		end

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

end -- class EB_KERNEL
