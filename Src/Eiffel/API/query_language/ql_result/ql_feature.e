indexing
	description: "Object that represents a feature item used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_FEATURE

inherit
	QL_CODE_STRUCTURE_ITEM
		redefine
			is_equal,
			is_compiled,
			wrapped_domain
		end

feature -- Access

	name: STRING is
			-- Name of current item
		deferred
		end

	hash_code: INTEGER is
			-- Hash code of current
		local
			l_name: STRING
		do
			if internal_hash_code = 0 then
				if parent /= Void then
					create l_name.make (name.count + parent.name.count + 1)
					l_name.append (parent.name)
					l_name.append_character (path_separator)
					l_name.append (name)
					internal_hash_code := l_name.hash_code
				else
					internal_hash_code := name.hash_code
				end
			end
			Result := internal_hash_code
		end

	wrapped_domain: QL_FEATURE_DOMAIN is
			-- A feature domain which has current as the only item
		do
			create Result.make
			Result.content.extend (Current)
		end

	scope: QL_SCOPE is
			-- Scope of current
		do
			Result := feature_scope
		ensure then
			good_result: Result = feature_scope
		end

feature -- Status report

	is_compiled: BOOLEAN is True
			-- Is current item compiled?

	is_immediate: BOOLEAN is
			-- Is current invariant immediate?
		deferred
		end

feature -- Visit

	process (a_visitor: QL_VISITOR) is
			-- Process `a_visitor'.
		do
			a_visitor.process_feature (Current)
		end

feature -- Feature body

	e_feature: E_FEATURE is
			-- Feature associated with Current
		require
			is_real_feature: is_real_feature
		deferred
		end

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			if is_real_feature and other.is_real_feature then
				Result := e_feature.same_as (other.e_feature)
			elseif is_invariant_feature and other.is_invariant_feature then
				Result := written_class.class_id = other.written_class.class_id
			end
		end


invariant
	class_c_attached: class_c /= Void
	parent_valid: parent /= Void implies parent.is_class and parent.is_valid_domain_item

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
