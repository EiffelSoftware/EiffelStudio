indexing

	description: 
		"Abstract data representation of a client%
		%supplier compressed link.";
	date: "$Date$";
	revision: "$Revision $"

class COMP_INHERIT_DATA

inherit

	COMP_LINK_DATA [INHERIT_KEY]
		rename
			f_rom as heir,
			t_o as parent
		undefine
			store_information
		redefine
			symbol
		select
			remove_from_system, put_in_system
		end

	INHERIT_DATA
		rename
			put_in_system as put_relation_in_system,
			remove_from_system as remove_relation_from_system
		undefine
			is_compressed, to_and_from_are_valid,
			is_equal, generate_name, update_system_defined
		redefine
			symbol,make
		end

creation

	make

feature -- Initialization

	make (a_heir, a_parent: LINKABLE_DATA) is
		do
			precursor (a_heir, a_parent)
			make_list
		end

feature -- Properties

	--cursor: SCREEN_CURSOR is
	--	do
		--	Result := Cursors.comp_inherit_cursor
	--	end;

	symbol: EV_PIXMAP is
		do
		--	Result := Pixmaps.selected_comp_inherit_pixmap
		end;

end -- class COMP_INHERIT_DATA
