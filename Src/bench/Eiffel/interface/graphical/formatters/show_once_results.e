-- Command to display results (if any) of once functions relevant
-- to a given object. 

class 

	SHOW_ONCE_RESULTS 

inherit

	FORMATTER
		redefine
			dark_symbol, display_temp_header
		end;
	SHARED_APPLICATION_EXECUTION

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

	display_info (object: OBJECT_STONE) is
		local
			once_func_list: SORTED_TWO_WAY_LIST [E_FEATURE];
			once_request: ONCE_REQUEST;
			arguments: E_FEATURE_ARGUMENTS;
			e_feature: E_FEATURE;
			dynamic_class: E_CLASS;
			type_name: STRING;
			status: APPLICATION_STATUS;	
			cs: CLASSC_STONE
		do
			status := Application.status;
			if status = void then
				warner (text_window).gotcha_call (w_System_not_running)
			elseif not status.is_stopped then
				warner (text_window).gotcha_call (w_System_not_stopped)
			else
				dynamic_class := object.dynamic_class;
				once_func_list := dynamic_class.once_functions;
				!! once_request.make;
				type_name := clone (dynamic_class.name);
				type_name.to_upper;
				!! cs.make (dynamic_class);
				text_window.put_stone (cs, type_name);
				text_window.put_string (" [");
				text_window.put_stone (object, object.object_address);
				text_window.put_char (']');
				text_window.new_line;
				text_window.new_line;
				from
					once_func_list.start
				until
					once_func_list.after
				loop
					text_window.put_string ("%T");
					e_feature := once_func_list.item;
					e_feature.append_name (text_window, dynamic_class);
					arguments := e_feature.arguments;
					if arguments /= Void then
						text_window.put_string (" (");
						from
							arguments.start
						until
							arguments.after
						loop
							text_window.put_string (arguments.argument_names.i_th (arguments.index));
							text_window.put_string (": ");
							arguments.item.actual_type.append_to (text_window);
							arguments.forth;
							if not arguments.after then
								text_window.put_string ("; ")
							end
						end;
						text_window.put_char (')')
					end;
					text_window.put_string (": ");
					if once_request.already_called (e_feature) then
						once_request.once_result (e_feature).append_type_and_value (text_window)
					else
						e_feature.type.append_to (text_window);
						text_window.put_string ("%TNot yet called")
					end;
					text_window.new_line;
					once_func_list.forth
				end
			end
		end;

	criterium (f: E_FEATURE): BOOLEAN is
			-- `f' is a once function and `f' is written in a descendant of ANY
			-- or the object is a direct instance of a parent of ANY
		require
			f_exists: f /= Void
		do
			Result := f.is_once and f.is_function
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Finding values of once functions...")
		end;

end -- class SHOW_ONCE_RESULTS
