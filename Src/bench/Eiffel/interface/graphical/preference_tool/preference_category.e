indexing

	description:
		"Abstract notion of category of resources used for a UI.";
	date: "$Date$";
	revision: "$Revision$"

deferred class PREFERENCE_CATEGORY

inherit
	ROW_COLUMN;
	PREFERENCE_COMMAND
		rename
			make as init_tool
		end

feature -- Access

	resources: LINKED_LIST [PREFERENCE_RESOURCE] is
			-- All resources for the user interface
		deferred
		end;

feature {PREFERENCE_TOOL} -- Initialization

	init_visual_aspects (a_menu: MENU_PULL; a_button_parent, a_parent: COMPOSITE) is
			-- Initialize Current and `a_parent' as `parent'.
		require
			a_menu_is_valid: a_menu /= Void and then not a_menu.destroyed;
			a_button_parent_is_valid: a_button_parent /= Void and then
				not a_button_parent.destroyed
		deferred
		end;

	add_button_action (a_tool: PREFERENCE_TOOL) is
			-- Add `a_tool' as command for `button'.
		do
			--button.add_activate_action (a_tool, name)
		end

feature -- Properties

	associated_category: RESOURCE_CATEGORY is
			-- Category Current is about
		deferred
		end;

feature -- User Interface

	display is
			-- Display Current
			--| This feature is used to initialize `resources'.
		deferred
		end;

	undisplay is
			-- Undisplay Current
			--| This will update `button'.
		deferred
		end

feature -- Validation

	is_valid: BOOLEAN;
			-- Are all resources in Current valid?

	validate is
			-- Validate all resources in Current
		local
			res: like resources
		do
			from
				res := resources;
				res.start;
				is_valid := True
			until
				res.after or else not is_valid
			loop
				res.item.validate;
				is_valid := is_valid and res.item.is_resource_valid;
				res.forth
			end
		end

feature -- Access

	save_resources (file: PLAIN_TEXT_FILE) is
			-- Save the resources from Current in `file'.
		require
			file_not_void: file /= Void;
			file_is_open_write: file.is_open_write
		local
			res: like resources
		do
			from
				res := resources;
				res.start
			until
				res.after
			loop
				res.item.save (file);
				res.forth
			end
		end;

	update is
			-- Update the resource users from
			-- `associated_category'.
		local
			mod_res: MODIFIED_RESOURCE
			res: like resources
		do
			from
				res := resources;
				res.start
			until
				res.after
			loop
				if res.item.is_changed then
					associated_category.add_modified_resource (res.item.modified_resource)
				end;
				res.forth
			end;
			associated_category.update
		end

feature {NONE} -- Properties

	holder: CATEGORY_HOLDER;
			-- Holder for the visual aspects

feature {PREFERENCE_COMMAND} -- Execution

	execute (argument: ANY) is
			-- Execute Current
		do
			tool.execute (argument)
		end

end -- class PREFERENCE_CATEGORY
