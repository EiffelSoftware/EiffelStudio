

class PICT_COLOR_C 

inherit

	BUTTON_C
		rename
			copy_attributes as button_copy_attributes,
			reset_modified_flags as button_reset_modified_flags,
			eiffel_color as old_eiffel_color,
			set_modified_flags as button_set_modified_flags
		redefine
			stored_node, widget, set_bg_pixmap_name, add_to_option_list,
			is_fontable
		end;

	BUTTON_C
		redefine
			stored_node, reset_modified_flags, copy_attributes, 
			eiffel_color, widget, set_modified_flags,
			set_bg_pixmap_name, add_to_option_list,
			is_fontable
		select
			copy_attributes, reset_modified_flags, eiffel_color,
			set_modified_flags
		end
	
feature 

	is_fontable: BOOLEAN is
			-- Is current context fontable
		do
			Result := false
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.pict_color_b_pixmap
		end;

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.primitive_page.pict_color_b_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make_unmanaged (entity_name, a_parent);
			widget.forbid_recompute_size;
			set_size (20, 20);
		end;

	widget: PICT_COLOR_B;

feature -- Default event

	default_event: BUT_ACT_EV is
		do
			Result := but_act_ev
		end
	
feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("Pict_color_b");
		end;
	
	add_to_option_list (opt_list: ARRAY [INTEGER]) is
		do
			opt_list.put (Context_const.geometry_form_nbr,
					Context_const.Geometry_format_nbr);
			opt_list.put (Context_const.pict_color_att_form_nbr,
					Context_const.Attribute_format_nbr);
		end;

feature 

	eiffel_type: STRING is "PICT_COLOR_B";

	full_type_name: STRING is "Picture color button"

	-- ***********************
	-- * specific attributes *
	-- ***********************

	pixmap_name: STRING;
			-- Name of the file containing the pixmap definition
	
feature 

	pixmap_name_modified: BOOLEAN;

	set_modified_flags is
		do
			button_set_modified_flags;
			if pixmap_name /= Void and then not pixmap_name.empty then
				pixmap_name_modified := True;
			end;
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
				widget.manage;
			else
				 !!a_pixmap.make;
				 a_pixmap.read_from_file (a_string);
				 if a_pixmap.is_valid then
					  widget.set_background_pixmap (a_pixmap);
					  bg_pixmap_modified := True;
				 end;
			end;
		end;

	set_pixmap_name (a_name: STRING) is
			-- Set the pixmap name to `a_name' and load the content
			-- of the file
		local
			a_pixmap: PIXMAP;
			cloned_current: like Current;
			p: COMPOSITE
		do
			pixmap_name_modified := False;
			pixmap_name := a_name;
			if pixmap_name = Void or else pixmap_name.empty then
				widget.hide;
				cloned_current := clone (Current);
				p := widget.parent;
					-- Need to do this so the pixmap 
					-- can be reset to nothing
				!! widget.make_unmanaged (entity_name, p);
				cloned_current.copy_attributes (Current);
				widget.set_x_y (cloned_current.widget.x, cloned_current.widget.y);
				cloned_current.widget.destroy;
				add_widget_callbacks;
				widget.manage;
			else
				!!a_pixmap.make;
				a_pixmap.read_from_file (a_name);
				if a_pixmap.is_valid then
					widget.unmanage;
					widget.set_pixmap (a_pixmap);
					widget.manage;
					pixmap_name_modified := True;
				end;
			end
		end;

	reset_modified_flags is
		do
			button_reset_modified_flags;
			pixmap_name_modified := False;
		end;

	
feature 

	copy_attributes (other_context: like Current) is
		do
			if pixmap_name_modified then
				other_context.set_pixmap_name (pixmap_name);
			end;
			button_copy_attributes (other_context);
		end;

	
feature {CONTEXT}

	eiffel_color (context_name: STRING): STRING is
			-- Generated string for the creation of all the
			-- colors and pixmaps of the current context
			-- and all its children
		do
			Result := old_eiffel_color (context_name);
			if pixmap_name_modified then
				Result.append ("%T%T%T!!a_pixmap.make;%N%T%T%Ta_pixmap.read_from_file (%"");
				Result.append (pixmap_name);
				Result.append ("%");%N%T%T%T");
				Result.append (context_name);
				Result.append ("set_pixmap (a_pixmap);%N");
			end;
		end;

-- ****************
-- Storage features
-- ****************

	
feature 

	stored_node: S_PICT_COLOR_B_R1 is
		local
			foobar: S_PICT_COLOR_B
		do
			!!Result.make (Current);
			if foobar = Void then end;
				-- So it won't be dead code removed
		end;

end
