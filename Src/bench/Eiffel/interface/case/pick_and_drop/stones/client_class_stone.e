indexing

	description:
		"Stone of a Heir";
	date: "$Date$";
	revision: "$Revision$"

class HEIR_CLASS_STONE

	inherit
		CLASS_STONE
			redefine
			--	set
			end

	creation
		make_heir


	feature
		-- Creation

		make_heir (a_data: like data ; c : CLASS_DATA ) is
			-- Set data to `a_data'.
		do
			make ( a_data )
			
			parent	:= c

		ensure
			data_set: data = a_data
		end;

	feature
		-- properties

		parent	: CLASS_DATA

	feature
		-- Redefinition

	--	set (namer: NAMER_WINDOW) is
	--		-- Set information from `namer'.
	--	local
	--		txt: STRING
	--		class_set	: CLASS_DATA
	--		heir	: LINKABLE_DATA
	--		data_link	: INHERIT_DATA
	--	do
	--		txt := namer.entered_text;
	--		txt.to_upper;
	--		if not txt.empty --and then not txt.is_equal (data.name) 
	--		then

	--			data_link	:= parent.parent_link_of	( data	)
		
	--			if parent /= Void
	--			then
	--				if	parent.new_heir_name	( namer.entered_text	)
	--				then	
	--					class_set	:= system.class_of_name	( namer.entered_text	)
	--	
	--					-- Destruction of the Old Link
	--					heir	:= data_link.heir
	--					if	heir	/= void
	--					then
	--						heir.delete_heir_link	( data_link	)
	--					end
	--	
	--					-- Update the Link
	--					data_link.set_heir	( class_set	)
	--					heir	:= data_link.heir
	--		
	--					-- Adding of the New Link
	--					-- Attention : the parent has been updated
	--					if	heir	/= void
	--					then
	--						heir.add_heir_link	( data_link	)
	--					else
	--						data_link.set_f_rom_name	( deep_clone	( namer.entered_text	) )
	--					end
----	
--						windows.update_class_windows
--						workareas.update_drawing
--					end
--				end	
--			end
--		end
	
end -- class HEIR_CLUSTER_STONE
