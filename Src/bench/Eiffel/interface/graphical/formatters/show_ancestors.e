indexing

	description:	
		"Command to display class ancestors.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_ANCESTORS 

inherit

	FILTERABLE
		redefine
			display_temp_header, post_fix
		end

create

	make
	
feature -- Properties

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := Pixmaps.bm_Showancestors 
		end;
 
feature {NONE} -- Properties

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Showancestors
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showancestors
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	title_part: STRING is
		do
			Result := Interface_names.t_Ancestors_of
		end;

	post_fix: STRING is "anc";

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
			-- Display parents of `c' in tree form.
		local
			cmd: E_SHOW_ANCESTORS;
		do
			create cmd.make (c.e_class);
			cmd.execute;
			Result := cmd.structured_text
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching for ancestors...")
		end;

end -- class SHOW_ANCESTORS
