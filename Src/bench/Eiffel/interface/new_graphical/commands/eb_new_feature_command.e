indexing
	description	: "Command to create a new feature."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_NEW_FEATURE_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			mini_pixmap
		end

	EB_DEVELOPMENT_WINDOW_COMMAND

	SHARED_WORKBENCH

create
	make

feature -- Basic operations

	execute is
			-- Pop up feature wizard.
		local
			c: CLASSI_STONE
			class_i: CLASS_I
			cg: CLASS_TEXT_MODIFIER
			wd: EV_WARNING_DIALOG
			class_c: CLASS_C
			test_file: RAW_FILE
			retried: BOOLEAN
		do
			if retried then
				create wd.make_with_text (Warning_messages.W_class_not_modifiable)
				wd.show_modal_to_window (target.window)	
			else
				if
					Workbench.last_reached_degree <= 2
				then
					c ?= target.stone
					if c /= Void then
						class_i := c.class_i
						if class_i /= Void then
							class_c := class_i.compiled_class
							create test_file.make (class_i.file_name)
							if
								test_file.exists
									and then
								test_file.is_writable
									and then
								(
									class_c = Void
										or else
									class_i.cluster = Void
										or else
									not (class_i.cluster.is_library or class_c.is_precompiled)
								)
							then
								create cg.make (class_i)
								cg.new_feature
							else
								create wd.make_with_text (Warning_messages.W_class_not_modifiable)
								wd.show_modal_to_window (target.window)	
							end
						end
					end
				else
					create wd.make_with_text (Warning_messages.w_Unsufficient_compilation (3))
					wd.show_modal_to_window (target.window)
				end
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Create_new_feature
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_new_feature
		end

	mini_pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command for mini toolbars.
		do
			Result := Pixmaps.Icon_new_feature_small
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Create_new_feature
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.f_Create_new_feature
		end

	name: STRING is "New_feature"
			-- Name of the command. Used to store the command in the
			-- preferences.

end -- class EB_NEW_FEATURE_COMMAND
