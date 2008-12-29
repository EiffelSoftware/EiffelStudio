note
	description: "`dotnet_constructors' indexing clause refers to a non-existing creation routine"
	date: "$Date$"
	revision: "$Revision$"

class
	VICR

inherit
	EIFFEL_ERROR
		redefine
			build_explain, class_c
		end

create
	make

feature {NONE} -- Initialization

	make (a_class: like class_c; a_routine_name: like routine_name)
			-- Create instance of current with `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_routine_name_not_void: a_routine_name /= Void
		do
			class_c := a_class
			routine_name := a_routine_name
		ensure
			class_c_set: class_c = a_class
			routine_name_set: routine_name = a_routine_name
		end

feature -- Access

	class_c: EIFFEL_CLASS_C
			-- Class where error is encountered.

	routine_name: STRING
			-- Name of missing creation routine

feature -- Properties

	code: STRING = "VICR"
		-- Error code

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- Display error message
		do
			a_text_formatter.add ("No creation routine with name `")
			a_text_formatter.add (routine_name)
			a_text_formatter.add ("' in ")
			class_c.append_signature (a_text_formatter, False)
			a_text_formatter.add (".")
			a_text_formatter.add_new_line
		end

note
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

end -- class VICR

