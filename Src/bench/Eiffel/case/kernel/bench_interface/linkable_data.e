indexing

	description: 
		"Factorization of entities possibly linked%
		%by relations (Class & Cluster)";
	date: "$Date$";
	revision: "$Revision $"

deferred class LINKABLE_DATA 

inherit

	COLORABLE
		undefine
			update_display
		redefine
			has_elements
		end;
	NAME_DATA
		undefine
			update_display
		redefine
			has_elements
		end;
	COORD_XY_DATA
		undefine
			stone_type,  update_display,
			put_in_cluster, focus 
		redefine
			has_elements
		end

feature -- Properties

	name: STRING
			-- Current name

	view_id: INTEGER;
			-- View id of Current

	is_hidden: BOOLEAN;
			-- Is the current class hidden from view?

	file_name: FILE_NAME;
			-- File name of current

	indexes: HASH_TABLE[STRING,STRING]
			-- Indexes of Current.
			-- It may contain a "description" field.

	heir_links: SORTED_TWO_WAY_LIST [INHERIT_DATA];
			-- List of inheritance relations for which current is the heir

	parent_links: LINKED_LIST [INHERIT_DATA];
			-- List of inheritance relations for which current is the parent

	supplier_links: LINKED_LIST [CLI_SUP_DATA];
			-- List of client/supplier relations for which current
			-- is the supplier

	client_links: SORTED_TWO_WAY_LIST [CLI_SUP_DATA];
			-- List of client/supplier relations for which current
			-- is the client

	id: INTEGER is
			-- Id of Current
		deferred
		end;

	is_class: BOOLEAN is
			-- Is Current a class data?
		deferred
		end

	is_cluster: BOOLEAN is
			-- Is Current a cluster data?
		do
			Result := not is_class
		end;

	has_elements: BOOLEAN is True;

	descendants: LINKED_LIST [LINKABLE_DATA] is
			-- Descendants of current class.
			-- Order is not important (not for displaying purposes).
		do
			!! Result.make;
			if parent_links /= Void then
				from
					parent_links.start
				until
					parent_links.after
				loop
					Result.extend (parent_links.item.heir);
					parent_links.forth
				end;
			end;
		end;

	stone: STONE is
		deferred
		end

	ancestors: SORTED_TWO_WAY_LIST [LINKABLE_DATA] is
			-- Ancestors of current class
			-- Order is important (for displaying purposes)
		do
			if heir_links /= Void then
				!! Result.make;
				from
					heir_links.start
				until
					heir_links.after
				loop
					Result.put_front (heir_links.item.parent);
					heir_links.forth
				end;
				Result.sort
			end;
		end

	workarea: WORKAREA is
		once
--			Result := windows.main_graph_window.draw_window
--		ensure
--			valid_result: Result /= Void
		end;

	set_default is
		deferred
		end

	has_name	( s : STRING	) : BOOLEAN	is
	do
		Result	:= name.is_equal	( s	)
	end


feature -- Access

	description: STRING is
			-- Description of Current
		do

		end

feature -- Link properties

	visible_links: LINKED_LIST [CLI_SUP_DATA] is
			-- Recursive list of all links in current cluster
		do
			!!Result.make;
			if client_links /= void then
				merge_list_into (client_links, Result);
			end;
			if heir_links /= void then
				merge_list_into (heir_links, Result);
			end
		ensure
			valid_result: Result /= void
		end; 

	extern_client_links, recursive_cli_sup_links: LINKED_LIST [CLI_SUP_DATA] is
			-- Recursive list of all links in current cluster
		do
			!!Result.make;
			if client_links /= void then
				merge_list_into (client_links, Result);
			end;
			if supplier_links /= void then
				merge_list_into (supplier_links, Result);
			end
		ensure
			valid_result: Result /= void
		end; 

	extern_inherit_links, recursive_inherit_links: LINKED_LIST [INHERIT_DATA] is
			-- Recursive list of all links in current cluster
		local
			link: INHERIT_DATA
		do
			!!Result.make;
			if heir_links /= void then
				merge_list_into (heir_links, Result);
			end;
			if parent_links /= void then
				merge_list_into (parent_links, Result);
			end
		ensure
			valid_result: Result /= void
		end; 

feature -- Setting

	set_name (s: STRING) is
		deferred
		end;

	set_file_name (s: STRING) is
		require
			valid_s: s /= Void and then not s.empty
		deferred
		end;

	set_description ( desc : STRING ) is
		do
		
		end

	set_hidden (b: BOOLEAN) is
			-- Set is_hidden to `b'.
		do
			is_hidden := b
		ensure
			is_hidden = b
		end; 

feature -- Access

	descendant_of (linkable: LINKABLE_DATA): BOOLEAN is
			-- Is current linkable a descendant of `linkable' ?
		require
			linkable /= void
		do
			if linkable = Current then
				Result := true
			elseif parent_cluster /= void then
				Result := parent_cluster.descendant_of (linkable)
			end
		end; -- descendant_of

	visible_descendant_of (linkable: LINKABLE_DATA): BOOLEAN is
			-- Is current linkable a visible descendant of `linkable' ?
		require
			valid_linkable: linkable /= void
		deferred
		end; -- visible_descendant_of

	contains_linkable (linkable: LINKABLE_DATA): BOOLEAN is
			-- Does current linkable contain `linkable' ?
		require
			valid_linkable: linkable /= void
		deferred
		end; 

	heir_compressed_link_with (a_link: RELATION_DATA): 
				COMP_LINK_DATA [RELATION_DATA_KEY] is
			-- Heir compressed relation data which
			-- has `a_link'
		local
			comp_data: COMP_LINK_DATA [RELATION_DATA_KEY]
		do
			if heir_links /= Void then
				from
					heir_links.start
				until
					heir_links.after or else
					Result /= Void
				loop
					if heir_links.item.is_compressed then
						comp_data ?= heir_links.item;	
						if comp_data.has_link (a_link) then
							Result := comp_data
						end
					end;
					heir_links.forth
				end;
				if Result = Void and then parent_cluster /= Void then
					Result := 
						parent_cluster.heir_compressed_link_with (a_link)
				end;
			end
		end;

	client_compressed_link_with (a_link: RELATION_DATA): 
				COMP_LINK_DATA [RELATION_DATA_KEY] is
			-- Client compressed relation data which
			-- has `a_link'
		local
			comp_data: COMP_LINK_DATA [RELATION_DATA_KEY]
		do
			if client_links /= Void then
				from
					client_links.start
				until
					client_links.after or else
					Result /= Void
				loop
					if client_links.item.is_compressed then
						comp_data ?= client_links.item;	
						if comp_data.has_link (a_link) then
							Result := comp_data
						end
					end;
					client_links.forth
				end;
			end
			if Result = Void and then parent_cluster /= Void then
				Result := 
					parent_cluster.client_compressed_link_with (a_link)
			end;
		end;

	client_link_of (supp: LINKABLE_DATA): CLI_SUP_DATA is
			-- Find client link with supplier `supp.
			-- Void if not found
		do
			if client_links /= Void then
				from
					client_links.start
				until
					client_links.after or else
					Result /= Void
				loop
					if client_links.item.supplier = supp then
						Result := client_links.item
					end;
					client_links.forth
				end
			end
		end;

	parent_link_of (heir: LINKABLE_DATA): INHERIT_DATA is
			-- Find heir link with parent `parent'.
			-- Void if not found
		do
			if parent_links /= Void then
				from
					parent_links.start
				until
					parent_links.after or else
					Result /= Void
				loop
					if parent_links.item.heir = heir then
						Result := parent_links.item
					end;
					parent_links.forth
				end
			end
		end;

	supplier_link_of ( client : LINKABLE_DATA): CLI_SUP_DATA is
			-- Find client link with supplier `supp.
			-- Void if not found
		do
			if supplier_links /= Void then
				from
					supplier_links.start
				until
					supplier_links.after or else
					Result /= Void
				loop
					if supplier_links.item.client = client then
						Result := supplier_links.item
					end;
					supplier_links.forth
				end
			end
		end;

	heir_link_of (parent: LINKABLE_DATA): INHERIT_DATA is
			-- Find heir link with parent `parent'.
			-- Void if not found
		do
			if heir_links /= Void then
				from
					heir_links.start
				until
					heir_links.after or else
					Result /= Void
				loop
					if heir_links.item.parent = parent then
						Result := heir_links.item
					end;
					heir_links.forth
				end
			end
		end;

	search_for_links (str: STRING): SORTED_TWO_WAY_LIST [RELATION_DATA] is
			-- Links for Current class that have prefix
			-- value `str'
		require
			str_exists: str /= Void
			valid_str: not str.empty 
		local
			n, tmp: STRING;
			search_string: STRING;
			search_specific_class: BOOLEAN
		do
			search_string := clone (str);
			search_string.to_upper;
			if search_string.item (str.count) = '*' then
				if search_string.count > 1 then
					search_string := search_string.substring
								(1, search_string.count - 1)
				else
					search_string.wipe_out
				end
			else
				search_specific_class := True
			end;	
			!! Result.make;
			if not search_specific_class and then search_string.empty then
				if client_links /= Void then
					Result.merge (client_links);
				end;
				if heir_links /= Void then
					Result.merge (heir_links);
				end
			else
				if client_links /= Void then
					from
						client_links.start
					until
						client_links.after
					loop
						n := client_links.item.supplier.name;
						if search_specific_class then
							if n.is_equal (search_string) then
								Result.put_front (client_links.item)
							end
						elseif n.count >= search_string.count then
							tmp := n.substring (1, search_string.count);
							if tmp.is_equal (search_string) then
								Result.put_front (client_links.item)
							end
						end;
						client_links.forth
					end;
				end;
				if heir_links /= Void then
					from
						heir_links.start
					until
						heir_links.after
					loop
						if	heir_links.item.parent	/= void
						then
							n := heir_links.item.parent.name;
						else
							n := heir_links.item.t_o_name
						end
						if search_specific_class then
							if n.is_equal (search_string) then
								Result.put_front (heir_links.item)
							end
						elseif n.count >= search_string.count then
							tmp := n.substring (1, search_string.count);
							if tmp.is_equal (search_string) then
								Result.put_front (heir_links.item)
							end
						end;
						heir_links.forth
					end
				end;
				Result.sort;
			end
		ensure
			result_not_void: Result /= Void
		end;

	new_parent_name	( s : STRING )	: BOOLEAN	is
	local
		name_found	: BOOLEAN
	do

		name_found	:= false


		if	heir_links	/= void
		-- heir_links is the data list where this class is an heir
		then
			from
				heir_links.start
			until
				heir_links.after	or
				name_found
			loop
				if	heir_links.item.has_parent_name	( s	)
				then
					name_found	:= true
				end

				heir_links.forth
			end

		end

		Result	:= not name_found
	end

	new_heir_name	( s : STRING )	: BOOLEAN	is
	local
		name_found	: BOOLEAN
	do

		name_found	:= false


		if	parent_links	/= void
		-- heir_links is the data list where this class is an heir
		then
			from
				parent_links.start
			until
				parent_links.after	or
				name_found
			loop
				if	parent_links.item.has_heir_name	( s	)
				then
					name_found	:= true
				end

				parent_links.forth
			end

		end

		Result	:= not name_found
	end

	new_supplier_name	( s : STRING )	: BOOLEAN	is
	local
		name_found	: BOOLEAN
	do

		name_found	:= false


		if	client_links	/= void
		-- client_links is the data list where this class is an client
		then
			from
				client_links.start
			until
				client_links.after	or
				name_found
			loop
				if	client_links.item.has_supplier_name	( s	)
				then
					name_found	:= true
				end

				client_links.forth
			end

		end

		Result	:= not name_found
	end

	new_client_name	( s : STRING )	: BOOLEAN	is
	local
		name_found	: BOOLEAN
	do

		name_found	:= false


		if	supplier_links	/= void
		-- supplier_links is the data list where this class is an supplier
		then
			from
				supplier_links.start
			until
				supplier_links.after	or
				name_found
			loop
				if	supplier_links.item.has_client_name	( s	)
				then
					name_found	:= true
				end

				supplier_links.forth
			end

		end

		Result	:= not name_found
	end

feature -- Element change


	similar_parent ( l1 : RELATION_DATA ; l2 : RELATION_DATA ) : BOOLEAN is
	local
		parent1	: LINKABLE_DATA
		parent2	: LINKABLE_DATA
		name1	: STRING
		name2	: STRING
	do
		parent1	:= l1.t_o
		parent2	:= l2.t_o
	
		if parent1 /= Void
		then
			name1	:= parent1.name
		else
			name1	:= l1.t_o_name
		end

		if parent2 /= Void
		then
			name2	:= parent2.name
		else
			name2	:= l2.t_o_name
		end

		Result	:= name1.is_equal	( name2	)

	end

	similar_heir ( l1 : RELATION_DATA ; l2 : RELATION_DATA ) : BOOLEAN is
	local
		heir1	: LINKABLE_DATA
		heir2	: LINKABLE_DATA
		name1	: STRING
		name2	: STRING
	do
		heir1	:= l1.f_rom
		heir2	:= l2.f_rom
	
		if heir1 /= Void
		then
			name1	:= heir1.name
		else
			name1	:= l1.f_rom_name
		end

		if heir2 /= Void
		then
			name2	:= heir2.name
		else
			name2	:= l2.f_rom_name
		end

		Result	:= name1.is_equal	( name2	)

	end

	similar_supplier ( l1 : RELATION_DATA ; l2 : RELATION_DATA ) : BOOLEAN is
	local
		supplier1	: LINKABLE_DATA
		supplier2	: LINKABLE_DATA
		name1	: STRING
		name2	: STRING
	do
		supplier1	:= l1.t_o
		supplier2	:= l2.t_o
	
		if supplier1 /= Void
		then
			name1	:= supplier1.name
		else
			name1	:= l1.t_o_name
		end

		if supplier2 /= Void
		then
			name2	:= supplier2.name
		else
			name2	:= l2.t_o_name
		end
		
		if (name1 /= Void) and (name2 /= Void) then
			Result	:= name1.is_equal	( name2	)	
		end

	end

	similar_client ( l1 : RELATION_DATA ; l2 : RELATION_DATA ) : BOOLEAN is
	local
		client1	: LINKABLE_DATA
		client2	: LINKABLE_DATA
		name1	: STRING
		name2	: STRING
	do
		client1	:= l1.f_rom
		client2	:= l2.f_rom
	
		if client1 /= Void
		then
			name1	:= client1.name
		else
			name1	:= l1.f_rom_name
		end

		if client2 /= Void
		then
			name2	:= client2.name
		else
			name2	:= l2.f_rom_name
		end

		if ( name1 /= Void ) and ( name2 /= Void )then
			Result	:= name1.is_equal	( name2	)
		end
	end


	similar_inherit_link ( l1 : RELATION_DATA ; l2 : RELATION_DATA ) : BOOLEAN is
	do
		Result	:= similar_parent ( l1 , l2 ) and similar_heir ( l1 , l2 )
	end

	similar_client_link ( l1 : RELATION_DATA ; l2 : RELATION_DATA ) : BOOLEAN is
	do
		Result	:= similar_supplier ( l1 , l2 ) and similar_client ( l1 , l2 )
	end


	add_heir_link (new_link: INHERIT_DATA) is
			-- Add `new_link' to the list of inheritance
			-- relations for which current link is the heir.
		require
			link_exists: new_link /= Void;
			not_have_link: heir_links /= Void implies
								not heir_links.has (new_link)
		local
			done	: BOOLEAN
			link	: INHERIT_DATA
		do
			if (heir_links = Void) then
				!!heir_links.make
			end;
		
			done	:= false
		
			from
				heir_links.start
			until
				heir_links.after or done
			loop
				link	:= heir_links.item
				if similar_client_link ( new_link	, link	)
				then
					heir_links.remove
					heir_links.extend	( new_link	)
					done	:= true
				end
				heir_links.forth
			end
			if not done
			then
				heir_links.extend (new_link)
			end
		ensure
			heir_links.has (new_link)
		end; -- add_heir_link

	add_client_link (new_link: CLI_SUP_DATA) is
			-- Add `new_link' to the list of client/supplier
			-- relations for which current link is the client.
		require
			link_exists: new_link /= Void;
			not_have_link: client_links /= Void implies
								not client_links.has (new_link)
		local
			done	: BOOLEAN
			link	: CLI_SUP_DATA
		do
			if (client_links = Void) then
				!!client_links.make
			end;

			from
				client_links.start
			until
				client_links.after or done
			loop
				link	:= client_links.item
				if similar_client_link ( new_link	, link	)
				then
					client_links.remove
					client_links.extend	( new_link	)
					done	:= true
				end
				client_links.forth
			end
			if not done
			then
				client_links.extend (new_link)
			end
		ensure
			client_links.has (new_link)
		end -- add_client_link

	add_parent_link (new_link: INHERIT_DATA) is
			-- Add `new_link' to the list of inheritance
			-- relations for which current link is the parent.
		require
			link_exists: new_link /= Void;
			not_have_link: parent_links /= Void implies
								not parent_links.has (new_link)
		local
			done	: BOOLEAN
			link	: INHERIT_DATA
		do
			if (parent_links = Void) then
				!!parent_links.make
			end;

			from
				parent_links.start
			until
				parent_links.after or done
			loop
				link	:= parent_links.item
				if similar_inherit_link ( new_link	, link	)
				then
					parent_links.remove
					parent_links.extend	( new_link	)
					done	:= true
				end
				parent_links.forth
			end
			if not done
			then
				parent_links.extend (new_link)
			end
		ensure
			parent_links.has (new_link)
		end; -- add_parent_link

	add_supplier_link (new_link: CLI_SUP_DATA) is
			-- Add `new_link' to the list of client/supplier
			-- relations for which current link is the supplier.
		require
			link_exists: new_link /= Void;
			not_have_link: supplier_links /= Void implies
								not supplier_links.has (new_link)
		local
			done	: BOOLEAN
			link	: CLI_SUP_DATA
		do
			if (supplier_links = Void) then
				!!supplier_links.make
			end;

			from
				supplier_links.start
			until
				supplier_links.after or done
			loop
				link	:= supplier_links.item
				if similar_inherit_link ( new_link	, link	)
				then
					supplier_links.remove
					supplier_links.extend	( new_link	)
					done	:= true
				end
				supplier_links.forth
			end
			if not done
			then
				supplier_links.extend (new_link)
			end
		ensure
			supplier_links.has (new_link)
		end; -- add_supplier_link

feature -- Removal

	remove_from_system is
			-- Remove the linkable from system.
		--require
		--	is_in_system: is_in_system
		deferred
		--ensure
		--	not_in_system: not is_in_system
		end -- remove_from_system


	delete_heir_link	( old_link : INHERIT_DATA )	is
	do
		if	heir_links	/= void
		then
			heir_links.start
			heir_links.prune	( old_link	)
		end
	end

	delete_parent_link	( old_link : INHERIT_DATA )	is
	do
		if	parent_links	/= void
		then
			parent_links.start
			parent_links.prune	( old_link	)
		end
	end

	delete_client_link	( old_link : CLI_SUP_DATA )	is
	do
		if	client_links	/= void
		then
			client_links.start
			client_links.prune	( old_link	)
		end
	end

	delete_supplier_link	( old_link : CLI_SUP_DATA )	is
	do
		if	supplier_links	/= void
		then
			supplier_links.start
			supplier_links.prune	( old_link	)
		end
	end

feature -- Output

	name_in_lower_case: STRING is
		do
			Result := clone (name);
			Result.to_lower
		end;

	full_cluster_name (cluster_data: CLUSTER_DATA): STRING is
			-- Full cluster name (ROOT. ... .PARENT.CLUSTER)
		require
			not (cluster_data = Void)
		local
			cluster: CLUSTER_DATA
		do
			!!Result.make (10);
			from
				cluster := cluster_data
			until
				(cluster = Void)
			loop
				if not Result.empty then
					Result.prepend (".")
				end;
				Result.prepend (cluster.name);
				cluster := cluster.parent_cluster
			end
		ensure
			has_result: Result /= void
		end;

	generate_name (text_area: TEXT_AREA) is
		deferred
		end;

	generate_as_parent ( text_area : TEXT_AREA; heir_data : CLASS_DATA ; inh_link : INHERIT_DATA ) is
		deferred
		end

	generate_description (text_area: TEXT_AREA) is
		do
		--	if not text_area.output_to_disk or else
		--		not description.is_default
		--	then
		--		text_area.append_keyword ("description")
		--		text_area.new_line;
		--		text_area.indent;
		--		description.generate (text_area, Current );
		--		text_area.exdent;
		--	end;
		end;

feature -- Update

	basic_update is
		do
--			workareas.change_data (Current);
--			workareas.refresh;
--			windows.system_window.update_page (stone_type);
		end;

feature {NONE} -- Implementation 

	merge_list_into (list, merged_list: LINKED_LIST [RELATION_DATA]) is	
			-- Merge `list' into `merged_list'.
		require
			valid_lists: list /= Void and then merged_list /= Void
		do
			from
				list.start
			until
				list.after
			loop
				merged_list.put_front (list.item);
				list.forth
			end
		end;

feature -- Storage

	store_information (storer: S_LINKABLE_DATA) is
			-- Store linkable information in `l_store'.
		local
			cl_sup_l: ARRAYED_LIST [S_CLI_SUP_DATA];
			inherit_l: ARRAYED_LIST [S_INHERIT_DATA];
			cli_sup: CLI_SUP_DATA;
			inherit_data: INHERIT_DATA;
		do
			--storer.set_view_id (view_id);
			--storer.set_file_name (file_name);
			--if not description.is_default then
			--	storer.set_description (description.storage_info)
			--end;
			--if client_links /= Void and then not client_links.empty then
			--	!! cl_sup_l.make (client_links.count);
			--	from
			--		client_links.start;
			--	until
			--		client_links.after
			--	loop
			--		cli_sup := client_links.item;
			--		if not cli_sup.is_compressed then
			--			cl_sup_l.extend (cli_sup.storage_info);
			--		end;
			--		client_links.forth
			--	end
			--	if not cl_sup_l.empty then
			--		storer.set_client_links (cl_sup_l);
			--	end
			--end;
			--if supplier_links /= Void and then not supplier_links.empty 
			--then
			--	if cl_sup_l = Void
			--	then
			--		!! cl_sup_l.make (supplier_links.count);
			--	end
			--	from
			--		supplier_links.start;
			--	until
			--		supplier_links.after
			--	loop
			--		cli_sup := supplier_links.item;
			--		if not cli_sup.is_compressed then
			--			cl_sup_l.extend (cli_sup.storage_info);
			--		end;
			--		supplier_links.forth
			--	end
			--	if not cl_sup_l.empty then
			--		storer.set_client_links (cl_sup_l);
			--	end
			--end;
			--if heir_links /= Void and then not heir_links.empty then
			--	!! inherit_l.make (heir_links.count);
			--	from
			--		heir_links.start;
			--	until
			--		heir_links.after
			--	loop
			--		inherit_data := heir_links.item;
			--		if not inherit_data.is_compressed then
			--			inherit_l.extend (inherit_data.storage_info);
			--		end;
			--		heir_links.forth
			--	end
			--	if not inherit_l.empty then
			--		storer.set_heir_links (inherit_l);
			--	end
			--end
			--if parent_links /= Void and then not parent_links.empty then
			--	if inherit_l = Void
			--	then
			--		!! inherit_l.make (parent_links.count);
			--	end
			--	from
			--		parent_links.start;
			--	until
			--		parent_links.after
			--	loop
			--		inherit_data := parent_links.item;
			--		if not inherit_data.is_compressed then
			--			inherit_l.extend (inherit_data.storage_info);
			--		end;
			--		parent_links.forth
			--	end
			--	if not inherit_l.empty then
			--		storer.set_heir_links (inherit_l);
			--	end
			--end
			--storer.set_x (x)
			--storer.set_y (y)
			--storer.set_color ( color_name )
			--storer.set_hidden ( is_hidden )
		end;

feature {NONE} -- Storage

	make_from_storer (storer: S_LINKABLE_DATA; 
			system_classes: HASH_TABLE [CLASS_DATA, INTEGER]) is
			-- Retrieve linkable information in `l_store'.
		require
			valid_storer: storer /= Void
		local
			cl_sup_l: ARRAYED_LIST [S_CLI_SUP_DATA];
			inherit_l: ARRAYED_LIST [S_INHERIT_DATA];
			inherit_data: INHERIT_DATA;
			cli_sup_data: CLI_SUP_DATA
			cl : CLUSTER_DATA
		do
		--	set_name (storer.name);
		--	!! file_name.make_from_string (storer.file_name);
		--	view_id := storer.view_id
		--	if storer.description = Void then
		--		!! description.make_with_default;
		--	else
		--		!! description.make_from_storer (storer.description);
		--	end;
		--	cl_sup_l := storer.client_links;
		--	if cl_sup_l /= Void then
		--		from
		--			cl_sup_l.start;	
		--		until
		--			cl_sup_l.after
		--		loop
		--			!! cli_sup_data.make_from_storer (cl_sup_l.item,
		--				system_classes);
		--			cl_sup_l.forth;
		--		end;
		--	end;
		--	inherit_l := storer.heir_links;
		--	if inherit_l /= Void then
		--		from
		--			inherit_l.start;	
		--		until
		--			inherit_l.after
		--		loop
		--			!! inherit_data.make_from_storer (inherit_l.item,
		--				system_classes);
		--			inherit_l.forth;
		--		end
		--	end
		--	-- especially for the Reverse Engineering process
		--	-- test if view_info is pseudo_void, that is if is_new_view is true
			--if View_information.is_new_view then
		--		if storer.x /= Void then
		--			set_x ( storer.x )
		--		end
		--		if storer.y /= Void then
		--			set_y ( storer.y)
		--		end
		--		if storer.color_name /= Void then
		--			set_color_name ( storer.color_name)
		--		end
		--		if storer.is_hidden /= Void then
		--			set_hidden ( storer.is_hidden )
		--		end
		--	--end
		end;

feature -- Generation for the reverse

	generation_for_reverse ( path : STRING ) is
		local
			fi : PLAIN_TEXT_FILE
			file_n : FILE_NAME
			st: STRING
			err : BOOLEAN
			s: STRING
		do
			if is_class then
			!! file_n.make
			--file_n.extend (parent_cluster.reversed_engineered_file_name )
			file_n.extend ( path ) -- added by pascalf	
			!! st.make(20)
			st.append(name)
			st.append(".cas")
			file_n.extend ( st )
			!! fi.make ( file_n )
			fi.create_read_write 
			!! s.make (10)
			s.append_integer(x)
			fi.put_string(s)
			fi.put_new_line
			s.wipe_out
			s.append_integer(y)
			fi.put_string(s)
			fi.put_new_line
			if color_name=VOid then
				fi.put_string(Resources.class_color.name)
			else
				fi.put_string(color_name)
			end
			fi.put_new_line
			if is_hidden then fi.put_string("TRUE") else fi.put_string("FALSE") end
			if is_class then
				fi.new_line
				add_links_for_reverse ( fi )
			end
			fi.close
			end
		end

add_links_for_reverse ( fi : PLAIN_TEXT_FILE ) is
		local
			st : STRING
			bp : LINKED_LIST[ HANDLE_DATA ]
			err: BOOLEAN
		do
--			if not err then
--			if client_links/= VOid and then client_links.count >0 then
--				from
--					client_links.start
--				until
--					client_links.after
--				loop
--					if client_links.item.supplier/= Void and client_links.item.client /= Void 
--						and then client_links.item.supplier.name /= Void then
--					-- Added by pascalf, since apparently the Reverse Engineering
--					-- does not work fine at the moment ...
--						fi.put_string(client_links.item.supplier.name)
--						fi.new_line
--						-- now, let's deal with the handles ...
--						!! st.make (5)
--						if client_links.item.break_points/= Void and then
--							client_links.item.break_points.count>0 then
--								st.append_integer(client_links.item.break_points.count)
--								fi.put_string(st)
--								fi.new_line
--								bp := client_links.item.break_points
--								from
--									bp.start
--								until
--									bp.after
--								loop
--									!! st.make (5)
--									st.append_integer (bp.item.x)
--									fi.put_string(st)
--									fi.new_line
--									!! st.make (5)
--									st.append_integer (bp.item.y)
--									fi.put_string(st)
--									fi.new_line
--									bp.forth
--								end
--						else
--							-- no handles
--							!! st.make (5)
----							st.append_integer(0)
--							fi.put_string(st)
--							fi.new_line	
--						end
--					end 
--					client_links.forth
--				end
--			end
--			if heir_links/= VOid and then heir_links.count >0 then
--				from
--					heir_links.start
--				until
--					heir_links.after
--				loop
--					if heir_links.item.parent/= Void or heir_links.item.t_o_name/= Void then
--						-- Added by pascalf, we have to check that the link is not corrupted ...
--						if	heir_links.item.parent	/= void 
--						then
--							fi.put_string(heir_links.item.parent.name)
--						else
--							fi.put_string	( heir_links.item.t_o_name	)
--						end
--	
--						fi.new_line
--						-- now, let's deal with the handles ...
--						!! st.make (5)
--						if heir_links.item.break_points/= Void and then
--							heir_links.item.break_points.count>0 then
--								st.append_integer(heir_links.item.break_points.count)
--								fi.put_string(st)
--								fi.new_line
--								bp := heir_links.item.break_points
--								from
--									bp.start
--								until
--									bp.after
--								loop
--									!! st.make (5)
--									st.append_integer (bp.item.x)
--									fi.put_string(st)
--									fi.new_line
--									!! st.make (5)
--									st.append_integer (bp.item.y)
--									fi.put_string(st)
--									fi.new_line
--									bp.forth
--								end
--						else
----							!! st.make (5)
----								st.append_integer ( 0 )
--							fi.put_string(st)
--							fi.new_line	
--						end
--					else
--						-- Link is corrupted 
--						Windows.add_message("Link corrupted",1)
--					end
--					-- 
--					heir_links.forth
--				end
--			end
--			else
--				Windows.add_message("Problem in add_link_for_reverse of Linkable Data",1)
--			end
--		rescue
--			err := TRUE
--			retry
		end
			
invariant

	--valid_name: name /= void and then not name.empty;
	--valid_file_name: file_name /= Void and then not file_name.empty
	--has_a_description: description /= Void
end -- class LINKABLE_DATA
