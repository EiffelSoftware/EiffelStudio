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

create

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
		do
			create Result.make;
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Looking up fields...")
		end;

end -- class SHOW_ATTR_VALUES
