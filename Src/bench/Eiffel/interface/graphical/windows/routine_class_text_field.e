indexing

	description:	
		"Class text field in routine tool."
	date: "$Date$";
	revision: "$Revision$"

class ROUTINE_CLASS_TEXT_FIELD

inherit

	TOOL_COMMAND
		redefine
			tool, execute
		end
	TEXT_FIELD
		rename
			make as text_field_make
		end;
	SHARED_EIFFEL_PROJECT;
	NAMER

creation

	make

feature -- Initialization

	make (a_parent: COMPOSITE; a_tool: ROUTINE_W) is
			-- Initialize the text field "Class_name".
			-- Set up the activate actions.
		do
			text_field_make (name, a_parent);
			add_activate_action (Current, Void);
			init (a_tool)
		end;

feature -- Updating

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

	update_text is
			-- Update the text area after a resize
		do
			set_text (text)
		end;

	update_choice_position is
			-- Update the position of the choice window.
		do
			if choice /= Void then
				choice.update_position
			end
		end;

feature -- Properties

	tool: ROUTINE_W;
			-- Tool of the routine.

	name: STRING is "change routine";

feature -- Closure

	close_choice_window is
		do
			if choice /= Void then
				choice.popdown
			end
		end

	popup_choice_window is
			-- Popup the choice window for text field.
		do
			execute (Void)
		end

feature {ROUTINE_TEXT_FIELD} -- Implementation

	execute (arg: ANY) is
			-- Execution of the command.
		local
			stone: CLASSC_STONE;
			cname, class_name: STRING;
			clusters: LINKED_LIST [CLUSTER_I];
			classes: EXTEND_TABLE [CLASS_I, STRING];
			sorted_classes: SORTED_TWO_WAY_LIST [CLASS_I];
			mp: MOUSE_PTR;
			choice_position: INTEGER;
			class_i: CLASS_I;
			at_pos: INTEGER;
			cluster_name: STRING;
			cluster: CLUSTER_I;
			pattern: STRING_PATTERN
		do
			if (choice /= Void) and then arg = choice then
				check
					class_list /= Void
				end;
				choice_position := choice.position;
				if choice_position /= 0 then
					class_i := class_list.i_th (choice_position);
					class_list := Void;
					cname := clone (class_i.class_name);
					cname.to_upper;
					set_text (cname);
					execute (class_i)
				else
					close_choice_window
				end
				class_list := Void;
			else
				class_i ?= arg;
				if class_i = Void then
					cname := clone (text);
					cname.left_adjust;
					cname.right_adjust;
					if cname.empty then
						warner (popup_parent).gotcha_call (w_Specify_a_class)
					else
						cname.to_lower;
						!! pattern.make (0);
						pattern.append (cname);
						if not pattern.has_wild_cards then
							!! mp.set_watch_cursor;
							at_pos := cname.index_of ('@', 1);
							if at_pos = 0 then
								class_list := Eiffel_universe.compiled_classes_with_name (cname);
								mp.restore;
								if class_list.empty then
									class_list := Void;
									warner (popup_parent).gotcha_call (w_Cannot_find_class (cname))
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
									warner (popup_parent).gotcha_call (w_Cannot_find_cluster (cluster_name))
								else
									class_i := cluster.classes.item (cname)
									if class_i = Void then
										warner (popup_parent).gotcha_call (w_Cannot_find_class (cname))
									end
								end
							end
						else
							!! mp.set_watch_cursor;
							!! sorted_classes.make;
							cname.head (cname.count - 1);
							clusters := Eiffel_universe.clusters;
							from clusters.start until clusters.after loop
								classes := clusters.item.classes;
								from
									classes.start
								until
									classes.after
								loop
									class_name := classes.key_for_iteration;
									class_i := classes.item_for_iteration
									if
										class_i.compiled and
										pattern.matches (class_name)
									then
										sorted_classes.put_front (class_i)
									end;
									classes.forth
								end;
								clusters.forth
							end;
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
					!! stone.make (class_i.compiled_eclass);
					tool.routine_text_field.execute (stone);
					close_choice_window
				end
			end
		end;

feature {NONE} -- Implementation

	work (arg: ANY) is
			-- Work that is to be done for the command.
		do
		end;

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
				cname := clone (class_i.class_name);
				if
					last_class /= Void and then
					last_class.class_name.is_equal (cname)
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
			choice.popup (Current, class_names)
		end

	choice: CHOICE_W;
			-- Window where the user can make his/her choices.

	class_list: LINKED_LIST [CLASS_I];
			-- List of compiled classes displayed in `choice'

end -- class ROUTINE_CLASS_TEXT_FIELD
