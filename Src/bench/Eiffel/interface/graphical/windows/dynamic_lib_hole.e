indexing

	description: ""
	date: "$Date$"
	revision: "$Revision$"

class DYNAMIC_LIB_HOLE

inherit
	SHARED_EIFFEL_PROJECT

	PROJECT_CONTEXT

	DEFAULT_HOLE_COMMAND
		redefine
			symbol, full_symbol, icon_symbol,
			name, stone_type, process_class, process_feature,
			compatible, process_classi, menu_name, accelerator,
			work
		end

	WARNER_CALLBACKS
		rename
			execute_warner_help as load_default,
			execute_warner_ok as load_chosen
		end

creation
	make

feature -- Callbacks

	load_default is
			-- Used when first open the dynamic_tool. (Create default)
			-- and when we click on the dynamic_lib button, to say, RELOAD (NO).
		local
			fn:STRING
			f: PLAIN_TEXT_FILE
			fc: PLAIN_TEXT_FILE
		do
			if Eiffel_dynamic_lib /= Void  and then Eiffel_dynamic_lib.modified then
				!! fc.make_open_read (eiffel_dynamic_lib.file_name)
				if eiffel_dynamic_lib.parse_exports_from_file(fc) then
					dynamic_lib_tool.synchronize
				end
				fc.close
				eiffel_dynamic_lib.set_modified(false)
			else
					-- First creation of the dynamic library
				Eiffel_project.create_dynamic_lib
				fn := clone(eiffel_system.name)
				fn.append_string(".def")
				!! f.make_create_read_write(fn)
				if 
					f.exists and then 
					f.is_readable and then 
					f.is_plain
				then
					f.close
					Eiffel_dynamic_lib.set_file_name (fn);
					work (Current);
				else
					io.put_string("Impossible to create the default file%N")
				end
			end
		end;

	load_chosen (argument: ANY) is
			-- Used when first open the dynamic_tool.
			-- and when we click on the dynamic_lib button, to say, SAVE (OK).
		local
			chooser: NAME_CHOOSER_W
			fc: PLAIN_TEXT_FILE
		do
			if Eiffel_dynamic_lib /= Void and then Eiffel_dynamic_lib.modified then
				if tool.save_cmd_holder /= Void then
					tool.save_cmd_holder.associated_command.execute (Void)
				end
				!! fc.make_open_read (eiffel_dynamic_lib.file_name)
				if eiffel_dynamic_lib.parse_exports_from_file(fc) then
					dynamic_lib_tool.synchronize
				end
				fc.close
				eiffel_dynamic_lib.set_modified(false)
			else
				chooser := name_chooser (popup_parent);
				chooser.set_open_file;
				chooser.set_pattern ("*.def")
				chooser.set_pattern_name ("Dynamic Library Definition File (*.def)")
				chooser.call (Current);
			end
		end;

feature -- Properties

	symbol: PIXMAP is
			-- Icon for the Dynamic Lib tool
		once
			Result := Pixmaps.bm_Dynamic_lib
		end;

	full_symbol: PIXMAP is
			-- Icon for the Dynamic Lib tool
		once
			Result := Pixmaps.bm_Dynamic_lib_dot
		end;

	icon_symbol: PIXMAP is
			-- Icon for the Dynamic Lib tool
		once
			Result := Pixmaps.bm_Dynamic_lib_icon
		end;

	name: STRING is
		do
			Result := Interface_names.s_Dynamic_lib_stone
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_New_dynamic_lib
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	stone_type: INTEGER is
		do
			Result := Dynamic_lib_type
		end;

feature -- Access

	compatible (dropped: STONE): BOOLEAN is
			-- Can current accept `dropped'?
		do
			Result := dropped /= Void and then
				((dropped.stone_type = Dynamic_lib_type) or
--				else (dropped.stone_type = Class_type) or
				else (dropped.stone_type = Routine_type))
--			Result := True
		end;

feature -- Update

	-- Actually we have two types of class holes. One type is
	-- displayed on the project window and the other type is
	-- used within the class and feature tool.
	-- When we drag a feature stone into the class hole of the project tool,
	-- we should bring up a class tool and highlight the feature.
	-- That's the intelligent stuff.

	process_class (st: CLASSC_STONE) is
		do
			if tool = Project_tool then
				open_dynamic_lib_tool (st)
			else
				tool.receive (st)
			end
		end;

	process_classi (st: CLASSI_STONE) is
		do
			if tool = Project_tool then
				open_dynamic_lib_tool (st)
			else
				tool.receive (st)
			end
		end;

	process_feature (st: FEATURE_STONE) is
		do
			if is_dynamic_lib_tool_created and then tool = dynamic_lib_tool then
				open_dynamic_lib_tool (st)
			else
				work(Current)
			end
		end;

feature {NONE} -- Execution

	work (argument: ANY) is
		local
			fn: STRING;
			f: PLAIN_TEXT_FILE
		do
			if Project_tool.initialized and then Eiffel_project.system /= Void then
				if is_dynamic_lib_tool_created and then tool = dynamic_lib_tool then
					tool.synchronize
				end
				if Eiffel_dynamic_lib = Void then
						-- No dynamic lib has been created, we request the creation
						-- of one.
					if argument /= Void and then argument = last_name_chooser then
						fn := clone (last_name_chooser.selected_file);
						if not fn.is_empty then
							!! f.make (fn);
							if 
								f.exists and then 
								f.is_readable and then 
								f.is_plain
							then
									-- First creation of the dynamic library
								Eiffel_project.create_dynamic_lib
								Eiffel_dynamic_lib.set_file_name (fn);
								work (Current);
							elseif f.exists and then not f.is_plain then
								warner (tool.popup_parent).custom_call 
									(Current, Warning_messages.w_Not_a_file_retry (fn), 
									Interface_names.b_Ok, Void, Interface_names.b_Cancel)
							else
								warner (tool.popup_parent).custom_call 
									(Current, Warning_messages.w_Cannot_read_file_retry (fn), 
									Interface_names.b_Ok, Void, Interface_names.b_Cancel)
							end
						else
							warner (tool.popup_parent).custom_call 
								(Current, Warning_messages.w_Not_a_file_retry (fn), 
								Interface_names.b_Ok, Void, Interface_names.b_Cancel)
						end

					else
						if System.dynamic_def_file /= Void then
							create f.make (System.dynamic_def_file)
							if f.exists and then f.is_readable and then f.is_plain then
								eiffel_project.create_dynamic_lib;
								eiffel_dynamic_lib.set_file_name (System.dynamic_def_file);
								work (Current)
							else
								warner (tool.popup_parent).custom_call 
									(Current, Interface_names.t_Specify_dynamic_lib,
									Interface_names.b_Browse, "Default", Interface_names.b_Cancel);
							end
						else
							warner (tool.popup_parent).custom_call 
								(Current, Interface_names.t_Specify_dynamic_lib,
								Interface_names.b_Browse, "Default", Interface_names.b_Cancel);
						end
					end
				else
					if tool = Project_tool then
						if dynamic_lib_tool /= Void then
							dynamic_lib_tool.force_raise
							dynamic_lib_tool.display
							dynamic_lib_tool.show_file_content (Eiffel_dynamic_lib.file_name)
						end
					else
						if Eiffel_dynamic_lib.modified then
							warner (popup_parent).custom_call (Current, Warning_messages.w_File_changed (Void),
							Interface_names.b_Yes, Interface_names.b_No, Interface_names.b_Cancel)
						else
							!! f.make_open_read (Eiffel_dynamic_lib.file_name)
							if Eiffel_dynamic_lib.parse_exports_from_file(f) then
								dynamic_lib_tool.synchronize
							end
							f.close
							Eiffel_dynamic_lib.set_modified(False)
						end
					end
				end 
			end
		end

feature {NONE} -- Implementation

	open_dynamic_lib_tool (a_stone: STONE) is
			-- open a dynamic lib tool and process `a_stone'.
		require
			valid_a_stone: a_stone /= Void and then a_stone.is_valid
		do
			dynamic_lib_tool.display
			dynamic_lib_tool.receive (a_stone)
		end;

end -- class DYNAMIC_LIB_HOLE

