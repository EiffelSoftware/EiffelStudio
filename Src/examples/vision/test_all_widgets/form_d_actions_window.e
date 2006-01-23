indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class FORM_D_ACTIONS_WINDOW

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

	allow_resize_b,
	forbid_resize_b,
	popup_b,
	popdown_b: ACTION_WINDOW_BUTTON

	set_other_widgets is
		do
			set_size (330, 350)
			create allow_resize_b.associate (Current, b_allow_resize, "Allow resize", 20, 260)
			create forbid_resize_b.associate (Current, b_forbid_resize, "Forbid resize", 180, 260)
			create popup_b.associate (Current, b_popup, "Popup", 20, 300)
			create popdown_b.associate (Current, b_popdown, "Popdown", 180, 300)
		end

	descendant_actions(arg: INTEGER_REF) is
		local
			dialog: DIALOG
		do
			dialog ?= demo_window_array.item(main_window.current_demo)
			inspect arg.item
			when b_allow_resize then
				dialog.allow_resize
			when b_forbid_resize then
				dialog.forbid_resize
			when b_popup then
				dialog.popup
			when b_popdown then
				dialog.popdown
			else
			end
		end

	set_other_widgets_insensitive is
		do
			allow_resize_b.set_insensitive
			forbid_resize_b.set_insensitive
			popup_b.set_insensitive
			popdown_b.set_insensitive
		end

	set_other_widgets_sensitive is
		do
			allow_resize_b.set_sensitive
			forbid_resize_b.set_sensitive
			popup_b.set_sensitive
			popdown_b.set_sensitive
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


end -- class FORM_D_ACTIONS_WINDOW

