note
	description: "PCRE error constants"
	copyright: "Copyright (c) 2001-2002, Harald Erdbruegger and others"
	license: "MIT License"

class ERROR_CONSTANTS

feature -- Access

	frozen err_msg_0: STRING = "compilation successfully"

	frozen err_msg_1: STRING = "\ at end of pattern"

	frozen err_msg_2: STRING = "\c at end of pattern"

	frozen err_msg_3: STRING = "unrecognized character follows \"

	frozen err_msg_4: STRING = "numbers out of order in {} quantifier"

	frozen err_msg_5: STRING = "number too big in {} quantifier"

	frozen err_msg_6: STRING = "missing terminating ] for character class"

	frozen err_msg_7: STRING = "invalid escape sequence in character class"

	frozen err_msg_8: STRING = "range out of order in character class"

	frozen err_msg_9: STRING = "nothing to repeat"

	frozen err_msg_10: STRING = "operand of unlimited repeat could match the empty string"

	frozen err_msg_11: STRING = "internal error: unexpected repeat"

	frozen err_msg_12: STRING = "unrecognized character after (?"

	frozen err_msg_13: STRING = "too many capturing parenthesized sub-patterns"

	frozen err_msg_14: STRING = "missing )"

	frozen err_msg_15: STRING = "back reference to non-existent subpattern"

	frozen err_msg_16: STRING = "erroffset passed as NULL"

	frozen err_msg_17: STRING = "unknown option bit(s) set"

	frozen err_msg_18: STRING = "missing ) after comment"

	frozen err_msg_19: STRING = "too many sets of parentheses"

	frozen err_msg_20: STRING = "regular expression too large"

	frozen err_msg_21: STRING = "failed to get memory"

	frozen err_msg_22: STRING = "unmatched parentheses"

	frozen err_msg_23: STRING = "internal error: code overflow"

	frozen err_msg_24: STRING = "unrecognized character after (?<"

	frozen err_msg_25: STRING = "lookbehind assertion is not fixed length"

	frozen err_msg_26: STRING = "malformed number after (?("

	frozen err_msg_27: STRING = "conditional group contains more than two branches"

	frozen err_msg_28: STRING = "assertion expected after (?("

	frozen err_msg_29: STRING = "(?p must be followed by )"

	frozen err_msg_30: STRING = "unknown POSIX class name"

	frozen err_msg_31: STRING = "POSIX collating elements are not supported"

	frozen err_msg_32: STRING = "this version of PCRE is not compiled with PCRE_UTF8 support"

	frozen err_msg_33: STRING = "characters with values > 255 are not yet supported in classes"

	frozen err_msg_34: STRING = "character value in \x{...} sequence is too large"

	frozen err_msg_35: STRING = "invalid condition (?(0)"

	frozen err_msg_51: STRING = "internal matcher error (invalid compiled code)"

	frozen err_msg_99: STRING = "no pattern compiled"

end
