indexing

	description:	
		"Command to display results (if any) of once %
		%functions relevant to a given object.";
	date: "$Date$";
	revision: "$Revision$"

class 

	SHOW_ONCE_RESULTS 

inherit
	FILTERABLE
		redefine
			display_temp_header
		end

	SHARED_APPLICATION_EXECUTION

create

	make

feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := Pixmaps.bm_Showonces 
		end;
	
feature {NONE} -- Properties

	name: STRING is
		do
			Result := Interface_names.f_Showoncefunc
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showoncefunc
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	title_part: STRING is
		do
			Result := Interface_names.t_Oncefunc_of
		end;

	criterium (f: E_FEATURE): BOOLEAN is
			-- `f' is a once function and `f' is written in a descendant of ANY
			-- or the object is a direct instance of a parent of ANY
		require
			f_exists: f /= Void
		do
			Result := f.is_once and f.is_function
		end;

	create_structured_text (object: OBJECT_STONE): STRUCTURED_TEXT is
		do
			create Result.make;
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Finding values of once functions...")
		end;

end -- class SHOW_ONCE_RESULTS
