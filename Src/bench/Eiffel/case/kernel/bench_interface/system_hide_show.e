indexing
	description: "Information about hide/show for System_data"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_HIDE_SHOW

inherit
	ONCES

feature -- attributes

	is_aggreg_hidden: BOOLEAN
	is_client_hidden: BOOLEAN
	is_grid_magnetic: BOOLEAN
	is_grid_visible: BOOLEAN
	is_inheritance_hidden: BOOLEAN
	is_label_hidden: BOOLEAN
	grid_spacing : INTEGER
	show_all_relations: BOOLEAN
		
	show_bon : BOOLEAN

feature -- functions

	set_show_all_relations (b: BOOLEAN) is
			-- Set show_all_relations to `b'
		do
			show_all_relations := b
		ensure
			show_all_relations = b
		end;

	set_show_bon ( b: BOOLEAN ) is
		do
			show_bon := b
		end

	set_is_client_hidden (b: BOOLEAN) is
			-- Set is_client_hidden to `b'
		do
			is_client_hidden := b
		ensure
			is_client_hidden = b
		end;

	set_is_label_hidden (b: BOOLEAN) is
			-- Set is_label_hidden to `b'
		do
			is_label_hidden := b
		ensure
			is_label_hidden = b
		end;

	set_is_inheritance_hidden (b: BOOLEAN) is
			-- Set is_inheritance_hidden to `b'
		do
			is_inheritance_hidden := b
		ensure
			is_inheritance_hidden = b
		end;

	set_is_aggreg_hidden (b: BOOLEAN) is
			-- Set is_aggreg_hidden to `b'
		do
			is_aggreg_hidden := b
		ensure
			is_aggreg_hidden = b
		end;

	set_grid_visible (value: like is_grid_visible) is
			-- Set `grid_visible'.
		do
			is_grid_visible := value
		ensure
			is_grid_visible = value
		end;

	set_grid_magnetic (value: like is_grid_magnetic) is
			-- Set `grid_magnetic'.
		do
			is_grid_magnetic := value
		ensure
			is_grid_magnetic = value
		end;

	set_grid_spacing (value: like grid_spacing) is
			-- Set `grid_spacing'.
		require
			value_greater_than_10: value >= 10;
			value_less_than_40: value <= 40
		do
			grid_spacing := value
		ensure
			grid_spacing = value
		end

end -- Class system_hide_show
