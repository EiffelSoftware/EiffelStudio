indexing
	description	: "Command to change visibility of client/supplier layer."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_TOGGLE_SUPPLIER_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_toolbar_item
		end

create
	make

feature -- Basic operations

	execute is
			-- Perform operation.
		local
			world: CONTEXT_DIAGRAM
		do
			if tool.class_view /= Void then
				world := tool.class_view
			elseif tool.cluster_view /= Void then
				world := tool.cluster_view
			end
			if world /= Void then
				if world.client_supplier_layer.is_show_requested then
					world.client_supplier_layer.hide
					world.client_supplier_layer.disable_sensitive
					world.client_supplier_mover_layer.hide
					world.client_supplier_mover_layer.disable_sensitive
					world.label_mover_layer.hide
					world.label_mover_layer.disable_sensitive
					world.disable_client_links_displayed
				else
					world.client_supplier_layer.show
					world.client_supplier_layer.enable_sensitive
					world.client_supplier_mover_layer.show
					world.client_supplier_mover_layer.enable_sensitive
					world.label_mover_layer.show
					world.label_mover_layer.enable_sensitive
					world.enable_client_links_displayed
				end
				current_button.set_tooltip (tooltip)
				tool.projector.project
			end
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOGGLE_TOOL_BAR_BUTTON is
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
			Result.toggle
			tt := clone (tooltip)
			if accelerator /= Void then
				tt.append (Opening_parenthesis)
				tt.append (accelerator.out)
				tt.append (Closing_parenthesis)
			end
			Result.set_tooltip (tt)
			Result.select_actions.extend (~execute)
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_supplier
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			if current_button.is_selected then
				Result := "Hide supplier links"
			else
				Result := "Show supplier links"
			end
		end

	description: STRING is
			-- Description for this command.
		do
			Result := "Toggle visibility of supplier links"
		end

	name: STRING is "Supplier_visibility"
			-- Name of the command. Used to store the command in the
			-- preferences.

feature {EB_CONTEXT_EDITOR} -- Implementation

	current_button: EB_COMMAND_TOGGLE_TOOL_BAR_BUTTON
			-- Current toggle button.

end -- class EB_TOGGLE_SUPPLIER_COMMAND
