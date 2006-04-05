indexing
	description	: "Command to create a new feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_NEW_FEATURE_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			mini_pixmap,
			tooltext
		end

	EB_DEVELOPMENT_WINDOW_COMMAND

	SHARED_WORKBENCH

	CONF_REFACTORING

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
				create wd.make_with_text (Warning_messages.w_could_not_modify_class)
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
							conf_todo
--							if
--								test_file.exists and then test_file.is_writable and then
--								(
--									class_c = Void or else class_i.cluster = Void or else
--									not (class_i.cluster.is_library or class_c.is_precompiled)
--								)
--							then
--								create cg.make (class_i)
--								cg.new_feature
--							else
--								create wd.make_with_text (Warning_messages.W_class_not_modifiable)
--								wd.show_modal_to_window (target.window)
--							end
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

feature -- Access

	mini_pixmap: EV_PIXMAP is
			-- Pixmap representing the command for mini toolbars.
		do
			Result := pixmaps.small_pixmaps.icon_new_feature
		end

feature {NONE} -- Implementation

	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Create_new_feature
		end

	pixmap: EV_PIXMAP is
			-- Pixmap representing the command.
		do
			Result := Pixmaps.Icon_new_feature
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Create_new_feature
		end

	tooltext: STRING is
			-- Text for the toolbar button.
		do
			Result := Interface_names.b_Create_new_feature
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.f_Create_new_feature
		end

	name: STRING is "New_feature";
			-- Name of the command. Used to store the command in the
			-- preferences.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_NEW_FEATURE_COMMAND
