
deferred class ICON_HOLE 

inherit

	ICON
		rename
			make_visible as org_make_visible
		undefine
			init_toolkit
		end;

	ICON
		undefine
			init_toolkit
		redefine
			make_visible
		select
			make_visible
		end;

	HOLE
	
feature 

	make_visible (a_parent: COMPOSITE) is
		do
			org_make_visible (a_parent);
			register
		end;

	target: WIDGET is
		do
			Result := button
		end;

end
