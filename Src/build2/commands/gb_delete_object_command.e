indexing
	description: "Objects that represent a new delete object command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_DELETE_OBJECT_COMMAND
	
inherit
	EB_STANDARD_CMD
		redefine
			make, execute, executable,
			new_toolbar_item
		end

	GB_SHARED_SYSTEM_STATUS

	GB_SHARED_HISTORY
	
	GB_SHARED_TOOLS

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		do
			Precursor {EB_STANDARD_CMD}
			set_tooltip ("Delete")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).icon_delete_small)
			set_name ("Delete")
			set_menu_name ("Delete")
		end
		
feature -- Access

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		do
			Result := system_status.project_open
		end

feature -- Basic operations

		new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
				-- Create a new toolbar item linked to `Current'. This has been redefined as each button
				-- needs to have its drop actions set.
			do
				Result := Precursor {EB_STANDARD_CMD} (display_text, use_gray_icons)
				Result.drop_actions.extend (agent delete_object)
				Result.drop_actions.extend (agent delete_component)
				Result.drop_actions.set_veto_pebble_function (agent veto_the_delete)
			end
	
		execute is
				-- Execute `Current'.
				-- Currently does nothing as you must drop
				-- on the toolbars representation to perform a delete.
			do
			end
			
feature {NONE} -- Implementation

	delete_object (an_object: GB_OBJECT) is
			-- Remove `an_object' from the system.
		require
			object_not_void: an_object /= Void
		local
			command_delete: GB_COMMAND_DELETE_OBJECT
			delete_position: INTEGER
		do
			delete_position := an_object.parent_object.layout_item.index_of (an_object.layout_item, 1)
			create command_delete.make (an_object.parent_object, an_object, delete_position)
			history.cut_off_at_current_position
			command_delete.execute
			--| FIXME we have not really performed the delete, as the object still exists.
			--| Need to clean up.
		end
		
	delete_component (a_component: GB_COMPONENT) is
			-- Remove `a_component' from `Current'.
		require
			component_not_void: a_component /= Void
		do
			component_selector.delete_component (a_component.name)
		end
		
		
	veto_the_delete (an_object: GB_OBJECT): BOOLEAN is
			-- Do not allow the delete if the object was picked
			-- from a type of component. The way that we are checking this,
			-- is by looking at the parent of the object. If it is Void then
			-- we should not be deleting the object.
		do
			Result := an_object.parent_object /= Void
		end

end -- class GB_DELETE_OBJECT
