indexing

	description: 
		"Shared objects.";
	date: "$Date$";
	revision: "$Revision $"

class ONCES

feature {NONE} -- Implementation

	History: HISTORY_EFC is
			-- History of the system
		once
			!! Result.make
		end

	System: SYSTEM_DATA is
			-- Global system
		once
			!! Result.make
		end

	View_information: VIEW_INFO is
			-- View information (for retrieving
			-- system views)
		once
			!! Result
		end

	Workareas: WORKAREAS_L is
			-- List of all workareas 
		once
			!! Result.make
		end

	observer_management: OBSERVER_MANAGEMENT is
		once
			!! Result.make
		end

	windows_manager: WINDOWS_MANAGER is
		once
			!! Result
		end

	popup_windows: POPUP_WINDOWS is
		once
			!! Result.make
		end


end -- class ONCES
