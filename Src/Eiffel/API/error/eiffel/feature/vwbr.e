indexing

	description: "Error with bracket expression"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class VWBR

inherit

	FEATURE_ERROR
		undefine
			subcode
		redefine
			build_explain, is_defined
		end

feature -- Properties

	target_type: TYPE_A
			-- Target type for which bracket expression is applied
			--| Can be a type set!

	code: STRING is "VWBR"
			-- Error code

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				is_feature_defined and then
				target_type /= Void
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Build specific explanation image for current error
			-- in `a_text_formatter'.
		local
			l_type_set: TYPE_SET_A
		do
			if target_type.has_associated_class then
				a_text_formatter.add ("Target class: ")
				target_type.associated_class.append_name (a_text_formatter)
			else
				l_type_set ?= target_type
				if l_type_set /= Void then
					a_text_formatter.add ("Target class set: ")
					l_type_set.append_to (a_text_formatter)
				else
					check should_never_happen: false end
						-- Code is here to fallback in case it happens in a production environment.
					a_text_formatter.add ("Target: ")
					target_type.append_to (a_text_formatter)
				end

			end
			a_text_formatter.add_new_line
		end

feature {COMPILER_EXPORTER} -- Setting

	set_target_type (t: TYPE_A) is
			-- Assign `t' to `target_class'.
		require
			t_not_void: t /= Void
			t_not_loose: not t.is_loose
		local
			cl_type_a: CL_TYPE_A
		do
			target_type := t
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

end
