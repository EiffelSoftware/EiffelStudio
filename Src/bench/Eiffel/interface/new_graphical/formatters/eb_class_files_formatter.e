indexing
	description: "Command to display classes of a cluster"
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_FILES_FORMATTER

inherit
	EB_FILTERABLE
		redefine
			display_temp_header, post_fix
		end

creation
	make

feature -- Properties

	symbol: EV_PIXMAP is 
		once 
			Result := Pixmaps.bm_Showclusters 
		end
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := Interface_names.f_Showclusters
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showclusters
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	title_part: STRING is
		do
			Result := Interface_names.t_Clusters_of
		end

	post_fix: STRING is "clf"

feature {NONE} -- Attributes

	create_structured_text (c: CLUSTER_STONE): STRUCTURED_TEXT is
			-- Show universe: clusters in class lists.
		local
			cmd: E_SHOW_CLASS_FILES
		do
			create cmd.make (c.cluster_i)
			cmd.execute
			Result := cmd.structured_text
		end

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Exploring the cluster...")
		end

end -- class EB_CLASS_FILES_FORMATTER
