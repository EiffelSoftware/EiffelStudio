
class GROUP_HOLE 

inherit

	COMMAND;
	WINDOWS;
	ICON_HOLE
		redefine
			process_context
		end;
	
	ERROR_POPUPER

creation

	make

	
feature 

	make (a_parent: COMPOSITE) is
		do
			set_label (" ");
			set_symbol (Pixmaps.context_pixmap);
			make_visible (a_parent);
			-- added by samik			
			set_focus_string (Focus_labels.group_label)
			-- end of samik	
		end;

	focus_source: WIDGET is
		do
			Result := button
		end;


	
feature {NONE}

	dropped_stone: CONTEXT_STONE;

	stone_type: INTEGER is
		do
			Result := Stone_types.context_type
		end;

	process_context (dropped: CONTEXT_STONE) is
		local
			a_context: CONTEXT;
		do
			a_context := dropped.data;
			if a_context.is_able_to_be_grouped then
				dropped_stone := dropped;
				unmanage;
				set_label (a_context.label);
				manage;
			end;
		end;
		
	execute (argument: TEXT_FIELD) is
		local
			a_context: CONTEXT;
			context_group: LINKED_LIST [CONTEXT];
			new_group: GROUP;
			found: BOOLEAN;
			a_name: STRING;
			mp: MOUSE_PTR
			a_group_c: GROUP_C;
			e_name: STRING;
			id: IDENTIFIER
		do
			a_name := argument.text;
			a_name.to_upper;
			if not a_name.empty and then
				dropped_stone /= Void 
			then
				if dropped_stone.data.deleted then
					set_label (" ");
					dropped_stone := Void;
				elseif not Context_catalog.has_group_name (a_name) then
					!! id.make (a_name.count);
					id.append (a_name);
					if id.is_valid then
						!!mp;
						mp.set_watch_shape;
						a_context := dropped_stone.data;
						if a_context.grouped then
							!! context_group.make;
							context_group.append (a_context.group)
						else
							!!context_group.make;
							context_group.put_right (a_context);
						end;
						a_group_c ?= a_context;
						if a_group_c = Void or else context_group.count /= 1 then
							!!new_group.make (a_name, context_group);
							set_label (" ");
						end;
						argument.set_text ("");
						dropped_stone := Void;
						mp.restore
					else
						error_box.popup (Current,
							Messages.invalid_group_class_name_er,
							a_name)
					end
				else
					error_box.popup (Current,
						Messages.group_name_exists_er,
						a_name)
				end;
			end;
		end;

	popuper_parent: COMPOSITE is
		do
			Result := Context_catalog
		end

end
