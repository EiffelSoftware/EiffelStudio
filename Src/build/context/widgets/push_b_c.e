
class PUSH_B_C 

inherit

	BUTTON_C
		redefine
			stored_node, widget,
			set_bg_pixmap_name
--			add_widget_callbacks
		end
	
feature 

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.push_b_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!! widget.make_unmanaged (entity_name, a_parent);
			disable_resize_policy (True);
		end;

	widget: PUSH_B;

	symbol: PIXMAP is
		do
			Result := Pixmaps.push_b_pixmap
		end;
	
--	add_widget_callbacks is
--		local
--			old_mode: INTEGER
--			test_cmd: TEST_COMMAND
--		do	
--			precursor
--			!! test_cmd.make
--			old_mode := executing_or_editing_mode
--			set_mode (executing_mode)
--			widget.add_activate_action (test_cmd, Void)
--			set_mode (old_mode)
--		end
	
feature -- Default event

	default_event: BUT_ACT_EV is
		do
			Result := but_act_ev
		end

feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("Push_b");
		end;

	set_bg_pixmap_name (a_string: STRING) is
		local
			a_pixmap: PIXMAP;
			cloned_current: like Current;
			p: COMPOSITE
		do
			bg_pixmap_name := a_string;
			bg_pixmap_modified := False;
			if (a_string = Void) then
				widget.hide;
				cloned_current := clone (Current);
				p := widget.parent;
				!! widget.make_unmanaged (entity_name, p);
				cloned_current.copy_attributes (Current);
				widget.set_x_y (cloned_current.widget.x, cloned_current.widget.y);
				cloned_current.widget.destroy;
				add_widget_callbacks;
				widget.manage
			else
				 !!a_pixmap.make;
				 a_pixmap.read_from_file (a_string);
				 if a_pixmap.is_valid then
					  widget.set_background_pixmap (a_pixmap);
					  bg_pixmap_modified := True;
				 end;
			end;
		end;

feature 

	eiffel_type: STRING is "PUSH_B";

	full_type_name: STRING is "Push button"

-- ****************
-- Storage features
-- ****************

	stored_node: S_PUSH_B_R1 is
		local
			foobar: S_PUSH_B
		do
			!!Result.make (Current);
			if foobar = Void then end;
				-- So it won't be dead code removed
		end;

end
