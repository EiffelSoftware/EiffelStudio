indexing
	description: "The callbacks that react on metric xml parsing"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_LOAD_METRIC_CALLBACKS

inherit
	XM_CALLBACKS_NULL
		redefine
			on_error,
			on_start_tag,
			on_attribute
		end

	EB_METRIC_XML_CONSTANTS

feature -- Access

	factory: EB_LOAD_METRIC_FACTORY
			-- Factory used to create new nodes when parsing xml definition file

	last_error: EB_METRIC_ERROR
			-- Last error

	current_tag: LINKED_STACK [INTEGER]
			-- The stack of tags we are currently processing

	current_attributes: HASH_TABLE [STRING, INTEGER]
			-- The values of the current attributes	

feature -- Status report

	has_error: BOOLEAN
			-- Does parsing contain error?

feature -- Setting

	clear_last_error is
			-- Clear `last_error'.
		do
			last_error := Void
		ensure
			last_error_is_cleared: last_error = Void and then not has_error
		end

feature -- Callbacks

	on_error (a_message: STRING) is
			-- Event producer detected an error.
		do
			set_parse_error_message (a_message)
		end

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- Start of start tag.
		local
			l_trans: HASH_TABLE [INTEGER, STRING]
			l_tag: INTEGER
		do
			if not has_error then
				if current_tag.is_empty then
					current_tag.extend (t_none)
				end
				l_trans := state_transitions_tag.item (current_tag.item)
				if l_trans /= Void then
					l_tag := l_trans.item (a_local_part)
				end
				if l_tag = 0 then
					set_parse_error_message ("Invalid tag/tag position '"+a_local_part+"'")
				else
					current_tag.extend (l_tag)
				end
			end
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING) is
			-- Start of attribute.
		local
			l_attr: HASH_TABLE [INTEGER, STRING]
			l_attribute: INTEGER
		do
			if not has_error then
				if
					not a_local_part.is_case_insensitive_equal ("xmlns") and not
					a_local_part.is_case_insensitive_equal ("xsi") and not
					a_local_part.is_case_insensitive_equal ("schemaLocation")
				then
					a_local_part.to_lower

						-- check if the attribute is valid for the current state
					l_attr := tag_attributes.item (current_tag.item)
					if l_attr /= Void then
						l_attribute := l_attr.item (a_local_part)
					end
					if current_attributes = Void then
						create current_attributes.make (1)
					end
					if l_attribute /= 0 and then not current_attributes.has (l_attribute) then
						current_attributes.force (a_value, l_attribute)
					else
						set_parse_error_message ("Invalid attribute '"+a_local_part+"'")
					end
				end
			end
		end

feature{NONE} -- Implementation

	set_error (an_error: EB_METRIC_ERROR) is
			-- Set `an_error'.
		require
			an_error_ok: an_error /= Void
		do
			has_error := True
			last_error := an_error
		end

	set_parse_error_message (a_message: STRING) is
			-- We have a parse error with a message.
		local
			l_error: EB_METRIC_ERROR_PARSE
		do
			create l_error
			l_error.set_message (a_message)
			has_error := True
			last_error := l_error
		end

feature{NONE} -- Implementation

	state_transitions_tag: HASH_TABLE [HASH_TABLE [INTEGER, STRING], INTEGER] is
			-- Mapping of possible tag state transitions from `current_tag' with the tag name to the new state.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	tag_attributes: HASH_TABLE [HASH_TABLE [INTEGER, STRING], INTEGER] is
			-- Mapping of possible attributes of tags.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	domain_item_type_table: HASH_TABLE [FUNCTION [ANY, TUPLE[STRING], EB_METRIC_DOMAIN_ITEM], STRING] is
			-- Domain item type
		once
			create Result.make (6)
			Result.put (agent factory.new_application_target_item, "target")
			Result.put (agent factory.new_group_item, "group")
			Result.put (agent factory.new_folder_item, "folder")
			Result.put (agent factory.new_class_item, "class")
			Result.put (agent factory.new_feature_item, "feature")
			Result.put (agent factory.new_delayed_item, "delayed")
		ensure
			result_attached: Result /= Void
		end

	check_uuid_vadility (a_uuid_str: STRING; a_msg: STRING): UUID is
			-- Check vadility of `a_uuid_str'.
			-- If valid, return an UUID object representing `a_uuid_str', otherwise, return Void.
		require
			a_msg_attached: a_msg /= Void
		local
			l_uuid: UUID
		do
			if a_uuid_str = Void then
				set_parse_error_message ("Uuid is missing " + a_msg)
			else
				create l_uuid
				if not l_uuid.is_valid_uuid (a_uuid_str) then
					set_parse_error_message  ("UUID %"" + a_uuid_str +"%" is invalid " + a_msg)
				else
					create Result.make_from_string (a_uuid_str)
				end
			end
		end

	quoted_name (a_name: STRING; a_prefix: STRING): STRING is
			-- Quoted name of `a_name'.
			-- If `a_prefix' is attached, add `a_prefix' before `a_name'.
			-- For example, when `a_name' is "Classes", and `a_prefix' is "metric",
			-- result will be: metric "Classes".
		require
			a_name_attached: a_name /= Void
		do
			if a_prefix /= Void then
				create Result.make (a_name.count + a_prefix.count + 3)
				Result.append (a_prefix)
				Result.append_character (' ')
			else
				create Result.make (a_name.count + 2)
			end
			Result.append_character ('%"')
			Result.append (a_name)
			Result.append_character ('%"')
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Status report

	is_valid_boolean_attribute (a_attr: STRING): BOOLEAN is
			-- Is `a_attr' a valid boolean attribute?
		require
			a_attr_attached: a_attr /= Void
			not_a_attr_is_empty: not a_attr.is_empty
		do
			Result := a_attr.is_boolean
		end

	is_domain_item_type_valid (a_scope: STRING): BOOLEAN is
			-- Is `a_scope' a valid domain item type?
		require
			a_scope_attached: a_scope /= Void
		do
			Result := domain_item_type_table.has (a_scope)
		end

invariant
		factory_attached: factory /= Void

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
