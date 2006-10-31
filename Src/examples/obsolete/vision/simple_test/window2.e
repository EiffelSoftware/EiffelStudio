indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class WINDOW2

inherit

	TOP_SHELL
		rename
			make as top_shell_make
		end;

	COMMAND

create

	make

feature

	text_area: SCROLLED_T;
	text_label: LABEL;

	bulletin: BULLETIN;

	make (a_name: STRING; a_screen: SCREEN) is
		do
			top_shell_make (a_name, a_screen);
			create bulletin.make ("Bulletin", Current);
			create text_area.make ("Text", bulletin);
			create text_label.make ("Label", bulletin);
			set_values;
			set_positions;	
			set_callbacks;
		end;

	set_values is
		local
			a_color: COLOR
		do
			create a_color.make;
			a_color.set_name ("yellow");
			text_area.set_background_color (a_color);
		end;

	set_positions is
			-- Set positions and sizes of `text_area' and
			-- `text_field' in the bulletin.
		do
			set_size (200, 200);
			text_area.set_x_y (5,5);
			text_area.set_size (190, 140);
			text_label.set_x_y (20, 160);
		end;

	set_callbacks is
		local
			Nothing: ANY
		do
			text_area.add_modify_action (Current, Nothing)
		end;

	counter: INTEGER;

	execute (argument: ANY) is
		local
			temp: STRING
		do
			counter := counter + 1;
			create temp.make (0);	
			temp.append_integer (counter);
			temp.append (" modification(s)");
			text_label.set_text (temp)
		end;
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end

