class HIDE_SHOW_WINDOWS

inherit

	W_MAN_GEN

feature

	was_popped_down: BOOLEAN;
			-- Was Current main panel popped down?

	shown_windows: LINKED_LIST [WIDGET];
			-- Shown windows before iconization

	hide is
			-- Hide all windows.
		local
			top_w: TOP;
			widget: WIDGET;
			dialog: DIALOG
		do
			!! shown_windows.make;
			from
				widget_manager.start
			until
				widget_manager.after
			loop
				widget := widget_manager.item;
				top_w ?= widget;
				dialog ?= widget;
				if top_w /= Void and then
					top_w.realized and then
					top_w.shown
				then
					top_w.hide;
					shown_windows.extend (widget)
				elseif dialog /= Void and then
					dialog.is_popped_up
				then
					dialog.popdown;
					shown_windows.extend (widget)
				end;
				widget_manager.forth
			end
			was_popped_down := True;
		end;

	show is
			-- Show all windows.
		local
			widget: WIDGET;
			dialog: DIALOG
		do
			if was_popped_down then
				was_popped_down := False;
				from
					shown_windows.start
				until
					shown_windows.after
				loop
					widget := shown_windows.item;
					if not widget.destroyed then
						dialog ?= widget;
						if dialog = Void then
							shown_windows.item.show;
						else
							dialog.popup
						end;
					end
					shown_windows.forth
				end;
				shown_windows := Void
			end
		end;

end
