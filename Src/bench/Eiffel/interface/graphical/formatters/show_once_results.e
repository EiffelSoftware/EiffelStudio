-- Command to display results (if any) of once functions relevant
-- to a given object. 

class 

	SHOW_ONCE_RESULTS 

inherit

	FORMATTER
		redefine
			dark_symbol
		end;
	SHARED_DEBUG

creation

	make

feature 

	make (c: COMPOSITE; a_text_window: OBJECT_TEXT) is
		do
			init (c, a_text_window);
			indent := 2
		end;

	symbol: PIXMAP is 
		once 
			Result := bm_Showonces 
		end;
	
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showonces 
		end;
	
feature {NONE}

	command_name: STRING is do Result := l_Showoncefunc end;

	title_part: STRING is do Result := l_Oncefunc_of end;

	dynamic_class: CLASS_C;
			-- Class associated with dynamic type of object being inspected

	display_info (i: INTEGER; object: OBJECT_STONE) is
		local
			feature_table: FEATURE_TABLE;
			once_func_list: PART_SORTED_TWO_WAY_LIST [FEATURE_I];
			once_request: ONCE_REQUEST;
			arguments: FEAT_ARG;
			feature_i: FEATURE_I;
			type_name: STRING
		do
			if not Run_info.is_running then
				warner.set_window (text_window);
				warner.gotcha_call ("Application is not running")
			elseif not Run_info.is_stopped then
				warner.set_window (text_window);
				warner.gotcha_call ("Application is not stopped")
			else
				dynamic_class := object.dynamic_class;
				feature_table := dynamic_class.feature_table;
				!! once_func_list.make;
				!! once_request.make;
				from
					feature_table.start
				until
					feature_table.after
				loop
					feature_i := feature_table.item_for_iteration;
					if criterium (feature_i) then
						once_func_list.extend (feature_i)
					end
				feature_table.forth
				end;
				type_name := clone (dynamic_class.class_name);
				type_name.to_upper;
				text_window.put_clickable_string (dynamic_class.stone, type_name);
				text_window.put_string (" [");
				text_window.put_clickable_string (object, object.object_address);
				text_window.put_char (']');
				text_window.new_line;
				text_window.new_line;
				from
					once_func_list.start
				until
					once_func_list.after
				loop
					text_window.put_string (tabs (1));
					feature_i := once_func_list.item;
					feature_i.append_clickable_name (text_window, dynamic_class);
					arguments := feature_i.arguments;
					if arguments /= Void then
						text_window.put_string (" (");
						from
							arguments.start
						until
							arguments.after
						loop
							text_window.put_string (arguments.argument_names.i_th (arguments.index));
							text_window.put_string (": ");
							arguments.item.actual_type.append_clickable_signature (text_window);
							arguments.forth;
							if not arguments.after then
								text_window.put_string ("; ")
							end
						end;
						text_window.put_char (')')
					end;
					text_window.put_string (": ");
					if once_request.already_called (feature_i) then
						once_request.once_result (feature_i).append_value (text_window)
					else
						feature_i.type.append_clickable_signature (text_window);
						text_window.put_string ("%TNot yet called")
					end;
					text_window.new_line;
					once_func_list.forth
				end
			end
		end;

	criterium (f: FEATURE_I): BOOLEAN is
			-- `f' is a once function and `f' is written in a descendant of ANY
			-- or the object is a direct instance of a parent of ANY
		require
			f_exists: f /= Void
		do
			Result := (f.written_class > System.any_class.compiled_class or
					dynamic_class <= System.any_class.compiled_class)
					and then (f.is_once and f.is_function)
		end;

end -- class SHOW_ONCE_RESULTS
