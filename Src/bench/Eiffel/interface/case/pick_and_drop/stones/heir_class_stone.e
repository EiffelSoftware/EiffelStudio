indexing

	description:
		"Stone of the Client Cluster";
	date: "$Date$";
	revision: "$Revision$"

class CLIENT_CLASS_STONE

	inherit
		CLASS_STONE
			redefine
			--	set
			end

	creation
		make_client


	feature
		-- Creation

		make_client (a_data: like data ; c : CLASS_DATA ) is
			-- Set data to `a_data'.
		do
			make ( a_data )
			
			supplier	:= c

		ensure
			data_set: data = a_data
		end;

	feature
		-- properties

		supplier	: CLASS_DATA

	feature
		-- Redefinition

	--	set (namer: NAMER_WINDOW) is
	--		-- Set information from `namer'.
	--	local
	--		txt: STRING
	--		class_set	: CLASS_DATA
	--		client	: LINKABLE_DATA
	--		data_link	: CLI_SUP_DATA
	--	do
	--		txt := namer.entered_text;
	--		txt.to_upper;
	--		if not txt.empty --and then not txt.is_equal (data.name) 
	--		then

	--			data_link	:= supplier.supplier_link_of	( data	)
		
	--			if supplier /= Void
	--			then
	--				if	supplier.new_client_name	( namer.entered_text	)
	--				then	
	--					class_set	:= system.class_of_name	( namer.entered_text	)
	--	
	--					-- Destruction of the Old Link
	--					client	:= data_link.client
	--					if	client	/= void
	--					then
	--						client.delete_client_link	( data_link	)
	--					end
		
	--					-- Update the Link
	--					data_link.set_client	( class_set	)
	--					client	:= data_link.client
			
	--					-- Adding of the New Link
	--					-- Attention : the supplier has been updated
	--					if	client	/= void
	--					then
	--						client.add_client_link	( data_link	)
	--					else
	--						data_link.set_f_rom_name	( deep_clone	( namer.entered_text	) )
	--					end
	
	--					windows.update_class_windows
	--					workareas.update_drawing
	--				end
	--			end	
	--		end
	--	end
	
end -- class CLIENT_CLUSTER_STONE
