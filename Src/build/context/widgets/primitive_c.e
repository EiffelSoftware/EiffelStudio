
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
			if a_name = Void or else a_name.empty then
				fg_color_modified := False;
				fg_color_name := Void;
				a_color := default_foreground_color;
				if a_color /= Void then
					widget.set_foreground_color (a_color)
				end
			else
				if fg_color_name = Void then
					save_default_foreground_color
				end;
				fg_color_name := a_name;
				fg_color_modified := True;
				!!a_color.make;
				a_color.set_name (a_name);
				widget.set_foreground_color (a_color)
			end;
		end;

	save_default_foreground_color is
		do
			if default_foreground_color = Void then
		   		default_foreground_color := widget.foreground_color
			end
		end;

	reset_default_foreground_color is
		do
			widget.set_foreground_color (default_foreground_color);
		end;


end
