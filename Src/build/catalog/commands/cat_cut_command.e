
class CAT_CUT_COMMAND 

inherit

	CAT_CUT_ELEMENT
		rename 
			undo as parent_undo,
			redo as parent_redo,
			catalog_work as parent_work
		redefine
			element,
			page
		end;

	CAT_CUT_ELEMENT
		redefine
			undo, redo, catalog_work,
			element,
			page
		select
			undo, redo, catalog_work
		end;

	WINDOWS
		export
			{NONE} all
		end

feature {NONE}

	catalog: CMD_CATALOG is
		do
			Result := command_catalog
		end;

	element: CMD;

	page: COMMAND_PAGE;

	catalog_work is
		do
			parent_work;
			element.remove_class;
		end;

feature

	redo is
		do
			parent_redo
			element.remove_class;
		end;

	undo is
		do
			parent_undo;
			element.recreate_class;
		end;
			
end
