indexing

	description: 
		"Undoable command that sets the implementation%
		%value of a link.";
	date: "$Date$";
	revision: "$Revision $"

class SHOW_IMPLEMENTATION_U

inherit

	UNDOABLE_EFC

creation

	make

feature -- Initialization

	make (a_link: like link; state: BOOLEAN) is
		require
			valid_a_link: a_link /= Void
		do
			link := a_link;
			is_implementation := state;
			record;
			redo
		end;

feature -- Property

	name: STRING is
		do
			if is_implementation then		
				Result := "Hide implementation"
			else
				Result := "Show implementation"
			end
		end;

feature -- Update

	redo, undo is
			-- Add shared specification to 'link'
		do
			link.set_implementation (is_implementation);
			if not System.show_all_relations then
				workareas.change_data (link)
			end;
			is_implementation := not is_implementation;
			update
		end; -- shared

	update is
			-- Update the relation window corresponding to 'link'
		local
			relation_window : EC_RELATION_WINDOW
		do
--			relation_window := windows.relation_window (link);
--			if relation_window /= Void then
--				relation_window.update_implementation
--			end;
--			workareas.refresh;
--			System.set_is_modified
		end -- update

feature {NONE} -- Implementation

	link: RELATION_DATA;
			-- Link which became shared or unshared

	is_implementation: BOOLEAN

end -- class SHOW_IMPLEMENTATION_U
