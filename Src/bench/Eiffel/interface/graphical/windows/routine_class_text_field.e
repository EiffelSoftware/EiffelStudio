indexing
	description: "Class text field in routine tool."
	date: "$Date$";
	revision: "$Revision$"

class ROUTINE_CLASS_TEXT_FIELD

inherit

	WINDOWS;
	EB_CONSTANTS;
	COMMAND;
	TEXT_FIELD
		rename
			make as text_field_make
		export
			{NAVIGATE_CMD} implementation
			{ROUTINE_W} toolkit		
		end;
	SHARED_EIFFEL_PROJECT

creation

	make

feature -- Initialization

	make (a_parent: COMPOSITE; a_tool: ROUTINE_W) is
			-- Initialize the text field "Class_name".
			-- Set up the activate actions.
		local
			debug_tip_cmd: DEBUG_TOOLTIP_CMD
		do
			text_field_make ("", a_parent);
			!! debug_tip_cmd.make (implementation)
			add_activate_action (Current, Void);
			tool := a_tool
		end;

feature -- Properties
	
	debug_tab (previous_tab: TEXT_FIELD) is
			-- manually fix the keyboard navigation with tab
		local
			navigate_tab_cmd: NAVIGATE_CMD
		do
			if not toolkit.name.is_equal ("MS_WINDOWS") then
				!! navigate_tab_cmd.make (previous_tab)
				set_action ("<Key>Tab", navigate_tab_cmd, Void)
				set_action ("Shift<Key>Tab", navigate_tab_cmd, Void)
			end
		end

	tool: ROUTINE_W;
			-- Tool of the routine.

feature -- Updating

	update_choice_position is
			-- Update the position of the choice window.
		do
			if choice /= Void then
				choice.update_position
			end
		end;

	update_text is
			-- Update the text area after a resize
		do
			set_text (text)
		end;

	update_class_name (n: STRING) is
			-- Redisplay the class name.
		require
			valid_n: n /= Void
		local
			temp: STRING
		do
			temp := clone (n);
			temp.to_upper;
			set_text (temp);
		end

feature -- Closure

	close_choice_window is
		do
			if choice /= Void then
				choice.popdown
			end
		end

feature {NONE} -- Implementation

	choice: CHOICE_W;
			-- Window where the user can make his/her choices.

	class_list: LINKED_LIST [CLASS_I];
			-- List of compiled classes displayed in `choice'


feature {ROUTINE_TEXT_FIELD} -- Implementation

	execute (arg: ANY) is
			-- Execution of the command.
		local
			stone: CLASSC_STONE;
			cname: STRING;
			sorted_classes: SORTED_TWO_WAY_LIST [CLASS_I];
			mp: MOUSE_PTR;
			choice_position: INTEGER;
			class_i: CLASS_I;
			at_pos: INTEGER;
			cluster_name: STRING;
			cluster: CLUSTER_I;
			matcher: KMP_WILD
			classes: ARRAY [CLASS_C]
			class_c: CLASS_C
			i, nb: INTEGER
		do
			if (choice /= Void) and then arg = choice then
				check
					class_list /= Void
				end;
				choice_position := choice.position;
				if choice_position /= 0 then
					class_i := class_list.i_th (choice_position);
					class_list := Void;
					cname := clone (class_i.name);
					cname.to_upper;
					set_text (cname);
					execute (class_i)
				end
				class_list := Void;
			elseif Eiffel_project.initialized and then Eiffel_project.system /= Void then
				class_i ?= arg;
				if class_i = Void then
					cname := clone (text);
					cname.left_adjust;
					cname.right_adjust;
					if cname.is_empty then
						warner (tool.popup_parent).gotcha_call (Warning_messages.w_Specify_a_class)
					else
						cname.to_lower;
						create matcher.make_empty
						matcher.set_pattern (cname);
						if not matcher.has_wild_cards then
							!! mp.set_watch_cursor;
							at_pos := cname.index_of ('@', 1);
							if at_pos = 0 then
								class_list := Eiffel_universe.compiled_classes_with_name (cname);
								mp.restore;
								if class_list.is_empty then
									class_list := Void;
									warner (tool.popup_parent).gotcha_call
										(Warning_messages.w_Cannot_find_class (cname))
								elseif class_list.count = 1 then
									class_i := class_list.first;
									class_list := Void
								else
									display_choice
								end
							elseif at_pos = cname.count then
								cname.head (cname.count - 1);
								set_text (cname);
								execute (Void)
							else
								cluster_name := cname.substring (at_pos + 1, cname.count)
								if at_pos > 1 then
									cname := cname.substring (1, at_pos - 1)
								else
									cname := ""
								end;
								cluster := Eiffel_universe.cluster_of_name (cluster_name);
								mp.restore;
								if cluster = Void then
									warner (tool.popup_parent).gotcha_call 
										(Warning_messages.w_Cannot_find_cluster (cluster_name))
								else
									class_i := cluster.classes.item (cname)
									if class_i = Void then
										warner (tool.popup_parent).gotcha_call 
											(Warning_messages.w_Cannot_find_class (cname))
									end
								end
							end
						else
							!! mp.set_watch_cursor;
							!! sorted_classes.make;
							from
								classes := Eiffel_system.system.classes
								i := classes.lower
								nb := classes.upper
							until
								i > nb
							loop
								class_c := classes.item (i)
								if class_c /= Void then
									matcher.set_text (class_c.lace_class.name)
									if matcher.search_for_pattern then
										sorted_classes.put_front (class_c.lace_class)
									end
								end
								i := i + 1
							end

							class_i := Void;
							sorted_classes.sort;
							class_list := sorted_classes;
							mp.restore;
							display_choice
						end
					end
				end;	
				if class_i /= Void then
					check
						class_i.compiled
					end
					!! stone.make (class_i.compiled_class);
					tool.routine_text_field.execute (stone);
				end
			end
		end;

feature {NONE} -- Implementation

	display_choice is
				-- Display class names from `class_list' to `choice'.
		require
			class_list_not_void: class_list /= Void
		local
			class_names: ARRAYED_LIST [STRING];
			class_i, last_class: CLASS_I;
			cname, last_name: STRING
			first_ambiguous: BOOLEAN
		do
			!! class_names.make (class_list.count);
			from class_list.start until class_list.after loop
				class_i := class_list.item;
				cname := clone (class_i.name);
				if
					last_class /= Void and then
					last_class.name.is_equal (cname)
				then
					if not first_ambiguous then
						first_ambiguous := True
						last_name := class_names.last;
						last_name.extend ('@');
						last_name.append (last_class.cluster.cluster_name)
					end
					cname.to_upper;
					cname.extend ('@');
					cname.append (class_i.cluster.cluster_name)
				else
					cname.to_upper;
					first_ambiguous := False
				end;
				class_names.extend (cname);
				last_class := class_i;
				class_list.forth
			end;
			if choice = Void then
				!! choice.make_with_widget (parent, Current)
			end;
			choice.popup (Current, class_names, Interface_names.t_Select_class)
		end

end -- class ROUTINE_CLASS_TEXT_FIELD
