-- Command to display values of attributes of a given object. 

class 

	SHOW_ATTR_VALUES

inherit

	FORMATTER;
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
			Result := bm_Showattributes 
		end;
	
feature {NONE}

	command_name: STRING is do Result := l_Showattributes end;

	title_part: STRING is do Result := l_Attrvalues_of end;

	dynamic_class: CLASS_C;
			-- Class associated with dynamic type of object being inspected

	display_info (i: INTEGER; object: OBJECT_STONE) is
		local
			attr_request: ATTR_REQUEST;
			attributes: LIST [ATTRIBUTE];
			type_name: STRING
		do
			if Run_info.is_running and Run_info.is_stopped then
				!! attr_request.make (object.object_address);
				attr_request.send;
				dynamic_class := object.dynamic_class;
				type_name := clone (dynamic_class.class_name);
				type_name.to_upper;
				text_window.put_clickable_string (dynamic_class.stone, type_name);
				text_window.put_string (" [");
				text_window.put_clickable_string (object, object.object_address);
				text_window.put_char (']');
				text_window.new_line;
				text_window.new_line;
				attributes := attr_request.attributes;
				from
					attributes.start
				until
					attributes.after
				loop
					attributes.item.append_attribute (text_window, 1);
					attributes.forth
				end
			end
		end;

end -- class SHOW_ATTR_VALUES
