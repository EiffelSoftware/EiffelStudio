indexing

	description: "Data for BON class chart representation.";
	date: "$Date$";
	revision: "$Revision $"

class CLASS_CHART

inherit

	CHART
		rename
			generate as generate_index
		redefine
			storage_info
		end;
	CHART
		redefine
			storage_info, generate
		select
			generate
		end

feature -- Output

	generate (text_area: TEXT_AREA; class_data: CLASS_DATA; is_bon: BOOLEAN) is
		do
			generate_index (text_area, class_data, is_bon);
			generate_inheritance (text_area, class_data);
		end

	generate_inheritance (text_area: TEXT_AREA; class_data: CLASS_DATA) is
			-- Generate inheritance in `text_area' 
			-- using class `class_data'.
		local
			heir_links: LINKED_LIST [INHERIT_DATA];
			inherit_data	: INHERIT_DATA
			link_data: CLASS_DATA
			is_first : BOOLEAN

			parent_class_stone	: PARENT_CLASS_STONE

		do
			heir_links := class_data.heir_links;
			if heir_links /= Void and then not heir_links.empty then
				text_area.append_keyword ("inherits");
				text_area.append_space;
				from
					heir_links.start
					is_first := TRUE
				until
					heir_links.after
				loop
					inherit_data	:= heir_links.item
					link_data ?= inherit_data.parent;
					if	link_data	/= void
					then
						if not is_first then
							text_area.append_string (", ")
						end
						link_data.generate_as_parent	( text_area	, class_data	, inherit_data	)
						is_first := FALSE
					else
						if heir_links.item.t_o_name/=Void then
							if not is_first then
								text_area.append_string (", ")
							end
							!! parent_class_stone.make_parent	( Void	, class_data	)
							text_area.append_clickable_string	( parent_class_stone	, heir_links.item.t_o_name	)
							--text_area.append_string	( heir_links.item.t_o_name	)
							is_first := FALSE
						end
					end
					heir_links.forth
				end
				text_area.new_line
			end;
		end;

feature -- Storage

	storage_info: S_CLASS_CHART is
		local
			l: ARRAYED_LIST [S_TEXT_DATA]
		do
			!! Result;
			store_information (Result);
		end

end -- class CLASS_CHART
