indexing
	description: "Supervisor for object tools"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OBJECT_TOOL_LIST

inherit
	EB_TEXT_TOOL_LIST [EB_OBJECT_TOOL]
		redefine
			make
		end

creation
	make

feature -- Initialization

	make is
			-- Initialize Current.
		do
			precursor
		end


feature -- Properties

	objects_kept: LINKED_SET [STRING] is
			-- Hector references to objects clickable from object tools
		do
			create Result.make
			from
				start
			until
				after
			loop
				Result.merge (item.kept_objects)
				forth
			end
		end

feature -- Synchronization

	hang_on is
			-- Make object addresses unclickable (during application execution).
		do
			from
				start
			until
				after
			loop
				item.hang_on
				forth
			end
		end

	reset is
			-- Reset each object tool.
		do
			from
				start
			until
				after
			loop
				item.reset
				forth
			end
		end

end -- class EB_OBJECT_TOOL_LIST
