indexing

	description: "Abstraction of linking entities (relationships)";
	date: "$Date$";
	revision: "$Revision $"

deferred class RELATION_DATA 

inherit

	COLORABLE
		undefine
			is_equal
		end
	DATA
		undefine
			is_equal
		end
	COMPARABLE
		
feature -- Properties

	view_id: INTEGER is
			-- View id of Current
		do
			if t_o /= Void
			then
				Result := t_o.view_id
			else
				Result	:= 0
			end
		end;

	is_in_compressed_link: BOOLEAN;
			-- Is Current in a compressed link?

	is_system_defined: BOOLEAN;
			-- Is Current a system defined link? (for iconisation)

	break_points: LINKED_LIST [HANDLE_DATA];
			-- List of break points

	is_in_system: BOOLEAN;
			-- Is current entity in system ?

	f_rom: LINKABLE_DATA;
			-- Partition from which the link originates.
			
	t_o: LINKABLE_DATA;
			-- Partition to which the link destinates.

	f_rom_name : STRING
			-- name of the entity where the link originates

	t_o_name : STRING 
			-- name of the entity where the link destinates

	already_in_system: BOOLEAN is
			-- Is current already defined?
			-- (This checks for equality not "=")
		deferred
		end;

	key: RELATION_DATA_KEY is
		deferred
		end;

	is_visible: BOOLEAN is
			-- Is current visible for drawing?
		do
			Result := not is_in_compressed_link
		end;

	is_inheritance: BOOLEAN is
			-- Is Current an inheritance relation?
		do
			Result := not ( is_aggregation or is_client )
		end

	is_aggregation: BOOLEAN is
			-- Is Current an aggregation?
		deferred
		end

	is_client: BOOLEAN is
			-- Is Current a client?
		deferred
		end

	is_implementation: BOOLEAN;
			-- Is this link a result of the implementation
			--| False implies that this relationship is derieved
			--| from the result type and argument type of the
			--| feature from the client class (for client-	
			--| supplier relations).
			--| False implies for inheritance relationship 
			--| that the ancestor was inherited for 
			--| implementation reason (not abstraction) 

	is_compressed: BOOLEAN is
			-- Is Current a compressed link?
		do
		end

	to_and_from_are_valid: BOOLEAN is
			-- Are f_rom and t_o valid?
			--| (By default both must be classes)
		do
			Result := t_o.is_class and then f_rom.is_class
		end;

	find_compressed_link: COMP_LINK_DATA [RELATION_DATA_KEY] is
			-- Find compressed link in which Current
			-- is in
		require
			is_in_link: is_in_compressed_link
		local
			no_problem: BOOLEAN -- FIXME pascalf
		do
			if not no_problem then
				if is_inheritance then
					Result := f_rom.heir_compressed_link_with (Current)
				else
					Result := f_rom.client_compressed_link_with (Current)
				end
			end
		rescue
			no_problem := TRUE
		retry
		end;

	stone: RELATION_STONE is
		do
			!! Result.make (Current);
		end;

	stone_type: INTEGER is
			-- Stone type of Current
		do
			Result := Stone_types.relation_type
		end;

	--cursor: SCREEN_CURSOR is
	--	deferred
	--	end;

	symbol: EV_PIXMAP is
		deferred
		end;

	destroy_command: DESTROY is
		deferred
		end;

	editor: EC_RELATION_WINDOW is
		do
--			Result := Windows.relation_window (Current);
		end;

	default_color: EV_COLOR is
			-- Default color
		deferred
		end

	generics : LINKED_LIST [ GENERIC_DATA ]

	modify_generics (p : INTEGER; g : GENERIC_DATA ) is -- p is for the position ...pascalf
		local
			cl: CLASS_DATA
			cl_list : EDITOR_LIST [ EC_CLASS_WINDOW ]
		do
--			generics.put_i_th(g,p)
--			cl ?= f_rom
--			if cl /= Void then
--				cl_list := Windows.class_windows
--				from
--					cl_list.start
--				until 
--					cl_list.after
--				loop
--					if cl_list.item.entity.name.is_equal(f_rom.name) then
--						cl_list.item.update
--					end
--					cl_list.forth
--				end
--			end
		end

	gene_generics:STRING is
	local
		b: BOOLEAN
	do
		!! Result.make(20)
		Result := clone("")
		if generics /= Void and then generics.count >0	then
			from
				generics.start
				b:= FALSE
				Result.append("[ ")
			until
				generics.after
			loop
				if b=TRUE then
					Result.append(", ")
				end
				Result.append(generics.item.name)
				b:= TRUE
				generics.forth
			end
			Result.append(" ]")
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

feature -- Setting

	set_is_in_compressed_link (b: BOOLEAN) is 
		do
			is_in_compressed_link := b
		end;

	set_implementation (b: BOOLEAN) is
			-- Set is_implementation to `b'.
		do
			is_implementation := b
		ensure
			is_implementation_set: is_implementation = b
		end;

	update_system_defined (b: BOOLEAN) is
		do
			is_system_defined := b;
		end;

	set_is_system_defined (b: BOOLEAN) is
		do
			is_system_defined := b
		end;

	set_t_o_name	( s : STRING	) is
	do
		t_o_name	:= s
	end

	set_f_rom_name	( s : STRING	) is
	do
		f_rom_name	:= s
	end

	set_generics	( generic_list : LINKED_LIST [ GENERIC_DATA ] ) is
	do
		generics	:= deep_clone	( generic_list	)
	end

feature -- Access

	contains_linkable (cluster: CLUSTER_DATA): BOOLEAN is
			-- Does f_rom and t_o exists in `cluster'?
		do
			if f_rom/= Void and then t_o/= Void then
				Result := cluster.contains_linkable (f_rom) and then
						cluster.contains_linkable (t_o)
		end	
	end;

	is_able_to_compress (other: RELATION_DATA): BOOLEAN is
			-- Is Current able to compress `other'?
		require
			valid_other: other /= Void
		do
			Result :=
				is_compressed and then
				Current /= other and then
				f_rom.contains_linkable (other.f_rom) and then
				t_o.contains_linkable (other.t_o) and then
				same_as (other)
		end;


feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is Current's from name before 
			-- or after other's from name?
		do
			if other.t_o=Void or t_o=Void then
				Result := TRUE
			else
				Result := t_o.view_id < other.t_o.view_id
			end
		end;

	same_as (other: RELATION_DATA): BOOLEAN is
			-- Is current relation same as `other'?
		deferred
		end;

feature -- Element change

	increment_points_shared is
			-- Add 1 to all shared attributes of break_points.
		do
			from
				break_points.start
			until
				break_points.after
			loop
				break_points.item.set_shared
							(break_points.item.shared+1);
				break_points.forth
			end
		end; -- increment_break_points

	decrement_points_shared is
			-- Substract 1 to all shared attributes of break_points.
		do
			from
				break_points.start
			until
				break_points.after
			loop
				break_points.item.set_shared
							(break_points.item.shared-1);
				break_points.forth
			end
		end; -- decrement_break_points

	put_in_system is
			-- Put the link in the system.
		require
		--	not_defined_in_system: not already_in_system -- pascalf;
				not_in_system: not is_in_system 
		do
			add_link;
			increment_points_shared;
		ensure
			defined_in_system: already_in_system;
			is_in_system: is_in_system
		end; -- put_in_system

feature -- Removal

	remove_from_system is
			-- Remove the link from the system.
		require
			defined_in_system: already_in_system;
			is_in_system: is_in_system
		deferred
		ensure
			not_defined_in_system: not already_in_system;
			not_in_system: not is_in_system
		end -- remove_from_system

	clear_editor is
		local
			ed: EC_RELATION_WINDOW
		do
			ed := editor;
			if ed /= Void then
			--	ed.clear
			end
		end;

feature -- Update

	update_editor is
		local
			ed: EC_RELATION_WINDOW;
			edlist: LINKED_LIST [EC_RELATION_WINDOW]
		do
--			edlist := Windows.relation_windows;
--			from
--				edlist.start
--			until
--				edlist.after
--			loop
--				ed := edlist.item;
--				if ed.entity = Current then
--					ed.update
--				end;
--				edlist.forth
--			end
		end;

feature -- Output

	generate_name (text_area: TEXT_AREA) is
		require
			valid_text_area: text_area /= Void
		do
			text_area.append_clickable_string (stone, focus);
			text_area.new_line;
		end;

	t_o_name_count	: INTEGER	is
	do
		Result	:= t_o_name.count
	end

feature -- Storage
	
	store_information (r_storer: S_RELATION_DATA) is
			-- Store Current information into `r_storer'.
		require
			valid_storer: r_storer /= Void;
			is_in_system: is_in_system
		local
			gg	: LINKED_LIST	[ S_GENERIC_DATA	]
			gene_data	: S_GENERIC_DATA
			from_id	: INTEGER
			to_id	: INTEGER
		do

			from_id	:= 0
			to_id	:= 0

			if f_rom /= Void
			then
				from_id	:= f_rom.id
			end
			if t_o /= Void
			then
				to_id	:= t_o.id
			end
			r_storer.set_class_links (from_id, to_id	)

			if t_o/=Void then
				r_storer.set_class_names	( f_rom_name	, t_o_name	)
			else
				r_storer.set_class_links (f_rom.id, 0	)
				r_storer.set_class_names	( f_rom_name	, t_o_name	)
			end
			if generics /= Void then
				-- allows a sane inheritance/ ... of generic classes ... pascalf			
				!! gg.make
				from 
					generics.start
				until
					generics.after
				loop
					!! gene_data.make(generics.item.name, Void )
					gg.extend	( clone	( gene_data	) )
					generics.forth
				end
				r_storer.set_generics ( gg ) 
			end
		end;

	storage_info: S_RELATION_DATA is
		deferred
		ensure
			valid_result: Result /= Void
		end;

feature {NONE} -- Storage

	make_from_storer (storer: S_RELATION_DATA;
			system_classes: HASH_TABLE [CLASS_DATA, INTEGER]) is
			-- Create Current from `storer' and insert into system.
		require
			valid_storer: storer /= Void
		local
			is_inherit : S_INHERIT_DATA
			is_client_link	: S_CLI_SUP_DATA
			generic_data : GENERIC_DATA
			inh : INHERIT_DATA
			client_link : CLI_SUP_DATA
			cl : CLASS_DATA
			parent_class	: CLASS_DATA
			supplier_class	: CLASS_DATA
		do
			f_rom := system_classes.item (storer.f_rom)
			t_o := system_classes.item (storer.t_o)
			f_rom_name := storer.f_rom_name
			t_o_name := storer.t_o_name
			-- added for the handles after a reverse
			if storer.handles_reverse/= VOid and then
				storer.handles_reverse.list/= Void and then
					storer.handles_reverse.list.count >0 then
				break_points := get_handles	( storer.handles_reverse	, f_rom)
			--
			else
				!! break_points.make;
			end
			-- pascalf
				!! generics.make
				if storer.generics /= Void then
					from
						storer.generics.start
					until
						storer.generics.after
					loop
						!! generic_data.make_from_storer (storer.generics.item )
						generics.extend ( generic_data )
						storer.generics.forth
					end		
			end

			is_inherit ?= storer
			
			cl ?= f_rom

			if is_inherit /= Void
			then
				if (t_o= Void or f_rom=Void) --and then is_inherit/= Void --and then cl/= Void 
				then
					inh ?= Current
					if cl /= Void then
						--if cl.heir_links/= Void then
						--	cl.heir_links.extend ( inh )
						--end		
					end			

					parent_class ?= t_o
					if parent_class /= Void
					then
						parent_class.add_parent_link	( inh	)
					end
				else
					add_link
				end
			else
				is_client_link	?= storer
				if is_client_link /= Void
				then
					if (t_o= Void or f_rom=Void)
					then
						client_link	?= Current						
						if cl /= Void then
							cl.add_client_link	( client_link	)		
						end			
						supplier_class ?= t_o
						if supplier_class /= Void
						then
							supplier_class.add_supplier_link	( client_link	)
						end
					else
						add_link
					end
				end
			end
		end;
feature

    get_handles	( handles_reverse : S_HANDLES_FOR_REVERSE ; cl : LINKABLE_DATA ) : LINKED_LIST [ HANDLE_DATA ] is
        local
            hand : HANDLE_DATA
        do
            !! Result.make
            if handles_reverse.list/= Void and then handles_reverse.list.count>0 then
                from
                    handles_reverse.list.start
                until
                    handles_reverse.list.after
                loop
                    !! hand
                    hand.set_x ( handles_reverse.list.item.x)
                    hand.set_y ( handles_reverse.list.item.y)
                    hand.set_from ( cl )
                    Result.extend (hand)
                    handles_reverse.list.forth
                end
            end
        end



feature {VIEW} -- Implementation

	add_link is
			-- Add link to f_rom and t_o linkables
		deferred
		end;

invariant

	go_to_an_entity: t_o /= void;
	go_from_an_entity: f_rom /= void;
	from_and_to_are_valid: to_and_from_are_valid;
	valid_break_points: break_points /= Void;
	valid_view_id: view_id /= 0
	not_corrupted: (t_o_name /= Void or t_o/= Void) and (f_rom_name /= Void or f_rom /= Void) 

end -- class RELATION_DATA
