
-- All shared access windows.

class WINDOWS

inherit

	SHARED_STATUS

feature {NONE}

--	project_tool: PROJECT_W is
pt: PROJECT_W is
			-- Main and unique control window
		once
			!!Result.make
		end;

project_tool: PROJECT_W is
do
	Result := pt
end;

	system_tool: SYSTEM_W is
			-- Unique assembly tool
		once
			!!Result.make (project_tool.screen)
		end;

	name_chooser: NAME_CHOOSER_W is
			-- File selection window
		once
			!!Result.make (project_tool)
		end;

	warner: WARNER_W is
			-- Warning window
		once
			!!Result.make (project_tool)
		end;

	confirmer: CONFIRMER_W is
			-- Confirmation widget
		once
			!!Result.make (project_tool)
		end;

	error_window: CLICK_WINDOW is
			-- Error window
		do
			if batch_mode then
				Result := term_window
			else
				Result := bench_error_window
			end;
		end;

	bench_error_window: TEXT_WINDOW is
		do
			Result := project_tool.text_window
		end;

	term_window: TERM_WINDOW is
		once
			!!Result
		end;

	info_window: CLICK_WINDOW is
			-- Info window
		do
			Result := error_window
		end;

	debug_window: CLICK_WINDOW is
			-- Debug window
		once
			Result := term_window
		end;

	explain_window: EXPLAIN_W is
			-- Explanation window
		once
			!!Result.make (project_tool.screen)
		end;

	font_window: FONT_W is
			-- Font window for font changes
		once
			!!Result.make (project_tool)
		end;

	search_window: SEARCH_W is
			-- Search window for string searches
		once
			!!Result.make (project_tool)
		end;

	custom_window: CUSTOM_W is
			-- Window for custom formats in class windows
		once
			!!Result.make (project_tool.screen)
		end

end
