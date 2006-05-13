indexing
	description: "[
					Object that represents a real feature (compared to feature item that represents a class invariant) 
					item used in Eiffel query language
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_REAL_FEATURE

inherit
	QL_FEATURE
		redefine
			is_real_feature,
			is_invariant_feature,
			process,
			ast
		end

	SHARED_SERVER
		undefine
			is_equal
		end

create
	make,
	make_with_parent

feature{NONE} -- Initialization

	make (a_feature: like e_feature) is
			-- Initialize `class_item' with `a_class'.
		require
			a_feature_attached: a_feature /= Void
		do
			e_feature := a_feature
		ensure
			e_feature_set: e_feature = a_feature
		end


	make_with_parent (a_feature: like e_feature; a_parent: like parent) is
			-- Initialize `class_item' with `a_class' and `parent' with `a_parent'
		require
			a_feature_attached: a_feature /= Void
			a_parent_attached: a_parent /= Void
			a_parent_valid: a_parent.is_class and then a_parent.is_compiled
		do
			make (a_feature)
			set_parent (a_parent)
		ensure
			e_feature_set: e_feature = a_feature
		end

feature -- Access

	name: STRING is
			-- Name of current item
		do
			Result := e_feature.name
		ensure then
			good_result: Result /= Void and then Result.is_equal (e_feature.name)
		end

	description: STRING is
			-- Description of current item
		local
			l_comments: EIFFEL_COMMENTS
		do
			l_comments := e_feature.ast.comment (match_list_server.item (e_feature.written_class.class_id))
			if l_comments /= Void then
				create Result.make (50)
				from
					l_comments.start
				until
					l_comments.after
				loop
					Result.append (l_comments.item)
					l_comments.forth
				end
			else
				Result := ""
			end
		end

	e_feature: E_FEATURE
			-- Feature associated with Current

	class_c: CLASS_C is
			-- Associated class with current feature
		do
			Result := e_feature.associated_class
		ensure then
			good_result: Result = e_feature.associated_class
		end

	ast: FEATURE_AS is
			-- AST node associated with current feature
		do
			Result := e_feature.ast
		ensure then
			good_result: Result = e_feature.ast
		end

	written_class: like class_c is
			-- CLASS_C in which current is written
		do
			Result := e_feature.written_class
		ensure then
			good_result: Result = e_feature.written_class
		end

	path_name_marker: QL_PATH_MARKER is
			-- Marker for `path_name'
		do
			Result := feature_path_marker
		ensure then
			good_result: Result = feature_path_marker
		end

feature -- Status report

	is_real_feature: BOOLEAN is True
			-- Is current a real feature?

	is_invariant_feature: BOOLEAN is False
			-- Is current an class invariant?

	is_immediate: BOOLEAN is
			-- Is current invariant immediate?
		do
			Result := e_feature.written_class.class_id = e_feature.associated_class.class_id
		ensure then
			good_result: Result implies (e_feature.written_class.class_id = e_feature.associated_class.class_id)
		end

feature -- Visit

	process (a_visitor: QL_VISITOR) is
			-- Process `a_visitor'.
		do
			a_visitor.process_real_feature (Current)
		end

invariant
	e_feature_attached: e_feature /= Void

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
