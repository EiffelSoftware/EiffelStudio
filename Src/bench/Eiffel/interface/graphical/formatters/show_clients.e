indexing

	description:	
		"Command to display class clients.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_CLIENTS 

inherit

	FILTERABLE
		redefine
			display_temp_header, post_fix
		end

create

	make

feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := Pixmaps.bm_Showclients 
		end;
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := Interface_names.f_Showclients
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showclients
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	title_part: STRING is
		do
			Result := Interface_names.t_Clients_of
		end;

	post_fix: STRING is "clt";

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
		local
			cmd: E_SHOW_CLIENTS
		do
			create cmd.make (c.e_class);
			cmd.execute;
			Result := cmd.structured_text
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching for clients...")
		end;

end -- class SHOW_CLIENTS
