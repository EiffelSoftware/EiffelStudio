indexing

	description:
		"EiffelBench preference tool."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PREFERENCE_TOOL

inherit
	EB_TOOL

creation

	make

feature {NONE} -- Initialization

	make  (man: EB_TOOL_CONTAINER; par: EV_WINDOW) is

			-- Create Current with manager `par', then
			-- show Current on the screen.
		local
			tree: EV_TREE
			leaves: ARRAY [EV_TREE_ITEM]
			item: EV_TREE_ITEM
			f: EV_TREE_ITEM_HOLDER
			ijk : INTEGER

			b: EV_BUTTON
		do


				-- panels loading
			Create {EB_PANEL_LIST_IMP} panel_list.make (Current)
			
			last_selected := Void

				-- Linking with parent
			parent := par
			manager := man
			set_title ("Preferences Tool")

				-- container creation
			Create container.make (par)
			container.set_minimum_size (500,340)
--			container.forbid_resize
			container.set_border_width (4)	
			container.set_spacing (4)	


				-- toolbar construction
			Create toolbar.make (container)
			from
				panel_list.start
			until
				panel_list.after
			loop
--				Create b.make_with_pixmap (toolbar, panel_list.item.symbol)
				Create b.make (toolbar)
				panel_list.item.raise_cmd.set_button (b)
				panel_list.forth
			end

				-- tree+panel container construction
			Create panels_box.make (container)
			panels_box.set_spacing (4)	

				-- tree construction

			Create tree.make (panels_box)
			tree.set_minimum_size (100, 300)
			Create leaves.make (1, panel_list.number_of_tree_items)
			from
				ijk := 1
				panel_list.start
			until
				(panel_list.after)
			loop
				if (panel_list.tree_parent.item (ijk)) = 0 then
					f := tree
				else
					f := leaves.item (panel_list.tree_parent.item (ijk))
				end
				Create item.make_with_text (f, panel_list.tree_names.item (ijk))
				panel_list.item.raise_cmd.set_leaf (item)
				leaves.put (item, ijk)
				ijk := ijk + 1
				panel_list.forth
			end

				-- panel dispatching

--			if not panel_list.empty then
--				from
--					panel_list.start
--				until
--					panel_list.after
--				loop
--					panel_list.item.set_parent (panels_box)
--					panel_list.item.hide
--					panel_list.forth
--				end
--			end

			display_panel (panel_list.first)

				-- buttons addition
			Create button_bar.make (container)
			button_bar.set_expand (False)

			Create ok_button.make_with_text (button_bar, "OK")
			ok_button.set_minimum_width (100)
			ok_button.set_horizontal_resize (False)
			ok_button.set_vertical_resize (False)
			Create apply_button.make_with_text (button_bar, "Apply")
			apply_button.set_minimum_width (100)
			apply_button.set_horizontal_resize (False)
			apply_button.set_vertical_resize (False)
			Create exit_button.make_with_text (button_bar, "Exit")
			exit_button.set_minimum_width (100)
			exit_button.set_horizontal_resize (False)
			exit_button.set_vertical_resize (False)

				-- commands creation and linking with buttons
			init_commands

			ok_button.add_click_command (ok_cmd, void)
			apply_button.add_click_command (apply_cmd, void)
			exit_button.add_click_command (exit_cmd, void)

		ensure then
			created: not destroyed
		end

	init_commands is
			-- Initialize basic commands
		do
			Create ok_cmd.make (Current)
			Create apply_cmd.make (Current)
			Create exit_cmd.make (Current)
			Create save_cmd.make (Current)
			Create validate_cmd.make (Current)
		end

feature {EB_RAISE_ENTRY_PANEL_COMMAND}

	display_panel (a_panel: EB_ENTRY_PANEL) is
			-- Select `a_panel' and display it.
		require
			has_panel: panel_list.has (a_panel)
		local
			valid: BOOLEAN
		do
			if last_selected /= a_panel then
				valid := True
					--| Assume valid is true:
					--| a) if `last_selected' is void => valid is true => page switch
					--| b) if `last_selected' is not Void => valid then reflects `last_selected.is_valid'

				if last_selected /= Void then
					last_selected.validate
					valid := last_selected.is_all_valid
				end
				if valid then
					if last_selected /= Void then
						last_selected.undisplay
					end
					a_panel.display
					last_selected := a_panel
				end
			end
		end

			
feature -- Adding categories

	add_preference_panel (a_panel: EB_ENTRY_PANEL) is
			-- Add `a_panel' to the list of all panels.
		require
			a_panel_not_void: a_panel /= Void
			not_created: a_panel.destroyed
		do
			panel_list.extend (a_panel)
		ensure
			panel_in_list: panel_list.has (a_panel)
		end

feature -- Access

	panel_list: EB_PANEL_LIST
			-- List of all preference panels, with the data used
			-- to build the associated tree

	container: EV_VERTICAL_BOX
			-- Interface widget

	validate_all is
			-- Validate all panels,
			-- and thus all resources.
		local
			pl: like panel_list
		do
			from
				is_all_valid := True
				pl := panel_list
				pl.start
			until
				pl.after or not is_all_valid
			loop
				pl.item.validate
				is_all_valid := is_all_valid and then pl.item.is_all_valid
				pl.forth
			end
		end

	is_all_valid: BOOLEAN
			-- Are all panels valid?

	apply_changes is
			-- Apply all changes.
		local
			pl: like panel_list
		do
			pl := panel_list
			if not pl.empty then
				from
					pl.start
				until
					pl.after
				loop
					pl.item.update
					pl.forth
				end
			end
		end

feature {EB_ENTRY_PANEL} -- Implementation

	panels_box: EV_HORIZONTAL_BOX
		-- Form where the panel is displayed on

feature {NONE} -- Implementation

	last_selected: EB_ENTRY_PANEL
			-- panel that is currently displayed

	toolbar: EV_HORIZONTAL_BOX
			-- tool bar

	button_bar: EV_HORIZONTAL_BOX
			-- Form for the `Save', `Apply', and `exit' buttons

	ok_button,
			-- Button for Ok action

	apply_button,
			-- Button fo Apply action

	exit_button: EV_BUTTON
			-- Button for exit action


feature {EB_PREFERENCE_COMMAND, EB_PREFERENCE_WINDOW} -- Commands

	ok_cmd: EB_OK_PREFERENCE_COMMAND
			-- Holder for the Ok command (which applies and Save the resources)

	apply_cmd: EB_APPLY_PREFERENCE_COMMAND
			-- Holder for the Apply command

	exit_cmd: EB_CANCEL_PREFERENCE_COMMAND
			-- Holder for the Exit/Cancel command

	save_cmd: EB_SAVE_PREFERENCE_COMMAND
			-- Holder for the Save command

	validate_cmd: EB_VALIDATE_PREFERENCE_COMMAND
			-- Holder for the Validate command

end -- class EB_PREFERENCE_TOOL
