class SHARED_HISTORY_CONTROL

inherit

	SHARED_WORKBENCH

feature

	History_control: HISTORY_CONTROL is
			-- History table controler
		once
			Result := System.history_control;
		end;

end
