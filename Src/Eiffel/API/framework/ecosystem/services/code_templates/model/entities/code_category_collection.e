indexing
	description: "[
		A collection of code template metadata categories, used in categorization.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CODE_CATEGORY_COLLECTION

inherit
	CODE_COLLECTION [STRING_32]
		redefine
			item_equality_tester
		end

	KL_EQUALITY_TESTER [!STRING_32]
		redefine
			test
		end

create
	make

feature {NONE} -- Access

	item_equality_tester: KL_EQUALITY_TESTER [!STRING_32]
			-- Optional equality tester for item comparison.
		do
			Result ?= Current
		ensure then
			result_attached: Result /= Void
		end

feature {NONE} -- Status report

	test (a_s1:!STRING_32; a_s2: !STRING_32): BOOLEAN
			-- <Precursor>
		do
			if a_s1 = a_s2 then
				Result := True
			else
				Result := a_s1.is_case_insensitive_equal (a_s2)
			end
		end

feature -- Visitor

	process (a_visitor: !CODE_TEMPLATE_VISITOR_I)
			-- <Precursor>
		do
			a_visitor.process_code_category_collection (({!CODE_CATEGORY_COLLECTION}) #? Current)
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
