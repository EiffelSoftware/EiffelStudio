indexing
	description: "Object that defines a menu item and a toolbar item of Terminate C Compilation function."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TERMINATE_C_COMPILATION_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_toolbar_item,
			tooltext
		end

	EB_SHARED_WINDOW_MANAGER
	
	EB_SHARED_MANAGERS

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
		end

feature -- Status setting

	execute is
			-- Launch `Current'.
			-- Pop up an error wizard relative to the last focused development window.
		do
			internal_execute 
		end
		
	execute_with_stone (st: ERROR_STONE)  is
			-- 
		do
			internal_execute 	
		end
		
		
feature -- Status report

	description: STRING is
			-- Explanatory text for this command.
		do
			Result := Interface_names.e_Terminate_c_compilation
		end

	tooltip: STRING is
			-- Tooltip for `Current's toolbar button.
		do
			Result := Interface_names.b_Terminate_c_compilation
		end

	tooltext: STRING is
			-- Text for `Current's toolbar button.
		do
			Result := Interface_names.b_Terminate_c_compilation
		end

	name: STRING is "Terminate C compilation"
			-- Internal textual representation.

	pixmap: ARRAY [EV_PIXMAP] is
			-- Images used for `Current's toolbar buttons.
		do
			Result := Void 
		end

	menu_name: STRING is
			-- Text used for menu items for `Current'.
		do
			Result := Interface_names.b_Terminate_c_compilation
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			--
			-- Call `recycle' on the result when you don't need it anymore otherwise
			-- it will never be garbage collected.
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} (display_text, use_gray_icons)
			Result.drop_actions.extend (agent execute_with_stone)
		end

feature {NONE} -- Implementation

	internal_execute is
			-- 
		do	
			if freezing_launcher.launched and then 
			   not freezing_launcher.has_exited
		    then
				freezing_launcher.terminate
			end	
			if finalizing_launcher.launched and then 
			   not finalizing_launcher.has_exited
		    then
				finalizing_launcher.terminate
			end				
		end

end -- class EB_TERMINATE_C_COMPILATION_CMD
