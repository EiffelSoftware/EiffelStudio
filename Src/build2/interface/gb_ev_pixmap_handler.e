indexing
	description: "Objects that provide common routines for pixmap handling."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_PIXMAP_HANDLER

feature -- Status report		

	valid_file_extension (extension: STRING): BOOLEAN is
			-- Is `extension' a valid file format for
			-- a pixmap on the current platform?
		require
			extension_length_3: extension.count = 3
		do
			Result := environment.supported_image_formats.has (extension.as_upper)			
		end
		
	invalid_type_warning: STRING is
			-- `Result' is message informing of the valid
			-- file types supported.
		local
			types: LINEAR [STRING]
			arrayed: ARRAYED_LIST [STRING]
			counter: INTEGER
		do
			Result := "File type not supported. "--unsupported_pixmap_type
			types := environment.supported_image_formats
			
				-- We must convert the LINEAR into an ARRAYED_LIST, as otherwise
				-- we cannot check to see if we are before the final position.
				-- This must be done so that we can correctly build the text formatting.
			create arrayed.make (3)
			from
				types.start
			until
				types.off
			loop
				arrayed.extend (types.item)
				types.forth
			end
				-- Now add supported types to `Result'.
			from
				counter := 1
			until
				counter > arrayed.count
			loop
				Result.append (arrayed.i_th (counter))
				if counter + 1 < arrayed.count  then
					Result.append (", ")
				elseif counter + 1 = arrayed.count then
					Result.append (" and ")
				end
				counter := counter + 1
			end
			Result.append (" types supported.")
		ensure
			Result_not_void: Result /= Void
			Result_not_empty: not Result.is_empty
		end
		
feature {NONE} -- Implementation

	environment: EV_ENVIRONMENT is
			-- Access to Vision2 Environment class.
		deferred
		end

end -- class GB_EV_PIXMAP_HANDLER
