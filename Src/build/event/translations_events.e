
class TRANSLATIONS_EVENTS 

inherit

	COMMAND;	
	COMMAND_ARGS
		rename
			First as unused
		end;
	WINDOWS;
	SHARED_TRANSLATIONS;
	EVENT_PAGE 
		rename
			add_button_callback as page_add_button_callback
		undefine
			init_toolkit		
		end;
	EVENT_PAGE
		undefine
			init_toolkit
		redefine
			add_button_callback
		select
			add_button_callback
		end;	

creation

	make
	
feature 

	update_content is
		local
			icon: CAT_EV_IS
		do
			list_wipe_out;
			from
				Shared_translation_list.start;
				start;
			until
				Shared_translation_list.after
			loop
				list_extend (Shared_translation_list.item);
				Shared_translation_list.forth;
			end;
			parent.unmanage;
			check_number_of_icons;
			if not empty then
				go_i_th (1);
				from
				until
					after
				loop
					icon := icons.item;
					if icon.original_stone /= item then
						icon.set_original_stone (item)
					else
						icon.update_name
					end;
					if not icon.managed then
						icon.set_managed (True);
					end;
					icons.forth;
					forth
				end;
			else
				icons.go_i_th (1)
			end;
			if not icons.after then
				from
				until
					icons.after
				loop
					icon := icons.item;
					icon.set_managed (False);
					icons.forth
				end;
			end;
			parent.manage;
		end;

	
feature {CATALOG}

	add_button_callback is
		do
			page_add_button_callback;
			button.add_button_press_action (2, Current, Third);
			button.add_activate_action (Current, Second);
			if translation_editor = Void then end;
		end;

	
feature {NONE}

	translation_editor: TRANSL_EDITOR is
		once
			!!Result.make ("Translation Editor", main_panel.base);
		end;

	execute (argument: ANY) is
		do
			if (argument = Second) then
				update_content;
			elseif (argument = Third) then
				translation_editor.popup
			end
		end;

end 
