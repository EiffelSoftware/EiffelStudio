indexing
	description: "Abstract description of an .NET feature."
	date: "$Date$"
	revision: "$Revision$"
	
class
	DOTNET_FEATURE_AS

create
	make
	
feature {NONE} -- Initialization
			
	make (a_consumed: CONSUMED_ENTITY) is
			-- Create instance of DOTNET_FEATURE_AS with `a_consumed'.
		require
			a_consumed_not_void: a_consumed /= Void
		do
			consumed_entity := a_consumed
		ensure
			has_dotnet_entity: consumed_entity /= Void
		end

feature -- Formatting

	format (fctxt: DOTNET_FEATURE_CONTEXT) is
			-- Format current using `fctxt'.
		require
			fctxt_not_void: fctxt /= Void
		do
			fctxt.prepare_for_feature (consumed_entity)
			fctxt.put_normal_feature
		end

feature {NONE} -- Access
			
	consumed_entity: CONSUMED_ENTITY
			-- Entity on which formatting will be done.

invariant
	has_dotnet_entity: consumed_entity /= Void

end -- class DOTNET_FEATURE_AS
