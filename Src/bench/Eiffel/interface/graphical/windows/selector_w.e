indexing

	description:	
		"Window describing an Eiffel object."
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

feature --Initialisation
	
	make (a_name: STRING; a_parent: SPLIT_WINDOW_CHILD) is
		do
			{SCROLLABLE_LIST} Precursor(a_name,a_parent)
			set_widget_attributes(Current)
 			add_click_action(Current,"selector_command")
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

	add_class_entry(c_w:CLASS_W) is
		local
			tmp: SCROLLABLE_LIST_SELECTOR_ELEMENT
		do
			!! tmp.make (c_w)
			extend(tmp)
		end

	change_class_entry (c_w: CLASS_W) is
		local
			tmp: SCROLLABLE_LIST_SELECTOR_ELEMENT
			c: CLASSC_STONE
			ci: CLASSI_STONE
			cl_name:STRING
		do
			c ?= c_w.stone
			ci ?= c_w.stone
			if c /= Void then
				cl_name := clone (c.e_class.name)
				cl_name.to_upper
			elseif ci /= Void then
				cl_name := clone (ci.class_i.name)
			end

			!! tmp.make (c_w)

 			if cl_name /= Void and then is_class_opened (cl_name,c_w)
 			then
				tmp.set_read_only
				c_w.set_read_only 
 			end

			from
				start
			until
				after or else c_w = item.tool
			loop
				forth
			end

			if index <= count then 
				replace(tmp)
			end
		end

	remove_class_entry (c_w: CLASS_W) is
		do
			from
				start
			until
				after or else c_w = item.tool
			loop
				forth
			end

			if index <= count then 
				remove
			end
		end


	update is
		local
			tmp: SCROLLABLE_LIST_SELECTOR_ELEMENT
			local_tool:CLASS_W
			active_class_editors: LINKED_LIST[CLASS_W]
			t:STRING
		do
			wipe_out

			active_class_editors := window_manager.class_win_mgr.active_editors
			from 
				active_class_editors.start
			until
				active_class_editors.after
			loop
				local_tool := active_class_editors.item
				t:= local_tool.class_text_field.text
				if local_tool.realized 
--  					and then local_tool.shown 
					and then not local_tool.class_text_field.text.empty 
				then
					!!tmp.make(local_tool)
-- 					io.put_string (local_tool.class_text_field.text)
-- 					io.put_string ("%N")
					extend(tmp)
				end
				active_class_editors.forth
			end
		end

feature -- Basic operations

	is_class_opened(cl_name:STRING; c_w:CLASS_W):BOOLEAN is
		local
			active_class_editors: LINKED_LIST[CLASS_W]
			tmp:STRING
		do
			Result := False
			from
				start
			until
				after or Result
			loop
				if item.tool /= c_w then
					tmp := clone(item.value)
					tmp.to_upper
					if tmp /= Void and then tmp.is_equal(cl_name) then
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
			active_class_editors: LINKED_LIST[CLASS_W]
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

