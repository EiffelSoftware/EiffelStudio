indexing

	description:
		"Command to generate the internal representation of %
		%the profile information."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GENERATE_PROFILE_INFO_CMD

inherit
	EV_COMMAND
	EB_CONSTANTS
	WINDOWS

feature -- Command execution

	execute (arg: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
		local
			profinfo, compile, profiler: STRING
			prof_converter: CONVERTER_CALLER
			conf_load: CONFIGURATION_LOADER
			prof_invoker: PROFILER_INVOKER
			error_dlg: EV_ERROR_DIALOG
			ok_dlg: EB_MESSAGE_WINDOW
		do
			if arg = Void and then dlg = Void then
					--| Create the dialog

				create dlg.make (Profile_tool.container)
				dlg.call
			elseif arg = dlg then
					--| Get info from the dialog
					--| And do real execution

					--| Grep the information.
				profinfo := dlg.profinfo_file
				compile := dlg.compile_mode
				profiler := dlg.profiler_type

					--| Destroy the dialog's interface
				dlg.destroy

				create conf_load.make_and_load (profiler)
				if conf_load.error_occured then
					raise_config_error
				else
					create prof_invoker.make (profiler, argument_window.argument_list, profinfo, compile)
					if prof_invoker.must_invoke_profiler then
						prof_invoker.invoke_profiler
					end
					create prof_converter.make (<<profinfo, compile>>, conf_load.shared_prof_config)
					if prof_converter.conf_load_error then
						profinfo.append (": file does not exist")
						create error_dlg.make_default (profile_tool.container, "Error", profinfo)
					elseif prof_converter.is_last_conversion_ok then
						create ok_dlg.make (profile_tool.container, "Ready for queries")
						ok_dlg.set_message ("Ready for queries") 
						ok_dlg.show
				 	end 
				end

					--| Get rid of the object...
				dlg := Void
			elseif arg = Void then
					--| Cancel generation

				dlg.destroy
				dlg := Void
			end
		end

feature -- Access

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

	dlg: EB_GENERATION_OPTIONS_DLG

	raise_config_error is
			-- Explains that an error occured while loading the
			-- profiler specific configuration file.
		local
			error_dlg: EB_ERROR_WINDOW
		do
			create error_dlg.make_default (profile_tool.container,
				Interface_names.t_Configuration_error,
				Warning_messages.w_Load_configuration)
		end

end -- EB_GENERATE_PROFILE_INFO_CMD
