indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class PICT_COLOR_ACTIONS_WINDOW

inherit

	ACTIONS_WINDOW
		redefine
			set_other_widgets,
			descendant_actions,
			set_other_widgets_insensitive,
			set_other_widgets_sensitive
		end

create
	make

feature

	set_pixmap_b: ACTION_WINDOW_BUTTON

	set_other_widgets is
	do
			set_size (330, 350)
			create set_pixmap_b.associate (Current, b_set_pixmap, "Set pixmap", 20, 300);
		end;

	descendant_actions(arg: INTEGER_REF) is
		local
			widget: PICT_COLOR_B
			pixmap: PIXMAP
		do
			widget ?= demo_window_array.item(main_window.current_demo).main_widget
			if arg.item=b_set_pixmap then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_pixmap)
					prompt.remove_cancel_action (Current, b_cancel)
					create pixmap.make
					pixmap.read_from_file (prompt.selection_text)
					if pixmap.is_valid then
						widget.set_pixmap (pixmap)
					end
					set_widgets_sensitive
					prompt.popdown
				else
					prompt.add_ok_action (Current, b_set_pixmap)
					prompt.add_cancel_action (Current, b_cancel)
					prompt.set_selection_label("Enter pixmap file:")
					prompt.set_selection_text ("")
					prompt_type:=b_set_pixmap
					set_widgets_insensitive
					prompt.popup
				end
			else
			end
		end;

	set_other_widgets_insensitive is
		do
			set_pixmap_b.set_insensitive
		end

	set_other_widgets_sensitive is
		do
			set_pixmap_b.set_sensitive
		end

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


end -- class PICT_COLOR_ACTIONS_WINDOW

