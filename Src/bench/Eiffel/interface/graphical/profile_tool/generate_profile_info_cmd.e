indexing

	description:
		"Command to generate the internal representation of %
		%the profile information.";
	date: "$Date$";
	revision: "$Revision$"

class GENERATE_PROFILE_INFO_CMD

inherit
	TOOL_COMMAND

creation
	make

feature {NONE} -- Initialization

	make (a_tool: PROFILE_TOOL) is
			-- Create Current
		require
			a_tool_not_void: a_tool /= Void
		do
			profile_tool := a_tool
		ensure
			profile_tool_set: profile_tool.is_equal (a_tool)
		end

feature -- Access

	profile_tool: PROFILE_TOOL
			-- Profile tool

feature -- Command execution

	work (arg: ANY) is
		local
			profinfo, compile, profiler: STRING
			prof_converter: CONVERTER_CALLER
			conf_load: CONFIGURATION_LOADER
			prof_invoker: PROFILER_INVOKER
		do
			if arg = Void and then dlg = Void then
					--| Create the dialog

				!! dlg.make (profile_tool)
				dlg.call (Current);
			elseif arg = dlg then
					--| Get info from the dialog
					--| And do real execution

					--| Grep the information.
				profinfo := dlg.profinfo_file;
				compile := dlg.compile_mode;
				profiler := dlg.profiler;

					--| Destroy the dialog's interface
				dlg.destroy;

				!! conf_load.make_and_load (profiler);
				if conf_load.error_occured then
					raise_config_error;
				else
					!! prof_invoker.make (profiler, argument_window.argument_list, profinfo, compile);
					if prof_invoker.must_invoke_profiler then
						prof_invoker.invoke_profiler;
					end;
					!! prof_converter.make (<<profinfo, compile>>, conf_load.shared_prof_config);
				end;

					--| Get rid of the object...
				dlg := Void
			elseif arg = Void then
					--| Cancel generation

				dlg.destroy;
				dlg := Void
			end
		end

feature -- Access

	name: STRING is
		once
			!! Result.make (0);
			Result.append ("Generate")
		end

feature {NONE} -- Implementation

	dlg: GENERATION_OPTIONS_DLG

	raise_config_error is
			-- Explains that an error occured while loading the
			-- profiler specific configuration file.
		local
			l_warner: WARNER_W
		do
			l_warner := warner (profile_tool)
			l_warner.gotcha_call ("An error occured while loading the configuration for your profiler.%N%
				%Please check with your system administrator whether your profiler is supported.%N");
		end

end -- class GENERATE_PROFILE_INFO_CMD
