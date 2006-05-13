indexing
	description: "Object that represents a feature component used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_FEATURE_COMPONENT

inherit
	QL_CODE_STRUCTURE_ITEM

feature -- Access

	description: STRING is
			-- Description of current item
		do
			Result := ""
		ensure then
			no_description_attached_to_a_line: Result.is_equal ("")
		end

	hash_code: INTEGER is
			-- Hash code value
		local
			l_hash_name: STRING
		do
			if internal_hash_code = 0 then
				create l_hash_name.make (50)
				l_hash_name.append (class_c.name)
				l_hash_name.append (e_feature.name)
				l_hash_name.append (name)
				internal_hash_code := l_hash_name.hash_code
			end
			Result := internal_hash_code
		end

	class_c: CLASS_C is
			-- CLASS_C object associated with current item
		local
			l_feature: QL_FEATURE
		do
			if internal_class_c = Void then
				retrieve_class_c_and_e_feature
			end
			Result := internal_class_c
		ensure then
			good_result: Result = internal_class_c
		end

	e_feature: E_FEATURE is
			-- E_FEATURE object associated with current item
		require
			parent_is_real_feature: parent.is_real_feature
		do
			if internal_e_feature = Void then
				retrieve_class_c_and_e_feature
			end
			Result := internal_e_feature
		ensure then
			good_result: Result = internal_e_feature
		end

feature -- Status report

	is_compiled: BOOLEAN is
			-- Is Current item compiled?
		do
			Result := True
		ensure then
			good_result: Result
		end

feature{NONE} -- Implementation

	internal_class_c: like class_c
			-- Implementation of `class_c'

	internal_e_feature: like e_feature
			-- Implementation of `e_feature'

	internal_ast: like ast
			-- Implementation of `ast'

	retrieve_class_c_and_e_feature is
			-- Retrieve `class_c' and `e_feature'.
			-- If parent of current is not a real feature, `e_feature' will be set to Void.
		local
			l_feature: QL_FEATURE
		do
			l_feature ?= parent
			check
				l_feature_attached: l_feature /= Void
			end
			internal_class_c := l_feature.class_c
			if l_feature.is_real_feature then
				internal_e_feature := l_feature.e_feature
			else
				internal_e_feature := Void
			end
		ensure
			internal_class_c_attached: internal_class_c /= Void
			internal_e_feature_correct:
				(parent.is_real_feature implies internal_e_feature /= Void) and
				(not parent.is_real_feature implies internal_e_feature = Void)
		end

invariant
	name_attached: name /= Void
	parent_attached: parent /= Void
	parent_valid: parent.is_valid_domain_item
	parent_is_feature: parent.is_feature

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
