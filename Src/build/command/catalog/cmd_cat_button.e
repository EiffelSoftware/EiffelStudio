
class CMD_CAT_BUTTON 

inherit

	ICON_HOLE
		rename
			make_visible as make_icon_visible
		end;

	ICON_HOLE
		redefine
			make_visible
		select
			make_visible
		end;

	FOCUSABLE
		export
			{NONE} all
		end


creation

	make
	
feature 

	page: COMMAND_PAGE;

	make (f: STRING; p: like page) is
			-- Create a button with `f' as the focus_label.
		do
			focus_string := f;	
			page := p
		end;

	
feature {NONE}

	focus_label: LABEL is
		do
			Result := command_catalog.focus_label
		end;

	focus_source: WIDGET is
		do
			Result := button;
		end;

	focus_string: STRING;

	
feature 

	make_visible (a_parent: COMPOSITE) is
		do
			make_icon_visible (a_parent);
			initialize_focus
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
				not (com_is = Void)
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
						page.hide;
					end
				end
			elseif
				not (new_command = Void)
			then
				!!cmd.make;
				cmd.set_internal_name ("");
				cmd.set_eiffel_text (cmd.template);
				command_catalog.add_to_page (cmd, page);
			end
		end;

end

