indexing

	description:
		"Abstract notion of command selected from feature batch menu"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class EWB_FEATURE

inherit

	EWB_FILTER_CLASS
		rename
			make as filter_class_make,
			execute as class_execute
		redefine
			loop_action, process_compiled_class,
			want_compiled_class
		end;
	EWB_FILTER_CLASS
		rename
			make as filter_class_make
		redefine
			loop_action, process_compiled_class,
			want_compiled_class, execute
		select
			execute
		end

feature -- Initialization

	make (cn, fn, filter: STRING) is
			-- Initialize Current with class_name `class_name',
			-- feature_name `feature_name', and filter `filter_name'.
		require
			non_void_cn: cn /= Void;
			non_void_fn: fn /= Void;
		do
			class_make (cn);
			feature_name := fn;
			feature_name.to_lower;
			init (filter)
		ensure
			feature_set: feature_name = fn;
		end;

feature -- Properties

	feature_name: STRING;
			-- Feature_name for current menu selection

	want_compiled_class (class_i: CLASS_I): BOOLEAN is
			-- Does current menu selection want `class_i" to be compiled?
			-- (Yes it does)
		do
			Result := True
		end;

feature {NONE} -- Implementation property

	associated_cmd: E_FEATURE_CMD is
			-- Associated feature command to be executed
			-- after successfully retrieving the feature_i
		deferred
		end;

feature {NONE} -- Implementation

	loop_action is
		do
			command_line_io.get_class_name;
			class_name := command_line_io.last_input;
			command_line_io.get_feature_name;
			feature_name := command_line_io.last_input;
			command_line_io.get_filter_name;
			filter_name := command_line_io.last_input;
			check_arguments_and_execute
		end;

	execute is
		do
			if class_name = Void then
				command_line_io.get_class_name;
				class_name := command_line_io.last_input;
			end;
			class_execute
		ensure then
			feature_name_cleared: feature_name = Void
		end

	process_compiled_class (e_class: CLASS_C) is
			-- Retrieve feature from `class_c' with
			-- `feature_name' and execute associated command.
		local
			e_feature: E_FEATURE;
		do
			if feature_name = Void then
				command_line_io.get_feature_name;
				feature_name := command_line_io.last_input;
			end;
			if not command_line_io.abort then
				e_feature := e_class.feature_with_name (feature_name);
				if e_feature = Void then
					io.error.put_string (feature_name);
					io.error.put_string (" is not a feature of ");
					io.error.put_string (class_name);
					io.error.put_new_line
				else
					process_feature (e_feature, e_class)
				end;
			end;
			feature_name := Void;
		end;

	process_feature (e_feature: E_FEATURE; e_class: CLASS_C) is
			-- Process feature `feature_i' defined in `class_c'.
		require
			valid_e_feature: e_feature /= Void;
			valid_e_class: e_class /= Void
		local
			cmd: like associated_cmd;
			filter: TEXT_FILTER
		do
			cmd := associated_cmd;
			if filter_name /= Void and then not filter_name.is_empty then
				create filter.make (filter_name);
				cmd.make (filter, e_feature);
				cmd.execute;
				output_window.put_string (filter.image)
			else
				cmd.make (output_window, e_feature);
				cmd.execute;
			end;
			output_window.put_new_line
		end

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

end -- class EWB_FEATURE
