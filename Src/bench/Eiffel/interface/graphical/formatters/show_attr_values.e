-- Command to display values of attributes of a given object. 

class 

	SHOW_ATTR_VALUES

inherit

	FORMATTER
		redefine
			dark_symbol, text_window, display_temp_header
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

	text_window: OBJECT_TEXT;

	symbol: PIXMAP is 
		once 
			Result := bm_Showattributes 
		end;
	
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showattributes 
		end;
	
feature {NONE}

	command_name: STRING is do Result := l_Showattributes end;

	title_part: STRING is do Result := l_Attrvalues_of end;

	display_info (object: OBJECT_STONE) is
		local
			obj: DEBUGGED_OBJECT;
			attributes: LIST [DEBUG_VALUE];
			type_name: STRING;
			is_special: BOOLEAN;
			dynamic_class: E_CLASS;
			status: APPLICATION_STATUS;
			stone: CLASSC_STONE
		do
			status := Application.status;
			if status = Void then
				warner (text_window).gotcha_call (w_System_not_running)
			elseif not status.is_stopped then
				warner (text_window).gotcha_call (w_System_not_stopped)
			else
				!! obj.make (object.object_address,
					text_window.sp_lower, text_window.sp_upper);
				attributes := obj.attributes;
				is_special := obj.is_special;
				text_window.set_sp_capacity (obj.max_capacity);
				dynamic_class := object.dynamic_class;
				type_name := clone (dynamic_class.name);
				type_name.to_upper;
				!! stone.make (dynamic_class);
				text_window.put_stone (stone, type_name);
				text_window.put_string (" [");
				text_window.put_stone (object, object.object_address);
				text_window.put_char (']');
				text_window.new_line;
				text_window.new_line;
				if 
					is_special and then (attributes.empty or else 
					attributes.first.name.to_integer > 0) 
				then
					text_window.put_string ("%T... Items skipped ...");
					text_window.new_line
				end;
				from
					attributes.start
				until
					attributes.after
				loop
					attributes.item.append_to (text_window, 1);
					attributes.forth
				end;
				if 
					is_special and then (attributes.empty or else 
					attributes.last.name.to_integer < obj.capacity - 1)
				then
					text_window.put_string ("%T... More items ...");
					text_window.new_line
				end
			end
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Looking up fields...")
		end;

end -- class SHOW_ATTR_VALUES
