indexing

	description: "Data representing inheritance relationships.";
	date: "$Date$";
	revision: "$Revision $"

class INHERIT_DATA
		
inherit

	RELATION_DATA
		rename 
			f_rom as heir, t_o as parent
		export
			{ANY} heir, parent
		end

creation

	make, make_from_storer

feature {NONE} -- Initialization

	make (a_heir, a_parent: LINKABLE_DATA) is
			-- Create a INHERIT_DATA object with `a_heir' and `a_parent' as 
			-- two extremities of the inheritance relationship.
		--require
		--	heir_exists: a_heir /= void;
		--	parent_exists: a_parent /= void;
		local
			cl : CLASS_DATA
		do
			heir := a_heir;
			parent := a_parent;
			cl ?= a_parent
			if cl /= Void then
				generics := deep_clone ( cl.generics ) -- pascalf
			end
			!!break_points.make;
		ensure
			heir_correctly_set: heir = a_heir;
			parent_correctly_set: parent = a_parent;
			not_in_system: not is_in_system
		end;

feature -- Properties

	position ( gene : GENERIC_DATA ):INTEGER is
		local
			i: INTEGER		
		do
			from
				 generics.start
				 i := 1
				RESULT := 0
			until
				generics.after
			loop
				if generics.item.name.is_equal ( gene.name ) then
					RESULT := i
				end
				i := i +1
				generics.forth
			end
		end		
		
	--cursor: SCREEN_CURSOR is
	--		-- Cursor associated with
	--		-- current stone during transport.
	--	do
	--		Result := Cursors.inherit_cursor
	--	end;

	symbol: EV_PIXMAP is
		do
	--		Result := Pixmaps.inherit_pixmap
		end;

	destroy_command: DESTROY_INHERIT is
		do
			!! Result.make (Current)
		end;

	key: INHERIT_KEY is
		do
			!! Result.make_with_relation (Current)
		end;

	already_in_system: BOOLEAN is
			-- Is Current already defined?
		do
			if	heir	/= void
			then
				Result := heir.heir_link_of (parent) /= Void
			else
				Result	:= false
			end
		end;

	is_not_reversed: BOOLEAN is
			-- Is there an inherit relation coming
			-- from parent to heir (if is not a cluster)
		do
			if	parent	/= void	and
				heir	/= void
			then
				if parent.is_cluster or else heir.is_cluster then
					Result := true
				else
					Result := parent.heir_link_of (heir) = void
				end
			else
				Result	:= true
			end
		end

	is_aggregation,is_client: BOOLEAN is FALSE

	default_color : EV_COLOR is
		--default color
		do
				Result := Resources.inh_link_color
		end;

	has_parent_name	( s : STRING )	: BOOLEAN	is
	do
		if	parent	/= void
		then
			Result	:= parent.has_name	( s	)
		else
			Result	:= t_o_name.is_equal	( s	)
		end
	end

	has_heir_name	( s : STRING )	: BOOLEAN	is
	do
		if	heir	/= void
		then
			Result	:= heir.has_name	( s	)
		else
			Result	:= f_rom_name.is_equal	( s	)
		end
	end

        feature_adaptation: STRING

feature -- Comparison

	same_as (other: RELATION_DATA): BOOLEAN is
			-- Is other relation an inheritance relation?
		do
			Result := other.is_inheritance
		end;

feature -- Element change

	add_link is
			-- Put the link in the system.
		local
			st : STRING
		do
			if heir = Void or else parent = Void then
				!! st.make ( 50)
				st.append("Lost inherit relation from ");
				if heir /= Void then
					st.append (heir.name)
				else
					st.append("???")
				end;
				st.append (" to ");
				if parent /= Void then
					st.append (parent.name)
				else
					st.append("???")
				end;
				--Windows.add_message(st,1)
			else
				heir.add_heir_link (Current);
				parent.add_parent_link (Current);
				is_in_system := true
			end;
		end; 

feature -- Removal

	remove_from_system is
			-- Remove the link from the system.
		local
			comp_link: COMP_LINK_DATA [RELATION_DATA_KEY]
			inh: INHERIT_DATA
			cli_sup: CLI_SUP_DATA
			h_l: SORTED_TWO_WAY_LIST [INHERIT_DATA]
			p_l: LINKED_LIST [INHERIT_DATA]
		do
			clear_editor;
			if is_in_compressed_link then
				comp_link := find_compressed_link
				if comp_link /= Void then
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
			if	heir	/= void
			then
				h_l := heir.heir_links
				if h_l /= Void then
					h_l.start;
					h_l.prune (Current);
				end
			end

			if	parent	/= void
			then
				p_l := parent.parent_links
				if p_l /= Void then
					p_l.start;
					p_l.prune (Current);
				end
			end

			decrement_points_shared;
			is_in_system := false
		end 

feature
	-- Set
	
	set_parent	( l : LINKABLE_DATA	) is
	do
		parent	:= l
	end

	set_heir	( l : LINKABLE_DATA	) is
	do
		heir	:= l
	end

        set_feature_adaptation (s: STRING) is
                do
                        feature_adaptation := s
                end

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
			if not to_focus then
				if	heir	/= void
				then
					Result.append (heir.name);
				else
					Result.append (f_rom_name);
				end
				Result.append (" : heir")
			else
				if	parent	/= void
				then
					Result.append (parent.name);
				else
					Result.append (t_o_name);
				end
				Result.append (" : parent")
			end
		end;

feature -- Storage

	storage_info: S_INHERIT_DATA is
		do
			!! Result;
			store_information (Result);
		end

end -- class INHERIT_DATA
