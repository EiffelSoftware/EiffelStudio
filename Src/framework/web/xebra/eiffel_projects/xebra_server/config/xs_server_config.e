note
	description: "[
			Contains configuration from the arguments and from the config file.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_SERVER_CONFIG

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create args.make_empty
			create file.make_empty
		ensure
			args_attached: args /= Void
			file_attached: file /= Void
		end

feature -- Access

	args: XS_ARG_CONFIG assign set_args
			-- Contains info that is read from arguments

	file: XS_FILE_CONFIG assign set_file
			-- Contains info that is read from config file


feature {XCC_LOAD_CONFIG} -- Status setting

	set_args (a_args: like args)
			-- Sets args.
		require
			a_args_attached: a_args /= Void
		do
			args := a_args
		ensure
			args_set: args  = a_args
		end

	set_file (a_file: like file)
			-- Sets file.
		require
			a_file_attached: a_file /= Void
		do
			file := a_file
		ensure
			file_set: file  = a_file
		end

invariant
	args_attached: args /= Void
	file_attached: file /= Void

note
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
