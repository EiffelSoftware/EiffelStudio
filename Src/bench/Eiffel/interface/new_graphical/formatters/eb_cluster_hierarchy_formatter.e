indexing
	description: "Command to display the cluster hierarchy in the universe."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLUSTER_HIERARCHY_FORMATTER

inherit
	EB_FILTERABLE
		redefine
			display_temp_header, post_fix
		end

creation

	make
	
feature -- Properties

--	symbol: EV_PIXMAP is 
--			-- Pixmap for the button.
--		once 
--			Result := Pixmaps.bm_Showcluster_hier_list 
--		end
 
feature {NONE} -- Properties

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Show_cluster_heir_list
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Show_cluster_heir_list
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	title_part: STRING is
		do
			Result := Interface_names.t_Clusters_hierarchy
		end

	post_fix: STRING is "hie"

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
			-- Show universe: classes in alphabetical order.
		local
			cmd: E_SHOW_CLUSTER_HIERARCHY
		do
			create cmd.make
			cmd.execute
			Result := cmd.structured_text
		end

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Exploring clusters...")
		end

end -- class EB_CLUSTER_HIERARCHY_FORMATTER
