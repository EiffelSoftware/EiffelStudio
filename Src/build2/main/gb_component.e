indexing
	description: "Objects that represent a component"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMPONENT
	
inherit
	
	GB_XML_OBJECT_BUILDER
		export
			{NONE} all
		end
	
	GB_SHARED_ID
		export
			{NONE} all
		end
	
	GB_GENERAL_UTILITIES
		export
			{NONE} all
		end
	
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		end
	
	GB_NAMING_UTILITIES
		export
			{NONE} all
		end

create
	
	make_with_name
	
feature {NONE} -- Initialization

	make_with_name (a_name: STRING) is
			-- Create `Current' and assign `a_name' to `name'.
		require
			name_not_empty_or_void: a_name /= Void and then not a_name.is_empty
		do
			set_name (a_name)
		ensure
			name_set: name.is_equal (a_name)
		end

feature -- Access

	name: STRING
		-- Name of `Current'.
		
	object: GB_OBJECT is
			-- `Result' is representation of `Current'
			-- unique each time.
		local
--			elements: ARRAYED_LIST [XM_ELEMENT]
--			gb_ev: ARRAYED_LIST [GB_EV_ANY]
--			values: ARRAYED_LIST [INTEGER]
--			new_value: STRING
--			full_information1: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			current_element: XM_ELEMENT
			all_new_objects: ARRAYED_LIST [GB_OBJECT]
		do
			current_element := (create {GB_SHARED_XML_HANDLER}).xml_handler.xml_element_representing_named_component (name)
--			id_compressor.shift_all_ids_upwards
			Result := (new_object (current_element, True))
			id_compressor.shift_object_ids_updwards (Result)
			create all_new_objects.make (50)
			Result.all_children_recursive (all_new_objects)
			object_handler.add_object_to_objects (Result)
			from
				all_new_objects.start
			until
				all_new_objects.off
			loop
				object_handler.add_object_to_objects (all_new_objects.item)
				all_new_objects.forth
			end
			id_compressor.compress_all_id

--| FIXME Must convert to the new implementation so that linked radio buttons still work correctly. This
-- commented code is the old approach, which is very messy. There must be a better way to support this for containers
-- and possible other properties that may need this. Re-implement.


				-- We must now update all ids in the new object, as they may not
				-- be the values that were originally stored, as this would duplicate ids.
				-- All these ids must stay relative, or the radio button grouping would not work correctly.
				-- We must also compress all these ids so that they ARE contiguous, but have no spacing in.
				-- If we did not do this, then we may skip large chunks of ids.	
--			id_compressor.compress_object_id (Result, current_id_counter)
--			
--				-- We must now update all id values stored in xml elements in deferred
--				-- builder. We use id_compressor.lookup for values to adjust by.
--			gb_ev := deferred_builder.all_gb_ev
--			elements := deferred_builder.all_element
--			from
--				gb_ev.start
--			until
--				gb_ev.off
--			loop
--					-- GB_EV_CONTAINER is currently, the only type that will contain
--					-- id references in the XML. If more are added, then they need to be
--					-- handled here also.
--				if gb_ev.item.generating_type.is_equal (gb_ev_container) then
--					current_element := elements @ (gb_ev.index)
--					full_information1 := get_unique_full_info (current_element)
--					if full_information1 @ merged_groups_string /= Void then
--						values := list_from_single_spaced_values ((full_information1 @ merged_groups_string).data)
--						-- Now, we update values to reflect the new ids that values should point to,
--						-- calculated during `compress_object_id'.
--						from
--							values.start
--						until
--							values.off
--						loop
--								-- This if statement cheks for invalid ids in
--								-- the component.
--							if Id_compressor.lookup.has (values.item) then
--								values.replace (Id_compressor.lookup.item (values.item))
--								values.forth
--							else
--								values.remove
--							end
--						end
--						new_value := single_spaced_values_from_list (values)
--
--							-- We can just do a wipe_out as containers only have this
--							-- one attribute.
--						current_element.wipe_out
--							-- The component may have only held invalid
--							-- radio groupings, and if so, then there should not
--							-- be an element replaced.
--						if not new_value.is_empty then
--							add_element_containing_string (current_element, merged_groups_string, new_value)						
--						end
--					end
--				end
--				gb_ev.forth
--			end
--			
--			
				
				-- Now execute the deferred building.	
			deferred_builder.build


			id_compressor.compress_all_id
		ensure
			result_not_void: Result /= Void
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
