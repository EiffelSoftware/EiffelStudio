
class APPLICATION_STORER 

inherit

	STORABLE_HDL;
	SHARED_STORAGE_INFO;
	WINDOWS;
	SHARED_APPLICATION

feature 

	Return_transition: INTEGER is -1;

	Exit_transition: INTEGER is - 2;

	
feature {NONE}

	No_initial_circle: INTEGER is -1;
	
feature 

	has_initial_circle: BOOLEAN is 
		do
			Result := (initial_circle /= -1)
		end;

	stored_graph: INT_H_TABLE [HASH_TABLE [INTEGER, STRING]];

	initial_circle: INTEGER;

	stored_circles: LINKED_LIST [S_CIRCLE];

	stored_lines: LINKED_LIST [S_LINE];	

	file_name: STRING is
		do
			Result := Environment.application_file_name
		end;

	tmp_store (dir_name: STRING) is
		require
			valid_dir_name: dir_name /= Void
		local
			s_circle: S_CIRCLE;
			s_line: S_LINE;
			app_figures: APP_FIGURES;	
			app_lines: APP_LINES;
			app_circle: STATE_CIRCLE
		do
			if (app_editor.initial_state_circle = Void) then
				initial_circle := No_initial_circle;
			else
				initial_circle := app_editor.initial_state_circle.data.identifier
			end;
			build_stored_graph;
			!!stored_circles.make;
			from
				app_figures := app_editor.figures;
				app_figures.start
			until
				app_figures.after
			loop
				app_circle ?= app_figures.figure;
				if (app_circle = Void) then
					io.error.putstring ("Does not know how to store black boxes yet%N");
				end;
				!!s_circle.make (app_circle);
				stored_circles.extend (s_circle);
				app_figures.forth
			end;
			!!stored_lines.make;
			from
				app_lines := app_editor.lines;
				app_lines.start
			until
				app_lines.after
			loop
				!!s_line.make (app_lines.line);
				stored_lines.extend (s_line);
				app_lines.forth
			end;
			tmp_store_by_name (dir_name);
			stored_circles := Void;
			stored_lines := Void;
			stored_graph := Void
		end;

	
feature {NONE}

	build_stored_graph is
		local
			new_table: HASH_TABLE [INTEGER, STRING];
			subtab: HASH_TABLE [GRAPH_ELEMENT, STRING];
			s: BUILD_STATE;
			g: GRAPH_ELEMENT
		do
			!!stored_graph.make (Shared_app_graph.count);
			from
				Shared_app_graph.start
			until
				Shared_app_graph.off	
			loop
				s ?= Shared_app_graph.key_for_iteration;
				subtab := Shared_app_graph.item_for_iteration;
				!!new_table.make (subtab.count);
				stored_graph.put (new_table, s.identifier);
				from
					subtab.start
				until
					subtab.off
				loop
					g := subtab.item_for_iteration;
					if (g = Void) then
							-- It is a Return transition.
						new_table.put (Return_transition, subtab.key_for_iteration);
					elseif (g = Shared_app_graph.exit_element) then
							-- It is an Exit transition.
						new_table.put (Exit_transition, subtab.key_for_iteration);
					else
						s ?= g;
						new_table.put (s.identifier, subtab.key_for_iteration);
					end;
					subtab.forth
				end;
				Shared_app_graph.forth
			end;
		end;

	
feature 

	retrieve (dir_name: STRING) is
		local
			figures: APP_FIGURES;
			lines: APP_LINES;
			line: STATE_LINE;
			circle: STATE_CIRCLE
		do
			retrieve_by_name (dir_name);
			stored_circles := retrieved.stored_circles;
			stored_lines := retrieved.stored_lines;
			stored_graph := retrieved.stored_graph;
			initial_circle := retrieved.initial_circle;
			figures := app_editor.figures;
			from
				stored_circles.start
			until
				stored_circles.after
			loop
				circle := stored_circles.item.state_circle;
				figures.append (circle);	
				circle.set_center (stored_circles.item.center);
				stored_circles.forth
			end;
			lines := app_editor.lines;
			from
				stored_lines.start
			until
				stored_lines.after
			loop
				line := stored_lines.item.state_line;
				lines.drawing_list_append (line);	
				stored_lines.forth
			end;
		end;

	rebuild_graph is
		local
			new_table: HASH_TABLE [GRAPH_ELEMENT, STRING];	
			subtab: HASH_TABLE [INTEGER, STRING];
			void_element: GRAPH_ELEMENT;
			subtab_item: INTEGER
		do
			from
				stored_graph.start
			until
				stored_graph.off
			loop
				subtab := stored_graph.item_for_iteration;
				!!new_table.make (subtab.count);
				Shared_app_graph.put (new_table, 
					state_table.item (stored_graph.key_for_iteration));
				from
					subtab.start
				until
					subtab.off
				loop
					subtab_item := subtab.item_for_iteration;
					if (subtab_item = Return_transition) then
						new_table.put (void_element, 
							subtab.key_for_iteration);	
					elseif (subtab_item = Exit_transition) then
						new_table.put (Shared_app_graph.exit_element, 
							subtab.key_for_iteration);	
					else
						new_table.put (state_table.item (subtab_item), 
							subtab.key_for_iteration);
					end;
					subtab.forth
				end;
				stored_graph.forth
			end;
		end;

end
