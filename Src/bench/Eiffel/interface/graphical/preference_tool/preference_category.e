indexing

	description:
		"Abstract notion of category of resources used for a UI.";
	date: "$Date$";
	revision: "$Revision$"

deferred class PREFERENCE_CATEGORY

inherit
	ROW_COLUMN
		rename
			make as make_row_column
		end;
	PREFERENCE_COMMAND
		rename
			make as init_tool
		end

feature {NONE} -- Initialization

	make (a_tool: like tool) is
			-- Initialize Current.
		do
			tool := a_tool;
			!! resources.make;
			update_resources 
		end

	update_resources is
			-- Update `resources'.
		require
			valid_resources: resources /= Void
		deferred
		end;

feature -- Access

	resources: LINKED_LIST [PREFERENCE_RESOURCE]
			-- All resources for the user interface

feature {PREFERENCE_TOOL} -- Initialization

	init_visual_aspects (a_menu: MENU_PULL; a_button_parent, a_parent: COMPOSITE) is
			-- Initialize Current and `a_parent' as `parent'.
		require
			a_menu_is_valid: a_menu /= Void and then not a_menu.destroyed;
			a_button_parent_is_valid: a_button_parent /= Void and then
				not a_button_parent.destroyed
		deferred
		end;

feature -- Properties

	associated_category: RESOURCE_CATEGORY is
			-- Category Current is about
		deferred
		end;

	name: STRING is
			-- Name of the category
		deferred
		end;
	
	symbol: PIXMAP is
			-- Pixmap representing the category
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
			file.putstring ("-- **** ");
			file.putstring (name);
			file.putstring (" **** ");
			file.new_line
			from
				res := resources;
				res.start
			until
				res.after
			loop
				res.item.save (file);
				res.forth
			end;
			file.new_line
		end;

	update is
			-- Update the resource users from
			-- `associated_category'.
		local
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

feature -- Output

	reset_content is
			-- Reset content;
			--| This feature is used to reset `resources'.
		local
			res: PREFERENCE_RESOURCE
		do
			if been_displayed then
				from
					resources.start
				until
					resources.after
				loop
					res := resources.item;
					res.reset;
					resources.forth
				end;
			end
		end;

	display is
			-- Display Current
			--| This feature is used to initialize `resources'.
		local
			res: PREFERENCE_RESOURCE
		do
			holder.set_selected (True);
			if not been_displayed then
				from
					resources.start
				until
					resources.after
				loop
					res := resources.item;
					res.init (Current);
					res.reset;
					resources.forth
				end;
				init_colors;
				been_displayed := True
			end
			manage
		end;

	undisplay is
			-- Undisplay Current
			--| This only updates the pixmap on the button
		do
			holder.set_selected (False);
			unmanage
		end

feature {NONE} -- Properties

	holder: CATEGORY_HOLDER;
			-- Holder for the visual aspects

	been_displayed: BOOLEAN
			-- Has Current already been displayed?

	init_colors is
			-- Initialize the colors.
		do
		end;

feature {PREFERENCE_COMMAND} -- Execution

	execute (argument: ANY) is
			-- Execute Current
		do
			tool.execute (Current)
		end

end -- class PREFERENCE_CATEGORY
