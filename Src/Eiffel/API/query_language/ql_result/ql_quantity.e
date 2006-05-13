indexing
	description: "Object that represents a quantity item used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_QUANTITY

inherit
	QL_ITEM
		redefine
			is_compiled,
			is_valid_domain_item,
			wrapped_domain
		end

create
	default_create,
	make_with_value

feature{NONE} -- Initialization

	make_with_value (a_value: like value) is
			-- Initialize `value' with `a_value'.
		do
			set_value (a_value)
		ensure
			value_set: value = a_value
		end

feature -- Setting

	set_value (a_value: like value) is
			-- Set `value' with `a_value'.
		do
			value := a_value
		ensure
			value_set: value = a_value
		end

feature -- Access

	value: DOUBLE
			-- Value of current quantity item

	name: STRING is
			-- Name of current item
		do
			create Result.make (0)
			Result.append_double (value)
		ensure then
			good_result: Result /= Void and then not Result.is_empty
		end

	description: STRING is
			-- Description of current item
		do
			Result := ""
		ensure then
			no_description_attached_to_quantity: Result.is_equal ("")
		end

	hash_code: INTEGER is
			-- Hash code of current
		do
			if internal_hash_code = 0 then
				internal_hash_code := value.hash_code
			end
			Result := internal_hash_code
		ensure then
			good_result: Result = internal_hash_code and internal_hash_code = value.hash_code
		end

	wrapped_domain: QL_QUANTITY_DOMAIN is
			-- A domain which has current as the only item
		do
			create Result.make
			Result.content.extend (Current)
		end

	path_name_marker: QL_PATH_MARKER is
			-- Marker for `path_name'
		do
			Result := quantity_path_marker
		ensure then
			good_result: Result = quantity_path_marker
		end

feature -- Status report

	is_compiled: BOOLEAN is False
			-- Is Current item compiled?

	is_valid_domain_item: BOOLEAN is True
			-- Is current a valid item that is fully attached in a domain?
			-- True as return value means every ancestors of current item is a valid domain item.

	scope: QL_SCOPE is
			-- Scope of current
		do
			Result := quantity_scope
		ensure then
			good_result: Result = quantity_scope
		end

feature -- Visit

	process (a_visitor: QL_VISITOR) is
			-- Process `a_visitor'.
		do
			a_visitor.process_quantity (Current)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := Current.value = other.value
		ensure then
			good_result: Result implies (Current.value = other.value)
		end

invariant
	parent_not_attached: parent = Void

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
