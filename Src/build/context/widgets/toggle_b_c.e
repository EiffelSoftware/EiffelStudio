

class TOGGLE_B_C 

inherit

	BUTTON_C
		redefine
			stored_node, widget, is_able_to_be_grouped
		end

feature 

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.toggle_b_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make_unmanaged (entity_name, a_parent);
			set_left_alignment (False);
		end;

	widget: TOGGLE_B;

	symbol: PIXMAP is
		do
			Result := Pixmaps.toggle_b_pixmap
		end;

	is_able_to_be_grouped: BOOLEAN is
			-- Is Current toggle able to be grouped?
		do
			Result := not parent.is_group_composite and
						then not is_in_a_group
		end

feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("Toggle_b");
		end;

feature 

	eiffel_type: STRING is "TOGGLE_B";

-- ****************
-- Storage features
-- ****************

	stored_node: S_TOGGLE_B_R1 is
		local
			foobar: S_TOGGLE_B
		do
			!!Result.make (Current);
			if foobar = Void then end;
				-- So it won't be dead code removed
		end;

end
