indexing

	description:
		"Manager for all edit windows.";
	date: "$Date$";
	revision: "$Revision$"

class EDITOR_MGR 

inherit

	GRAPHICS;
	WINDOWS;
	EB_CONSTANTS;
	RESOURCE_USER
		redefine
			update_boolean_resource,
			update_integer_resource
		end

feature -- Initialization

	make (a_screen: SCREEN) is
			-- Create a window manager. All editors will be create 
			-- with `a_screen' as the parent.
		do
			screen := a_screen;
			!!active_editors.make;
			!!free_list.make
		end;

feature -- Resource Update

	update_boolean_resource (old_res, new_res: BOOLEAN_RESOURCE) is
			-- Update all active class tools according to
			-- `new_res'.
		local
			ae: like active_editors
			aei: like editor_type
		do
			ae := active_editors
			from
				ae.start
			until
				ae.after
			loop
				aei := ae.item;
				aei.update_boolean_resource (old_res, new_res);
				ae.forth
			end;
		end;

	update_integer_resource (old_res, new_res: INTEGER_RESOURCE) is
			-- Update all active class tools according to
			-- `new_res'.
		local
			ae: like active_editors
		do
			ae := active_editors;
			from
				ae.start
			until
				ae.after
			loop
				ae.item.update_integer_resource (old_res, new_res);
				ae.forth
			end
		end

feature -- Properties

	active_editors: LINKED_LIST [like editor_type];
			-- Editors currently active 

feature -- Fonts

	set_font_to_default is
			-- Set the font of all active editors to the default font.
		do
			from 
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.set_font_to_default;
				active_editors.forth
			end
		end;

feature -- Tabulations

	set_tab_length_to_default is
			-- Set the tab length of all active editors 
			-- to the default tab length.
		local
			text_window: TEXT_WINDOW;
			tool: TOOL_W
		do
			from 
				active_editors.start
			until
				active_editors.after
			loop
				tool := active_editors.item;
				tool.set_tab_length_to_default;
				tool.update_save_symbol;
				if tool.text_window.is_graphical then	
					tool.synchronize
				end;
				active_editors.forth
			end
		end;

feature -- Synchronization

	synchronize is
			-- Synchronize active editors.
		local
			ed: TOOL_W
		do
			from 
				active_editors.start
			until
				active_editors.after
			loop
				ed := active_editors.item;
				ed.initialize_text_window_resources;
				ed.synchronize;
				active_editors.forth
			end
		end;

	synchronize_to_default is
			-- Synchronize active editors.
			-- Set them back to their default format.
		do
			from 
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.set_default_format;
				active_editors.item.synchronize;
				active_editors.forth
			end
		end;

feature -- Modifications

	changed: BOOLEAN is
			-- Has the text of one of the active editor been edited
			-- since last display?
		do
			from
				active_editors.start
			until
				Result or active_editors.after
			loop
				Result := active_editors.item.text_window.changed
				active_editors.forth
			end;
		end;

feature {NONE} -- Properties

	editor_type: BAR_AND_TEXT;
			-- Abstract window type. Redefined in descendants
			-- for specific window creation

	free_list: LINKED_LIST [like editor_type];
			-- Editors that has been requested to be destroyed 

	screen: SCREEN;
			-- Screen used for window creation

feature {WINDOW_MGR} -- Properties

	count: INTEGER is
		do
			Result := active_editors.count
		end;

	empty_editor: like editor_type is
			-- Retrieve an empty editor. If not found
			-- then create one.
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.forth
			end;
			if not active_editors.after then
				Result := active_editors.item
			else
				Result := top_shell_editor
			end
		end;

	form_d_editor: like editor_type is
		local
			mp: MOUSE_PTR;
			ed: BAR_AND_TEXT;
			fd: EB_FORM_DIALOG
		do
			!! mp.set_watch_cursor;
			!! fd.make ("", Project_tool);
			ed := shell_editor (fd);
			fd.set_title (ed.tool_name);
			Result ?= ed;
			mp.restore;
		end;

	top_shell_editor: like editor_type is
		local
			mp: MOUSE_PTR;
			ed: BAR_AND_TEXT;
			ts: EB_TOP_SHELL
		do
			!! mp.set_watch_cursor;
			!! ts.make (Project_tool.screen);
			ed := shell_editor (ts);
			ts.set_title (ed.tool_name);
			Result ?= ed
			mp.restore;
		end;

	shell_editor (a_parent: EB_SHELL): like editor_type is
			-- Creates new editor. (Either creates one or
			-- retrieves one from the free_list).
		local
			mp: MOUSE_PTR
		do
			if
				not free_list.empty
			then
				free_list.start;
				Result := free_list.item;
				free_list.remove;
			else
				!! mp.set_watch_cursor;
				!! Result.make_shell (a_parent);
				mp.restore
			end;
			active_editors.extend (Result);
		end;

	has (ed: like editor_type): BOOLEAN is
			-- Is editor `ed' displayed?
		do
			Result := active_editors.has (ed)
		end;

feature {WINDOW_MGR} -- Implementation

	hide_editors is
			-- Hide all active editors.
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.hide;
				active_editors.item.close_windows;
				active_editors.forth
			end;
		end;

	show_editors is
			-- Show all active editors.
		local
			ed: like editor_type
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				ed := active_editors.item;
				ed.show;
				active_editors.forth
			end
		end;

	remove (ed: like editor_type) is
			-- Remove an editor `ed'.
		do
			active_editors.start;
			active_editors.compare_references
			active_editors.search (ed);
			if
				not active_editors.after
			then
				ed.close;
				active_editors.remove;
				if free_list.count >= General_resources.window_free_list_number.actual_value then
					ed.destroy
				else
					free_list.extend (ed)
				end;
			else
					--| Should never happen but this is ultra
					--| safe programming.
				ed.close;
				if ed.is_a_shell then
					ed.destroy
				end
			end;
		end;

	raise_editors is
			-- Raise all active editors.
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.raise;
				active_editors.forth
			end
		end;

	close_editors is
			-- Close all active editors.
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.close;
				active_editors.forth
			end
		end

end -- class EDITOR_MGR
