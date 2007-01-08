indexing
	description: "[
		Test class defining a .NET property that is a function.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	TEST

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	make is
			-- Entry point.
		local
			l_client: TEST_CLIENT
		do
			create l_client.make (Current)
			print (l_client.assembly_name)
			print ("%N")
		end

feature -- Properties

	assembly_name: SYSTEM_STRING assign set_assembly_name is
			-- Name of running assembly
		indexing
			property: auto
		do
			Result := ({TEST}).to_cil.assembly.full_name
		end

feature -- Property setting

	set_assembly_name (a_name: like assembly_name) is
			-- Set `assembly_name' with `a_name'
		do
			{ISE_RUNTIME}.raise (create {INVALID_OPERATION_EXCEPTION}.make)
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end
