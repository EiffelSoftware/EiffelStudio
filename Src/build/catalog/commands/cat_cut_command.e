
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

feature {NONE}

	catalog: COMMAND_CATALOG is
		do
			Result := command_catalog
		end;

	element: USER_CMD;

	page: COMMAND_PAGE;

	parent_type: USER_CMD;

	catalog_work is
		do
			parent_work;
			parent_type ?= element.parent_type;
			element.remove_class;
			if parent_type /= Void then
				parent_type.remove_descendent (element)
			end
		end;

feature

	redo is
		do
			parent_redo
			element.remove_class;
			if parent_type /= Void then
				parent_type.remove_descendent (element)
			end
		end;

	undo is
		do
			if parent_type /= Void then
				parent_type.add_descendent (element)
			end
			parent_undo;
			element.recreate_class;
		end;
			
end
