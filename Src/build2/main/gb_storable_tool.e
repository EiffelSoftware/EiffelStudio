indexing
	description: "Objects that represent tools that may be stored."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_STORABLE_TOOL

feature -- Access

	name: STRING is
			-- Full name used to represent `Current'.
		deferred
		ensure
			Result_not_void: Result /= Void
		end
		
	storable_name: STRING is
			-- Storable version of `name' used in storage.
		do
			Result := name.twin
			Result.to_lower
			Result.prune_all (' ')			
		ensure
			Result_not_void: Result /= Void
		end
		
	tool_bar: EV_TOOL_BAR is
			-- A tool bar containing all buttons associated with `Current'.
		deferred
		ensure
			Result_not_void: Result /= Void
		end
		
	as_widget: EV_WIDGET is
			-- `Result' is `Current' as a widget.
		do
			Result ?= Current
		ensure
			Result /= Void
		end

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	is_widget: as_widget /= Void
end -- class GB_STORABLE_TOOL
