indexing

	description: 
		"Undoable command that changes the label orientation.";
	date: "$Date$";
	revision: "$Revision $"

class CHANGE_LABEL_ORIENTATION_U

inherit

	UNDOABLE_EFC

	EV_COMMAND

creation

	make


feature -- Initialization

	make (a_link: like link; vertical: BOOLEAN; reverse_capability: BOOLEAN) is
			-- Change the orientation of 'link' label
		require
			has_link : a_link /= Void
		do
			set_watch_cursor
			link := a_link
			reverse := reverse_capability
			vertical_text := vertical
			record
			redo
			restore_cursor
		ensure
			link_correctly_set : link = a_link
			reverse_correctly_set : reverse = reverse_capability
			side_correctly_set : vertical_text = vertical
		end

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Execute Current command.
		do
			redo
		end

feature -- Property

	name: STRING is
		do
			if reverse then
				if vertical_text then
					Result := "Move reverse label for %
						%vertical drawing"
				else
					Result := "Move reverse label for %
						%horizontal drawing"
				end
			else
				if vertical_text then
					Result := "Move label for vertical drawing"
				else
					Result := "Move label for horizontal drawing"
				end
			end
		end -- name

feature -- Update

	redo is
			-- Change the orientation of label
		do
			if reverse then
				link.change_reverse_label_orientation
			else
				link.change_label_orientation
			end;
			workareas.change_label_orientation (link, reverse);
			update
		end; -- shared

	undo is
		do
			redo
		end

feature {NONE} -- Implementation

	update is
			-- Update the relation window corresponding to 'link'
		--local
		--	relation_window : EC_RELATION_WINDOW
		do
		--	relation_window := windows.relation_window (link);
		--	if relation_window /= Void then
		--		relation_window.update_label_orientation
		--	end;
		--	workareas.refresh;
		--	System.set_is_modified
			observer_management.update_observer(link)
		end -- update

feature {NONE} -- Implementation property

	link: CLI_SUP_DATA;
			-- Link whose label move

	vertical_text: BOOLEAN;
			-- Is the label will be draw vertically ?

	reverse: BOOLEAN

invariant
	CHANGE_LABEL_ORIENTATION_U_link_exists: link /= Void
end -- class CHANGE_LABEL_ORIENTATION_U
