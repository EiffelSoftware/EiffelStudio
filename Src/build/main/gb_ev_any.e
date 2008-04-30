indexing
	description: "Objects that manipulate/have knowledge of Vision2 objects."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_ANY

inherit
	ANY
		redefine
			default_create
		end

	INTERNAL
		export
			{NONE} all
		undefine
			default_create
		end

	GB_CONSTANTS
		export
			{NONE} all
			{ANY} Ev_titled_window_string
		undefine
			default_create
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		undefine
			default_create
		end

	GB_XML_UTILITIES
		undefine
			default_create
		end

	GB_GENERAL_UTILITIES
		export
			{NONE} all
		undefine
			default_create
		end

feature -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	set_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
		ensure
			components_set: components = a_components
		end

	default_create is
			-- Create `Current'.
			-- Create `objects' to hold 2 items.
		do
			create objects.make (2)
			create validate_agents.make (2)
			create execution_agents.make (2)
			initialize_agents
		end

feature -- Access

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		deferred
		end

	validate_agents: HASH_TABLE [FUNCTION [ANY, TUPLE, BOOLEAN], STRING]
			-- Agents to query if a property modification is permitted, accessible
			-- via their associated name.

	execution_agents: HASH_TABLE [PROCEDURE [ANY, TUPLE], STRING]
			-- Agents to execute a property modification, accessible
			-- via their associated name.

	parent_editor: GB_OBJECT_EDITOR
		-- Object editor containing `Current'.

	object: GB_OBJECT
			-- Object referenced by `Current'. May be Void when generating code.

	type: STRING is
			-- String representation of object_type modifyable by `Current'.
		deferred
		end

	first: like ev_type is
			-- First entry in `objects'. This corresponds to
			-- the display component.
		require
			objects_not_empty: not objects.is_empty
		do
			Result := objects.first
		ensure
			Result_not_void: Result /= Void
		end

	initialize_attribute_editor (editor: GB_OBJECT_EDITOR_ITEM) is
			-- Perform necessary initialization on `editor'.
		require
			editor_not_void: editor /= Void
		do
			editor.set_type_represented (type)
			editor.set_creating_class (Current)
		end

	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
			-- Redefined in descendents. For example, see
			-- GB_EV_SENSITIVE.
		require
			objects_not_void: objects /= Void
			objects_has_at_least_one_item: objects.count >= 1
		do
			create Result.make_with_components (components)
			Result.set_type_represented (type)
			Result.set_creating_class (Current)
		ensure
			result_not_void: Result /= Void
		end

	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		deferred
		end


	objects: ARRAYED_LIST [like ev_type]
		-- All objects to which `Current' represents.
		-- Modifications must be made to all items
		-- identically.

feature -- Status setting

	add_object (an_object: like ev_type) is
			-- Add `an_object' to `objects'.
		require
			an_object_not_void: an_object /= Void
		do
			objects.extend (an_object)
		ensure
			objects.has (an_object)
		end

	set_object (an_object: GB_OBJECT) is
			-- Assign `an_object' to `object'.
		require
			an_object_not_void: an_object /= Void
		do
			object := an_object
		ensure
			object_set: object = an_object
		end


	set_parent_editor (an_editor: GB_OBJECT_EDITOR) is
			-- Assign `an_editor' to `parent_editor'.
		require
			an_editor_not_void: an_editor /= Void
		do
		 parent_editor := an_editor
		ensure
			object_editor_assigned: parent_editor = an_editor
		end


feature {GB_XML_STORE} -- Output


	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		require
			element_not_void: element /= Void
				-- `Current' has been generated dynamically as needed, so there is
				-- no reason for objects to have more than one representation of the
				-- widget that we wish to work with at this point.
			objects_only_has_one_item: objects.count = 1
			has_associated_object: object /= Void
		deferred
		ensure
				-- Why are we calling generate_xml on an GB_EV_ANY
				-- That does not have any attributes to store?
				-- This ensures we do not.
				-- As we only store the attributes if necessary, this does not hold.
				-- Maybe there is a way we can implement it with some kind of variable
				-- For now, remove.
				--	at_least_one_element_added: element.count > old element.count
		end

feature {GB_XML_LOAD, GB_XML_OBJECT_BUILDER, GB_XML_IMPORT, GB_OBJECT_HANDLER} -- Status setting

	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		require
			element_not_void: element /= Void
			has_associated_object: object /= Void
		deferred
		end

feature {GB_DEFERRED_BUILDER} -- Status setting

	modify_from_xml_after_build (element: XM_ELEMENT) is
			-- Redefine in any descendents that must perform part of
			-- their building at the end of the load/build cycle.
			-- Example  - GB_EV_BOX
		do
			-- Does nothing by default
		end

feature {GB_CODE_GENERATOR} -- Status setting

	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): ARRAYED_LIST [STRING] is
			-- `Result' is string representation of settings held in `Current' which is
			-- in a compilable format. Each element is a different setting line.
			-- `element' is the XML element that contains information about `Current'.
			-- So if `Current' is GB_EV_CONTAINER, `element' is <CONTAINER> in XML.
			-- `info' is info retrieved from the XML during the prepass stage, and contains
			-- all necessary information about the object that `Current' represents.
			-- Note that `info' therefore contains `element' within `supported_type_elements'.
		require
			element_not_void: element /= Void
			info_not_void: info /= Void
			info_contains_element: info.supported_type_elements.has (element)
			info_name_not_empty: not info.name.is_empty
		deferred
		ensure
			result_not_void: Result /= Void
		end


feature {GB_OBJECT} -- Status setting

	set_up_user_events (actual_object: GB_OBJECT; vision2_object, an_object: like ev_type) is
			-- Add events necessary for `vision2_object'.
			-- Some objects such as EV_TOGGLE_BUTTON can be modified
			-- by the user in the display window. We need to set up events
			-- on `vision2_object' so that we can notify the system that the
			-- change has taken place. There are only a few such events
			-- like these, but we need to be able to handle them.
			-- Does nothing by default, but must be redefined in descendents
			-- where an event must be handled.
		require
			actual_object_not_void: actual_object /= Void
			vision2_object_not_void: vision2_object /= Void
			an_object_not_void: an_object /= Void
		do
		ensure
			object_set: object = actual_object
			objects_count_is_two: objects.count = 2 and objects.has (vision2_object) and objects.has (an_object)
		end

	has_user_events: BOOLEAN is
			-- Does `Current' have user events which must be set?
		once
			Result := False
		end

feature {NONE} -- Implementation

	ev_type: EV_ANY is
			-- Vision2 type represented by `Current'.
			-- Only used with `like' in descendents.
			-- Always `Void'.
		deferred
		end

	for_all_objects (p: PROCEDURE [EV_ANY, TUPLE]) is
			-- Call `p' on every item in `objects'.
		do
			from
				objects.start
			until
				objects.off
			loop
				for_one_object (objects.item, p)
				objects.forth
			end
			object.update_instances (p)
			enable_project_modified
		end

	for_first_object (p: PROCEDURE [EV_ANY, TUPLE]) is
			-- Call `p' on the first_item in `objects'.
		require
			p_not_void: p /= Void
			objects_not_empty: not objects.is_empty
		do
			for_one_object (objects.first, p)
			object.update_first_instances (p)
			enable_project_modified
		end

	for_one_object (a_object: like ev_type; p: PROCEDURE [EV_ANY, TUPLE]) is
			-- Call `p' on `a_object'.
		require
			a_object_not_void: a_object /= Void
			p_not_void: p /= Void
		local
			l_tuple: TUPLE
		do
			l_tuple := p.empty_operands
			if l_tuple.valid_index (1) then
				check
					valid_item: l_tuple.valid_type_for_index (a_object, 1)
				end
				l_tuple.put (a_object, 1)
			end
			check valid_operands: p.valid_operands (l_tuple) end
			p.call (l_tuple)
		end

	for_all_instance_referers (an_object: GB_OBJECT; p: PROCEDURE [ANY, TUPLE [GB_OBJECT]]) is
			-- For all instance referers recursively of `an_object', call `p' with the current
			-- instance referer filled as the open argument. Used in places where `for_all_objects'
			-- can not be used directly as some level of indirection and/or calculation is required
			-- for each individual setting.
		require
			an_object_not_void: an_object /= Void
			p_not_void: p /= Void
		local
			current_object: GB_OBJECT
			l_tuple: TUPLE [GB_OBJECT]
		do
			from
				an_object.instance_referers.start
			until
				an_object.instance_referers.off
			loop
				current_object := components.object_handler.deep_object_from_id (an_object.instance_referers.item_for_iteration)
				l_tuple := p.empty_operands
				if l_tuple.valid_index (1) then
					check
						valid_item: l_tuple.valid_type_for_index (current_object, 1)
					end
					l_tuple.put (current_object, 1)
				end
				check valid_operands: p.valid_operands (l_tuple) end
				p.call (l_tuple)
				for_all_instance_referers (current_object, p)
				an_object.instance_referers.forth
			end
		end

	update_editors is
			-- Short version for calling everywhere.
		do
			components.object_editors.update_editors_for_property_change (objects.first, type, parent_editor)
		end

	strip_leading_indent (s: STRING): STRING is
			-- If `s' starts with `indent' then strip this indent.
			-- This is used in the code generation routines.
		do
			if s.substring (1, indent.count).is_equal (indent) then
				Result := s.substring (indent.count + 1, s.count)
			else
				Result := s
			end
		end

	enable_project_modified is
			-- Call enable_project_modified on `system_status' and
			-- update commands to reflect this.
		do
			components.system_status.mark_as_dirty
		end

	is_type_a_constant (a_type_name: STRING): BOOLEAN is
			-- Is data associated with `a_type_name' in `full_information',
			-- a constant?
		require
			type_not_not_void: a_type_name /= Void
		local
			element_info: ELEMENT_INFORMATION
		do
			element_info := full_information @ a_type_name
			if element_info /= Void then
				if element_info.is_constant then
					Result := True
				end
			end
		end

	retrieve_and_set_integer_value (a_type_name: STRING): INTEGER is
			-- Result is integer data associated with `a_type_name'.
			-- If the data of `a_type_name' is a constant, then create a new constant_context
			-- within the system, and return the integer data of the constant.
			-- Should only be user while loading a project from XML, and after a call to
			-- `get_unique_full_info'.
		require
			a_type_name_not_void: a_type_name /= Void
		local
			integer_constant: GB_INTEGER_CONSTANT
			element_info: ELEMENT_INFORMATION
			constant_context: GB_CONSTANT_CONTEXT
		do
			element_info := full_information @ a_type_name
			if element_info /= Void then
				if element_info.is_constant then
					integer_constant ?= components.constants.all_constants.item (element_info.data)
					create constant_context.make_with_context (integer_constant, object, type, a_type_name)
					integer_constant.add_referer (constant_context)
					object.add_constant_context (constant_context)
					Result := integer_constant.value
				else
					Result := element_info.data.to_integer
				end
			end
		end

	retrieve_string_setting (a_type_name: STRING): STRING is
			-- Result is string representation of data associated with `a_type_name''.
		require
			type_not_not_void: a_type_name /= Void
		local
			constant: GB_CONSTANT
			element_info: ELEMENT_INFORMATION
		do
			element_info := full_information @ a_type_name
			if element_info /= Void then
				if element_info.is_constant then
					constant ?= components.constants.all_constants.item (element_info.data)
					Result := constant.name
				else
					Result := "%"" + escape_special_characters (element_info.data) + "%""
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	retrieve_integer_setting (a_type_name: STRING): STRING is
			-- Result is string representation of data associated with `a_type_name''.
		require
			type_not_not_void: a_type_name /= Void
		local
			constant: GB_CONSTANT
			element_info: ELEMENT_INFORMATION
		do
			element_info := full_information @ a_type_name
			if element_info /= Void then
				if element_info.is_constant then
					constant ?= components.constants.all_constants.item (element_info.data)
					Result := constant.name
				else
					Result := element_info.data
				end
			end
		end

	retrieve_and_set_string_value (a_type_name: STRING): STRING is
			-- Result is string data associated with `a_type_name'.
			-- If the data of `a_type_name' is a constant, then create a new constant_context
			-- within the system, and return the integer data of the constant.
			-- Should only be user while loading a project from XML, and after a call to
			-- `get_unique_full_info'.
		require
			a_type_name_not_void: a_type_name /= Void
		local
			string_constant: GB_STRING_CONSTANT
			element_info: ELEMENT_INFORMATION
			constant_context: GB_CONSTANT_CONTEXT
		do
			element_info := full_information @ a_type_name
			if element_info /= Void then
				if element_info.is_constant then
					string_constant ?= components.constants.all_constants.item (element_info.data)
					if string_constant /= Void then
						create constant_context.make_with_context (string_constant, object, type, a_type_name)
						string_constant.add_referer (constant_context)
						object.add_constant_context (constant_context)
						Result := string_constant.value
					else
						--| FIXME IEK There is an error in the generated XML where a constant is referenced but not defined.
						--| The reason how the XML can be put into an invalid state is unknown.
						--| For now, return a valid error message constant so that project may still be used.
						Result := "*** Error - Constant for " + a_type_name + " not found ****"
					end

				else
					Result := element_info.data
				end
			end
		end

	retrieve_and_set_color_value (a_type_name: STRING): EV_COLOR is
			-- Result is string data associated with `a_type_name'.
			-- If the data of `a_type_name' is a constant, then create a new constant_context
			-- within the system, and return the integer data of the constant.
			-- Should only be user while loading a project from XML, and after a call to
			-- `get_unique_full_info'.
		require
			a_type_name_not_void: a_type_name /= Void
		local
			color_constant: GB_COLOR_CONSTANT
			element_info: ELEMENT_INFORMATION
			constant_context: GB_CONSTANT_CONTEXT
		do
			element_info := full_information @ a_type_name
			if element_info /= Void then
				if element_info.is_constant then
					color_constant ?= components.constants.all_constants.item (element_info.data)
					create constant_context.make_with_context (color_constant, object, type, a_type_name)
					color_constant.add_referer (constant_context)
					object.add_constant_context (constant_context)
					Result := color_constant.value
				else
					Result := build_color_from_string (element_info.data)
				end
			end
		end

	add_integer_element (element: XM_ELEMENT; name: STRING; current_value: INTEGER) is
			-- Add an element containing an INTEGER to `element', with name `name' and
			-- value `current_value' if no constant is specified, of the value of the constant
			-- in another constant element, if the current setting is represented by a constant.
		require
			element_not_void: element /= Void
			name_not_void: name /= Void
		do
			if uses_constant (name) then
				add_element_containing_integer_constant (element, name, object.constants.item (type + name).constant.name)
			else
				add_element_containing_integer (element, name, current_value)
			end
		end

	add_font_element (element: XM_ELEMENT; name: STRING; font: EV_FONT) is
			-- Add an element containing an EV_FONT to `element' with value `font'.
			-- if no constant is specified, of the value of the constant
			-- in another constant element, if the current setting is represented by a constant.
		require
			element_not_void: element /= Void
			name_not_void: name /= Void
			current_value_not_void: font /= Void
		do
			if uses_constant (name) then
				add_element_containing_integer_constant (element, name, object.constants.item (type + name).constant.name)
			else
				add_element_containing_integer (element, font_family_string, font.family)
				add_element_containing_integer (element, font_weight_string, font.weight)
				add_element_containing_integer (element, font_shape_string, font.shape)
				add_element_containing_integer (element, font_height_points_string, font.height_in_points)

					--|FIXME the `is_empty' check on the following line is to fix the bug reported by Guy Fokou
					--|KB entry 4203. Not yet sure why `preferred_families' would have an empty entry.
				if not font.preferred_families.is_empty and not (font.preferred_families @ 1).is_empty then
					add_element_containing_string (element, font_preferred_family_string, font.preferred_families @ 1)
				end
			end
		end

	add_color_element (element: XM_ELEMENT; name: STRING; color: EV_COLOR) is
			-- Add an element containing an EV_COLOR to `element' with value `color'.
			-- if no constant is specified, of the value of the constant
			-- in another constant element, if the current setting is represented by a constant.
		require
			element_not_void: element /= Void
			name_not_void: name /= Void
			current_value_not_void: color /= Void
		do
			if uses_constant (name) then
				add_element_containing_integer_constant (element, name, object.constants.item (type + name).constant.name)
			else
				add_element_containing_string (element, name, build_string_from_color (color))
			end
		end

	add_string_element (element: XM_ELEMENT; name: STRING; current_value: STRING) is
			-- Add an element containing a STRING to `element', with name `name' and
			-- value `current_value' if no constant is specified, of the value of the constant
			-- in another constant element, if the current setting is represented by a constant.
		require
			element_not_void: element /= Void
			name_not_void: name /= Void
		do
			if uses_constant (name) then
				add_element_containing_integer_constant (element, name, object.constants.item (type + name).constant.name)
			else
				add_element_containing_string (element, name, current_value)
			end
		end

	uses_constant (an_attribute: STRING): BOOLEAN is
			-- Does attribute named `an_attribute' use a constant?
		require
			an_attribute_not_void: an_attribute /= Void
		do
			Result := object.constants.item (type + an_attribute) /= Void
		end

	attribute_set (an_attribute: STRING): BOOLEAN is
			-- Has attribute named `an_attribute' been set?
		require
			an_attribute_not_void: an_attribute /= Void
			full_information_not_void: full_information /= Void
		do
			Result := full_information @ (an_attribute) /= Void
		end

	full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
		-- Result of last call to `get_unique_full_info'.

	build_set_code_for_string (item_text, access_string, feature_call: STRING): ARRAYED_LIST [STRING] is
			-- Generate code for a string property represented by `item_text' within `full_information'
			-- called on an object named `access_string' with the property features call represented by `feature_call'.
		require
			item_text_not_void: item_text /= Void
			access_string_not_void: access_string /= Void
			feature_call_not_void: feature_call /= Void
		do
			create Result.make (1)
			if is_type_a_constant (item_text) then
				Result.extend (string_constant_set_procedures_string + ".extend (agent " + access_string + feature_call + "?))")
				Result.extend (string_constant_retrieval_functions_string + ".extend (agent " + retrieve_string_setting (item_text) + ")")
			else
				Result.extend (access_string + feature_call + retrieve_string_setting (item_text) + ")")
			end
		ensure
			result_not_void: Result /= Void
		end

	build_set_code_for_integer (item_text, access_string, feature_call: STRING): ARRAYED_LIST [STRING] is
			-- Generate code for an integer property represented by `item_text' within `full_information'
			-- called on an object named `access_string' with the property features call represented by `feature_call'.
		require
			item_text_not_void: item_text /= Void
			access_string_not_void: access_string /= Void
			feature_call_not_void: feature_call /= Void
		do
			create Result.make (1)
			if is_type_a_constant (item_text) then
				Result.extend (integer_constant_set_procedures_string + ".extend (agent " + access_string + feature_call + "?))")
				Result.extend (integer_constant_retrieval_functions_string + ".extend (agent " + retrieve_string_setting (item_text) + ")")
			else
				Result.extend (access_string + feature_call + retrieve_integer_setting (item_text) + ")")
			end
		ensure
			result_not_void: Result /= Void
		end

invariant

	ev_type_is_void: ev_type = Void

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


end -- class GB_EV_ANY
