
deferred class ICON_HOLE 

inherit

	ICON
		redefine
			set_widget_default
		end;
	HOLE
	
feature 

	set_widget_default is
		do
			register
		end;

	target: WIDGET is
		do
			Result := button
		end;

end
