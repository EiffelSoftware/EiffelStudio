indexing

	description:	
		"Class text field in class tool.";
	date: "$Date$";
	revision: "$Revision$"

class CLASS_TEXT_FIELD

inherit

	TOOL_COMMAND
		redefine
			tool, execute
		end;
	TEXT_FIELD
		rename
			make as text_field_make
		end;
	SHARED_EIFFEL_PROJECT

creation

	make

feature -- Initialization

	make (a_parent: COMPOSITE; a_tool: CLASS_W) is
			-- Initialize the window.
		do
			text_field_make (name, a_parent);
			!! new_class_win.make (a_tool);
			add_activate_action (Current, Void);
			init_from_tool (a_tool);
		end;

feature -- Properties

	new_class_win: NEW_CLASS_W;
			-- New window for a class tool.

	tool: CLASS_W;
			-- Class tool

	name: STRING is "change class"

feature -- Updating

	update_choice_position is
			-- Update the text area after a resize
		do
			if choice /= Void then
				choice.update_position
			end;
		end;

	update_text is
			-- Update the text area after a resize
		do
			set_text (text)
		end;

feature -- Closure

	close_choice_window is
		do
			if choice /= Void then	
				choice.popdown
			end
		end

feature {NONE} -- Implementation

	choice: CHOICE_W;
			-- Window for user choices.

feature {NONE} -- Execution

	execute (arg: ANY) is
			-- Execute the command.
		local
			classi_stone: CLASSI_STONE;
			classc_stone: CLASSC_STONE;
			cname, class_name: STRING;
			class_names: SORTED_TWO_WAY_LIST [STRING];
			clusters: LINKED_LIST [CLUSTER_I];
			classes: EXTEND_TABLE [CLASS_I, STRING];
			class_i: CLASS_I;
			mp: MOUSE_PTR
		do
			if (choice /= Void) and then (arg = choice) then
				if choice.position /= 1 then
					set_text (choice.selected_item);
					execute (Void)
				end
			elseif project_initialized then
				cname := clone (text);
				cname.left_adjust;
				cname.right_adjust;
				if not cname.empty then
					cname.to_lower;
					!! mp.set_watch_cursor;
					if cname.item (cname.count) = '*' then
						!! class_names.make;
						cname.head (cname.count - 1);
						from
							clusters := Eiffel_universe.clusters;
							clusters.start
						until
							clusters.after
						loop
							from
								classes := clusters.item.classes;
								classes.start
							until
								classes.after
							loop
								class_name := classes.key_for_iteration;
								if 
									cname.empty or else
									(class_name.count >= cname.count and then
									class_name.substring 
											(1, cname.count).is_equal (cname))
								then
									class_name := clone (class_name);
									class_name.to_upper;
									class_names.put_front (class_name)
								end;
								classes.forth
							end;
							clusters.forth
						end;
						class_names.sort;
						if choice = Void then
							!! choice.make_with_widget (parent, Current)
						end;
						choice.popup (Current, class_names)
					else
						class_i := Eiffel_universe.class_with_name (cname);	
						if class_i /= Void then
							if class_i.compiled then
								!! classc_stone.make (class_i.compiled_eclass)
								tool.process_class (classc_stone);
							else
								!! classi_stone.make (class_i)
								tool.process_classi (classi_stone);
							end;
						else
							new_class_win.call (cname, tool.cluster)
						end
					end;
					mp.restore
				else
					warner (popup_parent).gotcha_call (w_Specify_a_class)
				end
			end
		end;

	work (arg: ANY) is
		do
		end;

end -- class CLASS_TEXT_FIELD
