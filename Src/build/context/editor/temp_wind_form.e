
class TEMP_WIND_FORM 

inherit

	CONTEXT_CMDS
		export
			{NONE} all
		end;
	EDITOR_FORM
		redefine
			context
		end


creation

	make

	
feature {NONE}

	temp_title_cmd: TEMP_TITLE_CMD is
		once
			!!Result
		end;

	temp_resize_cmd: TEMP_RESIZE_CMD is
		once
			!!Result
		end;

	title: EB_TEXT_FIELD;
			-- Title of the temp_wind

	forbid_recomp: EB_TOGGLE_B;

	start_hidden: EB_TOGGLE_B;

	
feature 

	make (a_parent: CONTEXT_EDITOR) is
		do
			a_parent.form_list.put (Current, temp_wind_form_number);
		end;

	make_visible (a_parent: CONTEXT_EDITOR) is
		local
			title_label: LABEL_G;
			icon_label: LABEL_G;
		do	
			initialize (Temp_wind_form_name, a_parent);

			!!title_label.make (T_itle, Current);
			!!title.make (T_extfield, Current, temp_title_cmd, a_parent);
			!!forbid_recomp.make (F_orbid_recomp_size, Current, temp_resize_cmd, a_parent);
			!!start_hidden.make (S_et_shown, Current, temp_hidden_cmd, a_parent);

			attach_left (title_label, 10);
			attach_left (title, 100);
			attach_right (title, 10);
			attach_left (forbid_recomp, 10);
			attach_left (start_hidden, 10);

			attach_top (title, 10);
			attach_top (title_label, 15);
			attach_top_widget (title, start_hidden, 15);
			attach_top_widget (start_hidden, forbid_recomp, 15);
			detach_bottom (forbid_recomp);
		end;

	
feature {NONE}

	context: TEMP_WIND_C;

	reset is
		do
			if not (context.title = Void) then
				title.set_text (context.title)
			else
				title.set_text ("")
			end;
			start_hidden.set_state (context.start_hidden);
			forbid_recomp.set_state (context.resize_policy_disabled);
		end;

	
feature 

	apply is
		do
			if (context.title = Void) then
				if (not title.text.empty) then
					context.set_title (title.text)
				end
			elseif not title.text.is_equal (context.title) then
				context.set_title (title.text)
			end;
			if context.start_hidden /= start_hidden.state then
				context.set_start_hidden (start_hidden.state);
			end;
			if context.resize_policy_disabled /= forbid_recomp.state then
				context.disable_resize_policy (forbid_recomp.state);
			end;
		end;

end
