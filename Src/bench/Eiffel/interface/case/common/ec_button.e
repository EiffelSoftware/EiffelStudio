indexing

	description: 
		"Button represented by a pixmap and associated to a command.";
	date: "$Date$";
	revision: "$Revision $"

class EC_BUTTON 

inherit

	--ACTIVE_PICT_COLOR_B
	--	rename
			--make as active_make,
	--		make as pcb_make
	--	end
-- FIXME Pascal
	--FOCUSABLE
--

creation
	make, make_with_symbol

feature -- Initialization

	make (a_parent: EV_CONTAINER; a_com: EC_LICENCED_COMMAND) is
			-- Initialize Current with name `a_name' and
			-- parent `a_parent'. The symbol used is the one in command.
			--| Normal way to use buttons.
		require
			a_parent_exists: a_parent /= Void
			a_com_exists: a_com /= Void
			symbol_exists: a_com.symbol /= Void
		do
			command := a_com
			initial_symbol := a_com.symbol 
		--	pcb_make (a_parent)
		--	set_pixmap (symbol)
			--focus_string := a_name
			--initialize_focus
		ensure
			command_set: command = a_com
			symbol_set: symbol = a_com.symbol
		end

	make_with_symbol (a_name: STRING; a_parent: EV_CONTAINER; 
						a_com: EC_COMMAND; a_sym: like symbol) is
		--	 Initialize Current with name `a_name', parent
		--	 `a_parent' and symbol `a_sym'. 
		--	 This is useful when using a command without symbol,
		--	 for example to have several buttons using the same command.
		require
			a_name_exists: a_name /= Void
			a_parent_exists: a_parent /= Void
			a_com_exists: a_com /= Void
			a_sym_exists: a_sym /= Void
		do
			command := a_com
			initial_symbol := a_sym
		--	pcb_make (a_parent)
		--	set_pixmap (symbol)
			--focus_string := a_name
			--initialize_focus
		ensure
			command_set: command = a_com
			symbol_set: symbol = a_sym
		end

feature -- Properties

--FIXME Pascal
	--focus_label: FOCUS_LABEL_I is
	--	local
	--		ti:TOOLTIP_INITIALIZER
	--	do
	--		ti ?= top
	--		check
	--			ti/=void
	--		end
	--		Result := ti.label
	--end
	
	command: EC_COMMAND
	--command: EV_COMMAND
			-- Command associated to Current button

	symbol: EV_PIXMAP is
			-- Symbol representing Current button.
		do 
				--| May be redefined
			Result := initial_symbol  
		end

feature -- Setting

	command_activate_action (callback_arg: ANY) is
			-- Set action to execute with parameter `callback_arg' 
			-- when Current button is activated
		do
		--	add_activate_action (command, callback_arg)
		end 

	command_set_action (translation: STRING; callback_arg: ANY) is
			-- Set action to execute with parameter `callback_arg' 
			-- when event `translation' occurs on Current button.
			-- `translation' must be specified with the X toolkit conventions.
		require
			translation_exists: translation /= Void
		do	
		--	set_action (translation, command, callback_arg)
		end

	update_pixmap is
			-- Update the symbol. 
		do
	--		if symbol /= Void and then symbol.is_valid then
	--			set_pixmap (symbol)
	--		end
	--	ensure
	--		pixmap_updated: (symbol /= Void and then symbol.is_valid) implies 
	--							(pixmap = symbol)
		end

feature {NONE} -- Implementation

	initial_symbol: like symbol
			-- Symbol set at creation.
			--| Is useful when resetting the initial symbol
			--| with a "set_pixmap (symbol)".
invariant
	command_exists: command /= Void
	--initial_symbol_exists: initial_symbol /= Void

end -- class EC_BUTTON








