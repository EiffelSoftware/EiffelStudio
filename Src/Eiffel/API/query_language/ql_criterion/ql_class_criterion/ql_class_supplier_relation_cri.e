note
	description: "Object that represents a criterion to decide whether or not a class is a supplier of another class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_CLASS_SUPPLIER_RELATION_CRI

inherit
	QL_CLASS_REFERENCE_RELATION_CRI

create
	make

feature{NONE} -- Implementation

	referenced_classes (a_class_c: CLASS_C): LIST [CLASS_C]
			-- A list of classes referenced by `a_class_c'.
			-- In supplier criterion, it's suppliers of `a_class_c'.
			-- In client criterion, it's clients of `a_class_c'.
		do
			Result := a_class_c.suppliers.classes
		end

	syntactical_referenced_classes (a_class_c: CLASS_C): LIST [CLASS_C]
			-- A list of syntactically referened by `a_class_c'.
			-- In supplier criterion, it's syntactical suppliers of `a_class_c'.
			-- In client criterion, it's ssyntactical clients of `a_class_c'.
		do
			Result := a_class_c.syntactical_suppliers
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

end
