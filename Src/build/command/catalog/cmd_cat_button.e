
class CMD_CAT_BUTTON 

inherit

	ICON_HOLE

creation

	make
	
feature 

	page: COMMAND_PAGE;

	make (p: like page; a_parent: COMPOSITE) is
			-- Create a button.
		require
			valid_p: p /= Void
		do
			page := p;
		end;

feature {NONE}

	process_stone is
		require else
			not_void_page: page /= Void;
		local
			p2: like page;
			com_is: CAT_COM_IS;
			new_command: CMD_CAT_ED_H;
			cmd: USER_CMD;
			temp_cmd: CMD
		do
			com_is ?= stone;
			new_command ?= stone;
			if
				(com_is /= Void)
			then
				if
					page /= com_is.page
				then
					p2 := com_is.page;
					p2.start;
					p2.search (com_is.original_stone);
					temp_cmd := com_is.original_stone;
					if
						not p2.after
					then
						p2.remove;
						page.extend (temp_cmd);
						if page.is_visible and then page.realized then
							page.hide;
						end
					end
				end
			elseif
				not (new_command = Void)
			then
				!!cmd.make;
				cmd.set_internal_name ("");
				cmd.set_eiffel_text (cmd.template);
				command_catalog.add_to_page (cmd, page);
				if command_catalog.current_page /= page then
					if page.is_visible and then page.realized then
						page.hide
					end
				end
			end
		end;

end

