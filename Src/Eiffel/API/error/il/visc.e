note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VISC

inherit
	EIFFEL_ERROR
		redefine
			build_explain, class_c
		end

create
	make

feature {NONE} -- Initialization

	make (a_class: like class_c; a_routine_1, a_routine_2: like routine_1)
			-- Create instance of current with `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_routine_1_not_void: a_routine_1 /= Void
			a_routine_2_not_void: a_routine_2 /= Void
		do
			class_c := a_class
			routine_1 := a_routine_1
			routine_2 := a_routine_2
		ensure
			class_c_set: class_c = a_class
			routine_1_set: routine_1 = a_routine_1
			routine_2_set: routine_2 = a_routine_2
		end

feature -- Access

	class_c: EIFFEL_CLASS_C
			-- Class where error is encountered.

	routine_1, routine_2: STRING
			-- Creation routines with identical signature

feature -- Properties

	code: STRING = "VISC"
		-- Error code

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- Display error message
		do
			a_text_formatter.add ("Creation routines of ")
			class_c.append_signature (a_text_formatter, False)
			a_text_formatter.add (" corresponding to constructors have same interface.")
			a_text_formatter.add_new_line
			a_text_formatter.add ("First creation routine: ")
			a_text_formatter.process_feature_name_text (routine_1, class_c)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Second creation routine: ")
			a_text_formatter.process_feature_name_text (routine_2, class_c)
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

end -- class VISC
