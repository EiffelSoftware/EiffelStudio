indexing
	description: "Objects that represent replace report."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_REPLACE_REPORT

feature -- Access

	class_replaced: INTEGER
			-- Number of classes in which replaced.

	text_replaced: INTEGER
			-- Number of text items that have been replaced.

feature -- Operation

	plus, infix "+" (a_other: like Current): like Current is
			-- Report addition.
		require
			a_other_not_void: a_other /= Void
		do
			create Result
			Result.set_class_replaced (class_replaced + a_other.class_replaced)
			Result.set_text_replaced (text_replaced + a_other.text_replaced)
		ensure
			addition_not_void: Result /= Void
		end

feature {MSR, MSR_REPLACE_STRATEGY, MSR_REPLACE_REPORT} -- Element change

	set_class_replaced (a_num: INTEGER) is
			-- Set `class_replaced' with `a_num'
		do
			class_replaced := a_num
		ensure
			class_replaced_set: class_replaced = a_num
		end

	set_text_replaced (a_num: INTEGER) is
			-- Set `text_replaced' with `a_num'
		do
			text_replaced := a_num
		ensure
			text_replaced_set: text_replaced = a_num
		end

feature -- Reset

	reset is
			-- Reset.
		do
			class_replaced := 0
			text_replaced := 0
		end

invariant
	invariant_clause: True -- Your invariant here

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

