indexing
	description: "[
		STA/MTA application entry point, required for .NET on Windows 2000.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"
	
frozen class
	EC_MAIN

inherit
	SYSTEM_OBJECT

	EC_SHARED_PROJECT
		export
			{NONE} all
		end

create
	make,
	make_sta

feature {NONE} -- Initialization

	make is
			-- Launch application in default thread apartment.
		local
			l_app: EC_APPLICATION
		do
			add_arguments
			create l_app.make_and_launch
		end

	make_sta is
			-- Launch application in a STA.
		local
			l_thread: SYSTEM_THREAD
			l_thread_start: THREAD_START
		do
			create l_thread_start.make (Current, $make)
			create l_thread.make (l_thread_start)
			l_thread.set_apartment_state (feature {APARTMENT_STATE}.sta)
			l_thread.start
			l_thread.join
		end
		
feature {NONE} -- Implementation

	add_arguments is
			-- Add first argument as assembly file name and all others as reference paths
		local
			l_args: like arguments
			l_count: INTEGER
			i: INTEGER
		do
			l_args := arguments
			l_count := l_args.argument_count
			if l_count >= 1 then
				project.set_assembly (arguments.argument (1))
				from
					i := 2
				until
					i > l_count
				loop
					project.add_reference_path (l_args.argument (i))
					i := i + 1
				end
				project.set_is_dirty (False)
			end
		end
		
	arguments: ARGUMENTS is
			-- Application arguments
		once
			create Result
		ensure
			result_not_void: Result /= Void
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
end -- class EC_MAIN
