indexing
	description: "Class describing the notion of routine; %
				% a command (corresponding to APPLICATION_COMMAND) %
				% is also a routine."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	APPLICATION_ROUTINE

inherit

	APPLICATION_METHOD
		rename
			method_name as routine_name
		end

creation
	make, make_from_command

feature -- Creation

	make (rout_name: STRING; arg_list: LINKED_LIST [APPLICATION_ARGUMENT]) is
			-- Create a routine object with name `rout_name'
			-- whose arguments are `arg_list'.
		require
			valid_routine_name: rout_name /= Void and not rout_name.empty
			valid_arguments: arg_list /= Void 
		do
			create precondition_list.make
			routine_name := rout_name
			argument_list := arg_list
		end

	make_from_command (a_command: APPLICATION_COMMAND) is
			-- Create a routine object using `a_command'.
		require
			valid_command: a_command /= Void
		local
			arg: APPLICATION_ARGUMENT
		do
			routine_name := a_command.command_name
			create precondition_list.make
			create argument_list.make
			create arg.make (a_command.argument_name, a_command.argument_type)
			argument_list.extend (arg)
			precondition_list := a_command.precondition_list
		end

feature -- Scrollable element

	value: STRING is
			-- Value displayed in a scrollable list.
		do
			create Result.make (0)
			Result.append (routine_name)
			if not argument_list.empty then
				Result.append (" (")
				argument_list.start
				Result.append (argument_list.item.eiffel_text)
				from
					argument_list.forth
				until
					argument_list.after
				loop
					Result.append ("; ")
					Result.append (argument_list.item.eiffel_text)
					argument_list.forth
				end
				Result.append (")")
			end
		end

feature -- Attributes

	argument_list: LINKED_LIST [APPLICATION_ARGUMENT];
			-- List of arguments

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


end -- class APPLICATION_ROUTINE
