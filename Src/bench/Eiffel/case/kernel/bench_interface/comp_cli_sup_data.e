indexing

	description: 
		"Abstract data representation of a client%
		%supplier compressed link.";
	date: "$Date$";
	revision: "$Revision $"

class COMP_CLI_SUP_DATA

inherit

	COMP_LINK_DATA [CLI_SUP_KEY]
		rename
			f_rom as client,
			t_o as supplier
		undefine
			infix "<", 
			store_information,
			is_visible
		redefine
			symbol
		select
			put_in_system, remove_from_system
		end;
	CLI_SUP_DATA
		rename
			make_ref as client_make_ref,
			make_aggreg as client_make_aggreg,
			make_reflexive as client_make_reflexive,
			put_in_system as put_relation_in_system,
			remove_from_system as remove_relation_from_system
		undefine
			is_compressed, to_and_from_are_valid, is_equal,
			generate_name, update_system_defined
		redefine
			--cursor, 
			symbol
		end

creation

	make_ref, make_aggreg, make_reflexive

feature -- Initialization

	make_ref (a_client, a_supplier: LINKABLE_DATA) is
			-- Create a CLI_SUP_DATA object with `a_client' and
			-- `a_supplier' as extremities of the current
			-- client-supplier link.
		require
			client_exists: a_client /= void;
			supplier_exists: a_supplier /= void;
		do
			client_make_ref (a_client, a_supplier);
			make_list
		ensure
			client_correctly_set: client = a_client;
			supplier_correctly_set: supplier = a_supplier;
			is_a_reference_link: not is_aggregation and not is_reflexive;
			not_in_system: not is_in_system
		end;

	make_reflexive (a_client_supplier: LINKABLE_DATA) is
			-- Create a CLI_SUP_DATA object with `a_client_supplier'
			-- as extremities of the current client-supplier link.
		require
			client_supplier_exists: a_client_supplier /= Void;
		do
			client_make_reflexive (a_client_supplier);
			make_list
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
			client_make_aggreg (a_client, a_supplier);
			make_list
		ensure
			client_correctly_set: client = a_client;
			supplier_correctly_set: supplier = a_supplier;
			is_an_aggregation_link: is_aggregation and not is_reflexive;
			not_in_system: not is_in_system
		end; -- make_aggreg

feature -- Properties

	--cursor: SCREEN_CURSOR is
	--	do
		--	Result := Cursors.comp_client_cursor
	--	end;

	symbol: EV_PIXMAP is
		do
			if is_aggregation then
		--		Result := Pixmaps.selected_comp_aggreg_pixmap
			else
		--		Result := Pixmaps.selected_comp_client_pixmap
			end
		end

end -- class COMP_CLI_SUP_DATA
