indexing
	description: "Objects that represent information about an object%
	%retrieved from a generated XML file."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_GENERATED_INFO

create
	make_child,
	make_root
		
feature -- Initialization

	make_root is
			-- Create `Current' as root node of generated info.
		do
			common_make
				-- Remove all information from previous
				-- prepass stage.
			names_by_id.clear_all
			generated_info_by_id.clear_all
		end
		
	make_child (a_parent: GB_GENERATED_INFO) is
			-- Create `Current' as child of `a_parent'.
		do
			common_make
			parent := a_parent
			parent.add_child (Current)
		end
		
feature {NONE} -- Initialization

	common_make is
			-- Initialization common to `make' and `make_child'.
		do
			create children.make (50)
			create supported_types.make (10)
			create supported_type_elements.make (10)
			create events.make (3)
		end
		

feature -- Access

	parent: GB_GENERATED_INFO
		-- Parent of `Current'
	
	children: ARRAYED_LIST [GB_GENERATED_INFO]
		-- All children of `Current'.
	
	type: STRING
		-- Type of `Current', i.e. EV_BUTTON
	
 	supported_types: ARRAYED_LIST [STRING]
 		-- All supported GB_EV_ types that `Current'
 		-- requires for re-building.
 		
 	events: ARRAYED_LIST [GB_ACTION_SEQUENCE_INFO]
 		-- All events of `Current'.
 		
 	supported_type_elements: ARRAYED_LIST [XML_ELEMENT]
 		-- All xml elements matching `supported_types'.
 		
 	names_by_id: HASH_TABLE [STRING, INTEGER] is
			-- All names found during prepass, referenced by id.
		once
			create Result.make (40)
		end
		
	generated_info_by_id: HASH_TABLE [GB_GENERATED_INFO, INTEGER] is
			--  All generated infos referenced by id.
		once
			create Result.make (40)
		end
		

	fonts_set: STRING is
			-- Have one or more fonts been set
			-- in the system?
		once
			Result := ""
		end
		
	pixmaps_set: STRING is
			-- Have one or more pixmaps been set
			-- in the system?
		once
			Result := ""
		end
		
	
	id: INTEGER
		-- Id of associated with object.
	
	name: STRING
		-- Name associated with object.
	
	element: XML_ELEMENT
		-- XML element that was representing object.
	
	child_names: ARRAYED_LIST [STRING] is
			-- `Result' is all `name' of `children'.
		do
			if internal_child_names = Void then
				create internal_child_names.make (children.count)
				from
					children.start
				until
					children.off
				loop
					internal_child_names.extend (children.item.name)
					children.forth
				end
			end
			Result := internal_child_names
		end

feature -- Status setting

	set_type (a_type: STRING) is
			-- Assign `a_type' to `type'.
		do
			type := a_type
		end
		
	set_id (an_id: INTEGER) is
			-- Assign `an_id' to `id'.
		do
			id := an_id
		end
		
	set_name (a_name: STRING) is
			-- Assign `a_name' to `name'.
		do
			name := a_name
		end
		
	set_element (an_element: XML_ELEMENT) is
			-- Assign `an_element' to `element'.
		do
			element := an_element
		end
		
	add_new_supported_type (a_type: STRING) is
			-- Add `a_type' to `supported_types'.
		do
			supported_types.extend (a_type)
		end
		
	add_new_type_element (an_element: XML_ELEMENT) is
			-- Add `an_element' to `supported_type_elements'.
		do
			supported_type_elements.extend (an_element)
		end
		
	add_new_event (event: GB_ACTION_SEQUENCE_INFO) is
			-- Add `event' to `events'.
		do
			events.extend (event)
		end
		
		
	enable_fonts_set is
			-- Make `fonts_set' not `is_empty'.
		do
			fonts_set.append_string ("1")
		end
		
	enable_pixmaps_set is
			-- Make `pixmaps_set' not `is_empty'.
		do
			pixmaps_set.append_string ("1")
		end
		
	reset_after_generation is
			-- Restore once attributes that need to be reset
			-- for each generation.
		do
			fonts_set.wipe_out
			pixmaps_set.wipe_out
		end
		
		
		
		
	
feature -- Element change

	new_child: GB_GENERATED_INFO is
			-- Create a new GB_GENERATED_INFO as
			-- child of `Current'.
		local
			a_new_child: GB_GENERATED_INFO
		do
			create a_new_child.make_child (Current)
			Result := a_new_child
		end

feature {GB_GENERATED_INFO} -- Implementation

	add_child (child: GB_GENERATED_INFO) is
			-- Add `child' to `children'.
		require
			child_exists: child /= Void
		do
			children.extend (child)
		ensure
			child_added: children.has (child)
			children_count_increased: children.count = old children.count + 1
		end
		
feature {NONE} -- Implementation

	internal_child_names: ARRAYED_LIST [STRING]
		-- Internal representation of all child names.
		

invariant
	supported_types_matches_elements: supported_types /= Void implies supported_types.count = supported_type_elements.count

end -- class GB_GENERATED_INFO
