indexing
	description: "Objects that manipulate objects of type EV_NOTEBOOK"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			item_pixmap_element: XM_ELEMENT
		do
			notebook ?= default_object_by_type (class_name (first))
			if first.tab_position /= notebook.tab_position then
				add_element_containing_integer (element, Tab_position_string, first.tab_position)
			end
			if not first.is_empty then
				item_text_element := new_child_element (element, item_text_string_new, "")
				element.force_last (item_text_element)
				from
					first.start
				until
					first.off
				loop					
						-- Note that we always add the element for each item text, even if empty
						-- as the code that updates the constants in GB_EV_NOTEBOOK relies on this fact.
					add_string_element (item_text_element, item_text_string + first.index.out, first.item_text (first.item))
					first.forth
				end
				item_pixmap_element ?= new_child_element (element, item_pixmap_string_new, "")
				element.force_last (item_pixmap_element)
				from
					first.start
				until
					first.off
				loop
						if first.pixmap_paths.item (first.index) /= Void or uses_constant (Item_pixmap_string + first.index.out)  then
							add_string_element (item_pixmap_element, Item_pixmap_string + first.index.out, first.pixmap_paths.item (first.index))
						end
					first.forth
				end
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
			new_pixmap: EV_PIXMAP
			pixmap_constant: GB_PIXMAP_CONSTANT
			constant_context: GB_CONSTANT_CONTEXT
			a_file_name: FILE_NAME
			file: RAW_FILE
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
									first.set_item_text (first.i_th (counter), string_value)
									(objects @ 2).set_item_text ((objects @ 2).i_th (counter), string_value)
								end
							end
							counter := counter + 1
						end
					end
					element.forth
				end
			end
			full_information := get_unique_full_info (element)
			element_info := full_information @ item_pixmap_string_new
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
							element_info := full_information @ (Item_pixmap_string + counter.out)
							if element_info /= Void then
								if element_info.is_constant then
									pixmap_constant ?= components.constants.all_constants.item (element_info.data)
									create constant_context.make_with_context (pixmap_constant, object, type, Item_pixmap_string + counter.out)
									pixmap_constant.add_referer (constant_context)
									object.add_constant_context (constant_context)
									create new_pixmap
									new_pixmap := pixmap_constant.pixmap
									set_pixmap (new_pixmap, Void, counter)
								else								
									create new_pixmap
									create a_file_name.make_from_string (element_info.data)
									create file.make (a_file_name)	
									if file.exists then
										new_pixmap.set_with_named_file (element_info.data)
										set_pixmap (new_pixmap, element_info.data, counter)
									else
											-- Must set the path even though the pixmap is Void.
										set_pixmap (Void, element_info.data, counter)
								--		for_all_objects (agent {EV_PIXMAP}.disable_pixmap_exists)
									end
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
					components.system_status.mark_as_dirty

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
			a_pixmap_string: STRING
			data: STRING
		do
			create Result.make (4)
			full_information := get_unique_full_info (element)
			element_info := full_information @ (tab_position_string)
			if element_info /= Void then
				Result.extend (info.actual_name_for_feature_call + "set_tab_position (" + element_info.data + ")")
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
								if full_information.item (item_text_string + counter.out).data /= Void then
									Result.append (build_set_code_for_string (item_text_string + counter.out, info.actual_name_for_feature_call, "set_item_text (" + children_names @ (counter) + ", "))
								end
							end
							counter := counter + 1
						end
					end
					element.forth
				end
			end
			
			full_information := get_unique_full_info (element)
			element_info := full_information @ (item_pixmap_string_new)
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
							if full_information.has (Item_pixmap_string + counter.out) then
								element_info := full_information @ (Item_pixmap_string + counter.out)
							
								if element_info.is_constant then
									a_pixmap_string := element_info.data
								else
									info.enable_pixmaps_set
									data := element_info.data
									Result.extend (pixmap_name + ".set_with_named_file (%"" + data + "%")")
									a_pixmap_string := pixmap_name
								end
								if is_type_a_constant (Item_pixmap_string + counter.out) then
									Result.extend (pixmap_constant_set_procedures_string + ".extend (agent (" + info.actual_name_for_feature_call + "item_tab (" + (children_names @ (counter)) + ")).set_pixmap)")
									Result.extend (pixmap_constant_retrieval_functions_string + ".extend (agent " + retrieve_string_setting (Item_pixmap_string + counter.out) + ")")
								else
									Result.extend (info.actual_name_for_feature_call + "item_tab (" + (children_names @ (counter)) + ").set_pixmap (" + a_pixmap_string + ")")
								end
							end
							counter := counter + 1
						end
					end
					element.forth
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class GB_EV_NOTEBOOK
