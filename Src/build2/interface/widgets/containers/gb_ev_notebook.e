indexing
	description: "Objects that manipulate objects of type EV_NOTEBOOK"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_NOTEBOOK

inherit
	
	GB_EV_ANY
		undefine
			attribute_editor
		redefine
			ev_type,
			modify_from_xml_after_build
		end
		
	GB_EV_NOTEBOOK_EDITOR_CONSTRUCTOR
		
	GB_SHARED_DEFERRED_BUILDER
		undefine
			default_create
		end
		
	DEFAULT_OBJECT_STATE_CHECKER
		undefine
			default_create
		end

feature {GB_XML_STORE} -- Output

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			notebook: EV_NOTEBOOK
			item_text_element: XM_ELEMENT
		do
			notebook ?= default_object_by_type (class_name (first))
			if first.tab_position /= notebook.tab_position then
				add_element_containing_integer (element, Tab_position_string, first.tab_position)
			end
			if not first.is_empty then
				item_text_element := new_child_element (element, item_text_string_new, "")
				from
					first.start
				until
					first.off
				loop					
						-- Note that we always add the element for each item text, even if empty
						-- as the code that updates the constants in GB_EV_NOTEBOOK relies on this fact.
					add_string_element (item_text_element, item_text_string + first.index.out, enclose_in_cdata (first.item_text (first.item)))
					first.forth
				end
				element.force_last (item_text_element)
			end
		end
		
	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			
			element_info := full_information @ (Tab_position_string)
			if element_info /= Void then
				for_all_objects (agent {EV_NOTEBOOK}.set_tab_position (element_info.data.to_integer))
			end
				-- We set up some deferred building now.
			deferred_builder.defer_building (Current, element)
		end
		
	modify_from_xml_after_build (element: XM_ELEMENT) is
			-- Build from XML any information that was
			-- deferred during the load/build cycle.
		local
			element_info: ELEMENT_INFORMATION
			names: ARRAYED_LIST [STRING]
			current_element: XM_ELEMENT
			counter: INTEGER
			string_value: STRING
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (item_text_string_new)
			if element_info /= Void then
				from
					element.start
				until
					element.off
				loop
					current_element ?= element.item_for_iteration
					if current_element /= Void then
						full_information := get_unique_full_info (current_element)
						from
							counter := 1
						until
							counter > first.count
						loop
							if full_information.has (item_text_string + counter.out) then
								string_value := retrieve_and_set_string_value (item_text_string + counter.out)
								if string_value /= Void then
									first.set_item_text (first.i_th (counter), strip_cdata (string_value))
									(objects @ 2).set_item_text ((objects @ 2).i_th (counter), strip_cdata (string_value))
								end
							end
							counter := counter + 1
						end
					end
					element.forth
				end
			end
			
				-- The following code is the old loading for notebook texts, 
				-- which is required for backwards compatibility with older
				-- saved files. The new loading code is above.
			element_info := full_information @ (Item_text_string)
			if element_info /= Void then
				names := names_from_string (element_info.data)
				from
					names.start
				until
					names.off
				loop
					first.set_item_text (first.i_th (names.index), names.item)
					(objects @ 2).set_item_text ((objects @ 2).i_th (names.index), names.item)
					system_status.enable_project_modified
					command_handler.update

					names.forth
				end
			end
		end	
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO):ARRAYED_LIST [STRING] is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info: ELEMENT_INFORMATION
			children_names: ARRAYED_LIST [STRING]
			current_element: XM_ELEMENT
			counter: INTEGER
			string_value: STRING
		do
			create Result.make (4)
			full_information := get_unique_full_info (element)
			element_info := full_information @ (tab_position_string)
			if element_info /= Void then
				Result.extend (info.name + ".set_tab_position (" + element_info.data + ")")
			end

			full_information := get_unique_full_info (element)
			element_info := full_information @ (item_text_string_new)
			if element_info /= Void then
				from
					element.start
				until
					element.off
				loop
					current_element ?= element.item_for_iteration
					if current_element /= Void then
						full_information := get_unique_full_info (current_element)
						children_names := info.child_names
						from
							counter := 1
						until
							counter > info.children.count
						loop
							if full_information.has (item_text_string + counter.out) then
								
							string_value := retrieve_string_setting (item_text_string + counter.out)
							if not string_value.is_equal ("%"%"") then
								Result.extend (info.name + ".set_item_text (" + (children_names @ (counter)) + ", " + string_value + ")")
							end
							end
							counter := counter + 1
						end
					end
					element.forth
				end
			end
		end

end -- class GB_EV_NOTEBOOK
