indexing

	description:	
		"Hole for an existing class tool. Yes, I know, %
					%it's very funny.";
	date: "$Date$";
	revision: "$Revision$"

class CLASS_HOLE 

inherit

	EB_BUTTON_HOLE
		redefine
			compatible, stone_type, receive
		end;
	WARNING_MESSAGES

creation

	make

feature -- Properties

	stone_type: INTEGER is
		do
			Result := Class_type
		end;

feature -- Pick & Throw

	receive (a_stone: STONE) is
			-- Process dropped stone `a_stone'.
		local
			received_type: INTEGER;
			feature_stone: FEATURE_STONE;
			new_tool: TOOL_W;
			invalid: BOOLEAN
		do
			if compatible (a_stone) then

				-- Okay, here we go.
				-- Actually we have two types of class holes. One type is
				-- displayed on the project window and the other type is
				-- used within the class and feature tool.
				-- When we drag a feature stone into the class hole of the project tool,
				-- we should bring up a class tool and highlight the feature.
				-- That's the intelligent stuff.

				if tool = Project_tool then
						-- Do some intelligent stuff here.

					if a_stone.stone_type = Routine_type then
						feature_stone ?= a_stone;		--| Cannot fail!
						if not feature_stone.is_valid then
							warner (Project_tool).gotcha_call
									(w_Feature_not_compiled);
							invalid := true;
						end
					end;

					if not invalid then
						new_tool := window_manager.class_window;
						new_tool.display;
						new_tool.receive (a_stone)
					end

				else
					tool.receive (a_stone)
				end
			end
		end;

feature {NONE} -- Properties

	compatible (dropped: STONE): BOOLEAN is
			-- Can current accept `dropped'?
		do
			Result := dropped /= Void and then
				((dropped.stone_type = Class_type) or 
				else (dropped.stone_type = Routine_type))
		end;

end -- class CLASS_HOLE
