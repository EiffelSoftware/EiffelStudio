indexing

	description: 
		"Save current EiffelCase project when the button % 
		%associated to Current command is pressed.";
	date: "$Date$";
	revision: "$Revision $"

class 
	SAVE_PROJECT 

inherit

	MAIN_PANEL_COM
		redefine
			--license_checked,
			--selected_symbol 
		end

creation
	make

feature -- Creation

	make (c: like caller) is
		do
			caller := c
		end

feature -- Properties

	caller: EV_WINDOW

	associated_button: EC_BUTTON
			-- Button to which Current is associated
			--| Necessary to be able to set its pixmap here.

	symbol: EV_PIXMAP is
			-- Symbol representing button to which Current 
			-- command is associated (at the beggining).
		do
			Result := Pixmaps.save_pixmap
		end

feature -- Setting

	selected_symbol: like symbol is
		do
			Result := Pixmaps.unsave_pixmap
		end

feature -- Execution (work)

	work (not_used: ANY) is
			-- Store project to disk.
		local
			store: STORE
		do
			if system.project_initialized then
				!! store.make (caller)
				store.execute (Void, Void)
			else
				windows_manager.popup_message ("Mg","", caller)
			end
		end

feature {NONE} -- Implementation

	license_checked: BOOLEAN is True
			-- Is license checked?
			--| True, so as to always allow the user to save his/her project, 
			--| even if his/her licence has expired

end -- class SAVE_PROJECT


