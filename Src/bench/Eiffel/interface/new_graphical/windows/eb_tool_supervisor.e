indexing
	description: "Window manager for tools."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TOOL_SUPERVISOR 

inherit
	EB_SHARED_INTERFACE_TOOLS

	NEW_EB_CONSTANTS

	EB_RESOURCE_USER
		redefine
			dispatch_modified_resource,
			finish_update
		end

creation

	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Make a tool manager. All editors will be create 
			-- using `par' as the parent.
		do
			create feature_tool_mgr.make
			create class_tool_mgr.make
			create object_tool_mgr.make
			create explain_tool_mgr.make
			Graphical_resources.add_user (Current)	
		end

feature -- Properties

	need_to_resynchronize: BOOLEAN	
		-- Do all the tools need to be resynchonized?
	
	need_to_update_attributes: BOOLEAN	
		-- Do all the tools need to update their colors and fonts?
	
	feature_tool_mgr: EB_FEATURE_TOOL_LIST
		-- Manager for feature tools 

	class_tool_mgr: EB_CLASS_TOOL_LIST
		-- Manager for class tools

	object_tool_mgr: EB_OBJECT_TOOL_LIST
		-- Manager for object tools

	explain_tool_mgr: EB_EXPLAIN_TOOL_LIST
		-- Manager for explain tools

	new_feature_tool: EB_FEATURE_TOOL is
			-- Make a feature tool in a new window
		local
			ft_win: EB_FEATURE_WINDOW
		do
			create ft_win.make_top_level
			Result := ft_win.tool

			feature_tool_mgr.extend (Result)
			project_tool.add_feature_entry (Result)
		end

	new_class_tool: EB_CLASS_TOOL is
			-- Make a class tool in a new window
		local
			cl_win: EB_CLASS_WINDOW
		do
			create cl_win.make_top_level
			Result := cl_win.tool

			class_tool_mgr.extend (Result)
			project_tool.add_class_entry (Result)
		end

	new_object_tool: EB_OBJECT_TOOL is
			-- Make an object tool in a new window
		local
			ob_win: EB_OBJECT_WINDOW
		do
			create ob_win.make_top_level
			Result := ob_win.tool

			object_tool_mgr.extend (Result)
			project_tool.add_object_entry (Result)
		end

	new_explain_tool: EB_EXPLAIN_TOOL is
			-- Create an explain tool in a new window
		local
			ex_win: EB_EXPLAIN_WINDOW
		do
			create ex_win.make_top_level
			Result := ex_win.tool

			explain_tool_mgr.extend (Result)
			Project_tool.add_explain_entry (Result)
		end

	class_tools_count: INTEGER is
			-- number of active class tools
		do
			Result := class_tool_mgr.count
		end	

	feature_tools_count: INTEGER is
			-- number of active feature tools
		do
			Result := feature_tool_mgr.count
		end	

	object_tools_count: INTEGER is
			-- number of active object tools
		do
			Result := object_tool_mgr.count
		end	

	explain_tools_count: INTEGER is
			-- number of active explain tools
		do
			Result := explain_tool_mgr.count
		end	

	has_active_editor_tools: BOOLEAN is
			-- Are there any active editor tools 
			-- (feature and class) up?
		do
			Result := feature_tools_count /= 0 or else
				class_tools_count /= 0
		end
				
	is_class_opened (cl_name:STRING):BOOLEAN is
			-- Return True if the class is already opened in a class_tool
			-- return False otherwise.
		do
			Result := False
			from
				class_tool_mgr.start
			until
				class_tool_mgr.after and Result
			loop
				if class_tool_mgr.item.class_text_field.text.is_equal(cl_name) then
					Result := True
				end
				class_tool_mgr.forth	
			end
		end

feature -- Graphical Interface

	remove (ed: EB_TOOL) is
			-- Remove `ed' from the supervisor. 
		local
			f_t: EB_FEATURE_TOOL
			c_t: EB_CLASS_TOOL
			o_t: EB_OBJECT_TOOL
			e_t: EB_EXPLAIN_TOOL
		do
			f_t ?= ed
			c_t ?= ed
			o_t ?= ed
			e_t ?= ed
			if f_t /= Void then
				feature_tool_mgr.remove_editor (f_t)
			else
				if c_t /= Void then
					class_tool_mgr.remove_editor (c_t)
				elseif o_t /= Void then
					object_tool_mgr.remove_editor (o_t)
				elseif e_t /= Void then
					explain_tool_mgr.remove_editor (e_t)
				end
			end
		end

	remove_class (c_t: EB_CLASS_TOOL) is
			-- Remove `c_t' from the supervisor. 
		do
			class_tool_mgr.remove_editor (c_t)
		end

	hide_all_editors is
		do
			feature_tool_mgr.hide_editors
			class_tool_mgr.hide_editors
			object_tool_mgr.hide_editors
			explain_tool_mgr.hide_editors
		end

	show_all_editors is
			-- Show all the editors.
		do
			feature_tool_mgr.show_editors
			class_tool_mgr.show_editors
			object_tool_mgr.show_editors
			explain_tool_mgr.show_editors
		end

	close_all_editors is
			-- Close all the editors.
		do
			feature_tool_mgr.close_editors
			class_tool_mgr.close_editors
			object_tool_mgr.close_editors
			explain_tool_mgr.close_editors
		end

	raise_all_editors is
			-- Raise all the editors.
		do
			explain_tool_mgr.raise_editors
			object_tool_mgr.raise_editors
			feature_tool_mgr.raise_editors
			class_tool_mgr.raise_editors
		end

	raise_class_tools is
		do
			class_tool_mgr.raise_editors
		end

	raise_explain_tools is
		do
			explain_tool_mgr.raise_editors
		end

	raise_object_tools is
		do
			object_tool_mgr.raise_editors
		end

	raise_feature_tools is
		do
			feature_tool_mgr.raise_editors
		end

feature -- Update


	dispatch_modified_resource (mod_res: EB_MODIFIED_RESOURCE) is
		do
		end

--	update_string_resource (old_res, new_res: EB_STRING_RESOURCE) is
--			-- Update Current to reflect changes in `a_modified_resource'.
--		local
--			old_c, new_c: EB_COLOR_RESOURCE
--			old_f, new_f: EB_FONT_RESOURCE
--		do
--			old_f ?= old_res
--			if old_f /= Void then
--				new_f ?= new_res
--				update_font_resource (old_f, new_f)
--			else
--				old_c ?= old_res
--				if old_c /= Void then
--					new_c ?= new_res
--					update_color_resource (old_c, new_c)
--				end
--			end
--		end

--	update_font_resource (old_res, new_res: EB_FONT_RESOURCE) is
--			-- Update Current to reflect changes in `a_modified_resource'.
--		local
--			gr: like Graphical_resources
--		do
--			gr := Graphical_resources
--			need_to_resynchronize := True
--			if old_res = gr.font then
--				need_to_update_attributes := True
--			end
--			old_res.update_with (new_res)
--		end
 
--	update_color_resource (old_res, new_res: EB_COLOR_RESOURCE) is
--			-- Update Current to reflect changes in `a_modified_resource'.
--		local
--			gr: like Graphical_resources
--		do
--			gr := Graphical_resources
--			need_to_resynchronize := True
--			if 
--				old_res = gr.background_color or else 
--				old_res = gr.foreground_color 
--			then
--				need_to_update_attributes := True
--			end
--			old_res.update_with (new_res)
--		end

	finish_update is
			-- Finish the update of resources.
--		local
--			att: WINDOW_ATTRIBUTES
--			top_w: TOP
--			widget: EV_WIDGET
		do
--			if need_to_update_attributes then
--				create att
--				from
--					widget_manager.start
--				until
--					widget_manager.after
--				loop
--					widget := widget_manager.item
--					if widget.depth = 0 then
--						top_w ?= widget
--						att.set_composite_attributes (top_w)
--					end
--					widget_manager.forth
--				end
--				need_to_update_attributes := False
--			end
--			if need_to_resynchronize then
--				Project_tool.update_graphical_resources
--				if is_system_tool_created then
--					System_tool.update_graphical_resources
--				end
--				if Profile_tool /= Void then	
--					Profile_tool.update_graphical_resources
--				end
--				feature_tool_mgr.update_graphical_resources
--				class_tool_mgr.update_graphical_resources
--				object_tool_mgr.update_graphical_resources
--				explain_tool_mgr.update_graphical_resources
--				need_to_resynchronize := False
--			end
		end	

end -- class EB_TOOL_SUPERVISOR
