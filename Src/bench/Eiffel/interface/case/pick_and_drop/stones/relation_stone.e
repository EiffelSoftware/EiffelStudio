indexing

	description: "Stone that has an associated relation data.";
	date: "$Date$";
	revision: "$Revision $"

class RELATION_STONE

inherit

	STONE

creation

	make

feature {NONE} -- Initialization

	make (a_data: like data) is
			-- Set data  to `a_data'.
		do
			data := a_data
		ensure
			data_set: data = a_data
		end

feature -- Properties

	data: RELATION_DATA;
			-- Associated relation data

	--stone_cursor: SCREEN_CURSOR is
	--		-- Cursor associated with
	--		-- Current stone during transport
	--	do
	--	--	Result := data.cursor
	--	end;

	stone_type_pnd: EV_PND_TYPE is 
			-- Current stone type
		do
			Result := stone_types.relation_type_pnd
		end

	destroy_command: DESTROY is
			-- Command to destroy a relation
		do
			Result := data.destroy_command
		end;

feature -- Duplication

	copy_data (a_stone: like Current) is
			-- Copy `a_stone' data to Current.
		do
		end

feature -- Access

	is_valid: BOOLEAN is
			-- Is Current stone valid?
		local
			linkable: LINKABLE_DATA;
			idata: INHERIT_DATA;
			csdata: CLI_SUP_DATA;
		do
			idata ?= data;
			csdata ?= data;

			if idata /= Void then
				linkable := data.f_rom;
				Result := linkable /= Void and then ((linkable.heir_links /= Void and then
							linkable.heir_links.has (idata)) or else (linkable.parent_links /= Void
							and then linkable.parent_links.has (idata)))
				if Result then
					linkable := data.t_o;
					Result := linkable /= Void and then ((linkable.heir_links /= Void and then
							linkable.heir_links.has (idata)) or else (linkable.parent_links /= Void
							and then linkable.parent_links.has (idata)))
				end;
			elseif csdata /= Void then
				linkable := data.f_rom;
				Result := linkable /= Void and then ((linkable.supplier_links /= Void and then
							linkable.supplier_links.has (csdata)) or else (linkable.client_links /= Void
							and then linkable.client_links.has (csdata)))
				if Result then
					linkable := data.t_o;
					Result := linkable /= Void and then ((linkable.supplier_links /= Void and then
							linkable.supplier_links.has (csdata)) or else (linkable.client_links /= Void
							and then linkable.client_links.has (csdata)))
				end;
			end;
		end;

feature -- Update

	process (com: EC_COMMAND) is
			-- Process Current stone dropped in a correct hole 
			-- with command `com' 
		do
			com.process_relation (Current)
		end;

end -- class RELATION_STONE
