indexing

	description: 
		"Abstract data representation of a compressed link.%
		%A compressed link is when a cluster is the%
		%source and/or destination of a link. It is made%
		%up of other relation data.";
	date: "$Date$";
	revision: "$Revision $"

deferred class COMP_LINK_DATA [T->RELATION_DATA_KEY]

inherit

	RELATION_DATA
		rename
			is_equal	as is_equal_comparable
		redefine
			to_and_from_are_valid,
			is_compressed,
			put_in_system,
			remove_from_system,
			generate_name,
			update_system_defined
		end

	LINKED_LIST [T]
		rename
			make as make_list,
			cursor as list_cursor	
		redefine
			is_equal
		select
			is_equal
		end;

feature -- Properties

	to_and_from_are_valid: BOOLEAN is
			-- Are f_rom and t_o valid?
			--| (One of these must be a cluster)
		do
			Result := t_o.is_cluster or else f_rom.is_cluster
		end;

	is_compressed: BOOLEAN is
		do
			Result := True
		end;

feature -- Access

	has_link (rel: RELATION_DATA): BOOLEAN is
		do
			from
				start
			until
				after or else (rel.f_rom = item.f_rom and then	
						rel.t_o = item.t_o)
			loop
				forth
			end;
			if not after then
				Result := true
			end
		end;

	all_visible_to (cluster: CLUSTER_DATA): BOOLEAN is
			-- Are all relations all visible to cluster
		local
			data: RELATION_DATA
		do
			Result := True;
			from
				start
			until
				after or else not Result
			loop
				data := item.data;
				if data /= Void then
					Result :=
						data.t_o.visible_descendant_of
							(cluster) and then
						data.f_rom.visible_descendant_of
							(cluster)
				end;
				forth
			end;
		end;

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			Result := f_rom = other.f_rom and then
				t_o = other.t_o
		end;

feature -- Setting

	set_from (f: like f_rom) is
		require
		  f_exits: f /= Void
		  class_if_to_is_cluster: f.is_class implies t_o.is_cluster
		do
			f_rom := f
		ensure
			at_least_one_cluster: to_and_from_are_valid
		end

	set_to (t: like t_o) is
		require
		  t_exits: t /= Void
		  class_if_from_is_cluster: t.is_class implies f_rom.is_cluster
		do
			t_o := t
		ensure
			at_least_one_cluster: to_and_from_are_valid
		end

feature -- Element change

	add_relation (rel_key: T) is
		require
			not_have_link: not has_link (rel_key.data);
			not_in_link: not rel_key.data.is_in_compressed_link
		do
			finish;
			rel_key.data.set_is_in_compressed_link (True);
			put_right (rel_key);
		ensure
			has_link: has_link (rel_key.data);
			is_in_link: rel_key.data.is_in_compressed_link
		end;

	update_system_defined (b: BOOLEAN) is
			-- If `b' then put current into system
			-- else remove from system and reset
			-- content.
		local
			data: RELATION_DATA
		do
			set_is_system_defined (b);
			if b then
				if not is_in_system then
					put_relation_in_system
				end
			else
				if is_in_system then
					remove_relation_from_system
				end
			end;
			from
				start
			until
				after
			loop
				data := item.data;
				if data = Void then
					remove
				else
					data.set_is_in_compressed_link (b);
					forth
				end
			end;
		end;

	put_in_system is
		local
			data: RELATION_DATA
		do
			put_relation_in_system;
			from
				start
			until
				after
			loop
				data := item.data;
				if data = Void then
					remove
				else
					if not data.is_in_system then
						data.put_in_system;
					end;
					forth
				end;
			end
		end;


	put_relation_in_system is
			-- Put Current relation in the system.
		deferred
		end;

feature -- Removal

	remove_relation_from_system is
			-- Remove Current relation from system.
		deferred
		end;

	remove_relation (rel: RELATION_DATA) is
		require
			valid_rel: rel /= Void;
			in_link: rel.is_in_compressed_link
		do
			from
				start
			until
				after or else (rel.f_rom = item.f_rom and then	
						rel.t_o = item.t_o)
			loop
				forth
			end;
			if not after then
				remove
			end;
			rel.set_is_in_compressed_link (False);
		ensure
			not_have_link: not has_link (rel);
			not_in_link: not rel.is_in_compressed_link
		end;

	remove_from_system is
		local
			data: RELATION_DATA
		do
			remove_relation_from_system;
			from
				start
			until
				after
			loop
				data := item.data;
				if data = Void then
					remove
				else
					if data.is_in_system then
						data.remove_from_system
					end;
					forth
				end;
			end
		end;

feature -- Output

	generate_relations (text_area: TEXT_AREA) is
		require
			valid_text_area: text_area /= Void
		local
			data: RELATION_DATA
		do
			from
				start
			until
				after
			loop
				data := item.data;
				if data = Void then
					remove
				else
					data.generate_name (text_area);
					forth
				end;
			end;
		end;

	generate_name (text_area: TEXT_AREA) is
		local
			data: RELATION_DATA
		do
			from
				start
			until
				after
			loop
				data := item.data;
				if data = Void then
					remove
				else
					data.generate_name (text_area);
					forth
				end;
			end;
		end;

end -- class COMP_LINK_DATA [T->RELATION_DATA_KEY]
