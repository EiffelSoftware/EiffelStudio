indexing
	description: "Objects that check the nesting structures within EiffelBuild"
	date: "$Date$"
	revision: "$Revision$"

class
	GB_NESTING_CHECKER
	
inherit
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
	
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		end

feature -- Access

	check_nesting is
			-- Check nesting of all top level objects within the current project
			-- to ensure that they are consistent and not corrupted. Simply
			-- checks types and structure, not the properties.
		local
			top_objects: ARRAYED_LIST [GB_OBJECT]
		do
			top_objects := widget_selector.objects
			from
				top_objects.start
			until
				top_objects.off
			loop
				check_object (top_objects.item)
				top_objects.forth
			end
		end
		
	check_object (an_object: GB_OBJECT) is
			--
		require
			an_object_is_top_level: an_object.is_top_level_object
		local
			all_children: ARRAYED_LIST [GB_OBJECT]
			all_instance_children: ARRAYED_LIST [GB_OBJECT]
			instance_object: GB_OBJECT
		do
			create all_children.make (20)
			an_object.all_children_recursive (all_children)
			all_children.extend (an_object)
			from
				an_object.instance_referers.start
			until
				an_object.instance_referers.off
			loop
				instance_object := object_handler.deep_object_from_id (an_object.instance_referers.item_for_iteration)
				create all_instance_children.make (20)
				instance_object.all_children_recursive (all_instance_children)
				all_instance_children.extend (instance_object)
				check
					all_children.count = all_instance_children.count
				end
				from
					all_children.start
					all_instance_children.start
				until
					all_children.off
				loop
					check
						types_correct: all_children.item.type.is_equal (all_instance_children.item.type)
					end
					all_instance_children.forth
					all_children.forth
				end
				an_object.instance_referers.forth
			end
		end

end -- class GB_NESTING_CHECKER
