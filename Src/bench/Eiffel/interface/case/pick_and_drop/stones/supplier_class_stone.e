indexing

	description:
		"Stone for a Supplier";
	date: "$Date$";
	revision: "$Revision$"

class SUPPLIER_CLASS_STONE

	inherit
		CLASS_STONE
			redefine
			--	set
			end

	creation
		make_supplier


	feature
		-- Creation

		make_supplier (a_data: like data ; c : CLASS_DATA ) is
			-- Set data to `a_data'.
		do
			make ( a_data )
			
			client	:= c

		ensure
			data_set: data = a_data
		end;

	feature
		-- properties

		client	: CLASS_DATA

	feature
		-- Redefinition

	--	set (namer: NAMER_WINDOW) is
	--		-- Set information from `namer'.
	---	local
	--		txt: STRING
	--		cluster	: CLUSTER_DATA
	--		class_set	: CLASS_DATA
	--		supplier	: LINKABLE_DATA
	--		data_link	: CLI_SUP_DATA
	--	do
	--		txt := namer.entered_text;
	--		txt.to_upper;
	--		if not txt.empty --and then not txt.is_equal (data.name) 
	--		then
--
	--			data_link	:= client.client_link_of	( data	)
	--	
	--			if client /= Void
	--			then
	--				if	client.new_supplier_name	( namer.entered_text	)
	--				then	
	--					class_set	:= system.class_of_name	( namer.entered_text	)
	--	
	--					-- Destruction of the Old Link
	--					supplier	:= data_link.supplier
	--					if	supplier	/= void
	--					then
	--						supplier.delete_supplier_link	( data_link	)
	--					end
	--	
	--					-- Update the Link
	--					data_link.set_supplier	( class_set	)
	--					if class_set /= Void
	--					then
	--						data_link.set_generics	( class_set.generics	)
	--					end
	--					supplier	:= data_link.supplier
	--		
	--					-- Adding of the New Link
	--					-- Attention : the supplier has been updated
	--					if	supplier	/= void
	--					then
	--						supplier.add_supplier_link	( data_link	)
	--					else
	--						data_link.set_t_o_name	( deep_clone	( namer.entered_text	) )
	--					end
--	
--						windows.update_class_windows
--						workareas.update_drawing
--					end
--				end	
--			end
--		end
	
end -- class supplier_CLUSTER_STONE
