indexing

	description:	
		"Command to display values of attributes of a given object.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_ATTR_VALUES

inherit

	FILTERABLE
		redefine
			tool, display_temp_header
		end;
	SHARED_APPLICATION_EXECUTION

creation

	make

feature -- Properties

	tool: OBJECT_W;
			-- Tool of inspected object

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := Pixmaps.bm_Showattributes 
		end;
	
feature {NONE} -- Properties

	name: STRING is
		do
			Result := Interface_names.f_Showattributes
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showattributes
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	title_part: STRING is
		do
			Result := Interface_names.t_Attrvalues_of
		end;

	create_structured_text (object: OBJECT_STONE): STRUCTURED_TEXT is
		local
			obj: DEBUGGED_OBJECT;
			attributes: LIST [ABSTRACT_DEBUG_VALUE];
			type_name: STRING;
			is_special: BOOLEAN;
			dynamic_class: CLASS_C;
			status: APPLICATION_STATUS;
		do
			status := Application.status;
			if status = Void then
				warner (popup_parent).gotcha_call (Warning_messages.w_System_not_running)
			elseif not status.is_stopped then
				warner (popup_parent).gotcha_call (Warning_messages.w_System_not_stopped)
			else
				!! Result.make;
				!! obj.make (object.object_address,
					tool.sp_lower, tool.sp_upper);
				attributes := obj.attributes;
				is_special := obj.is_special;
				tool.set_sp_capacity (obj.max_capacity);
				dynamic_class := object.dynamic_class;
				type_name := clone (dynamic_class.name);
				type_name.to_upper;
				Result.add_classi (dynamic_class.lace_class, type_name);
				Result.add_string (" [");
				Result.add_address (object.object_address, object.name, dynamic_class);
				Result.add_char (']');
				Result.add_new_line;
				Result.add_new_line;
				if 
					is_special and then (attributes.is_empty or else 
					attributes.first.name.to_integer > 0) 
				then
					Result.add_indent;
					Result.add_string ("... Items skipped ...");
					Result.add_new_line
				end;
				from
					attributes.start
				until
					attributes.after
				loop
					attributes.item.append_to (Result, 1);
					attributes.forth
				end;
				if 
					is_special and then (attributes.is_empty or else 
					attributes.last.name.to_integer < obj.capacity - 1)
				then
					Result.add_indent;
					Result.add_string ("... More items ...");
					Result.add_new_line
				end
			end
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Looking up fields...")
		end;

end -- class SHOW_ATTR_VALUES
