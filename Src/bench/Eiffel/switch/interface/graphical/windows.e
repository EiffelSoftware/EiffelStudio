indexing

	description: 
		"All shared access windows.";
	date: "$Date$";
	revision: "$Revision $"

class WINDOWS

feature {NONE}

	project_tool: PROJECT_W is
			-- Main and unique control window
		once
			!!Result.make
		end;

    transporter: TRANSPORTER is
		once
			!! Result.make (project_tool)
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

	warner (window: WIDGET): WARNER_W is
			-- Warning window associated with `window'
		require
			window_not_void: window /= Void
		local
			new_parent: COMPOSITE;
			old_warner: WARNER_W
		do
			new_parent := window.top;
			!!Result.make (new_parent);
			Result.set_window (new_parent);
			old_warner := last_warner;
			if old_warner /= Void then
				old_warner.popdown;
				old_warner.destroy
			end;
			last_warner_cell.put (Result)
		end;

	last_warner: WARNER_W is
			-- Last warner window created
		do
			Result := last_warner_cell.item
		end;

	confirmer (window: TEXT_WINDOW): CONFIRMER_W is
			-- Confirmation widget associated with `window'
		require
			window_not_void: window /= Void
		local
			new_parent: COMPOSITE;
			old_confirmer: CONFIRMER_W
		do
			new_parent ?= window.tool;
			!!Result.make (new_parent);
			Result.set_window (window);
			old_confirmer := last_confirmer;
			if old_confirmer /= Void then
				old_confirmer.popdown;
				old_confirmer.destroy
			end;
			last_confirmer_cell.put (Result)
		end;

	last_confirmer: CONFIRMER_W is
			-- Last confirmer window created
		do
			Result := last_confirmer_cell.item
		end;

	error_window: OUTPUT_WINDOW is
			-- Error window that displays error message
		do
			if batch_mode then
				Result := term_window
			else
				Result := bench_error_window
			end;
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

feature -- Compilation Mode

    batch_mode: BOOLEAN is
            -- Is the compiler in batch mode?
        do
            Result := mode.item
        end;

    set_batch_mode (compiler_mode: BOOLEAN) is
            -- Set `batch_mode' to `compiler_mode'
        do
            mode.put (compiler_mode)
        end;

feature {NONE} -- Implementation

	last_warner_cell: CELL [WARNER_W] is
			-- Cell containing the last warner window created
		once
			!! Result.put (Void)
		end;

	last_confirmer_cell: CELL [CONFIRMER_W] is
			-- Cell containing the last confirmer window created
		once
			!! Result.put (Void)
		end;

    mode: CELL [BOOLEAN] is
        once
            !! Result.put (False)
        end;

	bench_error_window: TEXT_WINDOW is
		do
			Result := project_tool.text_window
		end;

	term_window: TERM_WINDOW is
		once
			!! Result
		end;

end -- class WINDOWS
