note
	description: "Object that represents a code-related item like class, feature, contract, local, argument, generic"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_CODE_STRUCTURE_ITEM

inherit
	QL_ITEM
		undefine
			is_visible
		end

	SHARED_SERVER

feature -- Access

	ast: AST_EIFFEL
			-- AST node associated with current item
		require
			class_compiled: is_compiled
		deferred
		ensure
			result_attached: Result /= Void
		end

	class_i: CLASS_I
			-- CLASS_I object associated with current item
		deferred
		ensure
			result_attached: Result /= Void
		end

	class_c: CLASS_C
			-- CLASS_C object associated with current item
		require
			class_compiled: is_compiled
		deferred
		ensure
			result_attached: Result /= Void
		end

	written_class: like class_c
			-- CLASS_C in which current is written
		require
			class_compiled: is_compiled
		deferred
		ensure
			result_attached: Result /= Void
		end

	text: STRING
			-- Text of `ast'
		local
			l_list: LEAF_AS_LIST
		do
			check is_compiled end
			l_list := match_list_server.item (written_class.class_id)
			if l_list /= Void then
				Result := ast.original_text (l_list)
			else
				Result := ""
			end
		ensure
			result_attached: Result /= Void
		end

	first_line: INTEGER
			-- Line number of the first line of current item in file
		local
			l_list: LEAF_AS_LIST
		do
			l_list := match_list_server.item (written_class.class_id)
			check l_list /= Void end
			Result := ast.first_token (l_list).line
		end

	parent_with_real_path: QL_ITEM
			-- Parent item of Current with real path.
			-- Real path means that every parent is physically determined.
		do
			Result := query_class_item_from_class_i (class_i)
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
