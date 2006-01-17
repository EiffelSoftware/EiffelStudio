indexing

	description: 
		"Stone representing an eiffel class."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class CLASSC_STONE

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
	HASHABLE_STONE
		undefine
			header
		redefine
			is_valid, synchronized_stone, invalid_stone_message
		end;
	WINDOWS
	
	PLATFORM_CONSTANTS

create

	make
	
feature {NONE} -- Initialization

	make (a_class: CLASS_C) is
			-- Copy all information from argument
			-- OR KEEP A REFERENCE?
		do
			e_class := a_class
		end;

feature -- Properties

	e_class: CLASS_C;

feature -- Access

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
		do
			Result := e_class.class_signature
		end;

	icon_name: STRING is
		do
			Result := clone (e_class.name)
			Result.to_upper;
		end;

	header: STRING is
			-- Display class name, class' cluster and class location in 
			-- window title bar.
		do
			create Result.make (20);
			Result.append (stone_signature);
			Result.append ("  in cluster ");
			Result.append (e_class.cluster.cluster_name);
			if e_class.is_precompiled then
				Result.append ("  (precompiled)")
			else
				Result.append ("   located in ")
				Result.append (e_class.lace_class.cluster.path)
				Result.append_character (Directory_separator)
				Result.append (e_class.lace_class.base_name)
			end

			if e_class.lace_class.is_read_only then
				Result.append (" [READ-ONLY]")
			end
		end;

	stone_type: INTEGER is 
		do 
			Result := Class_type 
		end;

	stone_name: STRING is 
		do 
			Result := Interface_names.s_Class_stone
		end;
 
	click_list: CLICK_STONE_ARRAY is
		local
			c_list: CLICK_LIST
		do
			c_list := e_class.click_list;
			if c_list /= Void then
				create Result.make (c_list, e_class)
			end
		end;
 
	file_name: STRING is
			-- The one from CLASSC
		do
			if e_class /= Void then
				Result := e_class.file_name
			end
		end;

	set_file_name (s: STRING) is 
		do 	
		end;

	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
		do
			Result := e_class.has_ast
		end

feature -- Status report

	is_valid: BOOLEAN is
			-- Is `Current' a valid stone?
		do
			Result :=  fs_valid and then e_class /= Void
		end;

	invalid_stone_message: STRING is
			-- Message displayed for an invalid_stone
		do
			Result := Warning_messages.w_Class_not_in_universe
		end;

feature -- Synchronization

	synchronized_stone: STONE is
			-- Clone of `Current' stone after a recompilation
			-- (May be Void if not valid anymore. It may also be a 
			-- classi_stone if the class is not compiled anymore)
		local
			new_cluster: CLUSTER_I
		do
			if e_class /= Void then
				if e_class.is_valid then
					create {CLASSC_STONE} Result.make (e_class)
				else
					new_cluster := Eiffel_universe.cluster_of_name 
							(e_class.cluster.cluster_name);
					if 
						new_cluster /= Void and then
						new_cluster.classes.has_item (e_class.lace_class)
					then
						create {CLASSI_STONE} Result.make (e_class.lace_class)
					end
				end
			end
		end;

feature -- Hashable

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := e_class.name.hash_code
		end;

feature -- Update

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			if is_valid then
				hole.process_class (Current)
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

end -- class CLASSC_STONE
