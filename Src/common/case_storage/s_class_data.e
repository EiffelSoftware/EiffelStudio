class S_CLASS_DATA

inherit

	S_LINKABLE_DATA
		redefine
			chart
		end;
	STORABLE

creation

	make

feature

	chart: S_CLASS_CHART;
			-- Informal description of Current class

	feature_number: INTEGER;
			-- Number of created features

	generics: FIXED_LIST [S_GENERIC_DATA];
			-- Number of generic parameters

	features: LINKED_LIST [S_FEATURE_DATA];
			-- Features of class

	invariants: FIXED_LIST [S_ASSERTION_DATA];
			-- Invariants of the current class

	is_deferred: BOOLEAN;
			-- Is the current class deferred?

	is_effective: BOOLEAN;
			-- Is the current class an effecting a deferred class ?

	is_interfaced: BOOLEAN
			-- Is the current class interfaced with externals ?

	is_persistent: BOOLEAN;
			-- Does the current class have persistant instances ?

	is_reused: BOOLEAN;
			-- Is the current class already implemented
			-- in a previous project and reused in the current one.

	is_root: BOOLEAN;
			-- Is the current class the root of
			-- the system ?

feature

	set_booleans (is_d, is_e, is_i, is_p, is_re, is_ro: BOOLEAN) is
			-- Set all booleans for Current.
		do
			is_deferred := is_d;
			is_effective := is_e;
			is_interfaced := is_i;
			is_persistent := is_p;
			is_reused := is_re;
			is_root := is_ro;
		ensure
			booleans_are_set: is_deferred = is_d and then
								is_effective = is_e and then
								is_interfaced = is_i and then
								is_persistent = is_p and then
								is_reused = is_re and then
								is_root = is_ro;
		end;

	set_generics (l: like generics) is
			-- Set generics to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty;
			not_have_void: not l.has (Void)
		do
			generics := l
		ensure
			generics_set: generics = l
		end;

	set_features (l: like features) is
			-- Set features to `l'.
			--| Allow empty features to be stored
			--| to disk (because of bench).
		require
			valid_l: l /= Void;
		do
			features := l
		ensure
			features_set: features = l
		end;

	set_invariants (l: like invariants) is
			-- Set invariants to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty;
			not_have_void: not l.has (Void)
		do
			invariants := l
		ensure
			invariants_set: invariants = l
		end;

	set_feature_number (i: INTEGER) is
			-- Set feature_number to `i'.
		do
			feature_number := i
		end;

feature -- Storage

	store_to_disk (path: STRING) is
			-- Store a class.
		require
			valid_path: path /= Void;
		local
			class_file_name: STRING;
			class_file: RAW_FILE
		do
			!! class_file.make_open_write (path);
			independent_store (class_file);
			class_file.close;
		rescue
			if not class_file.is_closed then
				class_file.close;
			end;
		end;

end
