indexing
	description: "Command catalog."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_CATALOG

inherit

	CATALOG [CMD]
		export
			{ANY} all
		redefine
			current_page, make
		end

	WINDOWS
		select
			init_toolkit
		end

	CLOSEABLE

creation

	make

feature -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Creation routine
		do
			{CATALOG} Precursor (a_name, a_parent)
		end


	create_interface is
			-- Create command catalog interface.
		do
			!! page_sw.make (Widget_names.scroll, Current)
			!! button_rc.make (Widget_names.row_column, Current)
			!! separator.make ("", Current)
			!! pages.make
			!! command_catalog_label.make (Widget_names.command_catalog, Current)
			set_values
			attach_all
			define_command_pages
			update_interface
		end

	set_values is
			-- Set values for the GUI elements.
		do
			button_rc.set_preferred_count (1)
			button_rc.set_row_layout
			separator.set_horizontal (True)
		end

	attach_all is
			-- Perform attachments
		do
			attach_top (command_catalog_label, 3)
			attach_top (button_rc, 0)
			attach_left (command_catalog_label, 0)
			attach_left_widget (command_catalog_label, button_rc, 10)
			attach_right (button_rc, 0)
			attach_top_widget (command_catalog_label, separator, 0)
			attach_top_widget (button_rc, separator, 0)
			attach_left (separator, 0)
			attach_right (separator, 0)
			attach_top_widget (separator, page_sw, 0)
			attach_left (page_sw, 0)
			attach_right (page_sw, 0)
			attach_bottom (page_sw, 0)
		end

feature {NONE}

	define_command_pages is
			-- Define pages for the catalog.
		local
			file_commands: FILE_CMDS
			window_commands: WINDOW_CMDS
			command_templates: TEMPL_CMDS
		do
			!! user_defined_commands1.make (1, Current)
			!! user_defined_commands2.make (2, Current)
			!! generated_commands.make (3, Current)
			!! command_templates.make (Current)
			!! window_commands.make (Current)
			!! file_commands.make (Current)
			add_page (user_defined_commands1)
			add_page (user_defined_commands2)
			add_page (generated_commands)
			add_page (file_commands)
			add_page (window_commands)
			add_page (command_templates)
			set_initial_page (user_defined_commands1)
		end

feature {CMD_CAT_BUTTON} -- Attributes

	current_page: COMMAND_PAGE
			-- Current page in the command catalog

feature {NONE} -- Attributes

	separator: THREE_D_SEPARATOR
			-- Separator between the column row and the list of commands

	command_catalog_label: LABEL
			-- Label displaying "Command catalog"

feature {CMD_ADD_ARGUMENT, CMD_CUT_ARGUMENT, 
			GENERATE_OBJECT_TOOL_CMD, GENERATE_OBJECT_COMMAND_CMD}

	user_defined_commands1: USER_DEF_CMDS
	user_defined_commands2: USER_DEF_CMDS
	generated_commands: GENERATED_CMDS

feature -- Implementation

	close is
		do
			hide
			main_panel.command_catalog_entry.set_toggle_off	
		end

	clear is
			-- Clear commands from all pages
		local
			uc: USER_CMD
		do
			from 
				pages.start
			until
				pages.after
			loop
				pages.item.wipe_out
				pages.forth
			end
			!!uc.make
			uc.reset_name
		end

	command_with_class_name (cn: STRING): USER_CMD is
			-- Find user command with class name `cn'
		require
			valid_cn_name: cn /= Void
		local
			user_cmds: LINKED_LIST [LINKED_LIST [USER_CMD]]
			cmd_list: LINKED_LIST [USER_CMD]
			class_name: STRING
		do
			class_name := clone (cn)
			class_name.to_upper
			user_cmds := user_commands
			from
				user_cmds.start
			until
				user_cmds.after or else Result /= Void
			loop
				cmd_list := user_cmds.item
				from
					cmd_list.start
				until
					cmd_list.after or else Result /= Void
				loop
					if class_name.is_equal (cmd_list.item.eiffel_type_to_upper) then
						Result := cmd_list.item
					end
					cmd_list.forth
				end
				user_cmds.forth
			end
		end

	user_commands: LINKED_LIST [LINKED_LIST [USER_CMD]] is
		local
			nl: LINKED_LIST [USER_CMD]
			p: like current_page
			uc: USER_CMD
		do
			from
				pages.start
				!!Result.make
			until
				pages.after
			loop
				!!nl.make
				Result.extend (nl)
				from
					p := pages.item
					p.start
				until
					p.after
				loop
					uc ?= p.item
					if not (uc = Void) then
						if uc.edited then
							uc.save_text
						end
						nl.extend (uc)
					end
					p.forth
				end	
				pages.forth
			end
		end

	merge (l: LINKED_LIST [LINKED_LIST [USER_CMD]]) is
		local
			cl: LINKED_LIST [USER_CMD]
			p: like current_page
		do
			from
				l.start
				pages.start
			until
				l.after
			loop
				cl := l.item
				from cl.start
				until cl.after
				loop
					p := pages.item
					p.extend (cl.item)
					cl.forth
				end
				l.forth
				pages.forth
			end	
		end

feature {NONE}

	page_used: COMMAND_PAGE is
			-- Synonym for `current_page'.
		do
			Result := current_page
		end

feature -- Access

	add (c: USER_CMD) is
			-- Add command `c' to current page.
		local
			add_command: CAT_ADD_COMMAND
		do
			add_to_page (c, current_page)
		end

	add_to_page (c: USER_CMD p: like current_page) is
			-- Add command `c' to page `p'.
		local
			add_command: CAT_ADD_COMMAND
		do
			p.extend (c)
			!!add_command
			add_command.execute (p)
		end

feature 

-- 	hide is
-- 			-- Hide command catalog 
-- 		do 
-- 			{FORM} Precursor
-- 		end
-- 
-- 	show is 
-- 			-- Show command catalog
-- 		do 
-- 			{FORM} Precursor
-- 		end
-- 
-- 	shown: BOOLEAN is 
-- 			-- Is command catalog shown?
-- 		do 
-- 			{FORM} Precursor
-- 		end
-- 
feature 

    initialize_pages is
			-- Initialize pages.
        do
            from
                pages.start
            until
                pages.after
            loop
                if pages.item.empty then
                    pages.item.reset_commands
                end
                pages.forth
            end
        end

	update_icon_stone (c: CMD) is
			-- Update icon stone.
		local		
			p: like current_page
			finished: BOOLEAN
		do
			from 
				pages.start
			until
				pages.after or finished
			loop
				p := pages.item
				p.start
				p.search (c)
				if not p.after then	
					p.redisplay_current
					finished := True
				else
					pages.forth
				end
			end
		end

end -- class COMMAND_CATALOG
