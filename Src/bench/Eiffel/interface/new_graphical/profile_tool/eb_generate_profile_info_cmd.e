indexing

	description:
		"Command to generate the internal representation of %
		%the profile information."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GENERATE_PROFILE_INFO_CMD

inherit
	EB_TOOL_COMMAND
	NEW_EB_CONSTANTS
	EB_SHARED_INTERFACE_TOOLS
		-- for argument_list only.

creation
	make

feature -- Command execution

	execute (arg: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
		do
				--| Get info from the dialog
				--| And do real execution
				--| Grep the information.
			create options_dialog.make_default (Current)
		end

feature -- Command execution

	build_profile is
			-- Create profile according to `options_dialog' specifications
		require
			options_dialog_exists: not options_dialog.destroyed
		local
			profinfo, compile, profiler: STRING
			prof_converter: CONVERTER_CALLER
			conf_load: CONFIGURATION_LOADER
			prof_invoker: PROFILER_INVOKER
			error_dlg: EV_ERROR_DIALOG
			ok_dlg: EV_WARNING_DIALOG
		do
			profinfo := options_dialog.profinfo_file
			compile := options_dialog.compile_mode
			profiler := options_dialog.profiler_type
			create conf_load.make_and_load (profiler)
			if conf_load.error_occured then
				raise_config_error
			else
				create prof_invoker.make (profiler, Argument_list, profinfo, compile)
				if prof_invoker.must_invoke_profiler then
					prof_invoker.invoke_profiler
				end
				create prof_converter.make (<<profinfo, compile>>, conf_load.shared_prof_config)
				if prof_converter.conf_load_error then
					profinfo.append (": file does not exist")
					create error_dlg.make_default (tool.parent, "Error", profinfo)
				elseif prof_converter.is_last_conversion_ok then
					create ok_dlg.make_default (tool.parent_window,"", "Ready for queries")
				end 
			end
		end

feature -- Access

	options_dialog: EB_GENERATION_OPTIONS_DLG

--	name: STRING is
--		do
--			Result := Interface_names.f_Generate
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_Generate
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--		end

feature {NONE} -- Implementation

	raise_config_error is
			-- Explains that an error occured while loading the
			-- profiler specific configuration file.
		local
			error_dlg: EV_WARNING_DIALOG
		do
			create error_dlg.make_default (tool.parent_window,
				Interface_names.t_Configuration_error,
				Warning_messages.w_Load_configuration)
		end

end -- EB_GENERATE_PROFILE_INFO_CMD
