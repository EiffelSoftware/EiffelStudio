indexing

	description:
		"Command to generate the internal representation of %
		%the profile information.";
	date: "$Date$";
	revision: "$Revision$"

class GENERATE_PROFILE_INFO_CMD

inherit
	ISE_COMMAND;
	EB_CONSTANTS;
	WINDOWS

feature -- Command execution

	work (arg: ANY) is
		local
			profinfo, compile, profiler: STRING
			prof_converter: CONVERTER_CALLER
			conf_load: CONFIGURATION_LOADER
			prof_invoker: PROFILER_INVOKER
			information_dlg: WARNER_W
				--| Guillaume: Pb, utilise WEL...
		do
			if arg = Void and then dlg = Void then
					--| Create the dialog

				!! dlg.make (Profile_tool)
				dlg.call (Current);
			elseif arg = dlg then
					--| Get info from the dialog
					--| And do real execution

					--| Grep the information.
				profinfo := dlg.profinfo_file;
				compile := dlg.compile_mode;
				profiler := dlg.profiler_type;

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
					!! information_dlg.make(Profile_tool)
					if prof_converter.conf_load_error then
						profinfo.append (": File does not exist!")
						information_dlg.gotcha_call(profinfo)
					elseif prof_converter.is_last_conversion_ok then
						information_dlg.gotcha_call("Ready for queries...")
				 	end; --| Guillaume - 09/26/97
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
		do
			Result := Interface_names.f_Generate
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Generate
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

feature {NONE} -- Implementation

	dlg: GENERATION_OPTIONS_DLG

	raise_config_error is
			-- Explains that an error occured while loading the
			-- profiler specific configuration file.
		local
			l_warner: WARNER_W
		do
			!! l_warner.make(profile_tool)
			l_warner.gotcha_call (Warning_messages.w_Load_configuration);
		end

end -- class GENERATE_PROFILE_INFO_CMD
