indexing
	description: "Command catalog."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_CATALOG

inherit
	CATALOG
		export
			{ANY} all
		redefine
			current_page,
			set_values,
			show, hide
		end

	WINDOWS

--	CLOSEABLE

creation

	make

feature -- Initialization

-- 	make (par: EV_CONTAINER) is
-- 			-- Creation routine
-- 		local
-- 			vbox: EV_VERTICAL_BOX
-- 			hbox: EV_HORIZONTAL_BOX
-- 			cmd_b: CMD_ED_HOLE
-- 			command_label: EV_LABEL
-- 		do
-- 			create vbox.make (par)
-- 			create hbox.make (vbox)
-- 			hbox.set_expand (False)
-- 			create cmd_b.make (hbox)
-- 			create command_label.make_with_text (hbox, "Command")
--
-- 			{CATALOG} Precursor (vbox)
-- 			set_values
-- 		end

	set_values is
			-- Set values for the GUI elements.
		do
		end

feature {NONE}

	define_pages is
			-- Define pages for the catalog.
		local
			window_commands: WINDOW_CMDS
			reset_commands: RESET_CMDS
			file_commands: FILE_CMDS
			command_templates: TEMPL_CMDS
		do
			create window_commands.make (Current)
			create reset_commands.make (Current)
			create file_commands.make (Current)
			create command_templates.make (Current)
			create generated_commands.make (Current)

--			set_initial_page (window_commands)
--XX Use pixmaps instead of labels for the tabs.
			append_page (window_commands, "windows")
			append_page (reset_commands, "reset")
			append_page (file_commands, "file")
			append_page (command_templates, "templates")
			append_page (generated_commands, "generated")
		end

feature {CMD_ADD_ARGUMENT, CMD_CUT_ARGUMENT, CMD_CAT_BUTTON} -- Attributes

	current_page: COMMAND_PAGE is
			-- Current page in the command catalog
		do
--			Result ?= pages.item (current_page_number)
		end

feature {GENERATE_OBJECT_TOOL_CMD, GENERATE_OBJECT_COMMAND_CMD}

	generated_commands: GENERATED_CMDS

feature -- Status setting

	show is
		do
			main_window.vertical_split_area.set_parent (main_window.horizontal_split_area)
		end

	hide is
		do
--			if main_window.horizontal_split_area.shown then
--				parent.first.set_parent (main_window.horizontal_split_area)
--			else
--				parent.first.set_parent (main_window.vertical_box)
--			end
			main_window.vertical_split_area.set_parent (Void)
		end

feature -- Implementation

	close is
		do
			hide
--			main_panel.command_catalog_entry.set_toggle_off	
		end

-- 	clear is
-- 			-- Clear commands from all pages
-- 		local
-- 			uc: USER_CMD
-- 		do
-- 			from 
-- 				pages.start
-- 			until
-- 				pages.after
-- 			loop
-- 				pages.item.clear_items
-- 				pages.forth
-- 			end
-- 			create uc.make
-- 			uc.reset_name
-- 		end

-- 	command_with_class_name (cn: STRING): USER_CMD is
-- 			-- Find user command with class name `cn'
-- 		require
-- 			valid_cn_name: cn /= Void
-- 		local
-- 			user_cmds: LINKED_LIST [LINKED_LIST [USER_CMD]]
-- 			cmd_list: LINKED_LIST [USER_CMD]
-- 			class_name: STRING
-- 		do
-- 			class_name := clone (cn)
-- 			class_name.to_upper
-- 			user_cmds := user_commands
-- 			from
-- 				user_cmds.start
-- 			until
-- 				user_cmds.after or else Result /= Void
-- 			loop
-- 				cmd_list := user_cmds.item
-- 				from
-- 					cmd_list.start
-- 				until
-- 					cmd_list.after or else Result /= Void
-- 				loop
-- 					if class_name.is_equal (cmd_list.item.eiffel_type_to_upper) then
-- 						Result := cmd_list.item
-- 					end
-- 					cmd_list.forth
-- 				end
-- 				user_cmds.forth
-- 			end
-- 		end

-- 	user_commands: LINKED_LIST [LINKED_LIST [USER_CMD]] is
-- 		local
-- 			user_cmd_list: LINKED_LIST [USER_CMD]
-- 			p: like current_page
-- 			uc: USER_CMD
-- 		do
-- 			from
-- 				pages.start
-- 				create Result.make
-- 			until
-- 				pages.after
-- 			loop
-- 				create user_cmd_list.make
-- 				Result.extend (user_cmd_list)
-- 				from
-- 					p := pages.item
-- 					p.start
-- 				until
-- 					p.after
-- 				loop
-- 					uc ?= p.item
-- 					if uc /= Void then
-- 						if uc.edited then
-- 							uc.save_text
-- 						end
-- 						user_cmd_list.extend (uc)
-- 					end
-- 					p.forth
-- 				end	
-- 				pages.forth
-- 			end
-- 		end

-- 	merge (l: LINKED_LIST [LINKED_LIST [USER_CMD]]) is
-- 		local
-- 			cl: LINKED_LIST [USER_CMD]
-- 			p: like current_page
-- 		do
-- 			from
-- 				l.start
-- 				pages.start
-- 			until
-- 				l.after
-- 			loop
-- 				cl := l.item
-- 				from
-- 					cl.start
-- 				until
-- 					cl.after
-- 				loop
-- 					p := pages.item
-- 					p.extend (cl.item)
-- 					cl.forth
-- 				end
-- 				l.forth
-- 				pages.forth
-- 			end	
-- 		end

feature {NONE}

	page_used: COMMAND_PAGE is
			-- Synonym for `current_page'.
		do
			Result := current_page
		end

feature -- Access

-- 	add (c: USER_CMD) is
-- 			-- Add command `c' to current page.
-- 		local
-- 			add_command: CAT_ADD_COMMAND
-- 		do
-- 			add_to_page (c, current_page)
-- 		end

-- 	add_to_page (c: USER_CMD p: like current_page) is
-- 			-- Add command `c' to page `p'.
-- 		local
-- 			add_command: CAT_ADD_COMMAND
-- 		do
-- 			p.extend (c)
-- 			create add_command
-- 			add_command.execute (p)
-- 		end

feature 

-- 	initialize_pages is
-- 			-- Initialize pages.
-- 		do
-- 			from
-- 				pages.start
-- 			until
-- 				pages.after
-- 			loop
-- 				if pages.item.empty then
-- 					pages.item.reset_commands
-- 				end
-- 				pages.forth
-- 			end
-- 		end

-- 	update_icon_stone (c: CMD) is
-- 			-- Update icon stone.
-- 		local		
-- 			p: like current_page
-- 			finished: BOOLEAN
-- 		do
-- 			from	
-- 				pages.start
-- 			until
-- 				pages.after or finished
-- 			loop
-- 				p := pages.item
-- 				p.start
-- 				p.search (c)
-- 				if not p.after then	
-- 					p.redisplay_current
-- 					finished := True
-- 				else
-- 					pages.forth
-- 				end
-- 			end
-- 		end

end -- class COMMAND_CATALOG

