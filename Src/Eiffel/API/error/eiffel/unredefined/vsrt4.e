note
	description: "[
		Root type is syntactically valid but it is not
		semantically valid (not the correct number of actual generic parameters,
		not meeting the constraint on actual generic paramater).
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision: $"

class VSRT4

inherit
	VSRT
		redefine
			subcode, build_explain
		end;

feature -- Access

	subcode: INTEGER = 4
			-- Sub code of error

	error_list: LINKED_LIST [CONSTRAINT_INFO]
			-- Error description list

	any_class: CLASS_C
			-- Using ANY to type check the type.

feature	-- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
		do
			Precursor (a_text_formatter)
			if error_list = Void then
					-- Case when it is an error on the number of actual generic
					-- parameters not matching the base class specification
				a_text_formatter.add ("Base class: ")
				root_type.associated_class.append_signature (a_text_formatter, False)
				a_text_formatter.add_new_line
			else
					-- Display errors in the context of class ANY.
				from
					error_list.start
				until
					error_list.after
				loop
					error_list.item.build_explain (a_text_formatter, any_class)
					error_list.forth
				end
			end
		end

feature {COMPILER_EXPORTER}

	set_error_list (list: like error_list)
			-- Set `list' to `error_list'
		require
			list_exists: list /= Void
		do
			error_list := list
		ensure
			error_list: error_list = list
		end

	set_any_class (a_class: CLASS_C)
		require
			a_class_not_void: a_class /= Void
		do
			any_class := a_class
		ensure
			any_class_set: any_class = a_class
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
		]"

end -- class VSRT1
