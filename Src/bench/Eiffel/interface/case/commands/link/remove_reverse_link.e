indexing

	description: 
		"Remove the reverse link of a relation if the button associated %
		%to the Current command is pressed. Used for client-supplier %
		%bi-directional relations.";
	date: "$Date$";
	revision: "$Revision $"

class 
	REMOVE_REVERSE_LINK

inherit

	--EC_LICENCED_COMMAND
	--	select
	--		execute_licensed
	--	end

	--EDITOR_WINDOW_COM
	--	undefine
	--		work
	EC_EDITOR_WINDOW_COM
		redefine
			editor_window
		end;

creation
	make

feature -- Properties

	editor_window: EC_RELATION_WINDOW;
			-- Associated relation window

	symbol: EV_PIXMAP is
			-- Symbol representing Current button
		do
			Result := Pixmaps.remove_relation_pixmap
		end;

	is_already_selected : BOOLEAN

	set_already_selected ( b: BOOLEAN ) is
		do
			is_already_selected := b
		end

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Remove the reverse link for entity
			-- in relation_window.
		local
			remove_reverse_link: REMOVE_REVERSE_LINK_U
		do 
		--	if	not is_already_selected and 
		--		editor_window.is_edit_double_relation 
		--	then
		--		-- that is if the option was not selected 
		--		!! remove_reverse_link.make (editor_window.clientele_link)
		--		set_already_selected ( TRUE )
		--	end
		end

end -- class REMOVE_REVERSE_LINK
