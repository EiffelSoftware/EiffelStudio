indexing
	description: "Objects that represent a component"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMPONENT
	
inherit
	
	GB_XML_OBJECT_BUILDER
	
	GB_SHARED_ID
	
	GB_GENERAL_UTILITIES
	
	GB_XML_UTILITIES
	
	GB_SHARED_OBJECT_HANDLER
	
	GB_NAMING_UTILITIES

create
	
	make_with_name
	
feature {NONE} -- Initialization

	make_with_name (a_name: STRING) is
			-- Create `Current' and assign `a_name' to `name'.
		do
			set_name (a_name)
		end
		

feature -- Access

	name: STRING
		-- Name of `Current'.
		
	object: GB_OBJECT is
			-- `Result' is representation of `Current'
			-- unique each time.
		local
			elements: ARRAYED_LIST [XML_ELEMENT]
			gb_ev: ARRAYED_LIST [GB_EV_ANY]
			values: ARRAYED_LIST [INTEGER]
			new_value: STRING
			full_information1: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			current_element: XML_ELEMENT
			ucstring: UCSTRING
		do
			Result := (new_object ((create {GB_SHARED_XML_HANDLER}).xml_handler.xml_element_representing_named_component (name), True))
				-- We must now update all ids in the new object, as they may not
				-- be the values that were originally stored, as this would duplicate ids.
				-- All these ids must stay relative, or the radio button grouping would not work correctly.
				-- We must also compress all these ids so that they ARE contiguous, but have no spacing in.
				-- If we did not do this, then we may skip large chunks of ids.
				
				
			id_compressor.compress_object_id (Result, current_id_counter)
			
				-- We must now update all id values stored in xml elements in deferred
				-- builder. We use id_compressor.lookup for values to adjust by.
			gb_ev := deferred_builder.all_gb_ev
			elements := deferred_builder.all_element
			from
				gb_ev.start
			until
				gb_ev.off
			loop
					-- GB_EV_CONTAINER is currently, the only type that will contain
					-- id references in the XML. If more are added, then they need to be
					-- handled here also.
				if gb_ev.item.generating_type.is_equal (gb_ev_container) then
					current_element := elements @ (gb_ev.index)
					full_information1 := get_unique_full_info (current_element)
					if full_information1 @ merged_groups_string /= Void then
						values := list_from_single_spaced_values ((full_information1 @ merged_groups_string).data)
						-- Now, we update values to reflect the new ids that values should point to,
						-- calculated during `compress_object_id'.
						from
							values.start
						until
							values.off
						loop
								-- This if statement cheks for invalid ids in
								-- the component.
							if Id_compressor.lookup.has (values.item) then
								values.replace (Id_compressor.lookup.item (values.item))
								values.forth
							else
								values.remove
							end
						end
						new_value := single_spaced_values_from_list (values)
							-- We must now replace the current string value in the xml element, with `new_value'.
						create ucstring.make_from_string (merged_groups_string)
							-- We can just do a wipe_out as containers only have this
							-- one attribute.
						current_element.wipe_out
							-- The component may have only held invalid
							-- radio groupings, and if so, then there should not
							-- be an element replaced.
						if not new_value.is_empty then
							add_element_containing_string (current_element, merged_groups_string, new_value)						
						end
					end
				end
				gb_ev.forth
			end
			
			
				
				-- Now execute the deferred building.	
			deferred_builder.build
			
			
				-- Now we must rename the objects, as if they were created with names, we need to
				-- make sure that the names are not repeated.
			object_handler.recursive_do_all (Result, agent ensure_names_unique (?))
		ensure
			result_not_void: Result /= Void
		end
		
	ensure_names_unique (an_object: GB_OBJECT) is
			-- Ensure that name of `an_object' is unique, and does not
			-- clash with any feature names also.
		local
			temp_name, original_name: STRING
			counter: INTEGER
		do
			if not an_object.name.is_empty then
				from
					original_name := an_object.name
					temp_name := original_name
					counter := 1
				until
					not object_handler.string_is_feature_name (temp_name, an_object) and
					not object_handler.string_is_object_name (temp_name, an_object)
				loop
					temp_name := original_name + counter.out
					counter := counter + 1
				end
				an_object.set_name (temp_name)	
				an_object.layout_item.set_text (an_object.name + ": " + an_object.type.substring (4, an_object.type.count))			
			end
		end
		

	root_element_type: STRING is
			-- `Result' is type of root element.
		do
			Result := ((create {GB_SHARED_XML_HANDLER}).xml_handler.component_root_element_type (name))
		end
		

feature -- Status Setting

	set_name (a_name: STRING) is
			-- Assign `a_name' to `name'.
		require
			name_valid: a_name /= Void and then not a_name.is_empty
		do
			name := a_name
		ensure
			name_set: name = a_name
		end
		
feature {NONE} -- Implementation

	id_compressor: GB_ID_COMPRESSOR is
			-- Once instance of GB_ID_COMPRESSOR
			-- for compressing saved Ids.
		once
			create Result
		end

end -- class GB_COMPONENT
