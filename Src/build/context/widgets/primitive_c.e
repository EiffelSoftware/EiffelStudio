
deferred class PRIMITIVE_C 

inherit

	CONTEXT
		redefine
			widget
		end

feature 

	widget: PRIMITIVE;

	set_fg_color_name (a_name: STRING) is
		local
			a_color: COLOR;
		do
			fg_color_name := a_name;
			if a_name /= Void then
				fg_color_modified := True;
				!!a_color.make;
				a_color.set_name (a_name);
				widget.set_foreground_color (a_color)
			else
				fg_color_modified := False
			end;
		end;

	default_foreground_color: COLOR is
		do
			Result := widget.foreground_color
		end;

	set_default_foreground_color (color: COLOR) is
		do
			widget.set_foreground_color (color)
		end;

end
