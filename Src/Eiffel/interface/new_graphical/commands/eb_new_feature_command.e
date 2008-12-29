note
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
			mini_pixel_buffer,
			tooltext,
			pixel_buffer
		end

	EB_DEVELOPMENT_WINDOW_COMMAND

	SHARED_WORKBENCH

create
	make

feature -- Basic operations

	execute
			-- Pop up feature wizard.
		local
			c: CLASSI_STONE
			class_i: CLASS_I
			cg: CLASS_TEXT_MODIFIER
			class_c: CLASS_C
			retried: BOOLEAN
		do
			if retried then
				prompts.show_error_prompt (Warning_messages.w_could_not_modify_class, target.window, Void)
			else
				if
					Workbench.last_reached_degree <= 2
				then
					c ?= target.stone
					if c /= Void then
						class_i := c.class_i
						if class_i /= Void then
							class_c := class_i.compiled_class
							if not class_i.is_read_only then
								create cg.make (class_i)
								cg.new_feature
							else
								prompts.show_error_prompt (Warning_messages.W_class_not_modifiable, target.window, Void)
							end
						end
					end
				else
					prompts.show_error_prompt (Warning_messages.w_Unsufficient_compilation (3), target.window, Void)
				end
			end
		rescue
			retried := True
			retry
		end

feature -- Access

	mini_pixmap: EV_PIXMAP
			-- Pixmap representing the command for mini toolbars.
		do
			Result := pixmaps.mini_pixmaps.new_feature_icon
		end

	mini_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command for mini toolbars.
		do
			Result := pixmaps.mini_pixmaps.new_feature_icon_buffer
		end

feature {NONE} -- Implementation

	menu_name: STRING_GENERAL
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Create_new_feature
		end

	pixmap: EV_PIXMAP
			-- Pixmap representing the command.
		do
			Result := pixmaps.icon_pixmaps.new_feature_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.new_feature_icon_buffer
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Create_new_feature
		end

	tooltext: STRING_GENERAL
			-- Text for the toolbar button.
		do
			Result := Interface_names.b_Create_new_feature
		end

	description: STRING_GENERAL
			-- Description for this command.
		do
			Result := Interface_names.f_Create_new_feature
		end

	name: STRING = "New_feature";
			-- Name of the command. Used to store the command in the
			-- preferences.

note
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
