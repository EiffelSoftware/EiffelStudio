indexing

	description: "Stone that represents a feature as well as a comment%
				 %in a class chart. Drag-and-dropping will identify%
		 		 %it as a feature, renaming will rename the comment.";
	date: "$Date$";
	revision: "$Revision $"

class CHART_FEATURE_STONE

inherit
		
	EXP_FEATURE_STONE
		redefine
		--	set, setup_namer
		end;

creation

	make

feature -- Setting

--	set (namer: NAMER_WINDOW) is
--			-- Set information from `namer'.
--		local
--			new_comments: FEATURE_COMMENT_DATA;
--			replace_command: REPLACE_DATA_U;
--		do
--			new_comments := clone (data.comments);
--			new_comments.update_from_namer (namer);
--			!! replace_command.make (data, data.comments, new_comments);
--		end;
--
--	setup_namer (namer: NAMER_WINDOW) is
--			-- Setup `namer' from data comments.
--		do
--			data.comments.setup_namer (namer);
--		end;

end -- class CHART_FEATURE_STONE
