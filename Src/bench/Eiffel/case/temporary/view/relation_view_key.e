indexing

	description: "Key to identify a relationship.";
	date: "$Date$";
	revision: "$Revision $"

class RELATION_VIEW_KEY

creation

	make

feature {NONE} -- Initialization

	make (relation_data: RELATION_DATA_KEY) is
			-- Initialize Current with `relation_data'
		do
			from_view_id := relation_data.f_rom.view_id;
			to_view_id := relation_data.t_o.view_id;
		ensure
			initialized: from_view_id = relation_data.f_rom.view_id and then
					to_view_id = relation_data.t_o.view_id
		end;

feature -- Properties

	from_view_id: INTEGER;
			-- View identifer from the source link
			
	to_view_id: INTEGER;
			-- View identifer from the destination link

end -- class RELATION_VIEW_KEY
