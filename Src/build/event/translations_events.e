
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
			make_button_visible as page_make_button_visible
		-- added by samik
        undefine
            init_toolkit
		-- end of samik     
		end;
	EVENT_PAGE
		-- added by samik
        undefine
            init_toolkit
        -- end of samik     
		redefine
			make_button_visible
		select
			make_button_visible
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
			--parent.parent.unmanage;
			check_number_of_icons;
			if not empty then
				go_i_th (1);
				from
				until
					after
				loop
					icon := icons.item;
					if icon.data /= item then
						icon.set_data (item)
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
			--parent.parent.manage;
		end;

	
feature {CATALOG}

	make_button_visible (button_rc: ROW_COLUMN) is
		do
			page_make_button_visible (button_rc);
			button.add_activate_action (Current, Second);
			button.add_button_press_action (3, Current, Third);
            button.set_focus_string (Focus_labels.translation_label)
		end;

	
feature {NONE}

	symbol: PIXMAP is
		do
			Result := Pixmaps.translation_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_translation_pixmap
		end;

	set_focus_string is
		do
			button.set_focus_string (Focus_labels.translation_label)
		end;

	translation_editor: TRANSL_EDITOR is
		once
			!! Result.make;
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
