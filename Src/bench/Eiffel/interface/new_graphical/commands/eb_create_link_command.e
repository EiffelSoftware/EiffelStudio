indexing
	description: "Command to select which kind of new link will be created."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CREATE_LINK_COMMAND
	
inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_toolbar_item,
			make,
			description
		end

create
	make
	
feature {NONE} -- Initialization

	make (a_target: like tool) is
			-- Initialize `Current'.
			-- Client-supplier links are selected by default. 
		do
			Precursor (a_target)
			selected_type := Inheritance
		end
		

feature -- Basic operations

	execute is
			-- Perform operation.
		do
			if selected_type = inheritance then
				tool.on_new_inherit_click
			elseif selected_type = Supplier then
				tool.on_new_client_click
			else
				tool.on_new_agg_client_click
			end
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			--
			-- Call `recycle' on the result when you don't need it anymore otherwise
			-- it will never be garbage collected.
		local
			tt: STRING
		do
				-- Add it to the managed toolbar items
			if managed_toolbar_items = Void then
				create managed_toolbar_items.make (1)
			end
			create Result.make (Current)
			if display_text and pixmap.count >= 2 then
				Result.set_pixmap (pixmap @ 2)
			else
				Result.set_pixmap (pixmap @ 1)
			end
			if is_sensitive then
				Result.enable_sensitive
			else
				Result.disable_sensitive
			end
			current_button := Result
			tt := clone (tooltip)
			if accelerator /= Void then
				tt.append (Opening_parenthesis)
				tt.append (accelerator.out)
				tt.append (Closing_parenthesis)
			end
			Result.set_tooltip (tt)
			Result.select_actions.extend (agent show_text_menu)
		end

feature -- Status report

	selected_type: INTEGER
			-- Currently selected type of new links
			
	inheritance, supplier, aggregate: INTEGER is unique
			-- Possible values for `selected_type'.

feature -- Status setting

	select_type (a_type: INTEGER) is
			-- Set current type of link to `Supplier', `Inheritance' or`Aggregate'.
		require
			valid_type: a_type = Inheritance or else a_type = Supplier or else a_type = Aggregate
		local
			tbb: EB_COMMAND_TOOL_BAR_BUTTON
			tt: STRING
		do
			selected_type := a_type
			execute
			
			tt := clone (tooltip)
			if accelerator /= Void then
				tt.append (Opening_parenthesis)
				tt.append (accelerator.out)
				tt.append (Closing_parenthesis)
			end
			from
				managed_toolbar_items.start
			until
				managed_toolbar_items.after
			loop
				tbb := managed_toolbar_items.item
				tbb.set_pixmap (pixmap @ 1)
				tbb.set_tooltip (tt)
				if is_sensitive then
					tbb.enable_sensitive
				else
					tbb.disable_sensitive
				end
				managed_toolbar_items.forth
			end
		end
feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			if selected_type = inheritance then
				Result := Pixmaps.Icon_new_inherit
			elseif selected_type = Supplier then
				Result := Pixmaps.Icon_new_supplier
			else
				Result := Pixmaps.Icon_new_aggregate_supplier
			end
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			if selected_type = inheritance then
				Result := Interface_names.f_diagram_create_inheritance_links
			elseif selected_type = Supplier then
				Result := Interface_names.f_diagram_create_supplier_links
			else
				Result := Interface_names.f_diagram_create_aggregate_supplier_links
			end
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.l_diagram_create_links
		end

	name: STRING is "New_links"
			-- Name of the command. Used to store the command in the
			-- preferences.

	show_text_menu is
			-- Show menu to enable selection of link type.
		local
			menu: EV_MENU
			menu_item: EV_CHECK_MENU_ITEM
		do
			create menu
			create menu_item
			menu_item.set_text (Interface_names.f_diagram_create_inheritance_links)
			if selected_type = Inheritance then
				menu_item.enable_select
			end
			menu_item.select_actions.extend (agent select_type (Inheritance))
			menu.extend (menu_item)
			create menu_item
			menu_item.set_text (Interface_names.f_diagram_create_supplier_links)
			menu.extend (menu_item)
			if selected_type = Supplier then
				menu_item.enable_select
			end
			menu_item.select_actions.extend (agent select_type (Supplier))
			create menu_item
			menu_item.set_text (Interface_names.f_diagram_create_aggregate_supplier_links)
			if selected_type = Aggregate then
				menu_item.enable_select
			end
			menu_item.select_actions.extend (agent select_type (Aggregate))
			menu.extend (menu_item)
			menu.show
		end

feature {EB_CONTEXT_EDITOR} -- Implementation

	current_button: EB_COMMAND_TOOL_BAR_BUTTON
			-- Current toggle button.

end -- class EB_CREATE_LINK_COMMAND
