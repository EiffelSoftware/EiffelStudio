indexing
	description: "Widget Container, pointing to an entity"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GRAPHICAL_COMPONENT [G]

inherit
	OBSERVER

feature -- Initialization

	make (cont: EV_CONTAINER; caller: like caller_window) is
			-- Initialize
		require
			container_exists : cont /= Void
			caller_exists : caller /= Void
		do
			container := cont
			caller_window := caller
	
			if caller /= Void then
				caller.add_component (Current)
			end
		ensure
			caller_set: caller = caller_window
			container_set: container = cont
		end

feature -- Implemenatation

	caller_window: EC_EDITOR_WINDOW [ANY]
		-- Caller Window

	container: EV_CONTAINER
		-- Container of Current

	entity: G
		-- Entity that describes/uses Current

feature -- Updates

-- 	Update_from (ent: ANY) is
-- 			-- Update from 'ent'
-- 		deferred
-- 		end
-- 
-- 	update is
-- 			-- Update Current Component
-- 		do
-- 			if entity /= Void then
-- 				update_from (entity) 
-- 			else
-- 				clear
-- 			end
-- 		end


	work_on (ent: ANY) is
		-- Add properties to 'ent'
		do
		end

	clear is 
		-- Clear all fields/buttons of Current
		deferred
		end

	problem: STRING is
		-- if there is a problem with what the user entered, 
		-- fill the string with the correct message. If not,
		-- the string is empty.
		do
			!! Result.make(20)
		end

feature -- Settings

	set_entity (g: like entity) is
		do
			entity := g
		end

end -- class GRAPHICAL_COMPONENT
