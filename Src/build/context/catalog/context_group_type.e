

class CONTEXT_GROUP_TYPE 

inherit

	CONTEXT_TYPE
		rename
			make as context_type_create
		redefine
			dummy_context, help_file_name
		end;
	NAMABLE
		redefine
			check_new_name, is_valid_new_name
		end;
	ERROR_POPUPER

	DATA

creation

	make
	
feature  {NONE}

	make (a_name: STRING; a_context: GROUP_C) is
			-- create a context type associated with `a_context'
		do
			dummy_context := a_context;
			identifier := group.identifier;
		end;

	dummy_context: GROUP_C;
			-- Reference to a context, descendant of current type
	
feature 

	group: GROUP is
		do
			Result := dummy_context.group_type
		end;

	group_text: STRING is
		do
			Result := dummy_context.group_text
		end

	help_file_name: STRING is
		do
			Result := Help_const.group_help_fn
		end;

feature {NONE} -- Namable

	is_valid_new_name: BOOLEAN;

	set_visual_name (new_name: STRING) is
		local
			a_name: STRING		
		do
			a_name := clone (new_name);
			a_name.to_upper;
			group.set_entity_name (a_name);
			group.update_entity_name_in_tree;
			context_catalog.update_groups;
		end;

	visual_name: STRING is
		do
			Result := group.entity_name
		end;

	check_new_name (new_name: STRING) is
		local
			a_name: STRING;
			id: IDENTIFIER
		do
			is_valid_new_name := True;
			a_name := new_name;
			a_name.to_upper;
			if not Context_catalog.has_group_name (a_name) then
				!! id.make (a_name.count);
				id.append (a_name);
				if not id.is_valid then
					is_valid_new_name := False;
					error_box.popup (Current,
							Messages.invalid_group_class_name_er,
							a_name)
				end
			else
				is_valid_new_name := False;
				Error_window.popup (Current,
						Messages.group_name_exists_er,
						a_name);
			end
		end;

	popuper_parent: COMPOSITE is
		do
			Result := Namer_window
		end;

end
