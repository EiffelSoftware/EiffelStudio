indexing
	description: "Page representing the properties of a TEMP_WIND."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class TEMP_WIND_FORM 

inherit

	EDITOR_FORM
		redefine
			context
		end

creation

	make
	
feature {NONE}

	context: TEMP_WIND_C is
		do
			Result ?= editor.edited_context
		end

	title: EB_TEXT_FIELD
			-- Title of the temp_wind

	forbid_recomp: EB_TOGGLE_B

	start_hidden: EB_TOGGLE_B

	set_default_position_t: EB_TOGGLE_B
	
	form_number: INTEGER is
		do
			Result := Context_const.temp_wind_att_form_nbr
		end

	format_number: INTEGER is
		do
			Result := Context_const.attribute_format_nbr
		end

	Win_set_default_position_cmd: WIN_SET_DEFAULT_POS_CMD is
		once
			!! Result
		end

	Temp_hidden_cmd: TEMP_SHOWN_CMD is
		once
			!!Result
		end

	Temp_title_cmd: TEMP_TITLE_CMD is
		once
			!!Result
		end

	Temp_resize_cmd: WINDOW_RESIZE_CMD is
		once
			!!Result
		end

--	Temp_resize_cmd: TEMP_RESIZE_CMD is
--		once
--			!!Result
--		end

feature

	make_visible (a_parent: COMPOSITE) is
		local
			title_label: LABEL
			icon_label: LABEL
		do	
			initialize (Widget_names.temp_wind_form_name, a_parent)

			!!title_label.make (Widget_names.title_name, Current)
			!!title.make (Widget_names.textfield, Current, 
					Temp_title_cmd, editor)
			!!set_default_position_t.make 
					(Widget_names.set_default_position_name, Current, 
					Win_set_default_position_cmd, editor)
			!!forbid_recomp.make (Widget_names.forbid_recomp_size_name, 
					Current, Temp_resize_cmd, editor)
			!!start_hidden.make (Widget_names.set_shown_name, Current, 
					Temp_hidden_cmd, editor)

			set_size (200, 200)
			attach_left (title_label, 10)
			attach_left (title, 100)
			attach_right (title, 10)
			attach_left (forbid_recomp, 10)
			attach_left (start_hidden, 10)
			attach_left (set_default_position_t, 10)

			attach_top (title, 10)
			attach_top (title_label, 15)
			attach_top_widget (title, set_default_position_t, 15)
			attach_top_widget (set_default_position_t, start_hidden, 15)
			attach_top_widget (start_hidden, forbid_recomp, 15)
			detach_bottom (forbid_recomp)
			show_current
		end

	
feature {NONE}

	reset is
		do
			if not (context.title = Void) then
				title.set_text (context.title)
			else
				title.set_text ("")
			end
			set_default_position_t.set_state (context.default_position)
			start_hidden.set_state (context.start_hidden)
			forbid_recomp.set_state (context.resize_policy_disabled)
		end

	
feature 

	apply is
		do
			if (context.title = Void) then
				if (not title.text.empty) then
					context.set_title (title.text)
				end
			elseif not title.text.is_equal (context.title) then
				context.set_title (title.text)
			end
			if context.start_hidden /= start_hidden.state then
				context.set_start_hidden (start_hidden.state)
			end
			if context.resize_policy_disabled /= forbid_recomp.state then
				context.disable_resize_policy (forbid_recomp.state)
			end
			if context.default_position /= set_default_position_t.state then
				context.set_default_position (set_default_position_t.state)
			end
		end

end
