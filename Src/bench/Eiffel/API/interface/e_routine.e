indexing
	description: "Representation of an eiffel routine."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class E_ROUTINE

inherit

	E_FEATURE
		redefine
			has_postcondition, has_precondition,
			argument_names, arguments, is_once,
			is_deferred, locals, obsolete_message,
			is_external
		end

feature -- Properties

	arguments: E_FEATURE_ARGUMENTS;
			-- Arguments type

	has_precondition: BOOLEAN;
			-- Is the routine declaring some precondition ?
	
	has_postcondition: BOOLEAN;
			-- Is the routine declaring some postcondition ?

	obsolete_message: STRING;
			-- Obsolete message
			-- (Void if Current is not obsolete)

	is_deferred: BOOLEAN;
			-- Is the routine deferred?

	is_once: BOOLEAN;
			-- Is the routine declared as a once?

	is_external: BOOLEAN;
			-- Is the routine declared as a once?

feature -- Access

	argument_names: LIST [STRING] is
			-- Argument names
		do
			Result := arguments.argument_names;
		end;

	locals: EIFFEL_LIST [TYPE_DEC_AS] is
		local
			routine_as: ROUTINE_AS
		do
			routine_as ?= Body_server.item (body_index).body.content;
			if routine_as /= Void then
				Result := routine_as.locals
			end;
		end;

feature {FEATURE_I} -- Setting

	set_deferred (b: like is_deferred) is
			-- Set `is_deferred' to `b'.
		do
			is_deferred := b;
		end;

	set_once (b: like is_once) is
			-- Set `is_once' to `b'.
		do
			is_once := b;
		end;

	set_external (b: like is_external) is
			-- Set `is_external' to `b'.
		do
			is_external := b
		end;

	set_arguments (args: like arguments) is
			-- Assign `args' to `arguments'.
		do
			arguments := args;
		end;

	set_has_precondition (b: BOOLEAN) is
			-- Assign `b' to `has_precondition'.
		do
			has_precondition := b;
		end;

	set_has_postcondition (b: BOOLEAN) is
			-- Assign `b' to `has_postcondition'.
		do
			has_postcondition := b;
		end;

	set_obsolete_message (s: STRING) is
			-- Assign `s' to `obsolete_message'
		do
			obsolete_message := s;
		end;

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

end -- class E_ROUTINE
