indexing
	description: "Domain item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_DOMAIN_ITEM

inherit
	EB_SHARED_ID_SOLUTION
		undefine
			is_equal
		end

	QL_UTILITY
		undefine
			is_equal
		end

	QL_SHARED_SCOPES
		undefine
			is_equal
		end

	EB_CONSTANTS
		undefine
			is_equal
		end

feature{NONE} -- Initialization

	make (a_id: STRING) is
			-- Initialize `id' with `a_id'.
		require
			a_id_attached: a_id /= Void
		do
			create id.make_from_string (a_id)
		ensure
			id_set: id /= Void and then id.is_equal (a_id)
		end

feature -- Status report

	is_target_item: BOOLEAN is
			-- Is current an application target item?
		do
		end

	is_group_item: BOOLEAN is
			-- Is current a group item?
		do
		end

	is_folder_item: BOOLEAN is
			-- Is current a folder item?
		do
		end

	is_class_item: BOOLEAN is
			-- Is current a class item?
		do
		end

	is_feature_item: BOOLEAN is
			-- Is current a feature item?
		do
		end

	is_delayed_item: BOOLEAN is
			-- Is current a delayed item?
		do
		end

	is_valid: BOOLEAN is
			-- Does current represent a valid domain item?
		do
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := text_of_id.is_equal (other.text_of_id)
		end

feature -- Access

	domain (a_scope: QL_SCOPE): QL_DOMAIN is
			-- New query lanaguage domain representing current item
			-- `a_scope' is only used to generate delayed domain.
		require
			a_scope_attached: a_scope /= Void
			valid: is_valid
		deferred
		ensure
			result_attached: Result /= Void
		end

	domain_without_scope: QL_DOMAIN is
			-- New query lanaguage domain representing current item
		do
			if not is_delayed_item then
				Result := domain (class_scope)
			end
		ensure
			good_result:
				(is_delayed_item implies Result = Void) and then
				((not is_delayed_item) implies Result /= Void)
		end

	query_language_item: QL_ITEM is
			-- Query language item representation of current domain item
		require
			valid: is_valid
		deferred
		end

	text_of_id: STRING is
			-- Text of id if it is a id item, otherwise, an empty string
		do
			Result := id
		ensure
			result_attached: Result /= Void
		end

	id: STRING
			-- Id of current domain item		

	string_representation: STRING is
			-- Text of current item
		do
			if not is_valid then
				Result := interface_names.l_invalid_item
			end
		ensure
			result_attached: Result /= Void
		end

	library_target_uuid: STRING
			-- UUID of the library target if Current item is a group and represents a library

	group: QL_GROUP is
			-- Group to which current domain item belongs
			-- For group item, return it self,
			-- for folder item, return the group in which the folder is located,
			-- for class item, return the group in which the class is located,
			-- for feature item, return the group in which the feature's associated class is located,
			-- for other kinds of item, return Void.
		deferred
		end

feature -- Setting

	set_library_target_uuid (a_uuid: STRING) is
			-- Set `library_target_uuid' with `a_uuid'.
		require
			a_uuid_attached: a_uuid /= Void
			a_uuid_valid: uuid.is_valid_uuid (a_uuid)
		do
			create library_target_uuid.make_from_string (a_uuid)
		ensure
			library_target_uuid_set: library_target_uuid /= Void and then library_target_uuid.is_equal (a_uuid)
		end

	set_id (a_id: like id) is
			-- Set `id' with `a_id'.
		require
			a_id_attached: a_id /= Void
		do
			create id.make_from_string (a_id)
		ensure
			id_set: id /= Void and then id.is_equal (a_id)
		end

feature -- UUID

	uuid: UUID is
			-- UUID
		do
			create Result
		ensure
			result_attached: Result /= Void
		end

invariant
	id_attached: id /= Void

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
