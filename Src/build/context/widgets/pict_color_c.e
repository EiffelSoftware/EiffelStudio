

class PICT_COLOR_C 

inherit

	PIXMAPS
		rename
			Pict_color_b_pixmap as symbol
		export
			{NONE} all
		end;

	BUTTON_C
		rename
			copy_attributes as button_copy_attributes,
			reset_modified_flags as button_reset_modified_flags,
			eiffel_color as old_eiffel_color,
			set_modified_flags as button_set_modified_flags
		redefine
			stored_node, option_list, widget
		end;

	BUTTON_C
		redefine
			stored_node, reset_modified_flags, copy_attributes, 
			eiffel_color, option_list, widget, set_modified_flags
		select
			copy_attributes, reset_modified_flags, eiffel_color,
			set_modified_flags
		end
	
feature 

	context_type: CONTEXT_TYPE is
		do
			Result := context_catalog.primitive_page.pict_color_b_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make (entity_name, a_parent);
			widget.set_size (20, 20);
		end;

	widget: PICT_COLOR_B;

	
feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("Pict_color_b");
		end;
	
feature 

	eiffel_type: STRING is "PICT_COLOR_B";

	-- ***********************
	-- * specific attributes *
	-- ***********************

	option_list: ARRAY [INTEGER] is
		local
			i: INTEGER
		do
			Result := old_list;
			i := Result.upper+2;
			Result.force (pict_color_form_number, Result.upper+1);
			from
			until
				i > Result.upper
			loop
				Result.put (-1, i);
				i := i + 1
			end
		end;

	pixmap_name: STRING;
			-- Name of the file containing the pixmap definition

	
feature {NONE}

	editor_form_cell: CELL [INTEGER] is
        once
            !!Result.put (0)
        end;
 
feature 

	set_modified_flags is
		do
			button_set_modified_flags;
			if pixmap_name /= Void and then not pixmap_name.empty then
				pixmap_name_modified := True;
			end;
		end;


	pixmap_name_modified: BOOLEAN;

	set_pixmap_name (a_name: STRING) is
			-- Set the pixmap name to `a_name' and load the content
			-- of the file
		local
			a_pixmap: PIXMAP;
		do
			pixmap_name_modified := False;
			pixmap_name := a_name;
			if pixmap_name /= Void then
				!!a_pixmap.make;
				a_pixmap.read_from_file (a_name);
				if a_pixmap.is_valid then
					widget.set_managed (False);
					widget.set_pixmap (a_pixmap);
					widget.set_managed (True);
					pixmap_name_modified := True;
				end;
			end
		end;

	reset_modified_flags is
		do
			button_reset_modified_flags;
			pixmap_name_modified := False;
		end;

	
feature {NONE}

	copy_attributes (other_context: like Current) is
		do
			if pixmap_name_modified then
				other_context.set_pixmap_name (pixmap_name);
			end;
			button_copy_attributes (other_context);
		end;

--	context_initialization (context_name: STRING): STRING is
--		do
--			Result := old_context_initialization (context_name);
--			if pixmap_name_modified then
--				function_string_to_string (Result, context_name, "set_pixmap_by_name", pixmap_name)
--			end;
--		end;

	-- if set_pixmap_by_name is not implemented in EiffelVision
	-- then redefine eiffel_color

	
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

	stored_node: S_PICT_COLOR_B is
		do
			!!Result.make (Current);
		end;

end
