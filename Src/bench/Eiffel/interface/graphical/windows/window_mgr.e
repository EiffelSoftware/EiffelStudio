indexing
	description: "Window manager for tools."
	date: "$Date$"
	revision: "$Revision$"

class WINDOW_MGR 

inherit
	W_MAN_GEN

	WINDOWS

	EB_CONSTANTS

	RESOURCE_USER
		redefine
			update_string_resource, finish_update
		end

creation

	make

feature -- Initialization

	make (a_screen: SCREEN) is
			-- Make a window manager. All editors will be create 
			-- using `a_screen' as the parent. Allow `i' amount for
			-- the free list.
		do
			!!routine_win_mgr.make (a_screen)
			!!class_win_mgr.make (a_screen)
			!!object_win_mgr.make (a_screen)
			!!explain_win_mgr.make (a_screen)
			Graphical_resources.add_user (Current)	
		end

feature -- Properties

	need_to_resynchronize: BOOLEAN	
		-- Do all the windows need to be resynchonized?
	
	need_to_update_attributes: BOOLEAN	
		-- Do all the windows need to update their colors and fonts?
	
	routine_win_mgr: ROUTINE_WIN_MGR
		-- Manager for routine windows 

	class_win_mgr: CLASS_WIN_MGR
		-- Manager for class windows

	object_win_mgr: OBJECT_WIN_MGR
		-- Manager for object windows

	explain_win_mgr: EXPLAIN_WIN_MGR
		-- Manager for explain windows

	routine_window: ROUTINE_W is
			-- Make a routine window 
		do
			Result := routine_win_mgr.editor
			Project_tool.add_routine_entry (Result)
		end

	class_window: CLASS_W is
			-- Make a class window 
		do
			Result := class_win_mgr.editor
			Project_tool.add_class_entry (Result)
		end

	object_window: OBJECT_W is
			-- Make an object window
		do
			Result := object_win_mgr.editor
			Project_tool.add_object_entry (Result)
		end

	explain_window: EXPLAIN_W is
			-- Create a context editor
		do
			Result := explain_win_mgr.editor
			Project_tool.add_explain_entry (Result)
		end

	class_windows_count: INTEGER is
		do
			Result := class_win_mgr.count
		end	

	routine_windows_count: INTEGER is
		do
			Result := routine_win_mgr.count
		end	

	object_windows_count: INTEGER is
		do
			Result := object_win_mgr.count
		end	

	explain_windows_count: INTEGER is
		do
			Result := explain_win_mgr.count
		end	

	has_active_editor_tools: BOOLEAN is
			-- Are there any active editor tools 
			-- (routine and class) up?
		do
			Result := routine_windows_count /= 0 or else
				class_windows_count /= 0
		end
				
feature -- Graphical Interface

	close (ed: TOOL_W) is
			-- Close `ed'. 
		local
			r_w: ROUTINE_W
			c_w: CLASS_W
			o_w: OBJECT_W
			e_w: EXPLAIN_W
		do
			r_w ?= ed
			c_w ?= ed
			o_w ?= ed
			e_w ?= ed
			if r_w /= Void then
				routine_win_mgr.remove (r_w)
			elseif c_w /= Void then
				class_win_mgr.remove (c_w)
			elseif o_w /= Void then
				object_win_mgr.remove (o_w)
			elseif e_w /= Void then
				explain_win_mgr.remove (e_w)
			end
		end

	hide_all_editors is
		do
			routine_win_mgr.hide_editors
			class_win_mgr.hide_editors
			object_win_mgr.hide_editors
			explain_win_mgr.hide_editors
		end

	show_all_editors is
			-- Show all the editors.
		do
			routine_win_mgr.show_editors
			class_win_mgr.show_editors
			object_win_mgr.show_editors
			explain_win_mgr.show_editors
		end

	close_all_editors is
			-- Close all the editors.
		do
			routine_win_mgr.close_editors
			class_win_mgr.close_editors
			object_win_mgr.close_editors
			explain_win_mgr.close_editors
		end

	raise_all_editors is
			-- Raise all the editors.
		do
			explain_win_mgr.raise_editors
			object_win_mgr.raise_editors
			routine_win_mgr.raise_editors
			class_win_mgr.raise_editors
		end

	raise_class_windows is
		do
			class_win_mgr.raise_editors
		end

	raise_explain_windows is
		do
			explain_win_mgr.raise_editors
		end

	raise_object_windows is
		do
			object_win_mgr.raise_editors
		end

	raise_routine_windows is
		do
			routine_win_mgr.raise_editors
		end

feature -- Update

	update_string_resource (old_res, new_res: STRING_RESOURCE) is
			-- Update Current to reflect changes in `a_modified_resource'.
		local
			old_c, new_c: COLOR_RESOURCE
			old_f, new_f: FONT_RESOURCE
		do
			old_f ?= old_res
			if old_f /= Void then
				new_f ?= new_res
				update_font_resource (old_f, new_f)
			else
				old_c ?= old_res
				if old_c /= Void then
					new_c ?= new_res
					update_color_resource (old_c, new_c)
				end
			end
		end

	update_font_resource (old_res, new_res: FONT_RESOURCE) is
			-- Update Current to reflect changes in `a_modified_resource'.
		local
			gr: like Graphical_resources
		do
			gr := Graphical_resources
			need_to_resynchronize := True
			if old_res = gr.font then
				need_to_update_attributes := True
			end
			old_res.update_with (new_res)
		end
 
	update_color_resource (old_res, new_res: COLOR_RESOURCE) is
			-- Update Current to reflect changes in `a_modified_resource'.
		local
			gr: like Graphical_resources
		do
			gr := Graphical_resources
			need_to_resynchronize := True
			if 
				old_res = gr.background_color or else 
				old_res = gr.foreground_color 
			then
				need_to_update_attributes := True
			end
			old_res.update_with (new_res)
		end

	finish_update is
			-- Finish the update of resources.
		local
			att: WINDOW_ATTRIBUTES
			top_w: TOP
			widget: WIDGET
		do
			if need_to_update_attributes then
				!! att
				from
					widget_manager.start
				until
					widget_manager.after
				loop
					widget := widget_manager.item
					if widget.depth = 0 then
						top_w ?= widget
						att.set_composite_attributes (top_w)
					end
					widget_manager.forth
				end
				need_to_update_attributes := False
			end
			if need_to_resynchronize then
				Project_tool.update_graphical_resources
				if is_system_tool_created then
					System_tool.update_graphical_resources
				end
				if Profile_tool /= Void then	
					Profile_tool.update_graphical_resources
				end
				routine_win_mgr.update_graphical_resources
				class_win_mgr.update_graphical_resources
				object_win_mgr.update_graphical_resources
				explain_win_mgr.update_graphical_resources
				need_to_resynchronize := False
			end
		end	

end -- class WINDOW_MGR
