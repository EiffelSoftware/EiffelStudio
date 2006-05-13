indexing

	description:
		"General notion of an eiffel query command (semantic unity)%
		%for a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	E_FEATURE_CMD

inherit
	E_CLASS_CMD
		rename
			make as class_make
		export
			{NONE} class_make
		redefine
			executable
		end

feature -- Initialization

	make (a_text_formatter: TEXT_FORMATTER; a_feature: E_FEATURE) is
			-- Make current command with current_feature as `a_feature'.
		require
			non_void_a_feature: a_feature /= Void
			valid_class: a_feature.associated_class.has_feature_table
		do
			class_make (a_text_formatter, a_feature.associated_class);
			current_feature := a_feature
		ensure
			current_feature_set: current_feature = a_feature
		end;

feature -- Status report

	executable: BOOLEAN is
			-- Is the Current able to be executed?
		do
			Result := current_class /= Void and then
				current_feature /= Void and then
				text_formatter /= Void and then
				has_valid_feature
		ensure then
			good_result: Result implies current_feature /= Void and then
					has_valid_feature
		end

	has_valid_feature: BOOLEAN is
			-- Is current_feature valid?
		do
			Result := current_feature.is_compiled
		end;

feature -- Property

	current_feature: E_FEATURE;
			-- Feature for current action

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

end -- class E_FEATURE_CMD
