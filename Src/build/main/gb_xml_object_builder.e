indexing
	description: "Objects that can build a new GB_OBJECT based purely on an xml_element"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_XML_OBJECT_BUILDER

inherit
	GB_SHARED_DEFERRED_BUILDER
		export
			{NONE} all
		end

	GB_CONSTANTS
		export
			{NONE} all
			{ANY} item_string
		end

	GB_FILE_CONSTANTS
		export
			{NONE} all
		end

	GB_EVENT_UTILITIES
		export
			{NONE} all
		end

	INTERNAL
		export
			{NONE} all
		end

	GB_XML_UTILITIES
		export
			{NONE} all
		end

	ANY

feature -- Access

	components: GB_INTERNAL_COMPONENTS is
			-- Access to a set of internal components for an EiffelBuild instance.
		deferred
		end


	new_object (element: XM_ELEMENT; is_component: BOOLEAN): GB_OBJECT is
			-- `Result' is an object generated from `xml_element'.
			-- This object has no parent, is not included in the
			-- objects list and has all representations built.
		require
			element_not_void: element /= Void
		local
			a_new_object: GB_OBJECT
			current_element: XM_ELEMENT
			current_name: STRING
			gb_ev_any: GB_EV_ANY
			display_object: GB_DISPLAY_OBJECT
			xml_element: XM_ELEMENT
		do
			xml_element ?= element.first

			a_new_object := components.object_handler.build_object_from_string (xml_element.attribute_by_name (type_string).value)
			components.object_handler.build_object (a_new_object)
			from
				xml_element.start
			until
				xml_element.off
			loop
				current_element ?= xml_element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name
					if current_name.is_equal (Item_string) then
						-- Add the new objects as children.
						build_new_object (current_element, a_new_object, is_component)

					else
						if current_name.is_equal (Internal_properties_string) then
							a_new_object.modify_from_xml (current_element)
						elseif current_name.is_equal (Events_string) then
							extract_event_information (current_element, a_new_object)
						else
							gb_ev_any ?= new_instance_of (dynamic_type_from_string ("GB_" + current_name))
							gb_ev_any.set_components (components)
								-- Call default_create on `gb_ev_any'
							gb_ev_any.default_create

							-- Ensure that the new class exists.
						check
							new_instance_exists: gb_ev_any /= Void
						end
						gb_ev_any.set_object (a_new_object)
						gb_ev_any.add_object (a_new_object.object)
						display_object ?= a_new_object.display_object
						if display_object = Void then
							gb_ev_any.add_object (a_new_object.display_object)
						else
							gb_ev_any.add_object (display_object.child)
						end

							-- Call `modify_from_xml' which should modify the objects.
						gb_ev_any.modify_from_xml (current_element)

						end
					end
				end
				xml_element.forth
			end
			deferred_builder.build
			Result := a_new_object
		end

	build_new_object (element: XM_ELEMENT; object: GB_OBJECT; is_component: BOOLEAN) is
			-- Build a new object from information in `element'.
		require
			element_not_void: element /= Void
			element_type_is_item: element.name.is_equal (Item_string)
		local
			a_new_object: GB_OBJECT
			current_element: XM_ELEMENT
			gb_ev_any: GB_EV_ANY
			current_name: STRING
			display_object: GB_DISPLAY_OBJECT
		do
			a_new_object := components.object_handler.build_object_from_string (element.attribute_by_name (type_string).value)

			components.object_handler.add_object (object, a_new_object, object.children.count + 1)
			from
				element.start
			until
				element.off
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name
					if current_name.is_equal (Item_string) then
						-- The element represents an item, so we must add new objects.
						build_new_object (current_element, a_new_object, is_component)
					else
						-- We must check for internal properties, else set the properties of the component
						if current_name.is_equal (Internal_properties_string) then
							a_new_object.modify_from_xml (current_element)
						elseif current_name.is_equal (Events_string) then
							-- No events handled.
						else

							-- Create the class.
						gb_ev_any ?= new_instance_of (dynamic_type_from_string ("GB_" + current_name))
						gb_ev_any.set_components (components)
							-- Call default_create on `gb_ev_any'
						gb_ev_any.default_create

							-- Ensure that the new class exists.
						check
							new_instance_exists: gb_ev_any /= Void
						end
						gb_ev_any.set_object (a_new_object)
						gb_ev_any.add_object (a_new_object.object)
						display_object ?= a_new_object.display_object
						if display_object = Void then
							gb_ev_any.add_object (a_new_object.display_object)
						else
							gb_ev_any.add_object (display_object.child)
						end

							-- Call `modify_from_xml' which should modify the objects.
						gb_ev_any.modify_from_xml (current_element)
						end
					end
				end
				element.forth
			end
		end

	replace_all_instances_with_up_to_date_xml (element: XM_ELEMENT) is
			-- For all elements contained within then structure of `element' which represent top
			-- level objects, replace with a new representation of the associated top level object.
		require
			element_not_void: element /= Void
		local
			all_elements: ARRAYED_LIST [XM_ELEMENT]
			all_ids: ARRAYED_LIST [INTEGER]
			xml_store: GB_XML_STORE
			new_element: XM_ELEMENT
			current_element: XM_ELEMENT
			original_parent: XM_ELEMENT
			top_level_object: GB_OBJECT
			deleted_count: INTEGER
			element_info: ELEMENT_INFORMATION
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			top_id: INTEGER
			temp_element: XM_ELEMENT
			current_id: INTEGER
		do
			temp_element ?= child_element_by_name (element, internal_properties_string)
			if temp_element /= Void then
				full_information := get_unique_full_info (temp_element)
				element_info := full_information @ (reference_id_string)
				if element_info /= Void then
					top_id := element_info.data.to_integer
				end
			end

				-- We perform this loop so that if we are flattening instances of top level structures
				-- that no longer exist, and the flattened versions reference other top level structures
				-- that no longer exist the flattening is performed recusively.
			from
				deleted_count := -1
			until
				deleted_count = 0
			loop
				deleted_count := 0
				create all_elements.make (10)
				create all_ids.make (10)
				update_xml (element, all_elements, all_ids)
				create xml_store.make_with_components (components)
				from
					all_ids.start
					all_elements.start
				until
					all_ids.off
				loop
					current_id := all_ids.item

						-- In this case we are a top level instance but are deleted, so
						-- we must create a new instance of the top level object, not a
						-- new reference.
					if current_id = top_id and components.object_handler.deleted_objects.has (current_id) then
						top_level_object := components.object_handler.deep_object_from_id (current_id)
						xml_store.store_individual_object (top_level_object)
						new_element ?= xml_store.last_stored_individual_object.first
					else
						top_level_object := components.object_handler.objects @ current_id
						if top_level_object /= Void then
								-- The top level object still exists, so simply create a new instance.
							xml_store.store_individual_object (top_level_object)
							new_element ?= xml_store.last_stored_individual_object.first
							convert_element_to_instance (new_element, current_id, 1)
						else
								-- Only must increase the deleted count if the id is not the
								-- root object id. i.e. The root node of `element' as `element'
								-- is representing a top level object and not an instance.
								deleted_count := deleted_count + 1

								-- If the object thas been deleted, we simply retrieve it without
								-- converting it to an instance.
							top_level_object := components.object_handler.deleted_objects @ current_id
							xml_store.store_individual_object (top_level_object)
							new_element ?= xml_store.last_stored_individual_object.first
						end
					end

						-- Now replace the old element representing the object with the
						-- new and up to date version.
					current_element := all_elements.item
					original_parent := current_element.parent_element
					from
						original_parent.start
					until
						original_parent.off
					loop
						if original_parent.item_for_iteration = current_element then
							original_parent.replace (new_element, original_parent.index)
						end
						original_parent.forth
					end
					all_ids.forth
					all_elements.forth
				end
			end
		end

	convert_element_to_instance (element: XM_ELEMENT; id, depth: INTEGER) is
			-- Convert a `element' representing a copy of a top level object `id'
			-- to a representation of the top level object. `id' must match the
			-- associated object listed in `element'.
		require
			element_not_void: element /= Void
		local
			referenced_id: INTEGER
			current_element: XM_ELEMENT
			internal_current_element: XM_ELEMENT
			current_name: STRING
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			index: INTEGER
			reference_found: BOOLEAN
			current_index: INTEGER
		do
			from
				element.start
			until
				element.off or reference_found
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name
					if current_name.is_equal (Item_string) then
						-- The element represents an item, so we must add new objects.
						convert_element_to_instance (current_element, id, depth + 1)
					else
						-- We must check for internal properties, else set the properties of the component
						if current_name.is_equal (Internal_properties_string) then
							index := element.index
							current_index := current_element.index
							full_information := get_unique_full_info (current_element)
							if depth = 1 then
								add_element_containing_integer (current_element, reference_id_string, id)
							else
								element_info := full_information @ reference_id_string
								if element_info /= Void then
									referenced_id := element_info.data.to_integer
									from
										current_element.start
									until
										current_element.off
									loop
										internal_current_element ?= current_element.item_for_iteration
										if internal_current_element /= Void then
											if internal_current_element.name.is_equal (reference_id_string) then
												current_element.remove_at
											end
										end
										if not current_element.off then
											current_element.forth
										end
									end
								end
							end
							element.go_i_th (index)
							current_element.go_i_th (current_index.min (current_element.count))
						elseif current_name.is_equal (Events_string) then
							-- No events handled.
						else
						end
					end
				end
				element.forth
			end
		end

	update_xml (element: XM_ELEMENT; all_elements: ARRAYED_LIST [XM_ELEMENT]; all_ids: ARRAYED_LIST [INTEGER]) is
			-- For the representation of a widget structure in `element', return all elements that represent a top level
			-- instance within `all_elements' and the corresponding id of the top level object within `all_ids'.
		require
			element_not_void: element /= Void
			all_elements_not_void: all_elements /= Void
			all_ids_not_void: all_ids /= Void
		local
			referenced_id: INTEGER
			current_element: XM_ELEMENT
			current_name: STRING
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			index: INTEGER
			reference_found: BOOLEAN
		do
			from
				element.start
			until
				element.off or reference_found
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name
					if current_name.is_equal (Item_string) then
						-- The element represents an item, so we must add new objects.
						update_xml (current_element, all_elements, all_ids)
					else
						-- We must check for internal properties, else set the properties of the component
						if current_name.is_equal (Internal_properties_string) then
							index := element.index
							full_information := get_unique_full_info (current_element)
							element_info := full_information @ reference_id_string
							if element_info /= Void then
								referenced_id := element_info.data.to_integer
								all_elements.extend (element)
								all_ids.extend (referenced_id)
								reference_found := True
							end
							element.go_i_th (index)
						elseif current_name.is_equal (Events_string) then
							-- No events handled.
						else
						end
					end
				end
				element.forth
			end
		end

feature {NONE} -- Implementation

	extract_event_information (element: XM_ELEMENT; object: GB_OBJECT) is
			-- Generate event information into `object', from `element'.
		require
			element_not_void: element /= Void
			element_type_is_events: element.name.is_equal (Events_string)
		local
			current_element: XM_ELEMENT
			current_name: STRING
			current_data_element: XM_CHARACTER_DATA
			data: STRING
		do
			from
				element.start
			until
				element.off
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name
					if current_name.is_equal (Event_string) then
						from
							current_element.start
						until
							current_element.off
						loop
							current_data_element ?= current_element.item_for_iteration
							if current_data_element /= Void then
								data := current_data_element.content
									-- Add data into `object'.
								object.events.extend (string_to_action_sequence_info (data))
							end
							current_element.forth
						end
					end
				end
				element.forth
			end
		end

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


end -- class GB_XML_OBJECT_BUILDER
