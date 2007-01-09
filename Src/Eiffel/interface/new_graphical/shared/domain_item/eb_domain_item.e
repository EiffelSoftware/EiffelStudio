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

	HASHABLE
		undefine
			is_equal
		end

	SHARED_WORKBENCH
		undefine
			is_equal
		end

	EB_SHARED_WRITER
		undefine
			is_equal
		end

	EB_SHARED_EDITOR_TOKEN_UTILITY
		undefine
			is_equal
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		undefine
			is_equal
		end

feature{NONE} -- Initialization

	make (a_id: STRING) is
			-- Initialize `id' with `a_id'.
		require
			a_id_attached: a_id /= Void
			system_defined_and_compiled: workbench.system_defined and then workbench.is_already_compiled
		do
			create id.make_from_string (a_id)
			last_compilation_count := -1
			update
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

	is_input_domain_item: BOOLEAN is
			-- Is current an input domain item?
		do
		end

	is_real_delayed_item: BOOLEAN is
			-- Is current a real delayed item?
		do
		end

	is_wrapper_item: BOOLEAN is
			-- Is current a wrapper item?
		do
		end

	is_valid: BOOLEAN is
			-- Does current represent a valid domain item?
		do
		end

	is_up_to_date: BOOLEAN is
			-- Is current domain item up-to-date?
			-- An item can become old when new Eiffel compilation occurs.
		do
			Result := workbench.compilation_counter = last_compilation_count
		end

	is_sorting_order_index_valid (a_index: INTEGER): BOOLEAN is
			-- Is `a_index' a valid sorting order index?
		do
			Result := a_index = wrapper_index or else
					  a_index = target_index or else
					  a_index = cluster_index or else
					  a_index = library_index or else
					  a_index = assembly_index or else
					  a_index = folder_index or else
					  a_index = class_index or else
					  a_index = feature_index or else
					  a_index = delayed_index
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			if
				(is_target_item and then other.is_target_item) or else
				(is_group_item and then other.is_group_item) or else
				(is_folder_item and then other.is_folder_item) or else
				(is_class_item and then other.is_class_item) or else
				(is_feature_item and then other.is_feature_item) or else
				(is_delayed_item and then other.is_delayed_item)
			then
				Result := text_of_id.is_equal (other.text_of_id)
			elseif (is_wrapper_item and then other.is_wrapper_item) then
				Result := query_language_item.is_equal (other.query_language_item)
			end
		end

feature -- Access

	id: STRING
			-- Id of current domain item		

	text_of_id: STRING is
			-- Text of id if it is a id item, otherwise, an empty string
		do
			Result := id
		ensure
			result_attached: Result /= Void
		end

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

	string_representation: STRING is
			-- Text of current item
		deferred
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

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := id.hash_code
		end

	sorting_order_index: INTEGER is
			-- Sorting order index
		deferred
		end

	item_type_name: STRING_GENERAL is
			-- Name of type of current item
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Sorting order index

	wrapper_index: INTEGER is 0
	target_index: INTEGER is 1
	cluster_index: INTEGER is 2
	library_index: INTEGER is 3
	assembly_index: INTEGER is 4
	folder_index: INTEGER is 5
	class_index: INTEGER is 6
	feature_index: INTEGER is 7
	delayed_index: INTEGER is 8
			-- Sorting order index

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
			last_compilation_count := -1
			update
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

feature{NONE} -- Implementation

	last_compilation_count: INTEGER
			-- Compilation count when current itme is updated the last time

	update_last_compilation_count is
			-- Set `last_compilation_count' with `a_count'.
		do
			last_compilation_count := workbench.compilation_counter
		ensure
			last_compilation_count_set: last_compilation_count = workbench.compilation_counter
		end

	update is
			-- Update status of current item.			
		deferred
		ensure
			is_up_to_date: is_up_to_date
		end

	string_representation_internal: like string_representation;
			-- Implementation of `string_representation'

invariant
	id_attached: id /= Void
	sorting_order_index_valid: is_sorting_order_index_valid (sorting_order_index)

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
