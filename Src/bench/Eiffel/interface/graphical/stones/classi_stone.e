indexing

	description: 
		"Stone representing an uncompiled eiffel class."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class CLASSI_STONE 

inherit

	FILED_STONE
		rename
			is_valid as fs_valid
		redefine
			synchronized_stone, invalid_stone_message
		end;
	FILED_STONE
		redefine
			is_valid, synchronized_stone, invalid_stone_message
		select
			is_valid
		end;
	SHARED_EIFFEL_PROJECT;
	WINDOWS

	PLATFORM_CONSTANTS

create

	make
	
feature {NONE} -- Initialization

	make (aclassi: CLASS_I) is
			-- Copy all information from argument
			-- OR KEEP A REFERENCE?
		do
			class_i := aclassi
		end;

feature -- Properites
 
	class_i: CLASS_I;

feature -- Access

	file_name: STRING is
		do
			Result := class_i.file_name
		end;

	stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := Cursors.cur_Class
		end;

	x_stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			Result := Cursors.cur_X_Class
		end;

	stone_signature: STRING is
			-- Name and indication that the class is not compiled
		do
			Result := clone (class_i.name)
			Result.to_upper
		end;

	icon_name: STRING is
		do
			Result := clone (class_i.name)
			Result.to_upper
		end;

	header: STRING is
			-- Display class name, class' cluster and class location in 
			-- window title bar.
		do
			create Result.make (20);
			Result.append (stone_signature);
			Result.append ("  in cluster ");
			Result.append (class_i.cluster.cluster_name);
			Result.append ("  (not in system)");
			Result.append ("  located in ")
			Result.append (class_i.cluster.path)
			Result.append_character (Directory_separator)
			Result.append (class_i.base_name)
			if class_i.is_read_only then
				Result.append (" [READ-ONLY]")
			end
		end;
 
	stone_type: INTEGER is do Result := Class_type end;
 
	stone_name: STRING is
		do
			Result := Interface_names.s_Class_stone
		end;
 
--	feature_named (n: STRING): FEATURE_STONE is
--			-- Nothing: class is not compiled
--		do
--		end;

	click_list: ARRAY [CLICK_STONE] is do end;
			-- Unclickable: not compiled
 
	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
			-- No
		do
			Result := False
		end

	is_valid: BOOLEAN is
			-- Is `Current' a valid stone?
		do
			Result := class_i /= Void and then fs_valid
		end;

	invalid_stone_message: STRING is
			-- Message displayed for an invalid_stone
		do
			Result := Warning_messages.w_Class_not_in_universe
		end;

	synchronized_stone: STONE is
			-- Clone of `Current' after a recompilation
			-- (May be Void if not valid anymore. It may also 
			-- be a classc_stone if the class is compiled now)
		local
			new_cluster: CLUSTER_I;
		do
			if class_i /= Void then
				new_cluster := Eiffel_Universe.cluster_of_name 
							(class_i.cluster.cluster_name);
				if
					new_cluster /= Void and then
					new_cluster.classes.has_item (class_i)
				then
					if class_i.compiled then
						create {CLASSC_STONE} Result.make (class_i.compiled_class)
					else
						create {CLASSI_STONE} Result.make (class_i)
					end
				end
			end
		end;

feature -- Setting

	set_file_name (s: STRING) is do end;
 
feature -- Update

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			if is_valid then
				hole.process_classi (Current)
			else
				warner (hole.target.top).gotcha_call (invalid_stone_message)
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

end -- class CLASSI_STONE
