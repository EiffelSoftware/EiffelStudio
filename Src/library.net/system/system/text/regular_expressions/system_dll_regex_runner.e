indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Text.RegularExpressions.RegexRunner"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_REGEX_RUNNER

inherit
	SYSTEM_OBJECT

feature {NONE} -- Implementation

	frozen is_matched (cap: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Text.RegularExpressions.RegexRunner"
		alias
			"IsMatched"
		end

	frozen double_track is
		external
			"IL signature (): System.Void use System.Text.RegularExpressions.RegexRunner"
		alias
			"DoubleTrack"
		end

	frozen match_index (cap: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Text.RegularExpressions.RegexRunner"
		alias
			"MatchIndex"
		end

	frozen crawl (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Text.RegularExpressions.RegexRunner"
		alias
			"Crawl"
		end

	find_first_char: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Text.RegularExpressions.RegexRunner"
		alias
			"FindFirstChar"
		end

	init_track_count is
		external
			"IL deferred signature (): System.Void use System.Text.RegularExpressions.RegexRunner"
		alias
			"InitTrackCount"
		end

	frozen uncapture is
		external
			"IL signature (): System.Void use System.Text.RegularExpressions.RegexRunner"
		alias
			"Uncapture"
		end

	frozen double_crawl is
		external
			"IL signature (): System.Void use System.Text.RegularExpressions.RegexRunner"
		alias
			"DoubleCrawl"
		end

	frozen scan (regex: SYSTEM_DLL_REGEX; text: SYSTEM_STRING; textbeg: INTEGER; textend: INTEGER; textstart: INTEGER; prevlen: INTEGER; quick: BOOLEAN): SYSTEM_DLL_MATCH is
		external
			"IL signature (System.Text.RegularExpressions.Regex, System.String, System.Int32, System.Int32, System.Int32, System.Int32, System.Boolean): System.Text.RegularExpressions.Match use System.Text.RegularExpressions.RegexRunner"
		alias
			"Scan"
		end

	go is
		external
			"IL deferred signature (): System.Void use System.Text.RegularExpressions.RegexRunner"
		alias
			"Go"
		end

	frozen popcrawl: INTEGER is
		external
			"IL signature (): System.Int32 use System.Text.RegularExpressions.RegexRunner"
		alias
			"Popcrawl"
		end

	frozen is_boundary (index: INTEGER; startpos: INTEGER; endpos: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32, System.Int32): System.Boolean use System.Text.RegularExpressions.RegexRunner"
		alias
			"IsBoundary"
		end

	frozen match_length (cap: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Text.RegularExpressions.RegexRunner"
		alias
			"MatchLength"
		end

	frozen ensure_storage is
		external
			"IL signature (): System.Void use System.Text.RegularExpressions.RegexRunner"
		alias
			"EnsureStorage"
		end

	frozen crawlpos: INTEGER is
		external
			"IL signature (): System.Int32 use System.Text.RegularExpressions.RegexRunner"
		alias
			"Crawlpos"
		end

	frozen double_stack is
		external
			"IL signature (): System.Void use System.Text.RegularExpressions.RegexRunner"
		alias
			"DoubleStack"
		end

	frozen char_in_set (ch: CHARACTER; set: SYSTEM_STRING; category: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.Char, System.String, System.String): System.Boolean use System.Text.RegularExpressions.RegexRunner"
		alias
			"CharInSet"
		end

	frozen is_ecmaboundary (index: INTEGER; startpos: INTEGER; endpos: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32, System.Int32): System.Boolean use System.Text.RegularExpressions.RegexRunner"
		alias
			"IsECMABoundary"
		end

	frozen transfer_capture (capnum: INTEGER; uncapnum: INTEGER; start: INTEGER; end_: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Text.RegularExpressions.RegexRunner"
		alias
			"TransferCapture"
		end

	frozen capture (capnum: INTEGER; start: INTEGER; end_: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32): System.Void use System.Text.RegularExpressions.RegexRunner"
		alias
			"Capture"
		end

end -- class SYSTEM_DLL_REGEX_RUNNER
