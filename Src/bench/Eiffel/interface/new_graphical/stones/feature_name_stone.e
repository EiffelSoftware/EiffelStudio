indexing
	description: 
		"Stone based on feature name."
	date: "$Date$"
	revision: "$Revision $"

class
	FEATURE_NAME_STONE

inherit
	FEATURE_STONE
		rename
			make as old_make
		redefine
			update, feature_name, stone_signature, synchronized_stone
		end

create
	make

feature {NONE} -- Initialization

	make (f_name: STRING; ec: CLASS_C) is
		require
			valid_f_name: f_name /= Void
			ec_not_void: ec /= Void
		do
			feature_class := ec
			e_class := ec
			feature_name := f_name
			if ec.has_feature_table then
				e_feature := ec.feature_with_name (f_name)
				if e_feature /= Void then
					e_class := e_feature.written_class
				end
			end
			internal_start_position := -1
			internal_end_position := -1
		ensure
			feature_name_set: feature_name = f_name
			feature_class_set: feature_class = ec
		end

feature -- Properties

	feature_name: STRING
			-- Feature name

	feature_class: CLASS_C
			-- Class with feature `feature_name'

	stone_signature: STRING is
			-- Signature of Current feature
		do
			Result := feature_name.twin
		end

feature -- Update

	update is
			-- Update current feature stone.
		local
			retried: BOOLEAN
		do
			if not retried then
				if internal_start_position = -1 or else e_feature = Void then
						-- Means check has been done and is invalid
						-- Find e_feature from feature_name.
					if feature_class.has_feature_table then
							-- System has been completely compiled and has all its
							-- feature tables.
						e_feature := feature_class.feature_with_name (feature_name)
						if e_feature /= Void then
							e_class := e_feature.written_class
							Precursor {FEATURE_STONE}
						end
					end
				end
			end
		rescue
			retried := True
			retry
		end

feature -- Dragging

	synchronized_stone: CLASSI_STONE is
			-- Clone of `Current' after a recompilation
			-- (May be Void if not valid anymore)
		local
			new_e_feature: like e_feature
			classc_stone: CLASSC_STONE
		do
			if e_class /= Void then
				create classc_stone.make (feature_class)
				Result := classc_stone.synchronized_stone
				classc_stone ?= Result
				if classc_stone /= Void then
						-- Class is still valid
						-- Check feature
					new_e_feature := e_feature.updated_version
					if new_e_feature /= Void then
						create {FEATURE_NAME_STONE} Result.make (feature_name, classc_stone.e_class)
					end
				end
			end
		end

end -- class FEATURE_NAME_STONE
