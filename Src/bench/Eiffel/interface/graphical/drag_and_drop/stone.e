indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
deferred class STONE 

inherit

	STONE_TYPES;
	EB_CONSTANTS
	
feature -- Properties

	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
			-- (An uncompiled class  is not clickable, but a compiled class is).
		deferred
		end

	icon_name: STRING is
			-- Icon name for tool when editing Current 
		deferred
		end;

	stone_name: STRING is 
			-- Name of the Current stone for the UI.
		deferred 
		end;

	stone_type: INTEGER is 
			-- Type determining compatibility and cursor shape
		deferred 
		end;

	stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		deferred
		ensure
			non_void: Result /= Void
		end;

	x_stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		deferred
		ensure
			non_void: Result /= Void
		end;

feature -- Update

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		require
			non_void_hole: hole /= Void
		deferred
		end;

feature  -- Access

	help_text: LINKED_LIST [STRING] is
			-- Explaination of what current element means,
			-- "No help available" by default
		once
			create Result.make;
			Result.put_front (Interface_names.h_No_help_available)
		end;

	click_list: ARRAY [CLICK_STONE] is 
			-- Structure to make clickable the display of `origin_text'
		deferred 
		end;

	origin_text: STRING is
			-- What's shown by default usually. The others representations are
			-- callled `formats' or `displays' ...
			-- All stones have a textual representation that defines them
			-- unambiguously: ace text, class text, feature text, tagged_out...
			-- well, this is it!
		require
			valid_stone: is_valid
		deferred
		end;

	stone_signature: STRING is 
			-- Short string to explain Current
		deferred 
		end;

	header: STRING is 
			-- Short string to explain Current
			-- (By default, it is the stone_signature)
		do 
			Result := stone_signature 
		end;

	history_name: STRING is 
			-- Name used in the history list
			-- (By default, it is the stone_signature)
		do 
			Result := stone_signature 
		end;

	is_valid: BOOLEAN is
			-- Is `Current' a valid stone?
		do
			Result := True
		end;

	invalid_stone_message: STRING is
			-- Message displayed for an invalid_stone
		do
		end;

	synchronized_stone: STONE is
			-- Clone of `Current' after a recompilation
			-- (May be Void if not valid anymore)
		do
			Result := clone (Current)
		ensure
			valid_stone: Result /= Void implies Result.is_valid
		end;

	same_as (other: STONE): BOOLEAN is
			-- Is `other' same as Current?
			--| By default: Result = equal (Current, other).
		local
			o: like Current
		do
				-- System level validity problems
			o ?= other;
			Result := equal (Current, o)
		end

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

end -- class STONE
