indexing

	description:	
		"Window manager for object tools.";
	date: "$Date$";
	revision: "$Revision: "

class OBJECT_WIN_MGR 

inherit

	EDITOR_MGR
		rename
			make as mgr_make
		redefine
			editor_type
		end;
	EDITOR_MGR
		redefine
			editor_type, make
		select
			make
		end;
	EB_CONSTANTS

creation

	make

feature -- Initialization

	make (a_screen: SCREEN) is
			-- Initialize Current.
		do
			mgr_make (a_screen);
			Object_resources.add_user (Current)
		end


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

	synchronize_objects is
			-- Synchronize the object in the
			-- object tools (after the application stopped).
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
