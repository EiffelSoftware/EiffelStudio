indexing
	description	: "COM Wizard launcher, hides DOS console and launch COM wizard graphically"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	ROOT_CLASS

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			l_process_launcher: WEL_PROCESS_LAUNCHER
			l_args: ARGUMENTS
			l_path: STRING
			l_index: INTEGER
		do
			create l_args
			l_path := l_args.argument (0)
			l_index := l_path.last_index_of (operating_environment.Directory_separator, l_path.count)
			if l_index > 0 then
				l_path.keep_head (l_index)
			else
				l_path := ""
			end
			l_path.append ("com_wizard.exe -g")
			create l_process_launcher
			l_process_launcher.spawn (l_path, Void)
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
end -- class ROOT_CLASS

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

