indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class SCROLLED_T_ACTIONS_WINDOW

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

	sel_active_b,
	is_read_only_b,
	set_read_only_b,
	set_editable_b: ACTION_WINDOW_BUTTON

	set_other_widgets is
		do
			set_size (330, 390)
			create sel_active_b.associate (Current, b_sel_active, "Sel active", 20, 300)
			create is_read_only_b.associate (Current, b_is_read_only, "Is read only", 20, 340)
			create set_read_only_b.associate (Current, b_set_read_only, "Set read only", 180, 300)
			create set_editable_b.associate (Current, b_set_editable, "Set editable", 180, 340)
		end

	descendant_actions(arg: INTEGER_REF) is
		local
			widget: SCROLLED_T
		do
			widget ?= demo_window_array.item(main_window.current_demo).main_widget
			inspect arg.item
			when b_sel_active then
				if md.is_popped_up then
					md.remove_ok_action (Current, b_sel_active)
					md.popdown
					set_widgets_sensitive
				else
					md.add_ok_action (Current, b_sel_active)
					if widget.is_selection_active then
						md.set_message ("Selection active")
					else
						md.set_message ("No selection active")
					end
					set_widgets_insensitive
					md.popup
				end
			when b_is_read_only then
				if md.is_popped_up then
					md.remove_ok_action (Current, b_is_read_only)
					md.popdown
					set_widgets_sensitive
				else
					md.add_ok_action (Current, b_is_read_only)
					if widget.is_read_only then
						md.set_message ("Read Only")
					else
						md.set_message ("Editable")
					end
					set_widgets_insensitive
					md.popup
				end
			when b_set_read_only then
				widget.set_read_only
			when b_set_editable then
				widget.set_editable
			else
			end
		end

	set_other_widgets_insensitive is
		do
			sel_active_b.set_insensitive
			is_read_only_b.set_insensitive
			set_read_only_b.set_insensitive
			set_editable_b.set_insensitive
		end

	set_other_widgets_sensitive is
		do
			sel_active_b.set_sensitive
			is_read_only_b.set_sensitive
			set_read_only_b.set_sensitive
			set_editable_b.set_sensitive
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


end -- class SCROLLED_T_ACTIONS_WINDOW

