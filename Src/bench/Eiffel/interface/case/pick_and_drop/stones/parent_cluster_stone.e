indexing

	description:
		"Stone of the Parent Cluster";
	date: "$Date$";
	revision: "$Revision$"

class PARENT_CLUSTER_STONE

	inherit
		CLUSTER_STONE
			redefine
			--	set
			end

	creation
		make_parent


	feature
		-- Creation

		make_parent (a_data: like data ; c : CLASS_DATA ) is
			-- Set data to `a_data'.
		do
			make ( a_data )
			
			class_data	:= c

		ensure
			data_set: data = a_data
		end;

	feature
		-- properties

		class_data	: CLASS_DATA

	feature
		-- Redefinition

		--set (namer: NAMER_WINDOW) is
		--	-- Set information from `namer'.
		--local
		--	txt: STRING
		--	cluster	: CLUSTER_DATA
		--	
		--do
--			txt := namer.entered_text;
--			txt.to_upper;
--			if not txt.empty and then not txt.is_equal (data.name) then
--				if System.has_cluster (txt) then
--					class_data.put_in_cluster ( system.cluster_of_name ( txt ) )
--					windows.update_class_windows
--					workareas.update_drawing
--				else
--					namer.display_error_message
--						(Message_keys.cluster_doesnt_exists_er, txt)
--				end
--			end
		--end
	

end -- class PARENT_CLUSTER_STONE
