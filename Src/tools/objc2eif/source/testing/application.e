note
	description : "testing application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			pool: NS_AUTORELEASE_POOL
			class_clusters: CLASS_CLUSTERS
			objects_creation: OBJECTS_CREATION
			callbacks: CALLBACKS
			structs: STRUCTS
			memory_management: MEMORY_MANAGEMENT
		do
				 -- Create a top level autorelease pool.
				 -- In order to avoid memory leaks every cocoa app needs this.
			create pool.make

			create class_clusters
			class_clusters.run

			create objects_creation
			objects_creation.run

			create callbacks
			callbacks.run

			create structs
			structs.run

			create memory_management
			memory_management.run
			memory_management.collect_garbage
		end


end
