indexing   
	description: 
		"Abstraction of a graphical element associated to a command, %
		%that can be selected and unselected.";
	date: "$Date$";
	revision: "$Revision $"

deferred class 
	SELECTABLE

inherit
	ACTIVE_PICT_COLOR_B
		rename
			--make as active_make, 
			make as pcb_make
		export
			{NONE}  all
		end

feature {NONE} -- Initialization

	make_selected (a_parent: EV_CONTAINER; a_com: like command) is
			-- Initialize Current with name `a_name', parent `a_parent',
			-- associated command `a_com' and the selected 
			-- (highlighted) state.
		require
			a_parent_exists: a_parent /= Void
			a_com_exists: a_com /= Void
		deferred
		ensure
			is_default: is_default_selected
			default_is_selected: default_selected
		end

	make_unselected (a_parent: EV_CONTAINER; a_com: like command) is
			-- Initialize Current with name `a_name', parent `a_parent',
			-- associated command `a_com' and the unselected 
			-- (not highlighted) state.
		require
			a_parent_exists: a_parent /= Void
			a_com_exists: a_com /= Void
		deferred
		ensure
			is_default: is_default_selected
			default_is_unselected: not default_selected
		end

feature -- Properties

	command: EC_LICENCED_COMMAND
			-- Command associated to Current

	default_selected: like selected
			-- Is Current  to be selected (highlighted) by default at 
			-- creation? Used to (re)set the default selected state.
			-- Set according to the creation routine called.

	enabled: BOOLEAN
			-- Is Current command able to be selected and unselected 
			-- at present? Used to reflect the application's specific state. 

	is_default_selected: BOOLEAN is
			-- Is Current  in the default selected state ?
		do
			Result := (selected = default_selected)
		ensure
			definition:  Result = (selected = default_selected)
		end;

	selected: BOOLEAN is
			-- Is Current  selected?
		deferred
		end

feature -- Setting

	disable is
			-- Prevent Current from being (un)selected
		do
			enabled := False
		ensure
			disabled: not enabled
		end

	enable is
			-- Allow Current to be (un)selected
		do
			enabled := True
		ensure
			enabled: enabled
		end

	reverse_selection is
			-- Select Current  if it was unselected, and vice-versa.
		do
			if selected then
				unselect
			else
				select_it
			end
		ensure
			reverse: enabled implies (selected = (not old selected)) 
		end

	select_it is
			-- Select Current 
		require
			not_selected: not selected
		deferred
		ensure
			selected: enabled implies selected
		end

	unselect is
			-- Select Current
		deferred
		ensure
			not_selected: enabled implies (not selected)
		end;

end -- class SELECTABLE








