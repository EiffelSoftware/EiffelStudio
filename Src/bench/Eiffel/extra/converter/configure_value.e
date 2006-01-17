indexing

	description: 
		"Configure value extracted from the configure_file"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$" 

class CONFIGURE_VALUE

create

	make

feature {NONE} -- Initialization

	make (a_name, a_value: STRING) is
			-- Initialize Current with `a_name' as `name'
			-- and `a_value' as `value'
		require
			valid_args: a_name /= Void and then a_value /= Void
		do
			name := a_name;
			value := a_value
		ensure
			set: name = a_name and then value = a_value
		end

feature -- Access

	name: STRING;
		-- Name of the configured value

	value: STRING
		-- Value of the string to be substituted into the converted file

feature -- Debug

	trace is
			-- Debug trace.
		do
			print (name);
			print (": ");
			print (value);
			io.put_new_line
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

end -- class CONFIGURE_VALUE
