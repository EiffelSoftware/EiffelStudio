
class CAT_ADD_COMMAND 

inherit

	CAT_ADD_ELEMENT
		rename 
			undo as parent_undo,
			redo as parent_redo,
			catalog_work as parent_work
		redefine
			element,
			page
		end;
	CAT_ADD_ELEMENT
		redefine
			undo, redo, catalog_work,
			element,
			page
		select
			undo, redo, catalog_work
		end;
	WINDOWS
	
feature {NONE}

	element: CMD;

	page: COMMAND_PAGE;

	catalog: CMD_CATALOG is
		do
			Result := command_catalog
		end;

	reset_element is
		do
			if element.command_editor /= Void then
				element.command_editor.clear;
				element.reset
			end
		end;

	catalog_work is
		do
			parent_work;
		end;

feature

	redo is
		do
			parent_redo
			element.recreate_class;
		end;

	undo is
		do
			parent_undo;
			element.remove_class;
		end;
			
end
