indexing

	description:
		"";
	date: "$Date$";
	revision: "$Revision$"

class DESTROY_CREATION
	
	inherit	
		DESTROY

	creation
		make

	feature
		--creation

		make	( creation_data : CREATION_DATA )	is
		do
			data	:= creation_data
		end


	feature {DESTROY_ENTITIES_U, DESTROY_FEATURES_U, DESTROY_CLUSTER} -- Implementation

		update is
				-- Update required. Note this is only called
				-- once if Current is part of a list.
		do
		--	windows.namer_window.update;
		--	windows.update_class_windows
		--	workareas.refresh;
		end;

		redo is
		local
			creation_data	: CREATION_DATA
		do
			creation_data	?= data
			if	creation_data	/= void
			then
				creation_data.destroy
				update
			end
		end;

		undo is
		do
		end;

		name: STRING is "Destroy Creation Feature"
		
end -- class DESTROY_CREATION
