note
	description: "[
		THIS IS A GENERATED FILE, DO NOT EDIT!
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_GEN_APPLICATION

inherit
	KL_SHARED_ARGUMENTS
	XU_SHARED_OUTPUTTER

create
	make

feature-- Access

feature-- Implementation

	make
			--<Precursor>
		local
			l_controller_table: HASH_TABLE [STRING, STRING]
			l_path: STRING
		do
			o.set_name ("XEBSRVLGEN")
			o.set_debug_level (10)
			if  Arguments.argument_count /= 1 then
			print ("usage:serlvet_gen output_path%N")
			else
			l_path := Arguments.argument (1)
			create l_controller_table.make (1)
			l_controller_table.put ("CONTROLLER", "controller_1")
			(create {G_HELLO_SERVLET_GENERATOR}.make (l_path, "hello", l_controller_table, "g_hello_servlet_generator.e")).generate;
			end
		end

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
		]"end
