indexing

	description:	
		"Command to display the cluster hierarchy in the universe.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_CLUSTER_HIERARCHY 

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
			Result := Pixmaps.bm_Showcluster_hier_list 
		end;
 
feature {NONE} -- Properties

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Show_cluster_heir_list
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Show_cluster_heir_list
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	title_part: STRING is
		do
			Result := Interface_names.t_Clusters_hierarchy
		end;

	post_fix: STRING is "hie";

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
			-- Show universe: classes in alphabetical order.
		local
			cmd: E_SHOW_CLUSTER_HIERARCHY;
		do
			create cmd.make;
			cmd.execute;
			Result := cmd.structured_text
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Exploring clusters...")
		end;

end -- class SHOW_CLUSTER_HIERARCHY
