
class PERM_WIND_FORM 

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

	title: EB_TEXT_FIELD;
			-- Title of the perm_wind

	--forbid_recomp: EB_TOGGLE_B; -- only implement this is forms are involved not 
									-- bulletins

	icon_name: EB_TEXT_FIELD;

	iconic_state: EB_TOGGLE_B;

	
feature 

	make (a_parent: CONTEXT_EDITOR) is
		do
			a_parent.form_list.put (Current, perm_wind_form_number);
		end;

	make_visible (a_parent: CONTEXT_EDITOR) is
		local
			title_label: LABEL_G;
			icon_label: LABEL_G;
		do	
			initialize (Perm_wind_form_name, a_parent);

			!!title_label.make (T_itle, Current);
			!!title.make (T_extfield, Current, perm_title_cmd, a_parent);
			--!!forbid_recomp.make (F_orbid_recomp_size, Current, perm_resize_cmd, a_parent);

			!!icon_label.make (I_con_name, Current);
			!!icon_name.make (T_extfield, Current, perm_icon_name_cmd, a_parent);
			!!iconic_state.make (I_conic_state, Current, perm_iconic_cmd, a_parent);

			attach_left (title_label, 10);
			attach_left (title, 100);
			attach_right (title, 10);
			--attach_left (forbid_recomp, 10);
			attach_left (icon_label, 10);
			attach_left (icon_name, 100);
			attach_right (icon_name, 10);
			attach_left (iconic_state, 10);

			attach_top (title, 10);
			attach_top (title_label, 15);
			attach_top_widget (title, icon_label, 15);
			attach_top_widget (title, icon_name, 10);
			attach_top_widget (icon_name, iconic_state, 10);
			--attach_top_widget (iconic_state, forbid_recomp, 10);
			detach_bottom (iconic_state);
			iconic_state.set_text ("Iconic state (at start of application)");
		end;

	
feature {NONE}

	context: PERM_WIND_C;

	reset is
		do
			if not (context.title = Void) then
				title.set_text (context.title)
			else
				title.set_text ("")
			end;
			--forbid_recomp.set_state (context.resize_policy_disabled);
			if not (context.icon_name = Void) then
				icon_name.set_text (context.icon_name)
			else
				icon_name.set_text ("")
			end;
			iconic_state.set_state (context.is_iconic_state);
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
			if (context.icon_name = Void) then
				if (not icon_name.text.empty) then
					context.set_icon_name (icon_name.text)
				end
			elseif not icon_name.text.is_equal (context.icon_name) then
				context.set_icon_name (icon_name.text)
			end;
			--if context.resize_policy_disabled /= forbid_recomp.state then
				--context.disable_resize_policy (forbid_recomp.state);
			--end;
			if iconic_state.state /= context.is_iconic_state then
				context.set_iconic_state (iconic_state.state);
			end;
		end;

end
