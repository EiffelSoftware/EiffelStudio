indexing

	description: 
		"Stone based on feature name."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_NAME_STONE

inherit

	FEATURE_STONE
		rename
			make as old_make
		redefine
			check_validity, history_name, feature_name
		end 

create 
		
	make

feature {NONE} -- Initialization

	make (f_name: STRING; ec: CLASS_C) is
		require
			valid_f_name: f_name /= Void;
		do
			e_class := ec;
			feature_name := f_name;
			start_position := -1;
			end_position := -1;
		end;

feature -- Properties

	feature_name: STRING;
			-- Feature name

	history_name: STRING is
			-- Name used in the history list
		do
			create Result.make (0);
			Result.append (feature_name);
			Result.append (" from ");
			Result.append (e_class.name_in_upper)
		end;

feature -- Update

	check_validity is
			-- Check the validity of the stone.
		local
			feat: E_FEATURE
		do
			if start_position /= 0 then
				-- Means check has been done and is
				-- invalid
				if e_class /= Void then
						-- Find e_feature from feature_name.
					if e_class.feature_table /= Void then
							-- System has been completely compiled and has all its
							-- feature tables.
						feat := e_class.feature_with_name (feature_name);
						if feat /= Void then
							e_feature := feat;
							if start_position = -1 then
									-- calculate positions
								Precursor {FEATURE_STONE}	
							end
						end
					end
				end
			end
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class FEATURE_NAME_STONE
