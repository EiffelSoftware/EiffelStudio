indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_GRAPHIC

inherit
	EV_APPLICATION
		redefine
			initialize
		end

	EB_SHARED_INTERFACE_TOOLS

	EB_SHARED_PIXMAPS

creation
	make

feature -- Access

	first_window: EB_PROJECT_WINDOW is
			-- Initialize the windowing environment.
		local
			new_resources: EB_RESOURCES_INITIALIZER
			display_name: STRING
			exc: EXCEPTIONS
			exec_env: EXECUTION_ENVIRONMENT
--			g_degree_output: GRAPHICAL_DEGREE_OUTPUT
		do
				-- display issues: to be implemented later
--			if not ewb_display.is_valid then
--				io.error.putstring ("Cannot open display %"")
--				create exec_env
--				display_name := exec_env.get ("DISPLAY")
--				if display_name /= Void then
--					io.error.putstring (display_name)
--				end
--				io.error.putstring ("%"%N%
--					%Check that $DISPLAY is properly set and that you are%N%
--					%authorized to connect to the corresponding server%N")
--				create exc
--				exc.raise ("Invalid display")
--			end

				--| If we don't put bench mode here,
				--| `error_window' will assume batch
				--| mode and thus it will initialize
				--| `error_window' as a TERM_WINDOW.
				--| Also note that `error_window' is a
				--| once-function!!
			mode.set_item (False)
			create new_resources.initialize

			create Result.make_top_level
			Project_tool_cell.put (Result.tool)
			Result.show
		end

	initialize is
		do
--			splash_pixmap (bm_ISE_Power)
		end
end -- class ES_GRAPHIC
