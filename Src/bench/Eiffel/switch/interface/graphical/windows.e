
-- All shared access windows.

class WINDOWS

inherit

	SHARED_STATUS;
	NAMER;
	WARNING_MESSAGES

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

	ghost_top_shell: TOP_SHELL is
			-- Invisible parent of shared windows
			-- (warner, confirmer, ...)
		once
			!!Result.make (new_name, project_tool.screen);
			Result.set_size (Result.screen.width, Result.screen.height);
			Result.set_x_y (0, 0)
		end;

	name_chooser: NAME_CHOOSER_W is
			-- File selection window
		once
			!!Result.make (ghost_top_shell)
		end;

	warner: WARNER_W is
			-- Warning window
		once
			!!Result.make (ghost_top_shell)
		end;

	confirmer: CONFIRMER_W is
			-- Confirmation widget
		once
			!!Result.make (ghost_top_shell)
		end;

	error_window: CLICK_WINDOW is
			-- Error window that displays error message
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
			Result := bench_error_window
		end;

	explain_window: EXPLAIN_W is
			-- Explanation window
		once
			!!Result.make (project_tool.screen)
		end;

	window_manager: WINDOW_MGR is
			-- Window manager for ebench windows
		once
			!!Result.make (project_tool.screen, 2);
		end;

	custom_window: CUSTOM_W is
			-- Window for custom formats in class windows
		once
			!!Result.make (project_tool.screen)
		end

end
