indexing

	description: 
		"All cursors used in EiffelCase.";
	date: "$Date$";
	revision: "$Revision$"

class CURSORS

inherit

	CONSTANTS;
	CURSOR_TYPE
		export
			{NONE} all
		end;

feature -- Properties

	aggreg_cursor: SCREEN_CURSOR is
			-- Cursor representing an aggregation
		once
			Result := pixmap_cursor ("aggreg.cur")
		end; 

	argument_cursor: SCREEN_CURSOR is
			-- Cursor representing an argument
		once
			Result := pixmap_cursor ("argument.cur")
		end; 

	class_cursor: SCREEN_CURSOR is
			-- Cursor representing an aggregation
		once
			Result := pixmap_cursor ("class.cur")
		end;

	cluster_cursor: SCREEN_CURSOR is
			-- Cursor representing an aggregation
		once
			Result := pixmap_cursor ("cluster.cur")
		end;

	client_cursor: SCREEN_CURSOR is
			-- Cursor representing a client/supplier relation
		once
			Result := pixmap_cursor ("client.cur")
		end; 

	color_cursor: SCREEN_CURSOR is
			-- Cursor representing a color
		once
			Result := pixmap_cursor ("color.cur")
		end; 

	comment_cursor: SCREEN_CURSOR is
			-- Cursor representing comments
		once
			Result := pixmap_cursor ("comment.cur")
		end; 

	command_cursor: SCREEN_CURSOR is
			-- Cursor representing a command
		once
			Result := pixmap_cursor ("command.cur")
		end; 

	comp_client_cursor: SCREEN_CURSOR is
			-- Cursor representing a compressed client relation
		once
			Result := pixmap_cursor ("compcli.cur")
		end; 

	comp_inherit_cursor: SCREEN_CURSOR is
			-- Cursor representing a compressed inheritance relation
		once
			Result := pixmap_cursor ("compinh.cur")
		end; 

	constraint_cursor: SCREEN_CURSOR is
			-- Cursor representing a constraint
		once
			Result := pixmap_cursor ("constr.cur")
		end; 

	feature_cursor: SCREEN_CURSOR is
			-- Cursor representing a feature
		once
			Result := pixmap_cursor ("feature.cur")
		end; 

	feature_clause_cursor: SCREEN_CURSOR is
			-- Cursor representing a feature clause
		once
			Result := pixmap_cursor ("featclau.cur")
		end;

	generic_cursor: SCREEN_CURSOR is
			-- Cursor representing a generic class
		once
			Result := pixmap_cursor ("generic.cur")
		end; 

	group_cursor: SCREEN_CURSOR is
			-- Cursor representing a group of stones 
		once
			Result := pixmap_cursor ("group.cur")
		end; 

	handle_cursor: SCREEN_CURSOR is
			-- Cursor representing a handle
		once
			Result := pixmap_cursor ("handle.cur")
		end; 

	index_cursor: SCREEN_CURSOR is
			-- Cursor representing an index
		once
			Result := pixmap_cursor ("index.cur")
		end; 

	inherit_cursor: SCREEN_CURSOR is
			-- Cursor representing an inheritance relation
		once
			Result := pixmap_cursor ("inherit.cur")
		end; 

	invariant_cursor: SCREEN_CURSOR is
			-- Cursor representing an invariant
		once
			Result := pixmap_cursor ("invarnt.cur")
		end; 

	move_cursor: SCREEN_CURSOR is
			-- Cursor representing a move cursor
		once
			!!Result.make;
			Result.set_type (Fleur)
		--	Result := pixmap_cursor ("moove.bmp")
		end;

	resize_cursor: SCREEN_CURSOR is
		once
			!!Result.make;
			Result.set_type (Bottom_right_corner)
		--	Result := pixmap_cursor ("resiz.cur")
		end;

	new_class_cursor: SCREEN_CURSOR is
			-- Cursor representing an aggregation
		once
			Result := pixmap_cursor ("newclass.cur")
		end; 

	new_cluster_cursor: SCREEN_CURSOR is
			-- Cursor representing an aggregation
		once
			Result := pixmap_cursor ("newclust.cur")
		end; 

	precondition_cursor: SCREEN_CURSOR is
			-- Cursor representing precondition
		once
			Result := pixmap_cursor ("precond.cur")
		end; 

	postcondition_cursor: SCREEN_CURSOR is
			-- Cursor representing a postcondition
		once
			Result := pixmap_cursor ("postcond.cur")
		end; 

	query_cursor: SCREEN_CURSOR is
			-- Cursor representing a query
		once
			Result := pixmap_cursor ("query.cur")
		end; 

	rename_cursor: SCREEN_CURSOR is
			-- Cursor representing a rename clause
		once
			Result := pixmap_cursor ("rename.cur")
		end;

	result_cursor: SCREEN_CURSOR is
			-- Cursor representing result data
		once
			Result := pixmap_cursor ("result.cur")
		end; 

	version_cursor: SCREEN_CURSOR is
			-- Cursor representing a version
		once
			Result := pixmap_cursor ("version.cur")
		end; 

	watch_cursor: SCREEN_CURSOR is
			-- Cursor representing a watch
		once
			!!Result.make;
			Result.set_type (Watch)
		end;

feature {NONE} -- Implementation

	pixmap_cursor (file_name: STRING): SCREEN_CURSOR is
		require
			file_name_exists: file_name /= void
		local
			full_name: FILE_NAME
			p: PIXMAP
		do
			!! full_name.make_from_string (Environment.bitmap_directory);
			full_name.set_file_name (file_name);
			!! p.make;
			p.read_from_file (full_name);
			!! Result.make;
			if not p.is_valid then
				io.error.putstring ("EiffelCase: Can not read bitmap file%N");
				io.error.putstring (full_name);
				io.error.putstring (".%N");
			else
				Result.set_pixmap (p, Void);
			end;
		end;

end -- class CURSORS
