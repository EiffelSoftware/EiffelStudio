
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
				widget.set_foreground (a_color)
			else
				fg_color_modified := False
			end;
		end;

end
