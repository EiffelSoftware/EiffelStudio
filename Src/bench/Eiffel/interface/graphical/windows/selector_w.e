indexing

	description: "Selector for the class_tool windows."
	date: "$Date$"
	revision: "$Revision$"

class SELECTOR_W 

inherit
	SCROLLABLE_LIST
		redefine
			make, item
		end
	COMMAND

	WINDOWS
	WINDOW_ATTRIBUTES
	SHARED_EIFFEL_PROJECT
	EB_CONSTANTS

creation
	make

feature --Initialization
	
	make (a_name: STRING; a_parent: SPLIT_WINDOW_CHILD) is
		do
			{SCROLLABLE_LIST} Precursor (a_name,a_parent)
			set_widget_attributes (Current)
 			add_click_action (Current,"selector_command")
			selector_parent?= a_parent
		end

	init_toggle (toggle: TOGGLE_B) is
			-- Init arm action.
		do
			toggle.add_activate_action (Current, Void);
			associated_toggle:=toggle
			if Project_resources.selector_window.actual_value then
				show_selector
			else
				hide_selector
			end
		end;

feature -- Access

	associated_toggle: TOGGLE_B;
			-- associated toggle button with toolbar

	item: SCROLLABLE_LIST_SELECTOR_ELEMENT is
		do
 			Result ?= implementation.item
 		end;

	selector_parent: SPLIT_WINDOW_CHILD

feature -- User interface

	show_selector is
		do
			manage
			associated_toggle.set_toggle_on
			selector_parent.manage
		end

	hide_selector is
		do
			unmanage
			associated_toggle.set_toggle_off
			selector_parent.unmanage
		end

	add_tool_entry(t_w:TOOL_W) is
		local
			tmp: SCROLLABLE_LIST_SELECTOR_ELEMENT
		do
			!! tmp.make (t_w)
			extend(tmp)
		end

	change_tool_entry (t_w: TOOL_W) is
		local
			tmp: SCROLLABLE_LIST_SELECTOR_ELEMENT
  			t_name:STRING
		do
			t_name := clone (t_w.eb_shell.icon_name)
			!! tmp.make (t_w)

   			if t_name /= Void and then is_tool_opened (t_name,t_w)
  			then
-- FIXME JOC: still need to decide what to do.
--				tmp.set_read_only
			end

			from
				start
			until
				after or else t_w = item.tool
			loop
				forth
			end

			if index <= count then 
				replace(tmp)
			end
		end

	remove_tool_entry (t_w: TOOL_W) is
		do
			from
				start
			until
				after or else t_w = item.tool
			loop
				forth
			end

			if index <= count then 
				remove
			end
		end


-- 	update is
-- 		local
-- 			tmp: SCROLLABLE_LIST_SELECTOR_ELEMENT
-- 			local_tool:TOOL_W
-- 			active_tool_editors: LINKED_LIST[TOOL_W]
-- 			t:STRING
-- 		do
-- 			io.put_string ("update")
-- 			wipe_out
-- 			active_tool_editors := window_manager.class_win_mgr.active_editors
-- 			from 
-- 				active_tool_editors.start
-- 			until
-- 				active_tool_editors.after
-- 			loop
-- 				local_tool := active_tool_editors.item
-- 				t:= local_tool.eb_shell.icon_name
-- 				if
-- 					local_tool.realized 
-- 					and then not local_tool.eb_shell.icon_name.empty 
-- 				then
-- 					!!tmp.make(local_tool)
-- 					extend(tmp)
-- 				end
-- 				active_tool_editors.forth
-- 			end
-- 		end

feature -- Basic operations

	is_tool_opened(tool_name:STRING; t_w:TOOL_W):BOOLEAN is
		local
			tmp:STRING
		do
			Result := False
			from
				start
			until
				after or Result
			loop
				if item.tool /= t_w then
					tmp := clone(item.value)
					tmp.to_upper
					if tmp /= Void and then tmp.is_equal(tool_name) then
						Result := True
					end
				end
				forth	
			end
		end

	execute (argument: ANY) is
			-- Execute Current command.
			-- `argument' is automatically passed by
			-- EiffelVision when Current command is
			-- invoked as a callback.
		local
			arg_string: STRING
			local_name:STRING
			local_tool_w:TOOL_W
			active_tool_editors: LINKED_LIST[TOOL_W]
			selection: SCROLLABLE_LIST_SELECTOR_ELEMENT
		do
			arg_string ?= argument
			if arg_string /= Void and then arg_string.is_equal("selector_command") then
				selection ?= selected_item
				if selection /=Void then
					local_name:=clone(selection.value)
					local_tool_w ?= selection.tool
					if local_tool_w /= Void and then local_tool_w.realized then
						local_tool_w.force_raise
					end
				end
			else
				if associated_toggle.state then
					show_selector
				else
					hide_selector
				end
			end
		end

end -- class SELECTOR_W

