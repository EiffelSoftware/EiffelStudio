indexing

	description: "Data object that can have a color.";
	date: "$Date$";
	revision: "$Revision $"

deferred class COLORABLE

inherit

	DATA


feature -- Access

	color_name: STRING

	default_color: EV_COLOR is
			-- Default color
		deferred
		ensure
			valid_result: Result /= Void
		end

	color: EV_COLOR
			-- Color of Current

feature -- Setting

	set_color_name (a_name: STRING) is
		do
			color_name := a_name
		end

	set_color(new_color: EV_COLOR) is
			-- Set a new color to Current.
		require
			new_color_exists: new_color /= Void
		do
			color := new_color
		ensure
			new_color_set: new_color = color
		end

end -- class COLORABLE
