indexing

	description:	
		"Window manager for object tools.";
	date: "$Date$";
	revision: "$Revision: "

class OBJECT_WIN_MGR 

inherit

	EDITOR_MGR
		redefine
			editor_type, synchronize
		end

creation

	make

feature -- Properties

	objects_kept: LINKED_SET [STRING] is
			-- Hector references to objects clickable from object tools
		do
			!! Result.make;
			from
				active_editors.start
			until
				active_editors.after
			loop
				Result.merge (active_editors.item.kept_objects);
				active_editors.forth
			end
		end;

feature -- Synchronization

	synchronize is
			-- Synchronize object tools (after the application stopped).
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.synchronize;
				active_editors.forth
			end
		end;

	hang_on is
			-- Make object addresses unclickable (during application execution).
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.hang_on;
				active_editors.forth
			end
		end;

	reset is
			-- Reset each object tool.
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.reset;
				active_editors.forth
			end
		end;

feature {NONE} -- Properties

	editor_type: OBJECT_W;
	
end -- class OBJECT_WIN_MGR
