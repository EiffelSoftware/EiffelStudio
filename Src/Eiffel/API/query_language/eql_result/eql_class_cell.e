indexing
	description: "Cell for store a class_i and a class_c object in EQL"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_CLASS_CELL


feature{NONE} -- Initialization

	make_with_class_i (a_class_i: CLASS_I) is
			-- Initialize `class_i' with `a_class_i'.
		require
			a_class_i_not_void: a_class_i /= Void
		do
			set_class_i (a_class_i)
		end

	make_with_class_c (a_class_c: CLASS_C) is
			-- Initialize `class_c' with `a_class_c'.
		require
			a_class_c_not_void: a_class_c /= Void
		do
			set_class_c (a_class_c)
		end

feature -- Statuc reporting

	is_class_c_set: BOOLEAN is
			-- Is `class_c' set?
		do
			Result := class_c /= Void
		ensure
			good_result: Result implies class_c /= Void
		end

	is_class_i_set: BOOLEAN is
			-- Is `class_i' set?
		do
			Result := class_i /= Void
		ensure
			good_result: Result implies class_i /= Void
		end

feature -- Access

	class_c: CLASS_C
			-- Class in current context

	class_i: CLASS_I
			-- Class in current context

feature -- Setting

	set_class_c (cl: CLASS_C) is
			-- Assign `cl' to `class_c'.
		do
			class_c := cl
			if class_c /= Void then
				class_i := class_c.lace_class
			end
		end

	set_class_i (cl: CLASS_I) is
			-- Assign `cl' to `class_i'.
		do
			class_i := cl
			if class_i.compiled_class /= Void then
				class_c := class_i.compiled_class
			end
		end

invariant
	valid_class_c_class_i: (class_c /= Void implies (class_i /= Void and then class_i = class_c.lace_class)) and
						   ((class_i /= Void and then class_i.is_compiled) implies (class_c /= Void and then class_c = class_i.compiled_class))

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
end
