indexing

	description: 
		"Data representation of client-supplier%
		%relationship (reference, aggregation).";
	date: "$Date$";
	revision: "$Revision $"

class CLI_SUP_DATA 


inherit

	RELATION_DATA
		rename
			f_rom as client, t_o as supplier
		redefine
			is_visible
		end

creation

	make_ref, make_aggreg, make_reflexive, make_from_storer

feature {NONE} -- Initialization

	make_ref (a_client, a_supplier: LINKABLE_DATA) is
			-- Create a CLI_SUP_DATA object with `a_client' and
			-- `a_supplier' as extremities of the current
			-- client-supplier link.
		require
			client_exists: a_client /= void;
			supplier_exists: a_supplier /= void;
		local
			class_data	: CLASS_DATA
		do
			client := a_client
			supplier := a_supplier

			class_data	?= a_supplier
		
			if class_data /= Void
			then
				generics := deep_clone ( class_data.generics ) -- pascalf
			end

			!! break_points.make
			!! label.make (0)
		ensure
			client_correctly_set: client = a_client;
			supplier_correctly_set: supplier = a_supplier;
			is_a_reference_link: not is_aggregation and not is_reflexive;
			not_in_system: not is_in_system
		end; -- make_ref

	make_reflexive (a_client_supplier: LINKABLE_DATA) is
			-- Create a CLI_SUP_DATA object with `a_client_supplier'
			-- as extremities of the current client-supplier link.
		require
			client_supplier_exists: a_client_supplier /= Void;
		do
			client := a_client_supplier;
			supplier := a_client_supplier;
			is_reflexive := true;
			!! break_points.make;
			!! label.make (0)
		ensure
			client_supplier_correctly_set :
						client = a_client_supplier and
						supplier = a_client_supplier;
			is_a_reflexive_link: is_reflexive and not is_aggregation;
			not_in_system: not is_in_system
		end; -- make_reflexive

	make_aggreg (a_client, a_supplier: LINKABLE_DATA) is
			-- Create a CLI_SUP_DATA object with `a_client' and
			-- `a_supplier' as extremities of the current
			-- client-supplier link.
		require
			client_exists: a_client /= void;
			supplier_exists: a_supplier /= void;
		do
			client := a_client;
			supplier := a_supplier;
			is_aggregation := true;
			!! break_points.make;
			!! label.make (0)
		ensure
			client_correctly_set: client = a_client;
			supplier_correctly_set: supplier = a_supplier;
			is_an_aggregation_link: is_aggregation and not is_reflexive;
			not_in_system: not is_in_system
		end 

feature -- Properties

	is_in_reverse_link: BOOLEAN is
			-- Is Current in a reverse link ?
			-- (is it used as reverse_link in
			-- another cli_sup_data?)
		do
			Result := in_reverse_link /= Void
		end

	is_left_position: BOOLEAN
			-- Is 'label' on the left side of relation ?

	is_vertical_text: BOOLEAN
			-- Is 'label' written vertically ?

	is_reflexive: BOOLEAN
			-- Is this link an reflexive link ?

	shared: INTEGER
			-- Number of shared features of this link

	multiplicity: INTEGER;
			-- Multiplicity of this link

	label: LABEL_DATA;
			-- Label associated with Current link

	key: CLI_SUP_KEY is
		do
			!! Result.make_with_relation (Current)
		end;

	already_in_system: BOOLEAN is
			-- Is Current already defined?
		do
			Result := client.client_link_of (supplier) /= Void
		end;

	is_reverse_link: BOOLEAN is
			-- Is this a reverse link ?
		do
			Result := reverse_link /= Void
		end;

	is_visible: BOOLEAN is
			-- Is current visible for drawing?
		do
			Result := not is_in_compressed_link and then
				not is_in_reverse_link
		end;

	reverse_link: like Current;

	in_reverse_link: like Current;
			-- the reverse_link that contains this link

	is_reverse_aggregation: BOOLEAN is
			-- Is the reverse link an aggregation ?
		do
			if is_reverse_link then 
				Result := reverse_link.is_aggregation
			end
		end;

	reverse_label: like label is
			-- Label of the reverse link if it exists
		do
			if is_reverse_link then
				Result := reverse_link.label
			end
		end

	is_reverse_left_position: BOOLEAN is
			-- Is 'reverse_label' on left side of reverse link ?
		do
			if is_reverse_link then
				Result := reverse_link.is_left_position
			end
		end;

	is_reverse_vertical_text: BOOLEAN is
			-- Is 'reverse_label' wrote vertically ?
		do
			if is_reverse_link then
				Result := reverse_link.is_vertical_text
			end;
		end;

	reverse_shared: INTEGER is
			-- Number of shared features of reverse link
		do
			if is_reverse_link then
				Result := reverse_link.shared
			end
		end;

	reverse_multiplicity: INTEGER is
			-- Multiplicity of reverse link
		do
			if is_reverse_link then
				Result := reverse_link.multiplicity
			end
		end;

	is_client: BOOLEAN is 
			do
				Result := not is_aggregation
			end

	is_aggregation: BOOLEAN 

	destroy_command: DESTROY is
		do
			if is_aggregation then
				!DESTROY_AGGREGATION!Result.make (Current)
			else
				!DESTROY_REFERENCE!Result.make (Current)
			end
		end;

	--cursor: SCREEN_CURSOR is
	--		-- Cursor associated with
			-- current stone during transport.
	--	do
		--	if is_aggregation then
		--	--	Result := Cursors.aggreg_cursor
		--	else
		--		Result := Cursors.client_cursor
		--	end
	--	end;

	symbol: EV_PIXMAP is
		do
			if is_aggregation then
		--		Result := Pixmaps.aggreg_pixmap
			else
		--		Result := Pixmaps.client_pixmap
			end
		end;

	is_shared: BOOLEAN is
			-- Is Current shared?
		do
			Result := shared /= 0 
		end;

	is_reverse_shared: BOOLEAN is
			-- Is Current reverse link shared?
		do
			Result := reverse_shared /= 0 
		end;

	has_shared_break_points: BOOLEAN is
			-- Does Current have break points that 
			-- shared ?
		do
			if not break_points.empty then
				from
					break_points.start
				until
					Result or else break_points.after
				loop
					Result := break_points.item.shared > 1;
					break_points.forth
				end
			end
		end;

	default_color : EV_COLOR is
			--default color
		do
				Result := Resources.get_color("link_supplier") 
		end

	has_supplier_name	( s : STRING )	: BOOLEAN	is
	do
		if	supplier	/= void
		then
			Result	:= supplier.has_name	( s	)
		else
			Result	:= t_o_name.is_equal	( s	)
		end
	end

	has_client_name	( s : STRING )	: BOOLEAN	is
	do
		if	client	/= void
		then
			Result	:= client.has_name	( s	)
		else
			Result	:= f_rom_name.is_equal	( s	)
		end
	end

feature -- Access

	reverse_to_handle_nbr: INTEGER is
			-- Reverse to handle nbr in terms of Current
			-- link (not from reverse link)
		require
			is_reverse_link: is_reverse_link;
			reverse_label.to_handle_nbr <= break_points.count + 2
		do
			Result := break_points.count + 3 - reverse_label.to_handle_nbr
		ensure
			valid_result: Result >= 1 and then Result <= break_points.count + 2
		end;

	reverse_from_handle_nbr: INTEGER is
			-- Reverse from_handle nbr in terms of Current
			-- link (not from reverse link)
		require
			is_reverse_link: is_reverse_link
			reverse_label.from_handle_nbr <= break_points.count + 2
		do
			Result := break_points.count + 3 - reverse_label.from_handle_nbr
		ensure
			valid_result: Result >= 1 and then Result <= break_points.count + 2
		end;

feature -- Setting

	set_shared_value (a_value: like shared; reverse: BOOLEAN) is
			-- Set 'shared' to 'a_value'
		do
			if reverse then
				reverse_link.set_shared_value (a_value, false)
			else
				shared := a_value
			end
		ensure
			shared_correctly_set: shared = a_value or
						reverse_shared = a_value
		end; 

	set_multiplicity (a_value: like multiplicity; reverse: BOOLEAN) is
			-- Set 'multiplicity' to 'a_value'
		do
			if reverse then
				reverse_link.set_multiplicity (a_value, false)
			else
				multiplicity := a_value
			end
		ensure
			multiplicity_correctly_set: multiplicity = a_value or
						reverse_multiplicity = a_value
		end;

	set_reverse_label (new_reverse_label: STRING) is
		require
			has_new_label: new_reverse_label /= void
		do
			reverse_link.set_label (new_reverse_label)
		end; 

	set_label (new_label: STRING) is
		require
			has_new_label: new_label /= void
		do
			label.update_from (new_label)
		end; 

	set_supplier	( l : LINKABLE_DATA	) is
	do
		supplier	:= l
	end

	set_client	( l : LINKABLE_DATA	) is
	do
		client	:= l
	end

feature -- Element Change

	add_link is
			-- Put the link in the system.
		local
			st : STRING
		do
			if client = Void or else supplier = Void then
				!! st.make ( 50)
				st.append("Lost client relation from ");
				if client /= Void then
					st.append(client.name);
				else
					st.append ("???");
				end;
					st.append (" to ");
				if supplier /= Void then
					st.append (supplier.name);
				else
					st.append ("???");
				end;
				Windows_manager.add_error_message(st)
			else
				client.add_client_link (Current);
				if not is_reflexive then
					supplier.add_supplier_link (Current)
				end;
				is_in_system := true
			end;
		end; 

	add_shared (reverse: BOOLEAN) is
			-- Add shared capability to current link
		require
			is_not_shared: shared = 0 or reverse_shared = 0
		do
			if reverse then
				reverse_link.add_shared (false)
			else
				shared := 1
			end
		ensure
			is_shared: shared /= 0 or reverse_shared /= 0
		end; 

	add_multiplicity (reverse: BOOLEAN) is
			-- Add multiplicity capability to current link
		require
			is_not_multiplie: multiplicity = 0 or
					reverse_multiplicity = 0
		do
			if reverse then
				reverse_link.add_multiplicity (false)
			else
				multiplicity := 2
			end
		ensure
			is_multiplie: multiplicity /= 0 or
					reverse_multiplicity /= 0
		end;

	change_label_position is
		do
			is_left_position := not is_left_position
		ensure
			position_correctly_set: old is_left_position = 
										not is_left_position
		end;

	change_label_orientation is
		do
			is_vertical_text := not is_vertical_text
		ensure
			orientation_correctly_set: old is_vertical_text
											= not is_vertical_text
		end;

	change_reverse_label_position is
		require
			is_reverse_link: is_reverse_link
		do
			reverse_link.change_label_position
		ensure
			position_correctly_set: old is_reverse_left_position =
						not is_reverse_left_position
		end; -- change_reverse_label_position

	change_reverse_label_orientation is
		require
			is_reverse_link: is_reverse_link
		do
			reverse_link.change_label_orientation
		ensure
			orientation_correctly_set: old is_reverse_vertical_text =
							not is_reverse_vertical_text
		end; -- change_reverse_label_orientation

	add_reverse_link (link: like reverse_link) is
			-- Turn current link into a double link and precise if
			-- the reverse link is an aggregation or not
		require
			client_exists: client /= Void;
			supplier_exists: supplier /= Void;
			not_in_a_reverse_link: not is_in_reverse_link
		do
			reverse_link := link;
			reverse_link.set_in_reverse_link (Current)
		ensure
			has_reverse_link: is_reverse_link;
		end; -- add_reverse_link

	set_in_reverse_link (link: like in_reverse_link) is
			-- link is in reverse_link 'link'
			-- 'link' be Void (if not in reverse link)
		do
			in_reverse_link := link
		end


feature -- Removal

	remove_from_system is
			-- Remove the link from the system.
		local
			comp_link: COMP_LINK_DATA [RELATION_DATA_KEY]
			inh: INHERIT_DATA
			cli_sup: CLI_SUP_DATA
			c_l: SORTED_TWO_WAY_LIST [CLI_SUP_DATA]
		do
			clear_editor;
			if is_in_compressed_link then
				comp_link := find_compressed_link
				if comp_link /= Void then -- FIXME PASCAL
					comp_link.remove_relation (Current)
					if comp_link.empty then
						comp_link.remove_from_system

						inh ?= comp_link
						if inh /= Void then
							workareas.destroy_inherit (inh)
						else
							cli_sup ?= comp_link
							workareas.destroy_reference (cli_sup)
						end
					end
				end
			end
			c_l := client.client_links
			if c_l /= Void then
				c_l.start;
				c_l.prune (Current);
				if not is_reflexive then
					supplier.supplier_links.start;
					supplier.supplier_links.prune (Current)
				end;
				decrement_points_shared;
				is_in_system := false
			end
		end -- remove_from_system

	remove_shared (reverse: BOOLEAN) is
			-- Remove shared capability of current link
		require
			is_shared: shared /= 0 or reverse_shared /= 0
		do
			if reverse then
				reverse_link.remove_shared (false)
			else
				shared := 0
			end
		ensure
			is_not_shared: shared = 0 or reverse_shared = 0
		end; 

	remove_multiplicity (reverse: BOOLEAN) is
			-- Remove multiplicity capability of current link
		require
			is_multiplie: multiplicity /= 0 or
					reverse_multiplicity /= 0
		do
			if reverse then
				reverse_link.remove_multiplicity (false)
			else
				multiplicity := 0
			end
		ensure
			is_not_multiplie: multiplicity = 0 or
					reverse_multiplicity = 0
		end; 

	remove_reverse_link is
			-- Turn current link into a simple link
		require
			has_reverse_link: is_reverse_link
		do
			reverse_link.set_in_reverse_link (Void);
			reverse_link := Void;
		ensure
			has_no_reverse_link: not is_reverse_link
		end; 

feature -- Comparison

	same_as (other: RELATION_DATA): BOOLEAN is
		do
			Result := is_client = other.is_client and then
				is_aggregation = other.is_aggregation
		end;

feature -- Output

		to_focus : BOOLEAN
		-- is it the entity at the end of the link ?
		
	
		set_to_focus ( b : BOOLEAN ) is
		do
			to_focus := b
		end

	focus: STRING is
		do
			!! Result.make (20);
			if is_reverse_link then
				Result.append ("*");
			else
				if not to_focus then
					if	client	/= void
					then
						Result.append(client.name)
					else
						Result.append	( f_rom_name	)
					end
					Result.append(" : client")
				else
					if	supplier	/= void
					then
						Result.append	( supplier.name)
					else
						Result.append	( t_o_name	)
					end
					Result.append(" : supplier")
				end
			end
		end;

feature -- Storage

	storage_info: S_CLI_SUP_DATA is
		do
		--	!! Result;
		--	store_information (Result);
		--	if not label.empty then
		--		Result.set_label (label.string_value);
		--	end;
		--	Result.set_implementation (is_implementation);
		--	Result.set_reflexive (is_reflexive);
		end

feature {CLI_SUP_VIEW} -- Implementation

	set_aggregation (b: BOOLEAN) is
		do
			is_aggregation := b
		end;

invariant

	has_label: label /= void

end -- class CLI_SUP_DATA
