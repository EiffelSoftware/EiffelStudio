indexing

	description: "Data representation of classes.";
	date: "$Date$";
	revision: "$Revision $"

class CLASS_DATA

inherit

	LINKABLE_DATA

creation

	make
feature {NONE} -- Initialization

	make (c_name: STRING; i: INTEGER) is
			-- Create a CLASS_DATA object with `class_name'
			-- as class name.
		require
			name_not_Void : c_name /= Void
			name_not_empty : not c_name.empty
			valid_i: i > 0
		local
			col: EV_COLOR
		do
			set_name (c_name)
			view_id := i
			!! generics.make
			!! parent_links.make
			!! heir_links.make
			!! supplier_links.make
			!! client_links.make
			!! col.make_rgb(0,255,0)
			set_color(col)
		ensure
			name_set: name.is_equal (c_name)
			view_set : view_id=i	
		end

feature -- set view 

	set_view_id ( i: INTEGER ) is
			-- set view id to i	
		require
			view_positive : view_id >0	
		do
			view_id := i
		ensure
			view_set : view_id=i	
		end


feature -- Access

	is_root: BOOLEAN is do end
			-- Is the current class the root of
			-- the system ?

	is_deferred: BOOLEAN is do end
			-- Is the current class deferred?

	is_expanded: BOOLEAN is do end
			-- Is the current class deferred?

	is_effective: BOOLEAN is do end
			-- Is the current class an effecting a deferred class ?

	is_persistent: BOOLEAN is do end
			-- Does the current class have persistant instances ?

	is_reused: BOOLEAN is do end
			-- Is the current class already implemented
			-- in a previous project and reused in the current one.
				
	is_interfaced: BOOLEAN is do end
			-- Is the current class interfaced with externals ?

	is_obsolete: BOOLEAN is do end
			-- Is current class obsolete ?

feature -- Implementation

	generics: LINKED_LIST [GENERIC_DATA]
			-- Number of generic parameters

	invariants: HASH_TABLE [STRING, STRING] is do end
			-- Invariants of the current class

feature -- Internal Properties

	is_modified: BOOLEAN
			-- Is current class been modified for features,
			-- invariants or chart information?

	is_modified_since_last_re: BOOLEAN
			-- Is current class been modified since
			-- last reverse engineering ?

	is_new_since_last_re: BOOLEAN
			-- Is current class new since the
			-- last reverse engineering ?

	id: INTEGER;
			-- Id of Current

	is_class: BOOLEAN is True
			-- Is current a class? 

	focus: STRING is do end

	default_color: EV_COLOR is
			-- Default color
		do
			Result := Resources.class_interior_color
		ensure then 
			Color_not_void : Result /= Void	
		end

	auto_link : BOOLEAN
			-- boolean which automaically choose a squared creation
			-- of a link	

	stone: CLASS_STONE is
			-- associated stone of current	
		do
			!! Result.make (Current);
		end

	stone_type: INTEGER is
			-- Stone type of Current
		do
			--Result := Stone_types.class_type
		end

feature -- Setting

	set_is_obsolete (b: like is_obsolete) is
			-- Set is_new_since_last_re to True
			-- Obsolete now, since there is no more counter	
		do
		end

	set_id (i: INTEGER) is
			-- Set id to `i'.
		require
			valid_i: i > 0
		do
			id := i
		ensure
			id_set: id = i
		end

	set_deferred (status: BOOLEAN) is
			-- Modify current class status:
			-- deferred (true) or not deferred (false).
			-- Also modify is_effecting value as well
		do
		--	is_deferred := status
		--	if status then
		--		is_effective := False
		--	end
		ensure
		--	is_deferred = status 
		end;

	set_is_effective (status: BOOLEAN) is
			-- Modify current class status:
			-- deferred (true) or not is_effecting (false).
			-- Also modify is_deferred value as well
		do
			--is_effective := status;
			--if status then
			--	is_deferred := False	
			--end
		ensure
			--is_effective = status 
		end

	set_generics ( gene : LINKED_LIST [ GENERIC_DATA ] ) is
			-- set generic paramters of current	
		require
			list_gene_not_void : gene/= Void
		do
			generics := gene
		ensure
			list_set : generics = gene	
		end

	set_persistent (status: BOOLEAN) is
			-- Modify current class status:
			-- Does it have persistent instances (true)
			-- or not (false).
		do
		--	is_persistent := status
		--ensure
		--	is_persistent = status
		end

	set_reused (status: BOOLEAN) is
			-- Modify current class status:
			-- Is it reused (true) or not (false).
		do
		--	is_reused := status
		--ensure
		--	is_reused = status
		end

	set_root (status: BOOLEAN) is
			-- Modify current class status:
			-- root (true) or not root (false).
		do
		--	is_root := status
		ensure
			is_root = status
		end

	set_interfaced (status: BOOLEAN) is
			-- Modify current class status:
			-- Is it interfaced with externals (true) or 
			-- not (false).
		do
		--	is_interfaced := status
		--ensure
		--	is_interfaced = status
		end

	set_name (s: STRING) is
			-- set name from 's'.
			-- reset and set the associated filename of current	
		require else
			string_not_void : s/= Void 
			string_not_empty : s.count>0	
		local
			f_name: FILE_NAME
		do
			name := clone (s)
			name.to_upper

			-- Changed by pascalf, non sense !!! system.update_system_link
			if not System.is_in_retrieving_mode then
				-- removed temporarily, involves bugs...system.update_system_link
			end	
	
			!! f_name.make_from_string (s)
			f_name.add_extension ("e")
			set_file_name (f_name)
		ensure then 
			name_set : name.is_equal ( s )	
		end

	set_file_name (s: STRING) is
			-- set file_name from 's'.
		require else
			string_not_void : s/= Void
			string_not_empty : s.count>0	
		local
			f_name : STRING	
		do
			f_name := clone (s)
			f_name.to_lower
			!! file_name.make_from_string (f_name)
		end

	set_auto_link ( b : BOOLEAN ) is
			-- set the boolean auto_link to b	
		do
			auto_link := b
		end

	set_default is
		do
		end

feature -- Questions.

	visible_descendant_of (linkable: LINKABLE_DATA): BOOLEAN is
			-- Is current linkable a visible descendant of `linkable' ?
		do
			if not is_hidden and then parent_cluster /= Void then
				if not (parent_cluster.is_icon and then
					parent_cluster /= linkable)
				then
					Result := parent_cluster.visible_descendant_of (linkable)
				end
			end
		end;

	contains_linkable (linkable: LINKABLE_DATA): BOOLEAN is
			-- Does current contain `linkable' ?
		do
			if Current = linkable then
				Result := True
			end
		end

	has_generic (generic_name: STRING): BOOLEAN is
			-- Does Current class data have generic with
			-- name `generic_name'?
		require
			valid_generic_name: generic_name /= Void and then
									not generic_name.empty
		local
			search_string: STRING
		do
			search_string := clone (generic_name);
			search_string.to_upper;
			if generics /= Void then
				from
					generics.start
				until
					generics.after or else Result 
				loop
					Result := (generics.item.name.is_equal (search_string));
					generics.forth
				end
			end
		end

	has_feature (feature_name: STRING): BOOLEAN is
			-- Does Current class data have feature with
			-- name `feature_name'?
		require
			valid_feature_name: feature_name /= Void and then
									not feature_name.empty
		do
		end

	has_generics: BOOLEAN is
			-- Does Current Class have generic parameters?
		do
			Result := generics.count > 0
		end

feature -- requests.

	features_with_prefix (str: STRING): SORTED_TWO_WAY_LIST [FEATURE_DATA] is
			-- Features with prefix `str' in Current class
			--| Need to free information if result is not empty.
		require
			valid_str: str /= Void 
		do
			!! Result.make
		ensure
			result_not_void: Result /= Void;
		end

	feature_with_name (f_name: STRING): FEATURE_DATA is
			-- Features with prefix `str' in Current class
		require
			valid_str: f_name /= Void
			not_empty_string: not f_name.empty
		do
		end

	get_link_with_parent	( parent_name : STRING )	: INHERIT_DATA	is
	local
		found	: BOOLEAN
	do
		if	heir_links	/= void
		then
			from
				heir_links.start
			until 
				heir_links.after	or
				found
			loop
				found	:= heir_links.item.has_parent_name	( parent_name	)
				if found then
					Result := heir_links.item
				end
				heir_links.forth
			end
		end
	end

feature -- Element change

	add_invariant (tag,text: STRING) is
			-- Add `inv' to the list of current
			-- class invariants.
		require
		--	invariant_exists: inv /= Void
		do
		--	if (invariants = Void) then
		--		content.make_invariants
		--	end;
		--	invariants.extend (inv)
		end 

    add_formal_generic_clause (g: GENERIC_DATA) is
                do
                        if generics = Void then
                                !! generics.make
                        end

                        generics.extend (g)
                end

	put_in_cluster (cluster: CLUSTER_DATA) is
			-- Remove the class of `parent_cluster' if exists, and
			-- put the class in `cluster'.
		require else
			cluster_exists: cluster /= Void
		do
			if parent_cluster /= Void then
				parent_cluster.remove_class (Current)
				update_compressed_links (cluster)
			else
				System.system_classes.put (Current, view_id)
			end;
			parent_cluster := cluster;
			cluster.add_class (Current)
		ensure then
			cluster = parent_cluster
		end 

feature -- Removal

	clear_editors is
			-- Clear the class window editor and all feature window
			-- for Current
		do
		end


	remove_class_content_from_disk is
		-- Remove all the content of Current on the disk	
		require
			not_in_system: not is_in_system
		local
			path: STRING;
			file: RAW_FILE
			error_fi : BOOLEAN
		do
		end

	remove_from_system is
			-- Remove the class from system.
		local
--			l: EDITOR_LIST [FEATURE_WINDOW]
--			item: FEATURE_WINDOW;
		do
--			clear_editors;
--			l := Windows.feature_windows;
--			from
--				l.start
--			until
--				l.after
--			loop
--				item := l.item;
--				if item.entity /= Void and then
--					item.entity.class_container = Current 
--				then
--					item.clear
--				end
--				l.forth
--			end;
--			parent_cluster.remove_class (Current)
--			parent_cluster := Void
--			System.system_classes.remove (view_id)
		end

feature -- Output

	full_name: STRING is
			-- Class name including generics
		do
			!! Result.make (10)
			Result.append (name)
			if not generics.empty then
				Result.extend (' ')
				Result.append (generic_string_name)
			end
		end


	generate_chart (text_area: TEXT_AREA) is
			-- Generate Current's chart in `text_area'.
		require
			text_not_void : text_area /= Void
		local
			inv	: INVARIANT_DATA
		do
		end

	generate_code (text_area: TEXT_AREA) is
			-- Generate Current's code to file.
		require
			text_not_void : text_area/= Void	
		do
		--	generate	( text_area	, False	, false	)
			System.set_class_label ( name )
		end

	generate_browsing_code (text_area: TEXT_AREA) is
			-- Generate Current's code to file.
		require
			text_not_void : text_area/= Void	
		do
		--	generate	( text_area	, false	, true	)
			System.set_class_label ( name )
		end

	generate_feature_names (text_area: TEXT_AREA) is
			-- Generate the feature names to `text_area'
		require
			text_not_void : text_area/= Void
		do
			text_area.generate_class_feature_names (Current)
		end

	generate_inheritance (text_area: TEXT_AREA; is_spec: BOOLEAN ) is
		-- generate the text corresponding to inheritance	
		require
			exist_parents: heir_links /= void
			parents_not_empty: not heir_links.empty
			text_not_void : text_area /= Void	
		local
			link_data	: CLASS_DATA
			class_data	: CLASS_DATA
			ss	: STRING
			parent_class_stone	: PARENT_CLASS_STONE
		do
			text_area.append_keyword ("inherit");
			text_area.new_line;
			text_area.new_line;
			text_area.indent;

			from
				heir_links.start
			until
				heir_links.after
			loop
				link_data ?= heir_links.item.parent
				if link_data/= Void 
				then
					--link_data.generate_class_inheritance	( text_area	, heir_links.item.generics	, heir_links.item	)
					link_data.generate_as_parent	( text_area	, Current	, heir_links.item	)
					text_area.new_line
					text_area.new_line
				else
					if heir_links.item.t_o_name/= Void then
						!! ss.make ( 2)
						ss.append ( heir_links.item.t_o_name)
						ss.append (heir_links.item.gene_generics )

						!! parent_class_stone.make_parent	( Void	, Current	)
						text_area.append_clickable_string	( parent_class_stone	, ss )

						--text_area.append_string	( ss )
						text_area.new_line
						text_area.new_line
					end
				end
				heir_links.forth 
			end;
			text_area.exdent
		end

	generate_name (text_area: TEXT_AREA) is
			-- Append the signature of current data in `a_clickable'
		require else
			name_correct : name/= Void and then name.count>0
			text_not_void : text_area/= Void	
		local
-- 			class_name_data	: STRING_DATA
-- 			class_name_stone	: CLASS_NAME_STONE
		do

-- 			!! class_name_data.make	( name	)
-- 			!! class_name_stone.make	( class_name_data	)
-- 	
-- 			text_area.append_clickable_string	( class_name_stone	, name	)
-- 		
-- 			generate_generics ( text_area )
		
		end

	generate_class (text_area: TEXT_AREA ) is
			-- Append the signature of current data in `a_clickable'
		require else
			name_correct : name/= Void and then name.count>0
			text_not_void : text_area/= Void	
		local
			class_stone	: CLASS_STONE
		do
			!! class_stone.make	( Current	)
			text_area.append_clickable_string	( class_stone	, name	)
			generate_generics	( text_area	)
			--generate_class_generics	( text_area	)
		end

	generate_generics	( text_area : TEXT_AREA )	is
	do
		if not generics.empty then
			from
				text_area.append_string (" [")
				generics.start
			until
				generics.after
			loop
				generics.item.generate (text_area, Current )
				generics.forth
				if not generics.after 
				then
					text_area.append_string (", ")
				end
			end
			text_area.append_string ("]")
		end

	end

	generate_generic_element ( text_area: TEXT_AREA; generic_data : GENERIC_DATA ; generic_stone : GENERIC_STONE )	is 
		local
			tmp	: STRING
		do
			!! tmp.make (0);
			tmp.append	( generic_data.name	)

			if system.class_of_name	( tmp ) /= Void
			then
				tmp.to_upper
			end

			if generic_data.constraint_type = Void 
			then
				text_area.append_clickable_string	( generic_stone	, tmp	)
			else
				tmp.append ("->");
				text_area.append_clickable_string	( generic_stone	, tmp	)
				generic_data.constraint_type.generate (text_area, Current )
			end;
		end

	generate_generic_list	( text_area : TEXT_AREA ; generic_list : LINKED_LIST [ GENERIC_DATA ] ; relation_data : RELATION_DATA )	is
	local
		
		instance_generic_data	: INSTANCE_GENERIC_DATA
		generic_stone	: GENERIC_STONE
	do
		if	generic_list	/= void
		then
			if not generic_list.empty 
			then
				from
					text_area.append_string (" [")
					generic_list.start
				until
					generic_list.after
				loop
					!! instance_generic_data.make	( generic_list.item	, relation_data	)
					!! generic_stone.make	( instance_generic_data	)

					generate_generic_element	( text_area, generic_list.item	, generic_stone )
					generic_list.forth
					if not generic_list.after 
					then
						text_area.append_string (", ")
					end
				end
				text_area.append_string ("]")
			end
		end
	end

	generate_class_generics	( text_area : TEXT_AREA )	is
	local
		s: STRING
	do
		if not generics.empty then
			from
				text_area.append_string (" [")
				generics.start
			until
				generics.after
			loop
				!! s.make(20)
				s.append(generics.item.full_name) -- added
				--generics.item.generate (text_area, Current ) -- removed
				text_area.append_string(s)
				generics.forth
				if not generics.after then
					text_area.append_string (", ")
				end
			end
			text_area.append_string ("]")
		end

	end

	generate_as_parent ( text_area : TEXT_AREA; heir_data : CLASS_DATA ; inh_link : INHERIT_DATA ) is
			-- Append the signature of current data + generics of the heirs in a clickable
		require else
			text_not_void : text_area/= Void
		local
			parent_class_stone: PARENT_CLASS_STONE
		do
			!! parent_class_stone.make_parent (Current, heir_data)
			text_area.append_clickable_string (parent_class_stone, name)
			generate_generic_list	(text_area, inh_link.generics, inh_link)
		end

	generate_as_heir ( text_area : TEXT_AREA; heir_data : CLASS_DATA ; inh_link : INHERIT_DATA ) is
			-- Append the signature of current data + generics of the heirs in a clickable
		require else
			text_not_void : text_area/= Void
		local
			heir_class_stone: HEIR_CLASS_STONE
		do
			!! heir_class_stone.make_heir (Current, heir_data)
			text_area.append_clickable_string	( heir_class_stone, full_name)
		end

	generate_as_client ( text_area : TEXT_AREA; heir_data : CLASS_DATA ; client_link : CLI_SUP_DATA ) is
			-- Append the signature of current data + generics of the heirs in a clickable
		require else
			text_not_void : text_area/= Void
		local
			client_class_stone: CLIENT_CLASS_STONE
		do
			!! client_class_stone.make_client (Current, heir_data)
			text_area.append_clickable_string	( client_class_stone, full_name)
		end

	generate_as_supplier ( text_area : TEXT_AREA; heir_data : CLASS_DATA ; client_link : CLI_SUP_DATA ) is
			-- Append the signature of current data + generics of the heirs in a clickable
		require else
			text_not_void : text_area/= Void
		local
			supplier_class_stone: SUPPLIER_CLASS_STONE
		do
			!! supplier_class_stone.make_supplier (Current, heir_data)
			text_area.append_clickable_string	( supplier_class_stone, name)
			generate_generic_list	(text_area, client_link.generics, client_link)
		end


	generate_class_generic	( text_area : TEXT_AREA ; generic_list : LINKED_LIST [ GENERIC_DATA ] )	is
	local
		class_data	: CLASS_DATA
		class_stone	: CLASS_STONE
	do
		if generic_list	/= void
		then
			if not generic_list.empty
			then
				text_area.append_string (" [")

				from
					generic_list.start
				until
					generic_list.after
				loop	
			
					class_data	:= system.class_of_name	( generic_list.item.name	)
					if	class_data	/= void
					then
						!! class_stone.make	( class_data	)
						text_area.append_clickable_string	( class_stone	, class_data.name	)
					else
						text_area.append_string	( generic_list.item.name	)
					end			
	
					generic_list.forth
		
				if not generic_list.after 
					then
						text_area.append_string(", ")
					end
				end
				text_area.append_string("]")
			end
		end
	end

	generate_class_inheritance ( text_area : TEXT_AREA; generic_list : LINKED_LIST [ GENERIC_DATA ] ; inh_link : INHERIT_DATA ) is
			-- Append the signature of current data + generics of the heirs in a clickable
		require else
			text_not_void : text_area/= Void
		local
			class_stone	: CLASS_STONE
		do
			if inh_link.heir/= Void and then inh_link.parent/= Void then
				!! class_stone.make	( Current	)
				text_area.append_clickable_string ( class_stone , name )
				generate_class_generic	( text_area	, generic_list	)
			else
				-- on entity is not contained in the system ...
				if inh_link.t_o_name/= Void then
					text_area.append_string(inh_link.t_o_name)
				end
			end
		end

	generate_specification (text_area: TEXT_AREA) is
			-- Generate Current's specification in `text_area'.
		do
		--	generate (text_area, True	, false	);
		end

	generic_string_name: STRING is
			-- Generics as output string
		require
			generics_not_void : generics/=Void
			not_empty_generics: not generics.empty
		do
			!! Result.make (0)
			Result.append ("[")
			from
				generics.start
			until
				generics.after
			loop
				Result.append (generics.item.full_name)
				generics.forth
				if not generics.after then
					Result.append (", ")
				end
			end
			Result.append ("]")
		end

	new_feature_name: STRING is
			-- Generate a new feature name
		require
		--	feat_number_correct : feature_number>=0	
		do
			from
			until
				Result /= Void
			loop
				!! Result.make (0);
				Result.append ("feature");
			--	increment_feature_number;
			--	Result.append_integer (feature_number);
				if has_feature (Result) then
					Result := Void
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	new_generic_name: STRING is
		-- function which generates a new generic parameter	
		local
			i: INTEGER;
		do
			from
				i := 1
			until
				Result /= Void
			loop
				if i > 6 then
					!! Result.make (2);
					Result.append ("G");
					Result.append_integer (i - 7)
				else
					!! Result.make (0);
					Result.extend ('F' + i)
				end;
				if has_generic (Result) then
					Result := Void
				end;
				i := i + 1;
			end;
		ensure
			Result_not_void: Result /= Void
		end

	save_class_content_to_disk is
			-- Save class content to disk.
		do
		end

feature -- Update

	update_display (a_data: DATA) is
			-- Update relevant details using stone_type `st_type'
		require else
			class_not_void : a_data/= Void	
		local
			generic_data: GENERIC_DATA;
			c_l: EDITOR_LIST [EC_CLASS_WINDOW];
		do
--			generic_data ?= a_data;
--			if generic_data = Void then
--				if parent_cluster /= Void then
--					parent_cluster.update_display (a_data);
--				end;
--				c_l := Windows.class_windows;
--				from
--					c_l.start
--				until
--					c_l.after
--				loop
--					if c_l.item.entity /= Void then
--						c_l.item.update_page (stone_type)
--					end
--					c_l.forth
--				end;
--				if a_data.is_in_class_content then
--					set_is_modified;
--					basic_update
--				else
--					System.set_is_modified;
--					windows.system_window.update;
--				end;
--			else
--				update_name
--			end
		end

	update_name is
			-- Update relevant details after a name change.
		--require else
		--	editor_not_void : editor /= Void	
		local
	--		class_win: EC_CLASS_WINDOW;
	--		f_l: EDITOR_LIST [FEATURE_WINDOW];
	--		r_l: EDITOR_LIST [EC_RELATION_WINDOW];
	--		c_l: EDITOR_LIST [EC_CLASS_WINDOW];
	--		entity: RELATION_DATA
	--		client: CLASS_DATA;
		do
--			class_win := editor
--				-- Update editors being used
--			if class_win /= Void then
--				class_win.class_name.set_text (name);
--				class_win.update_title;
--				class_win.update_page (stone_type);
--				set_is_modified_since_last_re;
--				if supplier_links /= Void then
--					from
--						supplier_links.start
--					until
--						supplier_links.after
--					loop
--						client ?= supplier_links.item.client;
--						if client /= Void then
--							client.set_is_modified_since_last_re;
--						end;
--						supplier_links.forth;
--					end
--				end
--			end
--			c_l := Windows.class_windows;
--			from
--				c_l.start
--			until
--				c_l.after
--			loop
--				if c_l.item.entity /= Void then
--						-- Being edited
--					c_l.item.update_page (stone_type)
--				end
--				c_l.forth
--			end;
--			f_l := Windows.feature_windows;
--			from
--				f_l.start
--			until
--				f_l.after
--			loop
--				if 
--					f_l.item.entity /= Void and then 
--					f_l.item.entity.class_container = Current 
--				then
--					f_l.item.update_title
--				end;
--				f_l.item.update_page (stone_type)
--				f_l.forth
--			end;
--			r_l := Windows.relation_windows;
----			from
--				r_l.start
--			until
--				r_l.after
--			loop
--				entity := r_l.item.entity;
--				if 
--					entity /= Void and then 
--					(entity.t_o = Current or else
--					entity.f_rom = Current)
--				then
--					r_l.item.update_title
--				end
--				r_l.forth
--			end;
--			workareas.update_cluster_chart (parent_cluster, stone_type)
--			System.set_is_modified
--			basic_update
		end

feature -- Storage
	
	storage_info: S_CLASS_DATA_R331 is
		local
			g_l: FIXED_LIST [S_GENERIC_DATA];
			dummy: S_FREE_TEXT_DATA
			c_l	: LINKED_LIST	[ STRING	]
		do

		end

feature  -- Implementation

	reset_is_modified is
			-- Set is_modified to `false'.
		do
			is_modified := False
		ensure
			not_modified: not is_modified
		end;

	content_file_name: FILE_NAME is
			-- File name of stored content
		require
			valid_view_id: view_id > 0
		local
			tmp: STRING;
		do
			!! Result.make_from_string (Environment.Storage_directory);
		end

feature {NONE} -- Implementation

	update_compressed_links (new_cluster: CLUSTER_DATA) is
			-- Check and update compressed links that (recursively) 
			-- contain a link to Current
		require
			new_cluster_exists: new_cluster /= Void
		local
			all_links: LINKED_LIST [RELATION_DATA]
			a_link: RELATION_DATA
			compressed_link: COMP_LINK_DATA [RELATION_DATA_KEY]
			to_side: BOOLEAN
		do
			!! all_links.make
			all_links.merge_right (recursive_inherit_links)
			all_links.merge_right (recursive_cli_sup_links)
			from
				all_links.start
			until
				all_links.off
			loop
				a_link := all_links.item
				if (not a_link.is_compressed) and then
					a_link.is_in_compressed_link then
					to_side := (Current = a_link.t_o)
					check
						not_to_implies_from: (not to_side) implies (Current = a_link.f_rom)
					end
					compressed_link := a_link.find_compressed_link
					if compressed_link /= Void then -- for 4.x
						compressed_link.remove_relation (a_link)
						check_empty_compressed (compressed_link, a_link, new_cluster, to_side)
					end
				end
				all_links.forth
			end
		end


	check_empty_compressed (a_compressed_link: COMP_LINK_DATA [RELATION_DATA_KEY]; flat_link: RELATION_DATA; new_cluster: CLUSTER_DATA; to_side: BOOLEAN) is
			-- Check if `a_compressed_link' can be removed
		require
			not_void_comp: a_compressed_link /= Void
			not_void_link: flat_link /= Void
			new_cluster_exists: new_cluster /= Void
		local
			compressed_link, parent_compressed, old_compressed_link: like a_compressed_link
			inh: INHERIT_DATA
			inh_comp: COMP_INHERIT_DATA
			cli_sup: CLI_SUP_DATA
			cli_sup_comp: COMP_CLI_SUP_DATA
			rel_key_link: RELATION_DATA_KEY
			same_level: BOOLEAN
			extremity_cluster, other_cluster: like new_cluster
		do
			compressed_link := a_compressed_link
			if to_side then
				extremity_cluster ?= compressed_link.t_o
			else
				extremity_cluster ?= compressed_link.f_rom
			end
			same_level := (extremity_cluster /= Void) and then (extremity_cluster = new_cluster)

			from
				old_compressed_link := compressed_link
			until
			   compressed_link = Void or else
				same_level
			loop
				if compressed_link.is_in_compressed_link then
					parent_compressed := compressed_link.find_compressed_link
				else
					parent_compressed := Void
				end

				if compressed_link.empty then
					compressed_link.remove_from_system;
					inh ?= compressed_link;
					
					if inh /= Void then
						workareas.destroy_inherit (inh);
					else
						cli_sup ?= compressed_link;
						workareas.destroy_reference (cli_sup)
					end;
					
					if parent_compressed /= Void and then compressed_link.is_in_compressed_link then
						parent_compressed.remove_relation (compressed_link)
					end
				end

				old_compressed_link := compressed_link
				compressed_link := parent_compressed

				if compressed_link /= Void then
					if to_side then
						extremity_cluster ?= compressed_link.t_o
					else
						extremity_cluster ?= compressed_link.f_rom
					end
					same_level := (extremity_cluster /= Void) and then (extremity_cluster = new_cluster)
				end
			end -- loop

			if compressed_link /= Void then
				if to_side then
					extremity_cluster ?= compressed_link.t_o
				else
					extremity_cluster ?= compressed_link.f_rom
				end

				if (extremity_cluster /= Void) and then (extremity_cluster = new_cluster) then
					rel_key_link := flat_link.key
					compressed_link.add_relation (rel_key_link)
				else
					update_compressed_link_side (old_compressed_link, to_side, flat_link)
				end
			else
				update_compressed_link_side (old_compressed_link, to_side, flat_link)
			end
 		end

	update_compressed_link_side (compressed_link: COMP_LINK_DATA [RELATION_DATA_KEY]; to_side: BOOLEAN; flat_link: RELATION_DATA) is
			-- Update the extremity of `compressed_link' specified by `to_side'
		require
			compressed_link_exists: compressed_link /= Void
			flat_link_exists: flat_link /= Void
		local
			rel_link_key: RELATION_DATA_KEY
		do
			
			if to_side then
				if compressed_link.empty then
					if compressed_link.f_rom.is_cluster then
						compressed_link.set_to (flat_link.t_o)
						rel_link_key := flat_link.key
						compressed_link.add_relation (rel_link_key)
						if not (compressed_link.already_in_system or else compressed_link.is_in_system) then
							compressed_link.put_relation_in_system
						end
						workareas.change_data (compressed_link)
					else
						workareas.change_data (flat_link)
					end
				else
					update_create_compressed_link (compressed_link.f_rom, compressed_link.f_rom, flat_link.t_o, flat_link)
				end
			else
				if compressed_link.empty then
					if compressed_link.t_o.is_cluster then
						compressed_link.set_from (flat_link.f_rom)
						rel_link_key := flat_link.key
						compressed_link.add_relation (rel_link_key)
						if not (compressed_link.already_in_system or else compressed_link.is_in_system) then
							compressed_link.put_relation_in_system
						end
						workareas.change_data (compressed_link)
					else
						workareas.change_data (flat_link)
					end
				else
					update_create_compressed_link (compressed_link.t_o, flat_link.f_rom, compressed_link.t_o, flat_link)
				end
			end
		end


	update_create_compressed_link (compressed_extremity, from_extremity, to_extremity: LINKABLE_DATA; flat_link: RELATION_DATA) is
			-- Build new compressed link if necessary and update the workareas
		require
			compressed_extremity_exists: compressed_extremity /= Void
			from_extremity_exists: from_extremity /= Void
			to_extremity_exists: to_extremity /= Void
			flat_link_exists: flat_link /= Void
			from_or_to_is_compressed: (compressed_extremity = from_extremity) or else (compressed_extremity = to_extremity)
		local
			cli_sup: CLI_SUP_DATA
			inh: INHERIT_DATA
			new_comp_link: COMP_LINK_DATA [RELATION_DATA_KEY]
		do
			if compressed_extremity.is_cluster then
				inh ?= flat_link
				if inh /= Void then
					!COMP_INHERIT_DATA! new_comp_link.make (from_extremity, to_extremity)
				else
					cli_sup ?= flat_link
					check
						is_cli_sup: cli_sup /= Void
					end
					--| take care of aggregations when compressed 
					--| aggregation links are implemented
					!COMP_CLI_SUP_DATA! new_comp_link.make_ref (from_extremity, to_extremity)
				end
				new_comp_link.add_relation (flat_link.key)
				if not (new_comp_link.already_in_system or else new_comp_link.is_in_system) then
					new_comp_link.put_relation_in_system
					workareas.change_data (new_comp_link)
				end
			else
				workareas.change_data (flat_link)
			end
		end

invariant

	client_links_exists: client_links /= Void
	supplier_links_exists: supplier_links /= Void
	heir_links_exists: heir_links /= Void
	parent_links_exists: parent_links /= Void
	valid_generics: generics /= Void
	valid_view_id: view_id > 0

end -- class CLASS_DATA
