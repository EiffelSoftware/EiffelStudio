indexing

	description:
		"Stone of the Parent Cluster";
	date: "$Date$";
	revision: "$Revision$"

class PARENT_CLASS_STONE

	inherit
		CLASS_STONE
			redefine
			--	set
			end

	creation
		make_parent


	feature
		-- Creation

		make_parent (a_data: like data ; c : CLASS_DATA ) is
			-- Set data to `a_data'.
		do
			make ( a_data )
			
			heir	:= c

		ensure
			data_set: data = a_data
		end;

	feature
		-- properties

		heir	: CLASS_DATA

	feature
		-- Redefinition

		--set (namer: NAMER_WINDOW) is
		--	-- Set information from `namer'.
		--local
		--	txt: STRING
		--	cluster	: CLUSTER_DATA
		--	class_set	: CLASS_DATA
		--	parent	: LINKABLE_DATA
		--	data_link	: INHERIT_DATA
		--do
		--	txt := namer.entered_text;
		--	txt.to_upper;
		--	if not txt.empty --and then not txt.is_equal (data.name) 
		--	then
--
	--			data_link	:= heir.heir_link_of	( data	)
	--	
	--			if heir /= Void
	--			then
	--				if	heir.new_parent_name	( namer.entered_text	)
		--			then	
		--				class_set	:= system.class_of_name	( namer.entered_text	)
	--	
	--					-- Destruction of the Old Link
	--					parent	:= data_link.parent
	--					if	parent	/= void
	--					then
	--						parent.delete_parent_link	( data_link	)
	--					end
	--	
	--					-- Update the Link
	--					data_link.set_parent	( class_set	)
	--					if class_set /= Void
	--					then
	--						data_link.set_generics	( class_set.generics	)
	--					end
	--					parent	:= data_link.parent
	--		
	--					-- Adding of the New Link
	--					-- Attention : the parent has been updated
	--					if	parent	/= void
	--					then
	--						parent.add_parent_link	( data_link	)
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
	
end -- class PARENT_CLUSTER_STONE
