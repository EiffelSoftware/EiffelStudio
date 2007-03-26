indexing
	description: "Property manager for text criterion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_TEXT_CRITERION_PROPERTY_MANAGER

inherit
	EB_METRIC_CRITERION_PROPERTY_MANAGER
		redefine
			criterion_type,
			property_item
		end

create
	make

feature -- Access

	property_item: EB_METRIC_TEXT_PROPERTY is
			-- Grid item used to display properties
		local
			l_dialog: EB_METRIC_TEXT_PROPERTY_DIALOG
		do
			if property_item_internal = Void then
				create l_dialog
				create property_item_internal.make_with_dialog ("text properties", l_dialog)
				property_item_internal.set_display_agent (agent display_value_agent)
				property_item_internal.enable_text_editing
				property_item_internal.set_value (["", False, {QL_NAME_CRITERION}.identity_matching_strategy])
				property_item_internal.set_text ("...")
				property_item_internal.change_value_actions.extend (agent on_value_change)
				property_item_internal.set_tooltip (metric_names.f_insert_text_here)
			end
			Result := property_item_internal
		ensure then
			value_attached: property_item_internal.value /= Void
		end

feature -- Properties management

	load_properties (a_criterion: like criterion_type) is
			-- Load porperties from `a_criterion' into current manager
		do
			property_item.change_value_actions.block
			property_item.set_value ([a_criterion.text, a_criterion.is_case_sensitive, a_criterion.matching_strategy])
			property_item.change_value_actions.resume
		end

	store_properties (a_criterion: like criterion_type) is
			-- Store properties in current manager into `a_criterion'.
		local
			l_value: TUPLE [a_text: STRING_GENERAL; a_case_sensitive: BOOLEAN; a_matcher: INTEGER]
			l_dialog_property: EB_METRIC_TEXT_PROPERTY
		do
			l_dialog_property ?= property_item
			check l_dialog_property /= Void end
			l_value := property_item.value
			a_criterion.set_text (l_value.a_text.as_string_8)
			if l_value.a_case_sensitive then
				a_criterion.enable_case_sensitive
			else
				a_criterion.disable_case_sensitive
			end
			a_criterion.set_matching_strategy (l_value.a_matcher)
		end

feature{NONE} -- Actions

	display_value_agent (a_value: TUPLE [a_text: STRING_GENERAL; a_case_sensitive: BOOLEAN; a_matcher: INTEGER]): STRING_32 is
			-- Action to return displayable string
		local
			l_str: STRING_GENERAL
		do
			if a_value /= Void then
				l_str := a_value.a_text
			end
			if l_str /= Void then
				Result := l_str.to_string_32
			else
				Result := ""
			end
		ensure
			result_attached: Result /= Void
		end

	on_value_change (a_value: TUPLE [a_text: STRING_GENERAL; a_case_sensitive: BOOLEAN; a_matcher: INTEGER]) is
			-- Action to be performed when `value' from `property_item' changes
		do
			change_actions.call (Void)
		end

feature{NONE} -- Implementation

	criterion_type: EB_METRIC_TEXT_CRITERION
			-- Anchor type

	property_item_internal: like property_item;
			-- Implementation of `property_item'


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
