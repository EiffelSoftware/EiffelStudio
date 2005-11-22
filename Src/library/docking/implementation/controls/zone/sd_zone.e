indexing
	description: "Objects that used to hold SD_CONTENT's user widgets."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_ZONE

feature -- Query

	state: SD_STATE is
			-- State which `Current' is.
		do
			Result := content.state
		ensure
			not_void: Result /= Void
		end

	content: SD_CONTENT is
			-- Content which `Current' holded.
		deferred
		ensure
			not_void: Result /= Void
		end

	extend (a_content: SD_CONTENT) is
			-- Set `a_content'.
		require
			a_content_not_void: a_content /= Void
		deferred
		end

	type: INTEGER is
			-- type.
		do
			Result := content.type
		end

	has (a_content: SD_CONTENT): BOOLEAN is
			-- `Current' has `a_content'?
		require
			a_content_not_void: a_content /= Void
		deferred
		end

feature {SD_CONFIG_MEDIATOR} -- Save config.

	save_content_title (a_config_data: SD_INNER_CONTAINER_DATA) is
			-- save content(s) title(s) to `a_config_data'.
		require
			a_config_data_not_void: a_config_data /= Void
		deferred
		end

feature {SD_DOCKING_MANAGER} -- Focus out

	on_focus_out is
			-- Handle focus out.
		do
			content.focus_out_actions.call ([])
		end

feature {SD_DOCKING_MANAGER, SD_CONTENT}  -- Focus in

	on_focus_in (a_content: SD_CONTENT) is
			-- Handle focus in.
		require
			has: a_content /= Void implies has (a_content)
		do
			content.focus_in_actions.call ([])
		end

feature {NONE} -- Implementation

	internal_shared: SD_SHARED
			-- All singletons.

feature {SD_HOT_ZONE} -- Redraw

	invalidate is
			-- Redraw current.
		local

		do

		end

invariant

	internal_shared_not_void: internal_shared /= Void

end
