note
	description: "Feature domain item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_DOMAIN_ITEM

inherit
	EB_DOMAIN_ITEM
		redefine
			is_feature_item,
			is_valid,
			string_representation
		end

	QL_SHARED_SCOPES
		undefine
			is_equal
		end

	SHARED_TEXT_ITEMS
		undefine
			is_equal
		end

create
	make

feature -- Status report

	is_feature_item: BOOLEAN = True
			-- Is current a feature item?

	is_valid: BOOLEAN
			-- Does current represent a valid domain item?
		do
			update
			Result := e_feature /= Void
		end

feature -- Access

	domain (a_scope: QL_SCOPE): QL_DOMAIN
			-- New query lanaguage domain representing current item
		do
			Result := ql_feature.wrapped_domain
		end

	string_representation: STRING
			-- Text of current item
		do
			update
			Result := string_representation_internal
		end

	ql_feature: QL_FEATURE
			-- QL_FEATURE object representing current item
		require
			valid: is_valid
		do
			update
			Result := ql_feature_internal
		ensure
			result_attached: Result /= Void
		end

	query_language_item: QL_ITEM
			-- Query language item representation of current domain item
		do
			Result := ql_feature
		end

	group: QL_GROUP
			-- Group to which current domain item belongs
			-- Return the group where current feature's associated is located.
		do
			check
				query_language_item.parent /= Void
				query_language_item.parent.parent /= Void
			end
			Result ?= query_language_item.parent.parent
		ensure then
			result_attached: Result /= Void
		end

	sorting_order_index: INTEGER
			-- Sorting order index
		do
			Result := feature_index
		end

	associated_class_domain_item: EB_CLASS_DOMAIN_ITEM
			-- Class item for associated class of current feature
		require
			valid: is_valid
		do
			create Result.make (id_of_class (e_feature.associated_class.lace_class.config_class))
		ensure
			result_attached: Result /= Void
		end

	written_class_domain_item: EB_CLASS_DOMAIN_ITEM
			-- Class item for written class of current feature
		require
			valid: is_valid
		do
			create Result.make (id_of_class (e_feature.written_class.lace_class.config_class))
		ensure
			result_attached: Result /= Void
		end

	item_type_name: STRING_GENERAL
			-- Name of type of current item
		do
			Result := names.l_feature_domain_item
		end

feature{NONE} -- Implemenation

	update
			-- Update status of current item.			
		do
			if not is_up_to_date then
				e_feature := feature_of_id (id)
				if e_feature /= Void then
					ql_feature_internal := query_feature_item_from_e_feature (e_feature)
					string_representation_internal := e_feature.name
				else
					ql_feature_internal := Void
					if last_feature_name /= Void and then not last_feature_name.is_empty then
						string_representation_internal := last_feature_name.twin
					else
						string_representation_internal := names.l_invalid_item
					end
				end
				update_last_compilation_count
			end
		end

	ql_feature_internal: QL_FEATURE
			-- Query feature item represented by Current

	e_feature: E_FEATURE;
			-- E_FEATURE represented by Current

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
