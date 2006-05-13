indexing
	description: "[
					Object that represents a class invariant (compared to feature item that represents a real feature)
					item used in Eiffel query language
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_INVARIANT

inherit
	QL_FEATURE
		redefine
			is_real_feature,
			is_invariant_feature,
			process,
			class_c,
			written_class,
			ast
		end

create
	make,
	make_with_parent

feature{NONE} -- Initialization

	make (a_class: like class_c; a_written_class: like written_class) is
			-- Initialize `class_c' with `a_class_c' and `written_class' with `a_wirtten_class_c'.
		require
			a_class_attached: a_class /= Void
			a_written_class_attached: a_written_class /= Void
			a_written_class_has_invariant: a_written_class.has_invariant
		do
			class_c := a_class
			written_class := a_written_class
		ensure
			class_set: class_c = a_class
			a_written_class_set: written_class = a_written_class
		end

	make_with_parent (a_class: like class_c; a_written_class: like written_class; a_parent: QL_ITEM) is
			-- Initialize `class_c' with `a_class_c', `written_class' with `a_wirtten_class_c' and
			-- `parent' with `a_parent'.
		require
			a_class_attached: a_class /= Void
			a_written_class_attached: a_written_class /= Void
			a_written_class_has_invariant: a_written_class.has_invariant
			a_parent_valid: a_parent /= Void and then a_parent.is_class and then a_parent.is_valid_domain_item and then a_parent.is_compiled
		do
			make (a_class, a_written_class)
			set_parent (a_parent)
		ensure
			class_set: class_c = a_class
			a_written_class_set: written_class = a_written_class
			parent_set: parent = a_parent
		end

feature -- Access

	name: STRING is
			-- Name of current item
		once
			Result := "invariant"
		ensure then
			good_result: Result /= Void and then Result.is_equal ("invariant")
		end

	description: STRING is
			-- Description of current item
		do
			Result := ""
		ensure then
			no_description_attached_to_invariant: Result.is_equal ("")
		end

	class_c: CLASS_C
			-- Associated class with current feature

	ast: INVARIANT_AS is
			-- AST node associated with current feature
		do
			check written_class.has_invariant end
			Result := written_class.invariant_ast
		ensure then
			good_result: Result = written_class.invariant_ast
		end

	written_class: like class_c
			-- CLASS_C in which current invariant is written

	path_name_marker: QL_PATH_MARKER is
			-- Marker for `path_name'
		do
			Result := feature_path_marker
		ensure then
			good_result: Result = feature_path_marker
		end

feature -- Status report

	is_real_feature: BOOLEAN is False
			-- Is current a real feature?

	is_invariant_feature: BOOLEAN is True
			-- Is current an class invariant?

	is_immediate: BOOLEAN is
			-- Is current invariant immediate?
		do
			Result := class_c.class_id = written_class.class_id
		ensure then
			good_result: Result implies (class_c.class_id = written_class.class_id)
		end

feature -- Visit

	process (a_visitor: QL_VISITOR) is
			-- Process `a_visitor'.
		do
			a_visitor.process_invariant (Current)
		end

feature{QL_CRITERION} -- Feature body

	e_feature: E_FEATURE is
			-- Feature associated with Current
		do
			check
				should_not_arrive_here: False
			end
		ensure then
			result_not_attached: Result = Void
		end

invariant
	written_class_attached: written_class /= Void
	parent_valid: parent /= Void implies parent.is_class and parent.is_valid_domain_item and parent.is_compiled

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
