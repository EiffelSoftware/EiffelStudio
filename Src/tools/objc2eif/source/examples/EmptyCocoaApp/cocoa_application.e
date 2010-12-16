note
	description : "Class to inherit from by the class containing the root make creation procedure."
	date        : "$Date$"
	revision    : "$Revision$"

deferred class
	COCOA_APPLICATION

inherit
	ARGUMENTS

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			pool: NS_AUTORELEASE_POOL
			application: NS_APPLICATION
			bundle_utils: NS_BUNDLE_UTILS
			main_bundle: NS_BUNDLE
			main_nib_file: NS_STRING
		do
				-- Every cocoa app needs a main autorelease pool.
				-- Create it.
			create pool.make
				-- Reproduce the behavior of the NSRunApplication() C function that is
				-- installed in the main() function by default.
				--
				-- Step 1.
				-- Obtain the shared application object by invoking the class method
				-- shared_application.
			check attached (create {NS_APPLICATION_UTILS}).shared_application as attached_application then
				application := attached_application
			end
				-- Step 2.
				-- Load the application's main nib file into memory.
				-- Just like any other Cocoa app we don't want to have a hard coded NIB name,
				-- so we use the Info.plist file to read the NIB name.
			bundle_utils := create {NS_BUNDLE_UTILS}
			check attached bundle_utils.main_bundle as attached_main_bundle then
				main_bundle := attached_main_bundle
			end
			check attached {NS_STRING} main_bundle.object_for_info_dictionary_key_ ("NSMainNibFile") as attached_main_nib_file then
				main_nib_file := attached_main_nib_file
			end
			check bundle_utils.load_nib_named__owner_ (main_nib_file, application) end
				-- Connect the application to the application delegate
			application.set_delegate_ (create {APPLICATION_DELEGATE}.make)
				-- Step 3.
				-- Run the application
			application.run
		end

end
