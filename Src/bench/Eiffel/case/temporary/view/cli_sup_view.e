indexing

	description: "View information for a client-supplier relation.";
	date: "$Date$";
	revision: "$Revision $"

class CLI_SUP_VIEW

inherit

	RELATION_VIEW
		rename
			make as relation_make,
			update_data as relation_update_data
		end;
	RELATION_VIEW
		rename
			make as relation_make
		redefine
			update_data
		select
			update_data
		end

creation

	make

feature {NONE} -- Initialization

	make (relation_data: CLI_SUP_DATA) is
		do
			relation_make (relation_data)
			update_from (relation_data)
		end

feature -- Properties

	is_left_position: BOOLEAN;
			-- Is 'label' on the left side of relation ?

	is_vertical_text: BOOLEAN;
			-- Is 'label' written vertically ?

	is_reverse_link: BOOLEAN;
			-- Is Current a reverse link ?

	is_aggregation: BOOLEAN;
			-- Is this link an aggregation link ?

	shared: INTEGER;
			-- Number of shared features of this link

	multiplicity: INTEGER;
			-- Multiplicity of this link

	label_view: LABEL_VIEW is
			-- Associated label view
		do
		end;

feature -- Setting

	update_from (relation_data: CLI_SUP_DATA) is
			-- Update Current from `relation_data'.
		do
			is_left_position := relation_data.is_left_position;
			is_vertical_text := relation_data.is_vertical_text;
			is_reverse_link := relation_data.is_reverse_link;
			is_aggregation := relation_data.is_aggregation;
			shared := relation_data.shared;
			multiplicity := relation_data.multiplicity;
			set_label_view (relation_data.label.storage_info);
		ensure then
			set: 
				is_left_position = relation_data.is_left_position and then
				is_vertical_text = relation_data.is_vertical_text and then
				is_reverse_link = relation_data.is_reverse_link and then
				is_aggregation = relation_data.is_aggregation and then
				shared = relation_data.shared and then
				multiplicity = relation_data.multiplicity;
		end;

	update_data (relation_data: CLI_SUP_DATA) is
			-- Update `relation_data' from Current.
		local
			reverse_link: CLI_SUP_DATA;
			comp_link: COMP_CLI_SUP_DATA
		do
			if is_reverse_link then
					-- To be processed later on. At this point
					-- not all suppliers and clients have been
					-- recorded for compressed links. (BTW, it was not
					-- necessary to do this for non compressed links but
					-- we might as well group them into one list which will be
					-- processed in one routine later on - `retrieve_reverse_links'
					-- in class VIEW_INFO)
				view_information.add_reverse_comp_link (relation_data)
			end;
			relation_update_data (relation_data);
			if label_view /= Void then
				label_view.update_data (relation_data.label);
			end;
			relation_data.set_multiplicity (multiplicity, false);
			relation_data.set_shared_value (shared, false);
			relation_data.set_aggregation (is_aggregation);
			if is_left_position then
				relation_data.change_label_position
			end;
			if is_vertical_text then
				relation_data.change_label_orientation
			end;
		end;

	set_label_view (v: like label_view) is
			-- Set label_view to `v'.
		require
			valid_v: v /= Void
		do
		end;

end -- class CLI_SUP_VIEW
