indexing

	description:	
		"Command to display the the class history of a feature.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_ROUT_HIST

inherit

	FILTERABLE
		redefine
			display_temp_header
		end

	SHARED_SERVER

creation

	make
	
feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := Pixmaps.bm_Showhistory
		end;
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := Interface_names.f_Showhistory
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showhistory
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	title_part: STRING is
		do
			Result := Interface_names.t_History
		end;

	create_structured_text (f: FEATURE_STONE): STRUCTURED_TEXT is
			-- Display history of `f'.
		local
			cmd: E_SHOW_ROUTINE_IMPLEMENTERS;
		do
			!! cmd.make (f.e_feature);
			if cmd.has_valid_feature then
				cmd.execute;
				Result := cmd.structured_text
			end;
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching system for implementers...")
		end;

end -- class SHOW_ROUT_HIST
