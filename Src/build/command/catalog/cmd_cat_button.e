indexing
	description: "A button representing a command category %
				% in the command catalog."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"
				
class 
	CMD_CAT_BUTTON 

inherit

	HOLE
		redefine
			process_any	
		select
			init_toolkit
		end
		
	CAT_BUTTON
		redefine
			catalog_page,
			set_default
		end

creation

	make
	
feature {NONE}

	catalog_page: COMMAND_PAGE

feature {NONE}

	target: WIDGET is
		do
			Result := Current
		end

	stone_type: INTEGER is
		do
		 	Result := Stone_types.any_type
		end

	process_any (dropped: STONE) is
		local
			p2: like catalog_page
			com_is: CAT_COM_IS
			new_command: CMD_CAT_ED_H
			cmd: USER_CMD
			temp_cmd: CMD
		do
			com_is ?= dropped
			new_command ?= dropped
			if com_is /= Void then
				if catalog_page /= com_is.page then
					p2 := com_is.page
					p2.start
					p2.search (com_is.data)
					temp_cmd := com_is.data
					if
						not p2.after
					then
						p2.remove
						catalog_page.extend (temp_cmd)
						if catalog_page.is_visible and then 
							catalog_page.realized 
						then
							catalog_page.hide
						end
					end
				end
			elseif new_command /= Void then
				!!cmd.make
				cmd.set_internal_name ("")
				--cmd.retrieve_text_from_disk
				cmd.set_eiffel_text (cmd.template)
				cmd.overwrite_text
				command_catalog.add_to_page (cmd, catalog_page)
				if command_catalog.current_page /= catalog_page then
					if catalog_page.is_visible and then 
						catalog_page.realized 
					then
						catalog_page.hide
					end
				end
			end
		end

	set_default is
		do
			register
		end

end
